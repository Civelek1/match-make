import 'dart:collection';
import 'dart:math';

import '../data/models/level_data.dart';
import '../data/scoring_config.dart';
import 'board.dart';
import 'board_steps.dart';

class Move {
  final Pos a;
  final Pos b;
  const Move(this.a, this.b);
}

class _Run {
  final List<Pos> cells;
  final bool horizontal;
  _Run(this.cells, this.horizontal);
}

class _Group {
  final int type;
  final Set<Pos> cells = {};
  final List<_Run> runs = [];
  _Group(this.type);

  int get maxLen => runs.fold(0, (m, r) => max(m, r.cells.length));
  bool get hasH => runs.any((r) => r.horizontal);
  bool get hasV => runs.any((r) => !r.horizontal);
}

/// Pre-computed clear that seeds a resolution (special swaps / taps).
class _Seed {
  final Set<Pos> clear = {};
  final List<Pos> activate = [];

  /// Specials already spent by a combo; they must not fire again.
  final Set<Pos> consumed = {};
  final List<SpecialEffect> effects = [];
  int bonus = 0;
}

/// Pure match-3 rules: generation, swapping, matching, specials, gravity,
/// refills, cascades and shuffling. Deterministic for a given seed.
class Match3Engine {
  final Board board;
  final int typeCount;
  final Set<SpecialFeature> specials;
  final ScoringConfig scoring;
  final Random _rng;
  int _nextId = 1;

  /// Obstacle layout rows (see [parseObstacle]); null = plain board.
  final List<String>? obstacles;

  Match3Engine({
    required int width,
    required int height,
    required this.typeCount,
    Set<SpecialFeature>? specials,
    this.scoring = const ScoringConfig(),
    int? seed,
    this.obstacles,
  }) : assert(typeCount >= 3),
       board = Board(width, height),
       specials = specials ?? SpecialFeature.values.toSet(),
       _rng = Random(seed);

  /// Layout legend:
  /// `.` empty · `c`/`C`/`B` crate 1/2/3 · `i`/`I` ice 1/2 ·
  /// `l`/`L` chain 1/2 · `j` ice 1 + chain 1 · `J` ice 2 + chain 1.
  static ({int crate, int ice, int chain}) parseObstacle(String ch) => switch (ch) {
    'c' => (crate: 1, ice: 0, chain: 0),
    'C' => (crate: 2, ice: 0, chain: 0),
    'B' => (crate: 3, ice: 0, chain: 0),
    'i' => (crate: 0, ice: 1, chain: 0),
    'I' => (crate: 0, ice: 2, chain: 0),
    'l' => (crate: 0, ice: 0, chain: 1),
    'L' => (crate: 0, ice: 0, chain: 2),
    'j' => (crate: 0, ice: 1, chain: 1),
    'J' => (crate: 0, ice: 2, chain: 1),
    _ => (crate: 0, ice: 0, chain: 0),
  };

  /// Total damage points of each obstacle kind in a layout (objective caps).
  static Map<ObstacleKind, int> obstacleTotals(List<String>? rows) {
    final m = {for (final k in ObstacleKind.values) k: 0};
    for (final row in rows ?? const <String>[]) {
      for (final ch in row.split('')) {
        final o = parseObstacle(ch);
        m[ObstacleKind.crate] = m[ObstacleKind.crate]! + o.crate;
        m[ObstacleKind.ice] = m[ObstacleKind.ice]! + o.ice;
        m[ObstacleKind.chain] = m[ObstacleKind.chain]! + o.chain;
      }
    }
    return m;
  }

  ({int crate, int ice, int chain}) _layoutAt(int x, int y) {
    final rows = obstacles;
    if (rows == null || y >= rows.length || x >= rows[y].length) return (crate: 0, ice: 0, chain: 0);
    return parseObstacle(rows[y][x]);
  }

  /// Builds a board from digit rows, e.g. ['0120', '1201']. For tests.
  factory Match3Engine.fromLayout(List<String> rows, {required int typeCount, Set<SpecialFeature>? specials, int? seed}) {
    final e = Match3Engine(width: rows.first.length, height: rows.length, typeCount: typeCount, specials: specials, seed: seed);
    for (var y = 0; y < rows.length; y++) {
      for (var x = 0; x < rows[y].length; x++) {
        e.board.put(x, y, e._newTile(int.parse(rows[y][x])));
      }
    }
    return e;
  }

  Tile _newTile(int type, [SpecialKind s = SpecialKind.none]) => Tile(_nextId++, type, s);

  // ---------------------------------------------------------------------------
  // Generation
  // ---------------------------------------------------------------------------

  /// Fills the board with no pre-existing matches and at least one valid move.
  void generate() {
    // Crates first so runs are broken by them; ice/chains after filling.
    for (var y = 0; y < board.height; y++) {
      for (var x = 0; x < board.width; x++) {
        final o = _layoutAt(x, y);
        board.crates[y * board.width + x] = o.crate;
        board.ice[y * board.width + x] = o.ice;
      }
    }
    for (var attempt = 0; attempt < 500; attempt++) {
      for (var y = 0; y < board.height; y++) {
        for (var x = 0; x < board.width; x++) {
          if (board.crateAt(x, y) > 0) {
            board.put(x, y, null);
            continue;
          }
          final t = _newTile(_safeType(x, y));
          t.chain = _layoutAt(x, y).chain;
          board.put(x, y, t);
        }
      }
      if (findAnyMove() != null) return;
    }
  }

  /// Random type that does not complete a 3-run to the left or above.
  int _safeType(int x, int y) {
    final banned = <int>{};
    final l1 = board.at(x - 1, y), l2 = board.at(x - 2, y);
    if (l1 != null && l2 != null && l1.type == l2.type) banned.add(l1.type);
    final u1 = board.at(x, y - 1), u2 = board.at(x, y - 2);
    if (u1 != null && u2 != null && u1.type == u2.type) banned.add(u1.type);
    final options = [
      for (var t = 0; t < typeCount; t++)
        if (!banned.contains(t)) t,
    ];
    return options[_rng.nextInt(options.length)];
  }

  // ---------------------------------------------------------------------------
  // Move detection
  // ---------------------------------------------------------------------------

  bool _matchable(Tile? t) => t != null && t.special != SpecialKind.colorBomb;

  /// True if the tile at (x,y) is part of a horizontal or vertical 3-run.
  bool _hasMatchAt(int x, int y) {
    final t = board.at(x, y);
    if (!_matchable(t)) return false;
    bool same(int xx, int yy) {
      final o = board.at(xx, yy);
      return _matchable(o) && o!.type == t!.type;
    }

    var h = 1;
    for (var i = x - 1; same(i, y); i--) {
      h++;
    }
    for (var i = x + 1; same(i, y); i++) {
      h++;
    }
    if (h >= 3) return true;
    var v = 1;
    for (var j = y - 1; same(x, j); j--) {
      v++;
    }
    for (var j = y + 1; same(x, j); j++) {
      v++;
    }
    return v >= 3;
  }

  void _swapCells(Pos a, Pos b) {
    final t = board.atPos(a);
    board.putPos(a, board.atPos(b));
    board.putPos(b, t);
  }

  /// Returns a valid move (used for hints / tutorial / dead-board detection).
  /// Swapping any special is always valid, but normal moves are preferred.
  Move? findAnyMove() {
    Move? specialMove;
    for (var y = 0; y < board.height; y++) {
      for (var x = 0; x < board.width; x++) {
        final a = Pos(x, y);
        for (final b in [Pos(x + 1, y), Pos(x, y + 1)]) {
          if (!board.inBounds(b.x, b.y)) continue;
          final ta = board.atPos(a), tb = board.atPos(b);
          if (ta == null || tb == null || ta.locked || tb.locked) continue;
          if (ta.isSpecial || tb.isSpecial) {
            specialMove ??= Move(a, b);
            continue;
          }
          _swapCells(a, b);
          final ok = _hasMatchAt(a.x, a.y) || _hasMatchAt(b.x, b.y);
          _swapCells(a, b);
          if (ok) return Move(a, b);
        }
      }
    }
    return specialMove;
  }

  List<Move> allMoves() {
    final moves = <Move>[];
    for (var y = 0; y < board.height; y++) {
      for (var x = 0; x < board.width; x++) {
        final a = Pos(x, y);
        for (final b in [Pos(x + 1, y), Pos(x, y + 1)]) {
          if (!board.inBounds(b.x, b.y)) continue;
          final ta = board.atPos(a), tb = board.atPos(b);
          if (ta == null || tb == null || ta.locked || tb.locked) continue;
          if (ta.isSpecial || tb.isSpecial) {
            moves.add(Move(a, b));
            continue;
          }
          _swapCells(a, b);
          final ok = _hasMatchAt(a.x, a.y) || _hasMatchAt(b.x, b.y);
          _swapCells(a, b);
          if (ok) moves.add(Move(a, b));
        }
      }
    }
    return moves;
  }

  // ---------------------------------------------------------------------------
  // Player actions
  // ---------------------------------------------------------------------------

  /// Attempts a swap. Returns null for an illegal request (not adjacent / empty),
  /// a single reverted [SwapStep] for a swap that makes no match, or the full
  /// resolution otherwise.
  List<BoardStep>? trySwap(Pos a, Pos b) {
    if (!a.isAdjacent(b)) return null;
    final ta = board.atPos(a), tb = board.atPos(b);
    if (ta == null || tb == null || ta.locked || tb.locked) return null;

    // Special + special combos.
    if (ta.isSpecial && tb.isSpecial) {
      _swapCells(a, b);
      final seed = _comboSeed(a, b, ta, tb);
      return [SwapStep(a, b), ..._resolve(seed: seed)];
    }

    // Color bomb + normal piece: clear every tile of that type.
    if (ta.special == SpecialKind.colorBomb || tb.special == SpecialKind.colorBomb) {
      _swapCells(a, b);
      final bombPos = ta.special == SpecialKind.colorBomb ? b : a;
      final other = ta.special == SpecialKind.colorBomb ? tb : ta;
      final seed = _Seed()..consumed.add(bombPos);
      final targets = _positionsOfType(other.type);
      seed.clear
        ..add(bombPos)
        ..addAll(targets);
      seed.effects.add(SpecialEffect(EffectKind.colorBurst, bombPos, targets: targets));
      seed.bonus += scoring.specialActivatedBonus;
      return [SwapStep(a, b), ..._resolve(seed: seed)];
    }

    _swapCells(a, b);
    final groups = _findGroups();
    if (groups.isEmpty) {
      if (ta.isSpecial || tb.isSpecial) {
        // Rockets / bombs fire when swapped even without a match.
        final seed = _Seed()..activate.add(ta.isSpecial ? b : a);
        return [SwapStep(a, b), ..._resolve(seed: seed)];
      }
      _swapCells(a, b);
      return [SwapStep(a, b, reverted: true)];
    }
    return [
      SwapStep(a, b),
      ..._resolve(preferred: {a, b}),
    ];
  }

  /// Tapping a special piece fires it in place. Returns null if not special.
  List<BoardStep>? activateAt(Pos p) {
    final t = board.atPos(p);
    if (t == null || !t.isSpecial || t.locked) return null;
    return _resolve(seed: _Seed()..activate.add(p));
  }

  /// Debug / dead-board shuffle.
  ShuffleStep shuffle() => _shuffle();

  // ---------------------------------------------------------------------------
  // Resolution
  // ---------------------------------------------------------------------------

  List<Pos> _positionsOfType(int type) => [
    for (final p in board.positions)
      if (board.atPos(p) != null && board.atPos(p)!.type == type && board.atPos(p)!.special != SpecialKind.colorBomb) p,
  ];

  _Seed _comboSeed(Pos a, Pos b, Tile ta, Tile tb) {
    // After the swap, ta sits at b and tb at a. Effects centre on b.
    final seed = _Seed()..consumed.addAll({a, b});
    seed.clear.addAll({a, b});
    seed.bonus += scoring.specialActivatedBonus * 2;
    final ka = ta.special, kb = tb.special;
    final center = b;

    void addRow(int y) {
      if (y < 0 || y >= board.height) return;
      for (var x = 0; x < board.width; x++) {
        seed.clear.add(Pos(x, y));
      }
      seed.effects.add(SpecialEffect(EffectKind.row, Pos(center.x, y)));
    }

    void addCol(int x) {
      if (x < 0 || x >= board.width) return;
      for (var y = 0; y < board.height; y++) {
        seed.clear.add(Pos(x, y));
      }
      seed.effects.add(SpecialEffect(EffectKind.column, Pos(x, center.y)));
    }

    if (ka == SpecialKind.colorBomb && kb == SpecialKind.colorBomb) {
      seed.clear.addAll(board.positions);
      seed.effects.add(SpecialEffect(EffectKind.fullBoard, center));
      return seed;
    }
    if (ka == SpecialKind.colorBomb || kb == SpecialKind.colorBomb) {
      // Colour bomb + rocket/bomb: every tile of that type becomes that special.
      final other = ka == SpecialKind.colorBomb ? tb : ta;
      final targets = _positionsOfType(other.type).where((p) => p != a && p != b && !board.atPos(p)!.locked).toList();
      for (final p in targets) {
        final t = board.atPos(p)!;
        t.special = other.special == SpecialKind.bomb
            ? SpecialKind.bomb
            : (_rng.nextBool() ? SpecialKind.rocketH : SpecialKind.rocketV);
        seed.activate.add(p);
      }
      seed.effects.add(SpecialEffect(EffectKind.colorBurst, center, targets: targets));
      return seed;
    }
    if (ka.isRocket && kb.isRocket) {
      addRow(center.y);
      addCol(center.x);
      return seed;
    }
    if (ka == SpecialKind.bomb && kb == SpecialKind.bomb) {
      for (var dy = -2; dy <= 2; dy++) {
        for (var dx = -2; dx <= 2; dx++) {
          final p = Pos(center.x + dx, center.y + dy);
          if (board.inBounds(p.x, p.y)) seed.clear.add(p);
        }
      }
      seed.effects.add(SpecialEffect(EffectKind.area, center, radius: 3));
      return seed;
    }
    // Rocket + bomb: three rows and three columns.
    for (var d = -1; d <= 1; d++) {
      addRow(center.y + d);
      addCol(center.x + d);
    }
    return seed;
  }

  /// Cells a special clears when activated, plus its visual effect.
  (List<Pos>, SpecialEffect) _activationArea(Pos p, Tile t) {
    switch (t.special) {
      case SpecialKind.rocketH:
        return ([for (var x = 0; x < board.width; x++) Pos(x, p.y)], SpecialEffect(EffectKind.row, p));
      case SpecialKind.rocketV:
        return ([for (var y = 0; y < board.height; y++) Pos(p.x, y)], SpecialEffect(EffectKind.column, p));
      case SpecialKind.bomb:
        final cells = <Pos>[];
        for (var dy = -2; dy <= 2; dy++) {
          for (var dx = -2; dx <= 2; dx++) {
            if (dx.abs() + dy.abs() <= 2 && board.inBounds(p.x + dx, p.y + dy)) {
              cells.add(Pos(p.x + dx, p.y + dy));
            }
          }
        }
        return (cells, SpecialEffect(EffectKind.area, p, radius: 2));
      case SpecialKind.colorBomb:
        // Chain-triggered colour bomb targets the most common type.
        final counts = List<int>.filled(typeCount, 0);
        for (final q in board.positions) {
          final o = board.atPos(q);
          if (o != null && o.special != SpecialKind.colorBomb) counts[o.type]++;
        }
        var best = 0;
        for (var i = 1; i < typeCount; i++) {
          if (counts[i] > counts[best]) best = i;
        }
        final targets = _positionsOfType(best);
        return ([p, ...targets], SpecialEffect(EffectKind.colorBurst, p, targets: targets));
      case SpecialKind.none:
        return ([p], SpecialEffect(EffectKind.area, p));
    }
  }

  List<_Group> _findGroups() {
    final runs = <_Run>[];
    for (var y = 0; y < board.height; y++) {
      var x = 0;
      while (x < board.width) {
        final t = board.at(x, y);
        if (!_matchable(t)) {
          x++;
          continue;
        }
        var len = 1;
        while (x + len < board.width && _matchable(board.at(x + len, y)) && board.at(x + len, y)!.type == t!.type) {
          len++;
        }
        if (len >= 3) runs.add(_Run([for (var i = 0; i < len; i++) Pos(x + i, y)], true));
        x += len;
      }
    }
    for (var x = 0; x < board.width; x++) {
      var y = 0;
      while (y < board.height) {
        final t = board.at(x, y);
        if (!_matchable(t)) {
          y++;
          continue;
        }
        var len = 1;
        while (y + len < board.height && _matchable(board.at(x, y + len)) && board.at(x, y + len)!.type == t!.type) {
          len++;
        }
        if (len >= 3) runs.add(_Run([for (var i = 0; i < len; i++) Pos(x, y + i)], false));
        y += len;
      }
    }

    // Merge runs sharing cells (T / L / + shapes) into groups.
    final groups = <_Group>[];
    for (final run in runs) {
      final touching = groups.where((g) => run.cells.any(g.cells.contains)).toList();
      final target = touching.isEmpty ? _Group(board.atPos(run.cells.first)!.type) : touching.first;
      if (touching.isEmpty) groups.add(target);
      for (final other in touching.skip(1)) {
        target.cells.addAll(other.cells);
        target.runs.addAll(other.runs);
        groups.remove(other);
      }
      target.cells.addAll(run.cells);
      target.runs.add(run);
    }
    return groups;
  }

  SpecialKind _specialFor(_Group g) {
    final rocket = specials.contains(SpecialFeature.rocket);
    final bomb = specials.contains(SpecialFeature.bomb);
    final color = specials.contains(SpecialFeature.colorBomb);
    final longest = g.runs.reduce((a, b) => a.cells.length >= b.cells.length ? a : b);
    final rocketKind = longest.horizontal ? SpecialKind.rocketH : SpecialKind.rocketV;
    if (g.maxLen >= 5) {
      if (color) return SpecialKind.colorBomb;
      if (bomb) return SpecialKind.bomb;
      if (rocket) return rocketKind;
      return SpecialKind.none;
    }
    if (g.hasH && g.hasV) {
      if (bomb) return SpecialKind.bomb;
      if (rocket && g.maxLen >= 4) return rocketKind;
      return SpecialKind.none;
    }
    if (g.maxLen == 4 && rocket) return rocketKind;
    return SpecialKind.none;
  }

  Pos _pivot(_Group g, Set<Pos> preferred) {
    for (final p in preferred) {
      if (g.cells.contains(p)) return p;
    }
    if (g.hasH && g.hasV) {
      for (final h in g.runs.where((r) => r.horizontal)) {
        for (final v in g.runs.where((r) => !r.horizontal)) {
          for (final c in h.cells) {
            if (v.cells.contains(c)) return c;
          }
        }
      }
    }
    final longest = g.runs.reduce((a, b) => a.cells.length >= b.cells.length ? a : b);
    return longest.cells[longest.cells.length ~/ 2];
  }

  int _createdBonus(SpecialKind k) => switch (k) {
    SpecialKind.rocketH || SpecialKind.rocketV => scoring.rocketCreatedBonus,
    SpecialKind.bomb => scoring.bombCreatedBonus,
    SpecialKind.colorBomb => scoring.colorBombCreatedBonus,
    SpecialKind.none => 0,
  };

  /// Core loop: match → create specials → chain activations → clear →
  /// gravity → refill, repeated until the board is stable.
  List<BoardStep> _resolve({_Seed? seed, Set<Pos> preferred = const {}}) {
    final steps = <BoardStep>[];
    var cascade = 0;
    var pending = seed;
    var prefer = preferred;

    while (cascade < 60) {
      final groups = _findGroups();
      if (groups.isEmpty && pending == null) break;

      final clear = <Pos>{};
      final activated = <Pos>{};
      final effects = <SpecialEffect>[];
      final queue = Queue<Pos>();
      final createdPlan = <(Pos, SpecialKind, int)>[];
      var bonus = 0;

      if (pending != null) {
        clear.addAll(pending.clear);
        activated.addAll(pending.consumed);
        effects.addAll(pending.effects);
        queue.addAll(pending.activate);
        bonus += pending.bonus;
      }

      for (final g in groups) {
        clear.addAll(g.cells);
        final kind = _specialFor(g);
        if (kind != SpecialKind.none) {
          // Specials are never placed on a chained piece (it stays put).
          var pivot = _pivot(g, prefer);
          if (board.atPos(pivot)?.locked ?? false) {
            pivot = g.cells.firstWhere((c) => !(board.atPos(c)?.locked ?? true), orElse: () => pivot);
          }
          if (!(board.atPos(pivot)?.locked ?? false)) createdPlan.add((pivot, kind, g.type));
        }
      }

      for (final p in clear) {
        if (board.atPos(p)?.isSpecial == true && !activated.contains(p)) queue.add(p);
      }

      // Chain reactions: activated specials can hit other specials.
      while (queue.isNotEmpty) {
        final p = queue.removeFirst();
        if (!activated.add(p)) continue;
        final t = board.atPos(p);
        if (t == null || !t.isSpecial) continue;
        final (cells, effect) = _activationArea(p, t);
        effects.add(effect);
        bonus += scoring.specialActivatedBonus;
        for (final c in cells) {
          clear.add(c);
          if (board.atPos(c)?.isSpecial == true && !activated.contains(c)) queue.add(c);
        }
      }

      final hits = <ObstacleHit>[];
      // Crates: hit by blasts on their cell and by matches next to them
      // (at most one point of damage per crate per step).
      final crateHits = <Pos>{
        for (final p in clear)
          if (board.hasCrate(p)) p,
        for (final g in groups)
          for (final c in g.cells)
            for (final n in [Pos(c.x + 1, c.y), Pos(c.x - 1, c.y), Pos(c.x, c.y + 1), Pos(c.x, c.y - 1)])
              if (board.hasCrate(n)) n,
      };
      for (final p in crateHits) {
        final i = p.y * board.width + p.x;
        board.crates[i]--;
        hits.add(ObstacleHit(ObstacleKind.crate, p, board.crates[i]));
      }

      final cleared = <ClearedTile>[];
      final collected = <int, int>{};
      for (final p in clear) {
        final t = board.atPos(p);
        if (t == null) continue;
        if (t.locked) {
          // A chained piece loses a chain stage instead of being cleared.
          t.chain--;
          hits.add(ObstacleHit(ObstacleKind.chain, p, t.chain, tileId: t.id));
          continue;
        }
        cleared.add(ClearedTile(t.id, p, t.type, t.special));
        if (t.special != SpecialKind.colorBomb) collected[t.type] = (collected[t.type] ?? 0) + 1;
        board.putPos(p, null);
        final i = p.y * board.width + p.x;
        if (board.ice[i] > 0) {
          board.ice[i]--;
          hits.add(ObstacleHit(ObstacleKind.ice, p, board.ice[i]));
        }
      }

      final created = <CreatedSpecial>[];
      for (final (pos, kind, type) in createdPlan) {
        final t = _newTile(type, kind);
        board.putPos(pos, t);
        created.add(CreatedSpecial(t.id, pos, type, kind));
        bonus += _createdBonus(kind);
      }

      final base = cleared.length * scoring.pointsPerPiece + hits.length * scoring.obstacleHitBonus + bonus;
      steps.add(
        ClearStep(
          cleared: cleared,
          created: created,
          effects: effects,
          collected: collected,
          score: (base * scoring.multiplierFor(cascade)).round(),
          cascade: cascade,
          obstacleHits: hits,
        ),
      );
      steps.add(_applyGravity());

      pending = null;
      prefer = const {};
      cascade++;
    }

    if (findAnyMove() == null) steps.add(_shuffle());
    return steps;
  }

  FallStep _applyGravity() {
    final moves = <TileMove>[];
    final spawns = <TileSpawn>[];
    for (var x = 0; x < board.width; x++) {
      // Free cells bottom-up. Crates and chained pieces stay fixed; pieces
      // above them fall past (behind) them into free cells below.
      final slots = [
        for (var y = board.height - 1; y >= 0; y--)
          if (board.isSlot(x, y)) y,
      ];
      final falling = <(Tile, int)>[];
      for (final y in slots) {
        final t = board.at(x, y);
        if (t != null) falling.add((t, y));
        board.put(x, y, null);
      }
      for (var i = 0; i < falling.length; i++) {
        final (t, fromY) = falling[i];
        final y = slots[i];
        board.put(x, y, t);
        if (y != fromY) moves.add(TileMove(t.id, Pos(x, fromY), Pos(x, y)));
      }
      for (var i = falling.length; i < slots.length; i++) {
        final y = slots[i];
        final t = _newTile(_rng.nextInt(typeCount));
        board.put(x, y, t);
        spawns.add(TileSpawn(t.id, t.type, t.special, Pos(x, y), -1 - (i - falling.length)));
      }
    }
    return FallStep(moves, spawns);
  }

  ShuffleStep _shuffle() {
    // Only free pieces are shuffled; crates and chained pieces stay put.
    final cells = [
      for (final p in board.positions)
        if (board.atPos(p) != null && !board.atPos(p)!.locked) p,
    ];
    final tiles = [for (final p in cells) board.atPos(p)!];
    var ok = false;
    for (var attempt = 0; attempt < 200 && !ok; attempt++) {
      tiles.shuffle(_rng);
      for (var i = 0; i < cells.length; i++) {
        board.putPos(cells[i], i < tiles.length ? tiles[i] : null);
      }
      ok = _findGroups().isEmpty && findAnyMove() != null;
    }
    if (!ok) {
      // Fall back to re-rolling types in place (keeps tile identities).
      for (var attempt = 0; attempt < 500 && !ok; attempt++) {
        for (var y = 0; y < board.height; y++) {
          for (var x = 0; x < board.width; x++) {
            final t = board.at(x, y);
            if (t != null && !t.isSpecial && !t.locked) {
              board.put(x, y, null);
              t.type = _safeType(x, y);
              board.put(x, y, t);
            }
          }
        }
        ok = _findGroups().isEmpty && findAnyMove() != null;
      }
    }
    if (!ok) {
      // Last resort so a board can never dead-lock: release all chains.
      for (final p in board.positions) {
        board.atPos(p)?.chain = 0;
      }
    }
    return ShuffleStep([
      for (final p in board.positions)
        if (board.atPos(p) != null) ShuffledTile(board.atPos(p)!.id, board.atPos(p)!.type, board.atPos(p)!.special, p, chain: board.atPos(p)!.chain),
    ]);
  }
}
