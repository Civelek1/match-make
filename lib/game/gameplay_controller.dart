import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../app/app_services.dart';
import '../audio/audio_service.dart';
import '../data/models/level_data.dart';
import '../match3/board.dart';
import '../match3/board_steps.dart';
import '../match3/match3_engine.dart';
import '../progression/progress_service.dart';
import '../restoration/restoration_state.dart';
import '../ui/board/board_view.dart';
import 'level_session.dart';

enum PlayPhase { intro, playing, resolving, paused, celebrating, won, lost }

/// Icon flight request: from a cleared tile to an objective counter.
class FlyRequest {
  final String objectiveId;
  final String tileTypeId;
  final Offset fromGlobal;
  final int amount;
  const FlyRequest(this.objectiveId, this.tileTypeId, this.fromGlobal, this.amount);
}

enum BannerKind { objective, lastMoves, restored, shuffle }

class BannerEvent {
  final BannerKind kind;
  final String text;
  final int serial;
  const BannerEvent(this.kind, this.text, this.serial);
}

class ComboEvent {
  final int level;
  final int serial;
  const ComboEvent(this.level, this.serial);
}

/// Orchestrates one level: input → session rules → board playback → HUD,
/// restoration, tutorial and win/lose flow. UI widgets only observe it.
class GameplayController extends ChangeNotifier implements BoardListener {
  final AppServices services;
  final LevelData level;
  final BoardViewController board = BoardViewController();
  late final LevelSession session;
  late final RestorationState restoration;

  /// Objective values shown in the HUD (advance as icons land).
  final Map<String, int> displayed = {};

  PlayPhase phase = PlayPhase.intro;
  WinOutcome? outcome;

  /// Coins granted for this win (shown on the result card).
  int coinsEarned = 0;
  int displayScore = 0;

  /// -1 = no tutorial; 0 = make the move; 1 = objectives; 2 = scene.
  int tutorialStep = -1;
  Move? tutorialMove;

  final ValueNotifier<BannerEvent?> banner = ValueNotifier(null);
  final ValueNotifier<ComboEvent?> combo = ValueNotifier(null);
  void Function(FlyRequest request)? onFly;
  VoidCallback? onCelebrateScene;

  TurnResult? _currentTurn;
  Timer? _hintTimer;
  bool _disposed = false;
  int _serial = 0;
  bool _lastMovesWarned = false;
  bool _pauseRequested = false;

  GameplayController(this.services, this.level, {int? seed}) {
    session = LevelSession(level, seed: seed);
    restoration = RestorationState(level);
    for (final o in level.objectives) {
      displayed[o.id] = 0;
    }
    restoration.onStage = _onRestorationStage;
  }

  bool get inputEnabled => phase == PlayPhase.playing && (tutorialStep == -1 || tutorialStep == 0) && !_disposed;

  int get movesLeft => session.movesLeft;

  /// Called by the intro card's PLAY button.
  void start() {
    if (phase != PlayPhase.intro) return;
    board.reset(session.engine.board);
    phase = PlayPhase.playing;
    final tip = level.introducesObstacle;
    if (tip != null) services.progress.markTipSeen('obstacle_$tip');
    services.audio.playMusic(MusicTrack.gameplay);
    if (level.hasTutorial && !services.progress.tutorialDone) {
      tutorialStep = 0;
      tutorialMove = session.engine.findAnyMove();
      if (tutorialMove != null) board.setHighlight([tutorialMove!.a, tutorialMove!.b]);
    } else {
      _armHint();
    }
    notifyListeners();
  }

  void _armHint() {
    _hintTimer?.cancel();
    board.showHint(null);
    _hintTimer = Timer(const Duration(seconds: 6), () {
      if (!_disposed && phase == PlayPhase.playing) board.showHint(session.engine.findAnyMove());
    });
  }

  // ---------------------------------------------------------------------------
  // BoardListener
  // ---------------------------------------------------------------------------

  @override
  void onSwapRequested(Pos a, Pos b) {
    if (!inputEnabled) return;
    if (tutorialStep == 0 && tutorialMove != null) {
      final m = tutorialMove!;
      final ok = (a == m.a && b == m.b) || (a == m.b && b == m.a);
      if (!ok) {
        services.audio.play(Sfx.invalid);
        return;
      }
    }
    final board = session.engine.board;
    if ((board.atPos(a)?.locked ?? false) || (board.atPos(b)?.locked ?? false)) {
      // Chained pieces cannot be moved.
      services.audio.play(Sfx.locked);
      services.haptics.error();
      return;
    }
    final result = session.trySwap(a, b);
    if (result == null) return;
    _runTurn(result);
  }

  @override
  void onSpecialTapped(Pos p) {
    if (!inputEnabled || tutorialStep == 0) return;
    final result = session.activate(p);
    if (result == null) return;
    _runTurn(result);
  }

  @override
  void onSwapAnimated(bool reverted) {
    services.audio.play(reverted ? Sfx.invalid : Sfx.swap);
    if (reverted) services.haptics.error();
  }

  @override
  void onClear(ClearStep step, Map<int, Offset> clearedCentersGlobal) {
    // Sound + haptics by what happened.
    final kinds = step.effects.map((e) => e.kind).toSet();
    if (kinds.contains(EffectKind.fullBoard) || kinds.contains(EffectKind.colorBurst)) {
      services.audio.play(Sfx.colorBomb);
      services.haptics.special();
    } else if (kinds.contains(EffectKind.area)) {
      services.audio.play(Sfx.bomb);
      services.haptics.special();
    } else if (kinds.isNotEmpty) {
      services.audio.play(Sfx.rocket);
      services.haptics.special();
    } else {
      services.audio.play(step.cascade > 0 ? Sfx.combo : Sfx.match);
      services.haptics.match();
    }
    if (step.obstacleHits.isNotEmpty) {
      final kinds = step.obstacleHits.map((h) => h.kind).toSet();
      if (kinds.contains(ObstacleKind.chain) && step.obstacleHits.any((h) => h.kind == ObstacleKind.chain && h.remaining == 0)) {
        services.audio.play(Sfx.unlock);
      } else if (kinds.contains(ObstacleKind.crate)) {
        services.audio.play(Sfx.locked);
      } else {
        services.audio.play(Sfx.restore);
      }
    }
    if (step.cascade >= 1) {
      combo.value = ComboEvent(step.cascade.clamp(1, 4), ++_serial);
    }

    displayScore += step.score;

    // Fly objective icons from cleared tiles to their counters.
    final deltas = _currentTurn?.objectiveDeltas[step] ?? const {};
    deltas.forEach((objId, amount) {
      final obj = level.objectives.firstWhere((o) => o.id == objId);
      final typeIndex = level.tileIndexOf(obj.tileTypeId);
      final sources = obj.isObstacle
          ? [
              for (final h in step.obstacleHits)
                if (h.kind.name == obj.tileTypeId) ?board.cellCenterGlobal(h.pos),
            ]
          : [
              for (final c in step.cleared)
                if (c.type == typeIndex && clearedCentersGlobal.containsKey(c.id)) clearedCentersGlobal[c.id]!,
            ];
      if (onFly == null || sources.isEmpty) {
        arrive(objId, amount);
        return;
      }
      final n = sources.length.clamp(1, 3);
      var remaining = amount;
      for (var i = 0; i < n; i++) {
        final share = i == n - 1 ? remaining : (amount / n).floor();
        remaining -= share;
        if (share > 0) onFly!(FlyRequest(objId, obj.tileTypeId, sources[i * sources.length ~/ n], share));
      }
    });
    notifyListeners();
  }

  @override
  void onShuffle() {
    banner.value = BannerEvent(BannerKind.shuffle, services.loc.t('game.shuffling'), ++_serial);
  }

  /// An icon reached its counter.
  void arrive(String objectiveId, int amount) {
    if (_disposed) return;
    final o = level.objectives.firstWhere((o) => o.id == objectiveId);
    final real = session.progress[objectiveId] ?? 0;
    final next = ((displayed[objectiveId] ?? 0) + amount).clamp(0, real).clamp(0, o.target);
    displayed[objectiveId] = next;
    restoration.setAmount(objectiveId, next);
    notifyListeners();
  }

  void _onRestorationStage(String id, int stage, bool completed) {
    services.audio.play(completed ? Sfx.objectiveComplete : Sfx.restore);
    if (completed) {
      final name = services.loc.upper(services.loc.t('obj.$id'));
      banner.value = BannerEvent(BannerKind.objective, services.loc.t('obj.complete', {'name': name}), ++_serial);
    }
  }

  void _syncDisplayed() {
    for (final o in level.objectives) {
      final real = session.progress[o.id] ?? 0;
      if ((displayed[o.id] ?? 0) != real) {
        displayed[o.id] = real;
        restoration.setAmount(o.id, real);
      }
    }
    displayScore = session.score;
  }

  // ---------------------------------------------------------------------------
  // Turn flow
  // ---------------------------------------------------------------------------

  Future<void> _runTurn(TurnResult result) async {
    _hintTimer?.cancel();
    board.showHint(null);
    phase = PlayPhase.resolving;
    _currentTurn = result;
    notifyListeners();

    await board.play(result.steps);
    if (_disposed) return;
    // Let in-flight icons land, then make sure HUD matches the rules exactly.
    if (result.consumedMove) await Future<void>.delayed(const Duration(milliseconds: 380));
    if (_disposed) return;
    _syncDisplayed();
    _currentTurn = null;

    if (tutorialStep == 0 && result.consumedMove) {
      tutorialStep = 1;
      board.setHighlight(null);
    }

    switch (session.state) {
      case SessionState.won:
        await _celebrateWin();
      case SessionState.lost:
        await Future<void>.delayed(const Duration(milliseconds: 500));
        if (_disposed) return;
        phase = PlayPhase.lost;
        services.audio.play(Sfx.levelFailed);
        services.haptics.error();
      case SessionState.playing:
        if (phase == PlayPhase.resolving) phase = PlayPhase.playing;
        if (session.movesLeft == 5 && !_lastMovesWarned) {
          _lastMovesWarned = true;
          banner.value = BannerEvent(BannerKind.lastMoves, services.loc.t('game.last_moves', {'n': 5}), ++_serial);
        }
        if (tutorialStep == -1) _armHint();
        if (_pauseRequested && phase == PlayPhase.playing) pause();
    }
    _pauseRequested = false;
    notifyListeners();
  }

  Future<void> _celebrateWin() async {
    phase = PlayPhase.celebrating;
    notifyListeners();
    restoration.completeAll();
    board.timeScale = 0.6;
    board.celebrate();
    onCelebrateScene?.call();
    banner.value = BannerEvent(BannerKind.restored, services.loc.t('game.restored'), ++_serial);
    services.audio.play(Sfx.levelComplete);
    services.haptics.success();
    await Future<void>.delayed(const Duration(milliseconds: 1700));
    if (_disposed) return;
    board.timeScale = 1;
    outcome = services.progress.recordWin(level, session.finalScore, session.stars);
    coinsEarned = services.economy.grantWinReward(outcome!);
    if (outcome!.firstCompletion) services.audio.play(Sfx.galleryUnlock);
    phase = PlayPhase.won;
    notifyListeners();
  }

  void advanceTutorial() {
    if (tutorialStep < 1) return;
    tutorialStep++;
    if (tutorialStep > 2) {
      tutorialStep = -1;
      services.progress.completeTutorial();
      if (phase == PlayPhase.playing) _armHint();
    }
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Pause / debug
  // ---------------------------------------------------------------------------

  void pause() {
    // A pause requested mid-resolution is applied once the board settles, so
    // the overlay can never race the cascade.
    if (phase == PlayPhase.resolving) {
      _pauseRequested = true;
      return;
    }
    if (phase != PlayPhase.playing) return;
    phase = PlayPhase.paused;
    _hintTimer?.cancel();
    notifyListeners();
  }

  void resume() {
    if (phase != PlayPhase.paused) return;
    phase = PlayPhase.playing;
    if (tutorialStep == -1) _armHint();
    notifyListeners();
  }

  /// Resume a lost level with bonus moves (rewarded-ad hook, disabled in this build).
  void continueWithExtraMoves(int n) {
    if (phase != PlayPhase.lost) return;
    session.movesLeft += n;
    session.state = SessionState.playing;
    phase = PlayPhase.playing;
    _armHint();
    notifyListeners();
  }

  /// True if restarting / leaving would throw away meaningful progress.
  bool get hasProgress => session.movesUsed > 0;

  void debugWin() {
    if (phase == PlayPhase.won || phase == PlayPhase.celebrating) return;
    session.debugWin();
    _syncDisplayed();
    _celebrateWin();
  }

  void debugLose() {
    if (phase == PlayPhase.won || phase == PlayPhase.lost) return;
    session.debugLose();
    phase = PlayPhase.lost;
    services.audio.play(Sfx.levelFailed);
    notifyListeners();
  }

  Future<void> debugShuffle() async {
    if (phase != PlayPhase.playing && phase != PlayPhase.paused) return;
    final step = session.engine.shuffle();
    phase = PlayPhase.resolving;
    notifyListeners();
    await board.play([step]);
    if (_disposed) return;
    phase = PlayPhase.playing;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _hintTimer?.cancel();
    banner.dispose();
    combo.dispose();
    restoration.dispose();
    super.dispose();
  }
}
