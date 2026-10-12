import 'package:flutter_test/flutter_test.dart';
import 'package:match_make/data/content/game_content.dart';
import 'package:match_make/match3/board.dart';
import 'package:match_make/match3/board_steps.dart';
import 'package:match_make/match3/match3_engine.dart';

import 'match3_engine_test.dart' show hasAnyMatch;

/// Places obstacles on a fromLayout board.
Match3Engine withObstacles(List<String> tiles, List<String> obstacles, {int seed = 3}) {
  final e = Match3Engine.fromLayout(tiles, typeCount: 4, seed: seed);
  for (var y = 0; y < obstacles.length; y++) {
    for (var x = 0; x < obstacles[y].length; x++) {
      final o = Match3Engine.parseObstacle(obstacles[y][x]);
      final i = y * e.board.width + x;
      e.board.crates[i] = o.crate;
      e.board.ice[i] = o.ice;
      if (o.crate > 0) e.board.put(x, y, null);
      e.board.at(x, y)?.chain = o.chain;
    }
  }
  return e;
}

void main() {
  group('crates', () {
    test('a match next to a crate damages it once', () {
      final e = withObstacles(
        ['0010', '1203', '2312', '3123'],
        ['....', '..C.', '....', '....'],
      );
      final steps = e.trySwap(const Pos(2, 0), const Pos(3, 0))!;
      final clear = steps.whereType<ClearStep>().first;
      final hits = clear.obstacleHits.where((h) => h.kind == ObstacleKind.crate).toList();
      expect(hits.length, 1);
      expect(hits.single.remaining, 1);
      expect(e.board.crateAt(2, 1), 1);
    });

    test('rocket blast damages crates on its line', () {
      final e = withObstacles(
        ['0123', '1230', '2301', '3012'],
        ['....', '....', '.c..', '....'],
      );
      e.board.at(0, 2)!.special = SpecialKind.rocketH;
      final steps = e.activateAt(const Pos(0, 2))!;
      final clear = steps.whereType<ClearStep>().first;
      expect(clear.obstacleHits.any((h) => h.kind == ObstacleKind.crate && h.remaining == 0), isTrue);
      expect(e.board.crateAt(1, 2), 0);
    });

    test('pieces fall past crates and the board stays full', () {
      final e = withObstacles(
        ['1230', '2301', '3012', '0010'],
        ['....', '....', '.B..', '....'],
      );
      final above = e.board.at(1, 1)!.id;
      // Row 3 match clears (1,3) under the crate; the piece above falls past it.
      e.trySwap(const Pos(2, 3), const Pos(3, 3));
      expect(e.board.find(above), const Pos(1, 3));
      expect(e.board.isFull, isTrue);
      expect(e.board.at(1, 2), isNull, reason: 'crate cell never holds a piece');
      expect(e.board.crateAt(1, 2), 2);
    });
  });

  group('ice', () {
    test('clearing the piece on ice cracks one layer', () {
      final e = withObstacles(
        ['0010', '1203', '2312', '3123'],
        ['I...', '....', '....', '....'],
      );
      final steps = e.trySwap(const Pos(2, 0), const Pos(3, 0))!;
      final clear = steps.whereType<ClearStep>().first;
      expect(clear.obstacleHits.any((h) => h.kind == ObstacleKind.ice && h.remaining == 1), isTrue);
      expect(e.board.iceAt(0, 0), 1);
    });
  });

  group('chains', () {
    test('chained pieces cannot be swapped', () {
      final e = withObstacles(
        ['0123', '1230', '2301', '3012'],
        ['l...', '....', '....', '....'],
      );
      expect(e.trySwap(const Pos(0, 0), const Pos(1, 0)), isNull);
      expect(e.allMoves().any((m) => m.a == const Pos(0, 0) || m.b == const Pos(0, 0)), isFalse);
    });

    test('matching a chained piece breaks the chain instead of clearing it', () {
      final e = withObstacles(
        ['0010', '1203', '2312', '3123'],
        ['l...', '....', '....', '....'],
      );
      final id = e.board.at(0, 0)!.id;
      final steps = e.trySwap(const Pos(2, 0), const Pos(3, 0))!;
      final clear = steps.whereType<ClearStep>().first;
      expect(clear.obstacleHits.single.kind, ObstacleKind.chain);
      expect(clear.obstacleHits.single.remaining, 0);
      expect(clear.cleared.any((c) => c.id == id), isFalse);
    });

    test('chained pieces stay put while the column above refills', () {
      final e = withObstacles(
        ['0120', '0231', '1032', '2013'],
        ['....', '....', '....', 'l...'],
      );
      final id = e.board.at(0, 3)!.id;
      e.trySwap(const Pos(0, 2), const Pos(1, 2));
      expect(e.board.find(id), const Pos(0, 3));
      expect(e.board.isFull, isTrue);
    });

    test('shuffle never moves chained pieces or fills crates', () {
      final e = withObstacles(
        ['0101', '2323', '0101', '2323'],
        ['l...', '....', '..c.', '....'],
      );
      final id = e.board.at(0, 0)!.id;
      e.shuffle();
      expect(e.board.at(0, 0)!.id, id);
      expect(e.board.at(2, 2), isNull);
      expect(hasAnyMatch(e.board), isFalse);
    });
  });

  test('every new level generates a fair starting board', () {
    final content = GameContent.standard();
    for (final l in content.allLevels.where((l) => l.obstacles != null)) {
      for (var seed = 0; seed < 25; seed++) {
        final e = Match3Engine(
          width: l.gridWidth,
          height: l.gridHeight,
          typeCount: l.tileTypeIds.length,
          specials: l.specials,
          seed: seed,
          obstacles: l.obstacles,
        )..generate();
        expect(hasAnyMatch(e.board), isFalse, reason: '${l.id} seed $seed');
        expect(e.findAnyMove(), isNotNull, reason: '${l.id} seed $seed');
        expect(e.board.isFull, isTrue);
        final totals = Match3Engine.obstacleTotals(l.obstacles);
        expect(e.board.crates.fold(0, (a, b) => a + b), totals[ObstacleKind.crate]);
      }
    }
  });
}
