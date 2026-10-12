import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:match_make/data/models/level_data.dart';
import 'package:match_make/game/level_session.dart';
import 'package:match_make/match3/board.dart';
import 'package:match_make/match3/board_steps.dart';
import 'package:match_make/match3/match3_engine.dart';

import 'obstacles_test.dart' show withObstacles;
import 'support/key_bot.dart';

var _keyId = 5000;
Tile key() => Tile(_keyId++, 0, SpecialKind.none, true);

int keysOn(Board b) => b.positions.where((p) => b.atPos(p)?.drop ?? false).length;

int collected(List<BoardStep> steps) => steps.whereType<ClearStep>().fold(0, (n, s) => n + s.dropsCollected);

void main() {
  test('a key never takes part in a match', () {
    final e = Match3Engine.fromLayout(['0012', '1230', '2301', '3012'], typeCount: 4, seed: 1);
    e.board.put(2, 0, key());
    // Swapping a 0 next to the key cannot complete 0-0-key.
    expect(e.allMoves().any((m) => m.a == const Pos(2, 0) || m.b == const Pos(2, 0)), isFalse);
  });

  test('keys survive rockets and bombs', () {
    final e = Match3Engine.fromLayout(['0123', '1230', '2301', '3012'], typeCount: 4, seed: 1);
    final k = key();
    e.board.put(2, 0, k);
    e.board.at(0, 0)!.special = SpecialKind.rocketH;
    final steps = e.activateAt(const Pos(0, 0))!;
    final first = steps.whereType<ClearStep>().first;
    expect(first.cleared.any((c) => c.id == k.id), isFalse);
    expect(e.board.find(k.id), isNotNull);
  });

  test('a key falling to the bottom is collected and scored', () {
    final e = Match3Engine.fromLayout(['0123', '1230', '2301', '3012'], typeCount: 4, seed: 4);
    final k = key();
    e.board.put(0, 0, k);
    var got = 0;
    var score = 0;
    for (var i = 0; i < 6 && e.board.find(k.id) != null; i++) {
      final steps = e.hammerAt(Pos(0, e.board.height - 1))!;
      got += collected(steps);
      score += steps.whereType<ClearStep>().fold(0, (n, s) => n + s.score);
    }
    expect(got, 1);
    expect(e.board.find(k.id), isNull);
    expect(e.board.isFull, isTrue);
    expect(score, greaterThanOrEqualTo(1000));
  });

  test('the exit is the lowest free cell: a key resting on a crate is collected', () {
    final e = withObstacles(['0123', '1230', '2301', '3012'], ['....', '....', '....', 'C...'], seed: 2);
    final k = key();
    e.board.put(0, 1, k);
    final steps = e.hammerAt(const Pos(0, 2))!; // key drops onto the crate
    expect(collected(steps), 1);
    expect(e.board.find(k.id), isNull);
  });

  test('hammer refuses keys; shuffle leaves them in place', () {
    final e = Match3Engine.fromLayout(['0123', '1230', '2301', '3012'], typeCount: 4, seed: 1);
    final k = key();
    e.board.put(1, 1, k);
    expect(e.hammerAt(const Pos(1, 1)), isNull);
    e.shuffle();
    expect(e.board.find(k.id), const Pos(1, 1));
  });

  test('colour bomb swapped with a key bursts the most common colour instead', () {
    final e = Match3Engine.fromLayout(['0123', '1230', '2301', '3012'], typeCount: 4, seed: 1);
    final k = key();
    e.board.put(1, 0, k);
    e.board.at(0, 0)!.special = SpecialKind.colorBomb;
    final steps = e.trySwap(const Pos(0, 0), const Pos(1, 0))!;
    final first = steps.whereType<ClearStep>().first;
    expect(first.effects.first.kind, EffectKind.colorBurst);
    expect(first.cleared.length, greaterThan(2));
    expect(e.board.find(k.id), isNotNull);
  });

  test('spawning respects the total and the on-board cap; the board stays playable', () {
    for (var seed = 0; seed < 12; seed++) {
      final e = Match3Engine(width: 8, height: 8, typeCount: 5, seed: seed, dropsTotal: 4, maxDropsOnBoard: 2)..generate();
      expect(keysOn(e.board), 2);
      var got = 0;
      final rng = Random(seed);
      for (var i = 0; i < 60; i++) {
        final moves = e.allMoves();
        final m = moves[rng.nextInt(moves.length)];
        got += collected(e.trySwap(m.a, m.b)!);
        expect(keysOn(e.board), lessThanOrEqualTo(2));
        expect(e.board.isFull, isTrue);
        expect(e.findAnyMove(), isNotNull);
        expect(got + keysOn(e.board) + e.dropsPending, 4, reason: 'keys are never lost or duplicated');
      }
    }
  });

  test('sessions count collected keys toward key objectives', () {
    const level = LevelData(
      id: 'test_keys',
      chapterId: 'x',
      number: 99,
      environmentId: 'garden',
      moves: 45,
      tileTypeIds: ['flower', 'fence', 'bench', 'grass', 'tree'],
      objectives: [ObjectiveData(id: 'gate', tileTypeId: 'key', target: 3)],
      starThresholds: [10000, 20000],
    );
    expect(level.dropsTotal, 3);
    final s = LevelSession(level, seed: 8);
    expect(s.engine.dropsTotal, 3);
    final rng = Random(3);
    var got = 0;
    while (s.isPlaying) {
      final m = keyAwareMove(s.engine, rng);
      got += collected(s.trySwap(m.a, m.b)!.steps);
    }
    expect(got, greaterThan(0));
    expect(s.progress['gate'], min(got, 3));
    expect(s.state == SessionState.won, got >= 3);
  });
}
