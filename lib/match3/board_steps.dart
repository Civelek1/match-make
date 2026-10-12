import 'board.dart';

/// The engine resolves a move instantly and describes what happened as an
/// ordered list of steps. The view replays them with animations, so logic and
/// presentation never disagree about board state.
sealed class BoardStep {}

class SwapStep extends BoardStep {
  final Pos a;
  final Pos b;

  /// True when the swap made no match and was swapped back.
  final bool reverted;
  SwapStep(this.a, this.b, {this.reverted = false});
}

class ClearedTile {
  final int id;
  final Pos pos;
  final int type;
  final SpecialKind special;

  /// A key collected at the bottom of the board.
  final bool drop;
  const ClearedTile(this.id, this.pos, this.type, this.special, {this.drop = false});
}

class CreatedSpecial {
  final int tileId;
  final Pos pos;
  final int type;
  final SpecialKind kind;
  const CreatedSpecial(this.tileId, this.pos, this.type, this.kind);
}

enum EffectKind { row, column, area, colorBurst, fullBoard, hammer }

/// Visual hint for special activations (rocket beam, bomb ring, ...).
class SpecialEffect {
  final EffectKind kind;
  final Pos origin;
  final int radius;
  final List<Pos> targets;
  const SpecialEffect(this.kind, this.origin, {this.radius = 0, this.targets = const []});
}

/// One point of damage dealt to an obstacle.
class ObstacleHit {
  final ObstacleKind kind;
  final Pos pos;

  /// Durability / layers / chain stages left after the hit.
  final int remaining;

  /// Chained tile id (chain hits only).
  final int? tileId;
  const ObstacleHit(this.kind, this.pos, this.remaining, {this.tileId});
}

class ClearStep extends BoardStep {
  final List<ClearedTile> cleared;
  final List<CreatedSpecial> created;
  final List<SpecialEffect> effects;
  final List<ObstacleHit> obstacleHits;

  /// Tiles removed per engine type index (objective collection).
  final Map<int, int> collected;
  final int score;

  /// 0 for the direct result of the move, 1+ for cascades.
  final int cascade;

  /// Keys that reached the bottom in this step.
  final int dropsCollected;

  ClearStep({
    required this.cleared,
    required this.created,
    required this.effects,
    required this.collected,
    required this.score,
    required this.cascade,
    this.obstacleHits = const [],
    this.dropsCollected = 0,
  });
}

class TileMove {
  final int id;
  final Pos from;
  final Pos to;
  const TileMove(this.id, this.from, this.to);
}

class TileSpawn {
  final int id;
  final int type;
  final SpecialKind special;
  final Pos to;

  /// Row the tile starts falling from (negative = above the board).
  final int fromY;
  final bool drop;
  const TileSpawn(this.id, this.type, this.special, this.to, this.fromY, {this.drop = false});
}

class FallStep extends BoardStep {
  final List<TileMove> moves;
  final List<TileSpawn> spawns;
  FallStep(this.moves, this.spawns);
}

/// Keys sinking one row: each pair is (key position, piece below), swapped.
class SinkStep extends BoardStep {
  final List<(Pos, Pos)> swaps;
  SinkStep(this.swaps);
}

class ShuffledTile {
  final int id;
  final int type;
  final SpecialKind special;
  final Pos pos;
  final int chain;
  final bool drop;
  const ShuffledTile(this.id, this.type, this.special, this.pos, {this.chain = 0, this.drop = false});
}

class ShuffleStep extends BoardStep {
  final List<ShuffledTile> tiles;
  ShuffleStep(this.tiles);
}
