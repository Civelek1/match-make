import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:match_make/data/content/game_content.dart';
import 'package:match_make/data/models/level_data.dart';
import 'package:match_make/game/level_session.dart';
import 'package:match_make/match3/board.dart';
import 'package:match_make/match3/match3_engine.dart';

import 'support/key_bot.dart';

/// A deliberately simple bot: prefers specials, then moves whose tile type is
/// still needed by the objective with the most remaining, with a bonus for
/// playing next to obstacles an objective still needs and for clearing
/// under keys. Humans plan better,
/// so a level the bot can beat is comfortably beatable.
Move pickMove(LevelSession s, Random rng) {
  final moves = s.engine.allMoves();
  final b = s.engine.board;
  int need(String id) {
    var n = 0;
    for (final o in s.level.objectives) {
      if (o.tileTypeId == id) n = max(n, o.target - s.progress[o.id]!);
    }
    return n;
  }

  final crateNeed = need('crate'), iceNeed = need('ice'), chainNeed = need('chain'), keyNeed = need('key');
  double near(Pos p) {
    var bonus = 0.0;
    for (final d in const [Pos(0, 0), Pos(1, 0), Pos(-1, 0), Pos(0, 1), Pos(0, -1)]) {
      final q = Pos(p.x + d.x, p.y + d.y);
      if (!b.inBounds(q.x, q.y)) continue;
      if (crateNeed > 0 && b.hasCrate(q)) bonus += 6;
      if (iceNeed > 0 && b.iceAt(q.x, q.y) > 0 && d == const Pos(0, 0)) bonus += 5;
      if (chainNeed > 0 && (b.atPos(q)?.locked ?? false)) bonus += 6;
    }
    return bonus;
  }

  double scoreOf(Move m) {
    final ta = b.atPos(m.a)!, tb = b.atPos(m.b)!;
    if (ta.isSpecial || tb.isSpecial) return 1000 + rng.nextDouble();
    var best = 0.0;
    for (final t in [ta.type, tb.type]) {
      best = max(best, need(s.level.tileTypeIds[t]).toDouble());
    }
    // Keys are the slowest objective, so a sensible player chases them first.
    final keys = keyNeed > 0 ? keyMoveValue(b, m) * 5 : 0.0;
    return best + near(m.a) + near(m.b) + keys + rng.nextDouble();
  }

  moves.sort((x, y) => scoreOf(y).compareTo(scoreOf(x)));
  return moves.first;
}

({double winRate, List<int> scores, List<int> stars}) simulate(LevelData level, int runs) {
  var wins = 0;
  final scores = <int>[];
  final stars = <int>[];
  for (var seed = 0; seed < runs; seed++) {
    final s = LevelSession(level, seed: seed * 31 + 7);
    final rng = Random(seed);
    while (s.isPlaying) {
      final m = pickMove(s, rng);
      final r = s.trySwap(m.a, m.b);
      expect(r, isNotNull);
      expect(s.engine.board.isFull, isTrue);
      expect(s.engine.findAnyMove(), isNotNull);
    }
    if (s.state == SessionState.won) {
      wins++;
      scores.add(s.finalScore);
      stars.add(s.stars);
    }
  }
  scores.sort();
  return (winRate: wins / runs, scores: scores, stars: stars);
}

void main() {
  final content = GameContent.standard();
  // Minimum bot win rates: the curve falls chapter by chapter, but no level
  // is luck-only. Level 50 is the finale.
  const minWinRate = {
    'garden': 0.9, 'kitchen': 0.75, 'bathroom': 0.6, 'gaming_room': 0.5, 'attic': 0.4,
    'farmyard': 0.85, 'barn': 0.7, 'chicken_coop': 0.58, 'workshop': 0.58, 'farmhouse': 0.48,
    'entrance': 0.6, 'rest_kitchen': 0.5, 'dining_hall': 0.58, 'terrace': 0.46, 'vip_room': 0.5,
    'beach': 0.46, 'pool': 0.44, 'beach_bar': 0.44, 'hotel_room': 0.45, 'rooftop': 0.36,
    'front_yard': 0.3, 'grand_hall': 0.3, 'luxury_bedroom': 0.33, 'cinema_room': 0.3, 'penthouse': 0.2,
    // Chapters 6–10 (keys from level 26). Each chapter opens gently and ends harder.
    'castle_gate': 0.62, 'banquet_hall': 0.5, 'castle_library': 0.44, 'armory': 0.46, 'throne_room': 0.4,
    'lodge_front': 0.56, 'lodge_lounge': 0.46, 'ski_room': 0.4, 'lodge_spa': 0.4, 'lodge_suite': 0.4,
    'harbor_dock': 0.46, 'fish_market': 0.4, 'boathouse': 0.4, 'lighthouse_base': 0.42, 'keeper_cottage': 0.32,
    'museum_steps': 0.48, 'sculpture_hall': 0.38, 'art_gallery': 0.38, 'history_hall': 0.4, 'museum_cafe': 0.34,
    'theater_front': 0.38, 'theater_lobby': 0.36, 'dressing_room': 0.36, 'concert_hall': 0.34, 'grand_stage': 0.3,
  };

  for (final chapter in content.chapters) {
    for (final level in content.levelsOf(chapter.id)) {
      test('level ${level.number} ${level.id} is beatable by a simple bot', () {
        final r = simulate(level, 100);
        final s = r.scores;
        String pct(double p) => s.isEmpty ? '-' : '${s[(p * (s.length - 1)).round()]}';
        final dist = [1, 2, 3].map((k) => r.stars.where((x) => x == k).length).toList();
        // ignore: avoid_print
        print(
          '${level.number} ${level.id}: win ${(r.winRate * 100).toStringAsFixed(0)}% '
          'score p50=${pct(.5)} p90=${pct(.9)} stars1/2/3=$dist',
        );
        expect(r.winRate, greaterThanOrEqualTo(minWinRate[level.id]!));
      });
    }
  }

  test('obstacle objectives never exceed what the layout contains', () {
    for (final l in content.allLevels) {
      final totals = Match3Engine.obstacleTotals(l.obstacles);
      for (final o in l.objectives.where((o) => o.isObstacle)) {
        final kind = ObstacleKind.values.byName(o.tileTypeId);
        expect(o.target, lessThanOrEqualTo(totals[kind]!), reason: '${l.id}/${o.id}');
      }
      expect(l.objectives.length, inInclusiveRange(5, 7), reason: l.id);
    }
  });

  test('special piece moves are always accepted', () {
    final s = LevelSession(content.level('attic')!, seed: 1);
    s.engine.board.at(0, 0)!.special = SpecialKind.bomb;
    final r = s.trySwap(const Pos(0, 0), const Pos(1, 0));
    expect(r!.consumedMove, isTrue);
    expect(s.movesLeft, s.level.moves - 1);
  });
}
