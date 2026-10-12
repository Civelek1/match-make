import 'dart:math';

import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../../app/game_navigator.dart';
import '../../data/models/level_data.dart';
import '../../game/gameplay_controller.dart';
import '../../localization/localization.dart';
import '../board/board_view.dart';
import '../scenes/scene_art.dart';
import '../theme/game_colors.dart';
import '../widgets/game_button.dart';
import '../widgets/game_panel.dart';
import '../widgets/game_text.dart';
import 'gameplay_overlays.dart';
import 'hud_widgets.dart';

/// Playing screen: restoration scene on top (~1/3), board below (~2/3).
class GameplayScreen extends StatefulWidget {
  final LevelData level;
  const GameplayScreen({super.key, required this.level});

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> with WidgetsBindingObserver {
  late final GameplayController c;
  final _flyKey = GlobalKey<FlyLayerState>();
  final _sceneKey = GlobalKey<SceneViewState>();
  final _sceneBoxKey = GlobalKey();
  final _objectivesKey = GlobalKey();
  final Map<String, GlobalKey> _counterKeys = {};
  late final GameNavigator _nav;

  @override
  void initState() {
    super.initState();
    final s = context.services;
    _nav = s.navigator;
    c = GameplayController(s, widget.level);
    for (final o in widget.level.objectives) {
      _counterKeys[o.id] = GlobalKey();
    }
    c.onFly = _fly;
    c.onCelebrateScene = () => _sceneKey.currentState?.celebrate();
    c.addListener(_onChange);
    _nav.backOverride = _onBack;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_nav.backOverride == _onBack) _nav.backOverride = null;
    c.removeListener(_onChange);
    c.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) c.pause();
  }

  void _onChange() {
    if (mounted) setState(() {});
  }

  /// Android back / system back while playing.
  bool _onBack() {
    switch (c.phase) {
      case PlayPhase.playing:
      case PlayPhase.resolving:
        c.pause();
        return true;
      case PlayPhase.paused:
        c.resume();
        return true;
      case PlayPhase.celebrating:
        return true;
      default:
        return false;
    }
  }

  void _fly(FlyRequest r) {
    final target = _counterKeys[r.objectiveId]?.currentContext?.findRenderObject() as RenderBox?;
    final layer = _flyKey.currentState;
    if (target == null || layer == null || !target.hasSize) {
      c.arrive(r.objectiveId, r.amount);
      return;
    }
    final to = target.localToGlobal(Offset(target.size.width / 2, target.size.width / 2));
    layer.fly(r.tileTypeId, r.objectiveId, r.amount, r.fromGlobal, to);
  }

  Future<void> _confirmThen(String message, String confirm, VoidCallback action) async {
    if (!c.hasProgress) {
      action();
      return;
    }
    final loc = context.services.loc;
    final ok = await showConfirmModal(
      context,
      title: loc.t('pause.confirm'),
      message: message,
      confirmLabel: confirm,
      cancelLabel: loc.t('common.cancel'),
      confirmTone: ButtonTone.orange,
    );
    if (ok) action();
  }

  void _restart() {
    final loc = context.services.loc;
    _confirmThen(
      loc.t('pause.confirm_restart'),
      loc.t('pause.yes_restart'),
      () => _nav.go(AppScreen.playing, arg: widget.level.id, force: true),
    );
  }

  void _home() {
    final loc = context.services.loc;
    _confirmThen(
      loc.t('pause.confirm_home'),
      loc.t('pause.yes_leave'),
      () => _nav.go(AppScreen.chapterMap, style: TransitionStyle.zoomOut, force: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = EnvironmentTheme.of(widget.level.environmentId);
    final loc = context.services.loc;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [theme.bgTop, theme.bgBottom]),
      ),
      child: Stack(
        children: [
          SafeArea(
            child: LayoutBuilder(
              builder: (context, cons) {
                final width = min(cons.maxWidth, 720.0);
                const topBar = 64.0, objectives = 70.0, scoreBar = 40.0, gaps = 18.0;
                final rest = cons.maxHeight - topBar - objectives - scoreBar - gaps;
                final boardSize = min(width - 12, rest * 0.66).clamp(200.0, 680.0);
                final sceneH = max(120.0, rest - boardSize);
                return Center(
                  child: SizedBox(
                    width: width,
                    child: Column(
                      children: [
                        SizedBox(height: topBar, child: _topBar(loc)),
                        SizedBox(
                          key: _sceneBoxKey,
                          height: sceneH,
                          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: _scene(theme)),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(key: _objectivesKey, height: objectives, child: _objectiveStrip()),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: boardSize,
                          height: boardSize,
                          child: BoardView(
                            width: widget.level.gridWidth,
                            height: widget.level.gridHeight,
                            tileTypeIds: widget.level.tileTypeIds,
                            theme: theme,
                            controller: c.board,
                            listener: c,
                            inputEnabled: () => c.inputEnabled,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: scoreBar,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: ScoreBar(
                              score: c.displayScore,
                              thresholds: widget.level.starThresholds,
                              label: loc.t('common.score'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned.fill(
            child: FlyLayer(key: _flyKey, onArrive: c.arrive),
          ),
          Positioned.fill(
            child: IgnorePointer(child: _ComboText(c: c)),
          ),
          if (c.tutorialStep >= 0 && c.phase != PlayPhase.intro)
            Positioned.fill(
              child: TutorialOverlay(c: c, objectivesKey: _objectivesKey, sceneKey: _sceneBoxKey),
            ),
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: ScaleTransition(scale: Tween(begin: 0.92, end: 1.0).animate(anim), child: child),
              ),
              child: _phaseOverlay(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _phaseOverlay() {
    switch (c.phase) {
      case PlayPhase.intro:
        return LevelIntroOverlay(key: const ValueKey('intro'), c: c);
      case PlayPhase.paused:
        return PauseOverlay(key: const ValueKey('pause'), c: c, onRestart: _restart, onHome: _home);
      case PlayPhase.won:
        return WinOverlay(key: const ValueKey('win'), c: c);
      case PlayPhase.lost:
        return LoseOverlay(key: const ValueKey('lose'), c: c);
      default:
        return const SizedBox.shrink(key: ValueKey('none'));
    }
  }

  Widget _topBar(Localization loc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        children: [
          GameIconButton(
            icon: Icons.pause_rounded,
            tone: ButtonTone.purple,
            size: 46,
            semanticLabel: loc.t('pause.title'),
            onTap: c.phase == PlayPhase.playing || c.phase == PlayPhase.resolving ? c.pause : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.t('game.level', {'n': widget.level.number}),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 11, letterSpacing: 1),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: GameText(loc.t(widget.level.nameKey), size: 19, strokeWidth: 3),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          MovesBubble(moves: c.movesLeft, label: loc.t('common.moves')),
        ],
      ),
    );
  }

  Widget _scene(EnvironmentTheme theme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white, width: 3.5),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: Stack(
          children: [
            Positioned.fill(
              child: SceneView(key: _sceneKey, environmentId: widget.level.environmentId, state: c.restoration),
            ),
            Positioned.fill(child: _BannerText(c: c)),
          ],
        ),
      ),
    );
  }

  Widget _objectiveStrip() {
    final objs = widget.level.objectives;
    return LayoutBuilder(
      builder: (context, cons) {
        final size = min(46.0, (cons.maxWidth - 24) / objs.length - 12);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (final o in objs)
              ObjectiveCounter(key: _counterKeys[o.id], objective: o, value: c.displayed[o.id] ?? 0, size: size),
          ],
        );
      },
    );
  }
}

/// "GOOD! / GREAT! / AMAZING! / INCREDIBLE!" pop text over the board.
class _ComboText extends StatelessWidget {
  final GameplayController c;
  const _ComboText({required this.c});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ComboEvent?>(
      valueListenable: c.combo,
      builder: (context, e, _) {
        if (e == null) return const SizedBox.shrink();
        final text = context.services.loc.t('game.combo.${e.level}');
        const colors = [Color(0xFF9CF08A), Color(0xFF7CC8FF), Color(0xFFFFC93C), Color(0xFFFF7AD9)];
        return Align(
          alignment: const Alignment(0, 0.25),
          child: TweenAnimationBuilder<double>(
            key: ValueKey(e.serial),
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1000),
            builder: (context, t, child) {
              final scale = t < 0.25 ? Curves.easeOutBack.transform(t / 0.25) * 1.1 : 1.1 - (t - 0.25) * 0.15;
              final opacity = t < 0.75 ? 1.0 : (1 - (t - 0.75) / 0.25);
              return Opacity(
                opacity: opacity.clamp(0, 1),
                child: Transform.translate(
                  offset: Offset(0, -30 * t),
                  child: Transform.rotate(
                    angle: -0.06,
                    child: Transform.scale(scale: scale, child: child),
                  ),
                ),
              );
            },
            child: GameText(text, size: 40 + e.level * 4, color: colors[(e.level - 1) % 4], strokeWidth: 7),
          ),
        );
      },
    );
  }
}

/// Banner text inside the scene ("FENCE COMPLETE!", "RESTORED!", ...).
class _BannerText extends StatelessWidget {
  final GameplayController c;
  const _BannerText({required this.c});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ValueListenableBuilder<BannerEvent?>(
        valueListenable: c.banner,
        builder: (context, e, _) {
          if (e == null) return const SizedBox.shrink();
          final big = e.kind == BannerKind.restored;
          final color = switch (e.kind) {
            BannerKind.objective => const Color(0xFF9CF08A),
            BannerKind.lastMoves => const Color(0xFFFF8E98),
            BannerKind.restored => GameColors.gold,
            BannerKind.shuffle => Colors.white,
          };
          return Center(
            child: TweenAnimationBuilder<double>(
              key: ValueKey(e.serial),
              tween: Tween(begin: 0, end: 1),
              duration: Duration(milliseconds: big ? 2200 : 1600),
              builder: (context, t, child) {
                final inT = Curves.elasticOut.transform((t / 0.3).clamp(0, 1));
                final out = ((t - 0.8) / 0.2).clamp(0.0, 1.0);
                return Opacity(
                  opacity: 1 - out,
                  child: Transform.scale(scale: inT, child: child),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: FittedBox(
                  child: GameText(e.text, size: big ? 44 : 28, color: color, strokeWidth: 6),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
