import 'package:flutter_test/flutter_test.dart';
import 'package:match_make/data/content/game_content.dart';
import 'package:match_make/game/level_session.dart';
import 'package:match_make/match3/board.dart';
import 'package:match_make/match3/board_steps.dart';
import 'package:match_make/match3/match3_engine.dart';

import 'match3_engine_test.dart' show hasAnyMatch;
import 'obstacles_test.dart' show withObstacles;

void main() {
  final content = GameContent.standard();

  group('hammer', () {
    test('smashes exactly one piece and refills', () {
      final e = Match3Engine.fromLayout(['0123', '1230', '2301', '3012'], typeCount: 4, seed: 1);
      final target = e.board.at(1, 2)!.id;
      final steps = e.hammerAt(const Pos(1, 2))!;
      final first = steps.whereType<ClearStep>().first;
      expect(first.cleared.map((c) => c.id), [target]);
      expect(first.effects.single.kind, EffectKind.hammer);
      expect(e.board.find(target), isNull);
      expect(e.board.isFull, isTrue);
      expect(hasAnyMatch(e.board), isFalse);
    });

    test('fires a special it hits', () {
      final e = Match3Engine.fromLayout(['0123', '1230', '2301', '3012'], typeCount: 4, seed: 1);
      e.board.at(0, 1)!.special = SpecialKind.rocketH;
      final first = e.hammerAt(const Pos(0, 1))!.whereType<ClearStep>().first;
      expect(first.cleared.length, 4);
      expect(first.effects.map((x) => x.kind), containsAll([EffectKind.hammer, EffectKind.row]));
    });

    test('takes one layer off a crate and one stage off a chain', () {
      final e = withObstacles(['0123', '1230', '2301', '3012'], ['....', '.C..', '..L.', '....']);
      final crateHit = e.hammerAt(const Pos(1, 1))!.whereType<ClearStep>().first;
      expect(crateHit.obstacleHits.single.kind, ObstacleKind.crate);
      expect(e.board.crateAt(1, 1), 1);

      final chained = e.board.at(2, 2)!;
      final chainHit = e.hammerAt(const Pos(2, 2))!.whereType<ClearStep>().first;
      expect(chainHit.obstacleHits.single.kind, ObstacleKind.chain);
      expect(chainHit.cleared, isEmpty);
      expect(chained.chain, 1);
      expect(e.board.atPos(const Pos(2, 2)), same(chained));
    });

    test('rejects out-of-board targets', () {
      final e = Match3Engine.fromLayout(['0123', '1230', '2301', '3012'], typeCount: 4, seed: 1);
      expect(e.hammerAt(const Pos(-1, 0)), isNull);
      expect(e.hammerAt(const Pos(4, 0)), isNull);
    });
  });

  group('broom', () {
    test('sweeps the whole row', () {
      final e = Match3Engine.fromLayout(['0123', '1230', '2301', '3012'], typeCount: 4, seed: 2);
      final ids = [for (var x = 0; x < 4; x++) e.board.at(x, 3)!.id];
      final first = e.sweepRow(3)!.whereType<ClearStep>().first;
      expect(first.cleared.map((c) => c.id).toSet(), containsAll(ids));
      expect(first.effects.first.kind, EffectKind.row);
      expect(e.board.isFull, isTrue);
      expect(e.sweepRow(4), isNull);
    });
  });

  test('start specials land on free normal pieces only', () {
    final e = withObstacles(['0123', '1230', '2301', '3012'], ['l.l.', '.l.l', 'l.l.', '.l.l'], seed: 9);
    final placed = e.placeSpecials(SpecialKind.bomb, 3);
    expect(placed.length, 3);
    for (final p in placed) {
      final t = e.board.atPos(p)!;
      expect(t.special, SpecialKind.bomb);
      expect(t.locked, isFalse);
    }
    // More requested than available: only the free ones change.
    final rest = e.placeSpecials(SpecialKind.rocketH, 100);
    expect(rest.length, 8 - 3);
  });

  group('session', () {
    test('boosters never cost a move but do count objectives and score', () {
      final s = LevelSession(content.level('garden')!, seed: 5);
      final moves = s.movesLeft;
      final r = s.useBroom(4)!;
      expect(r.consumedMove, isFalse);
      expect(s.movesLeft, moves);
      expect(s.movesUsed, 0);
      expect(s.score, greaterThan(0));
      expect(s.progress.values.fold(0, (a, b) => a + b), greaterThan(0));
      expect(s.useHammer(const Pos(0, 0))!.consumedMove, isFalse);
      final sh = s.useShuffle()!;
      expect(sh.steps.single, isA<ShuffleStep>());
      expect(s.movesLeft, moves);
    });

    test('a booster can finish the level', () {
      final s = LevelSession(content.level('garden')!, seed: 5);
      for (final o in s.level.objectives) {
        s.progress[o.id] = o.target - 1;
      }
      // Sweeping rows eventually collects the last pieces.
      for (var y = 0; y < s.level.gridHeight && s.isPlaying; y++) {
        s.useBroom(y);
      }
      expect(s.state, SessionState.won);
      expect(s.useHammer(const Pos(0, 0)), isNull);
    });

    test('start specials only before the first move', () {
      final s = LevelSession(content.level('farmyard')!, seed: 3);
      expect(s.placeStartSpecials([SpecialKind.bomb, SpecialKind.colorBomb]).length, 2);
      final m = s.engine.findAnyMove()!;
      s.trySwap(m.a, m.b);
      expect(s.placeStartSpecials([SpecialKind.bomb]), isEmpty);
    });
  });
}
