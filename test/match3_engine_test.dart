import 'package:flutter_test/flutter_test.dart';
import 'package:match_make/data/models/level_data.dart';
import 'package:match_make/match3/board.dart';
import 'package:match_make/match3/board_steps.dart';
import 'package:match_make/match3/match3_engine.dart';

bool hasAnyMatch(Board b) {
  for (var y = 0; y < b.height; y++) {
    for (var x = 0; x < b.width; x++) {
      final t = b.at(x, y);
      if (t == null || t.special == SpecialKind.colorBomb) continue;
      bool same(Tile? o) => o != null && o.special != SpecialKind.colorBomb && o.type == t.type;
      if (same(b.at(x + 1, y)) && same(b.at(x + 2, y))) return true;
      if (same(b.at(x, y + 1)) && same(b.at(x, y + 2))) return true;
    }
  }
  return false;
}

void main() {
  group('generation', () {
    test('never starts with matches and always has a move', () {
      for (var seed = 0; seed < 300; seed++) {
        final e = Match3Engine(width: 8, height: 8, typeCount: 6, seed: seed)..generate();
        expect(e.board.isFull, isTrue);
        expect(hasAnyMatch(e.board), isFalse, reason: 'seed $seed');
        expect(e.findAnyMove(), isNotNull, reason: 'seed $seed');
      }
    });
  });

  group('swaps', () {
    test('non-adjacent swap is rejected', () {
      final e = Match3Engine(width: 8, height: 8, typeCount: 5, seed: 1)..generate();
      expect(e.trySwap(const Pos(0, 0), const Pos(2, 0)), isNull);
      expect(e.trySwap(const Pos(0, 0), const Pos(1, 1)), isNull);
    });

    test('swap without match is reverted and board unchanged', () {
      final e = Match3Engine.fromLayout(['0123', '1230', '2301', '3012'], typeCount: 4);
      final before = [for (final p in e.board.positions) e.board.atPos(p)!.id];
      final steps = e.trySwap(const Pos(0, 0), const Pos(1, 0))!;
      expect(steps.single, isA<SwapStep>());
      expect((steps.single as SwapStep).reverted, isTrue);
      expect([for (final p in e.board.positions) e.board.atPos(p)!.id], before);
    });

    test('horizontal match clears three and refills', () {
      final e = Match3Engine.fromLayout(['0010', '1203', '2312', '3123'], typeCount: 4, seed: 3);
      final steps = e.trySwap(const Pos(2, 0), const Pos(3, 0))!;
      final clear = steps.whereType<ClearStep>().first;
      expect(clear.cleared.length, 3);
      expect(clear.collected[0], 3);
      expect(e.board.isFull, isTrue);
      expect(hasAnyMatch(e.board), isFalse);
    });

    test('vertical match detected', () {
      final e = Match3Engine.fromLayout(['0123', '0231', '1032', '2013'], typeCount: 4, seed: 3);
      final steps = e.trySwap(const Pos(0, 2), const Pos(1, 2))!;
      final clear = steps.whereType<ClearStep>().first;
      expect(clear.cleared.map((c) => c.pos.x).toSet(), {0});
      expect(clear.cleared.length, 3);
    });
  });

  group('specials', () {
    test('4 in a row creates a rocket at the swapped cell', () {
      final e = Match3Engine.fromLayout(['00102', '12023', '23312', '31231', '12312'], typeCount: 4, seed: 5);
      final steps = e.trySwap(const Pos(2, 0), const Pos(2, 1))!;
      final clear = steps.whereType<ClearStep>().first;
      expect(clear.created.single.kind, SpecialKind.rocketH);
      expect(clear.created.single.pos, const Pos(2, 0));
    });

    test('5 in a row creates a colour bomb', () {
      final e = Match3Engine.fromLayout(['00102', '12023', '23312', '31231', '12312'], typeCount: 4, seed: 5);
      e.board.at(0, 0)!.type = 0;
      e.board.at(4, 0)!.type = 0;
      e.board.at(3, 0)!.type = 0;
      final steps = e.trySwap(const Pos(2, 0), const Pos(2, 1))!;
      expect(steps.whereType<ClearStep>().first.created.single.kind, SpecialKind.colorBomb);
    });

    test('L shape creates a bomb', () {
      // Moving the 0 at (0,3) up forms column x=0 rows 0-2 + row 2 x=0-2.
      final e = Match3Engine.fromLayout(['01231', '02312', '30023', '03121', '12312'], typeCount: 4, seed: 5);
      final steps = e.trySwap(const Pos(0, 3), const Pos(0, 2))!;
      final clear = steps.whereType<ClearStep>().first;
      expect(clear.created.single.kind, SpecialKind.bomb);
      expect(clear.created.single.pos, const Pos(0, 2));
    });

    test('disabled specials are not created', () {
      final e = Match3Engine.fromLayout(['00102', '12023', '23312', '31231', '12312'], typeCount: 4, specials: {}, seed: 5);
      final steps = e.trySwap(const Pos(2, 0), const Pos(2, 1))!;
      expect(steps.whereType<ClearStep>().first.created, isEmpty);
    });

    test('rocket clears its full row when swapped', () {
      final e = Match3Engine.fromLayout(['0123', '1230', '2301', '3012'], typeCount: 4, seed: 9);
      e.board.at(1, 1)!.special = SpecialKind.rocketH;
      final steps = e.trySwap(const Pos(1, 1), const Pos(1, 0))!;
      final clear = steps.whereType<ClearStep>().first;
      // Rocket moved to (1,0) and clears row 0.
      expect(clear.cleared.where((c) => c.pos.y == 0).length, 4);
      expect(clear.effects.any((f) => f.kind == EffectKind.row), isTrue);
    });

    test('colour bomb + normal clears every tile of that type', () {
      final e = Match3Engine.fromLayout(['0123', '1230', '2301', '3012'], typeCount: 4, seed: 9);
      e.board.at(0, 0)!.special = SpecialKind.colorBomb;
      final steps = e.trySwap(const Pos(0, 0), const Pos(1, 0))!; // other is type 1
      final clear = steps.whereType<ClearStep>().first;
      expect(clear.collected[1], 4);
    });

    test('rocket + rocket clears row and column', () {
      final e = Match3Engine.fromLayout(['01230', '12301', '23012', '30123', '01230'], typeCount: 4, seed: 2);
      e.board.at(2, 2)!.special = SpecialKind.rocketH;
      e.board.at(3, 2)!.special = SpecialKind.rocketV;
      final steps = e.trySwap(const Pos(2, 2), const Pos(3, 2))!;
      final clear = steps.whereType<ClearStep>().first;
      expect(clear.cleared.length, 9); // 5 + 5 - 1 overlap
    });

    test('chain reaction: rocket hits bomb', () {
      final e = Match3Engine.fromLayout(['01230', '12301', '23012', '30123', '01230'], typeCount: 4, seed: 2);
      e.board.at(0, 2)!.special = SpecialKind.rocketH;
      e.board.at(4, 2)!.special = SpecialKind.bomb;
      final steps = e.activateAt(const Pos(0, 2))!;
      final clear = steps.whereType<ClearStep>().first;
      expect(clear.effects.map((f) => f.kind), containsAll([EffectKind.row, EffectKind.area]));
      expect(clear.cleared.length, greaterThan(5));
    });

    test('special swap always valid, even without match', () {
      final e = Match3Engine.fromLayout(['0123', '1230', '2301', '3012'], typeCount: 4, seed: 9);
      e.board.at(2, 2)!.special = SpecialKind.bomb;
      final steps = e.trySwap(const Pos(2, 2), const Pos(3, 2))!;
      expect((steps.first as SwapStep).reverted, isFalse);
    });
  });

  group('stability', () {
    test('random play keeps the board full, stable and playable', () {
      for (var seed = 0; seed < 40; seed++) {
        final e = Match3Engine(width: 8, height: 8, typeCount: 6, seed: seed)..generate();
        for (var turn = 0; turn < 60; turn++) {
          final m = e.findAnyMove()!;
          e.trySwap(m.a, m.b);
          expect(e.board.isFull, isTrue);
          expect(hasAnyMatch(e.board), isFalse);
          expect(e.findAnyMove(), isNotNull);
        }
      }
    });

    test('dead board is shuffled into a playable one', () {
      final e = Match3Engine.fromLayout(
        ['0101', '2323', '0101', '2323'],
        typeCount: 4,
        seed: 4,
        specials: {SpecialFeature.rocket},
      );
      expect(e.findAnyMove(), isNull);
      final s = e.shuffle();
      expect(s.tiles.length, 16);
      expect(e.findAnyMove(), isNotNull);
      expect(hasAnyMatch(e.board), isFalse);
    });

    test('tile ids stay unique', () {
      final e = Match3Engine(width: 8, height: 8, typeCount: 5, seed: 11)..generate();
      for (var i = 0; i < 50; i++) {
        final m = e.findAnyMove()!;
        e.trySwap(m.a, m.b);
        final ids = [for (final p in e.board.positions) e.board.atPos(p)!.id];
        expect(ids.toSet().length, ids.length);
      }
    });
  });
}
