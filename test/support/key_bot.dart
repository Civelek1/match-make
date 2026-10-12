import 'dart:math';

import 'package:match_make/match3/board.dart';
import 'package:match_make/match3/match3_engine.dart';

bool _matchable(Tile? t) => t != null && !t.drop && t.special != SpecialKind.colorBomb;

/// Cells a swap would clear by its direct match (no specials / cascades).
Set<Pos> directClears(Board b, Move m) {
  final ta = b.atPos(m.a), tb = b.atPos(m.b);
  b.putPos(m.a, tb);
  b.putPos(m.b, ta);
  final out = <Pos>{};
  for (final p in [m.a, m.b]) {
    final t = b.atPos(p);
    if (!_matchable(t)) continue;
    bool same(int x, int y) => _matchable(b.at(x, y)) && b.at(x, y)!.type == t!.type;
    final h = [p];
    for (var x = p.x - 1; same(x, p.y); x--) {
      h.add(Pos(x, p.y));
    }
    for (var x = p.x + 1; same(x, p.y); x++) {
      h.add(Pos(x, p.y));
    }
    final v = [p];
    for (var y = p.y - 1; same(p.x, y); y--) {
      v.add(Pos(p.x, y));
    }
    for (var y = p.y + 1; same(p.x, y); y++) {
      v.add(Pos(p.x, y));
    }
    if (h.length >= 3) out.addAll(h);
    if (v.length >= 3) out.addAll(v);
  }
  b.putPos(m.a, ta);
  b.putPos(m.b, tb);
  return out;
}

/// How far keys would descend: every cleared cell under a key lowers it by one.
int keyDescent(Board b, Iterable<Pos> cleared) {
  var n = 0;
  for (final c in cleared) {
    for (var y = 0; y < c.y; y++) {
      if (b.at(c.x, y)?.drop ?? false) n++;
    }
  }
  return n;
}

/// Score bonus for a move that helps bring keys down (0 if no keys).
double keyMoveValue(Board b, Move m) {
  final ta = b.atPos(m.a)!, tb = b.atPos(m.b)!;
  var v = 0.0;
  // Swapping a key straight down.
  if ((ta.drop && m.b.y > m.a.y) || (tb.drop && m.a.y > m.b.y)) v += 8;
  v += keyDescent(b, directClears(b, m)) * 4;
  // Specials in a key's column clear under it.
  for (final p in [m.a, m.b]) {
    final t = b.atPos(p)!;
    if (!t.isSpecial) continue;
    for (var y = 0; y < b.height; y++) {
      if (b.at(p.x, y)?.drop ?? false) v += 10;
    }
  }
  return v;
}

/// Key-chasing move picker used by tests.
Move keyAwareMove(Match3Engine e, Random rng) {
  final moves = e.allMoves();
  double score(Move m) {
    final ta = e.board.atPos(m.a)!, tb = e.board.atPos(m.b)!;
    return keyMoveValue(e.board, m) + (ta.isSpecial || tb.isSpecial ? 3 : 0) + rng.nextDouble();
  }

  moves.sort((x, y) => score(y).compareTo(score(x)));
  return moves.first;
}
