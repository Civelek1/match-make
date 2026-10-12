import '../data/models/level_data.dart';
import '../data/scoring_config.dart';
import '../match3/board.dart';
import '../match3/board_steps.dart';
import '../match3/match3_engine.dart';

enum SessionState { playing, won, lost }

/// Result of one player action, with per-clear objective deltas so the UI can
/// fly the right icons at the right moment.
class TurnResult {
  final List<BoardStep> steps;
  final bool consumedMove;
  final Map<ClearStep, Map<String, int>> objectiveDeltas;
  const TurnResult(this.steps, this.consumedMove, this.objectiveDeltas);

  bool get reverted => steps.length == 1 && steps.first is SwapStep && (steps.first as SwapStep).reverted;
}

/// Rules of one level attempt: moves, score, objectives, win/lose.
class LevelSession {
  final LevelData level;
  final ScoringConfig scoring;
  final Match3Engine engine;
  final Map<String, int> progress;
  int movesLeft;
  int score = 0;
  int movesUsed = 0;
  SessionState state = SessionState.playing;

  LevelSession(this.level, {this.scoring = const ScoringConfig(), int? seed})
    : engine = Match3Engine(
        width: level.gridWidth,
        height: level.gridHeight,
        typeCount: level.tileTypeIds.length,
        specials: level.specials,
        scoring: scoring,
        seed: seed,
        obstacles: level.obstacles,
      ),
      movesLeft = level.moves,
      progress = {for (final o in level.objectives) o.id: 0} {
    engine.generate();
  }

  bool get isPlaying => state == SessionState.playing;

  bool get objectivesComplete => level.objectives.every((o) => (progress[o.id] ?? 0) >= o.target);

  int get moveBonus => movesLeft * scoring.remainingMoveBonus;
  int get finalScore => score + (state == SessionState.won ? moveBonus : 0);
  int get stars => state == SessionState.won ? level.starsForScore(finalScore) : 0;

  double get completion {
    var got = 0, need = 0;
    for (final o in level.objectives) {
      got += (progress[o.id] ?? 0).clamp(0, o.target);
      need += o.target;
    }
    return need == 0 ? 1 : got / need;
  }

  TurnResult? trySwap(Pos a, Pos b) {
    if (!isPlaying || movesLeft <= 0) return null;
    final steps = engine.trySwap(a, b);
    if (steps == null) return null;
    final result = TurnResult(steps, true, {});
    if (result.reverted) return TurnResult(steps, false, const {});
    return _consume(steps);
  }

  TurnResult? activate(Pos p) {
    if (!isPlaying || movesLeft <= 0) return null;
    final steps = engine.activateAt(p);
    if (steps == null) return null;
    return _consume(steps);
  }

  /// Hammer booster at [p]. Never costs a move.
  TurnResult? useHammer(Pos p) {
    if (!isPlaying) return null;
    final steps = engine.hammerAt(p);
    if (steps == null) return null;
    return _consume(steps, costsMove: false);
  }

  /// Broom booster on row [y]. Never costs a move.
  TurnResult? useBroom(int y) {
    if (!isPlaying) return null;
    final steps = engine.sweepRow(y);
    if (steps == null) return null;
    return _consume(steps, costsMove: false);
  }

  /// Shuffle booster. Never costs a move.
  TurnResult? useShuffle() {
    if (!isPlaying) return null;
    return TurnResult([engine.shuffle()], false, const {});
  }

  /// Start boosters: places specials before the first move.
  List<Pos> placeStartSpecials(List<SpecialKind> kinds) => [
    if (movesUsed == 0)
      for (final k in kinds) ...engine.placeSpecials(k, 1),
  ];

  TurnResult _consume(List<BoardStep> steps, {bool costsMove = true}) {
    if (costsMove) {
      movesLeft--;
      movesUsed++;
    }
    final deltas = <ClearStep, Map<String, int>>{};
    for (final s in steps) {
      if (s is ClearStep) deltas[s] = _applyClear(s);
    }
    _evaluate();
    return TurnResult(steps, costsMove, deltas);
  }

  Map<String, int> _applyClear(ClearStep s) {
    score += s.score;
    final delta = <String, int>{};
    for (final h in s.obstacleHits) {
      for (final o in level.objectives) {
        if (o.tileTypeId != h.kind.name) continue;
        final before = progress[o.id]!;
        if (before < o.target) {
          progress[o.id] = before + 1;
          delta[o.id] = (delta[o.id] ?? 0) + 1;
        }
      }
    }
    s.collected.forEach((typeIndex, count) {
      final tileId = level.tileTypeIds[typeIndex];
      for (final o in level.objectives) {
        if (o.tileTypeId != tileId) continue;
        final before = progress[o.id]!;
        final after = (before + count).clamp(0, o.target);
        if (after > before) {
          progress[o.id] = after;
          delta[o.id] = after - before;
        }
      }
    });
    return delta;
  }

  void _evaluate() {
    if (objectivesComplete) {
      state = SessionState.won;
    } else if (movesLeft <= 0) {
      state = SessionState.lost;
    }
  }

  // Debug helpers ------------------------------------------------------------

  void debugWin() {
    for (final o in level.objectives) {
      progress[o.id] = o.target;
    }
    state = SessionState.won;
  }

  void debugLose() {
    movesLeft = 0;
    state = SessionState.lost;
  }
}
