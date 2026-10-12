enum SpecialKind {
  none,
  rocketH, // clears its row
  rocketV, // clears its column
  bomb, // clears a diamond area around itself
  colorBomb; // clears every tile of one type

  bool get isRocket => this == rocketH || this == rocketV;
}

/// Grid coordinate. x = column (left→right), y = row (top→bottom).
class Pos {
  final int x;
  final int y;
  const Pos(this.x, this.y);

  bool isAdjacent(Pos o) => (x - o.x).abs() + (y - o.y).abs() == 1;

  @override
  bool operator ==(Object other) => other is Pos && other.x == x && other.y == y;

  @override
  int get hashCode => x * 7919 + y;

  @override
  String toString() => '($x,$y)';
}

/// Board obstacles introduced in later chapters.
/// * crate – occupies a cell (no piece); damaged by adjacent matches / specials.
/// * ice   – layer over a cell; cracks when the piece on it is cleared.
/// * chain – locks a piece in place; broken by matching / blasting that piece.
enum ObstacleKind { crate, ice, chain }

class Tile {
  /// Stable identity across moves so the view can animate the same sprite.
  final int id;
  int type;
  SpecialKind special;

  /// Remaining chain stages; a chained tile cannot move.
  int chain = 0;

  /// A collectible key: never matches and survives blasts; it is collected
  /// when it reaches the bottom of its column. Its [type] is meaningless.
  final bool drop;

  Tile(this.id, this.type, [this.special = SpecialKind.none, this.drop = false]);

  bool get isSpecial => special != SpecialKind.none;
  bool get locked => chain > 0;
}

class Board {
  final int width;
  final int height;
  final List<Tile?> _cells;

  /// Crate durability per cell (0 = no crate).
  final List<int> crates;

  /// Ice layers per cell (0 = no ice).
  final List<int> ice;

  Board(this.width, this.height)
    : _cells = List<Tile?>.filled(width * height, null),
      crates = List<int>.filled(width * height, 0),
      ice = List<int>.filled(width * height, 0);

  int crateAt(int x, int y) => inBounds(x, y) ? crates[y * width + x] : 0;
  int iceAt(int x, int y) => inBounds(x, y) ? ice[y * width + x] : 0;
  bool hasCrate(Pos p) => crateAt(p.x, p.y) > 0;

  /// Cells a falling piece can come to rest in (no crate, no chained piece).
  bool isSlot(int x, int y) => crateAt(x, y) == 0 && !(at(x, y)?.locked ?? false);

  bool get hasObstacles => crates.any((c) => c > 0) || ice.any((c) => c > 0) || _cells.any((t) => t?.locked ?? false);

  bool inBounds(int x, int y) => x >= 0 && y >= 0 && x < width && y < height;

  Tile? at(int x, int y) => inBounds(x, y) ? _cells[y * width + x] : null;
  Tile? atPos(Pos p) => at(p.x, p.y);

  void put(int x, int y, Tile? t) => _cells[y * width + x] = t;
  void putPos(Pos p, Tile? t) => put(p.x, p.y, t);

  Iterable<Pos> get positions sync* {
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        yield Pos(x, y);
      }
    }
  }

  Pos? find(int tileId) {
    for (var i = 0; i < _cells.length; i++) {
      if (_cells[i]?.id == tileId) return Pos(i % width, i ~/ width);
    }
    return null;
  }

  /// Every non-crate cell holds a piece.
  bool get isFull {
    for (var i = 0; i < _cells.length; i++) {
      if (crates[i] == 0 && _cells[i] == null) return false;
    }
    return true;
  }
}
