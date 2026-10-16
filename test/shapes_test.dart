import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:match_make/match3/board.dart';
import 'package:match_make/match3/board_steps.dart';
import 'package:match_make/match3/match3_engine.dart';

/// Shapes used across these tests (`#` = no cell).
const shapes = <String, List<String>>{
  'U': ['##....##', '##....##', '##....##', '........', '........', '........', '........', '........'],
  'T': ['........', '........', '........', '##....##', '##....##', '##....##', '##....##', '##....##'],
  'L': ['....####', '....####', '....####', '....####', '........', '........', '........', '........'],
  'plus': ['##....##', '##....##', '........', '........', '........', '........', '##....##', '##....##'],
  // Gaps inside columns: pieces and keys must cross them.
  'ring': ['........', '........', '..#..#..', '..####..', '..####..', '..#..#..', '........', '........'],
  'hourglass': ['........', '#......#', '##....##', '###..###', '###..###', '##....##', '#......#', '........'],
};

int keysOn(Board b) => b.positions.where((p) => b.atPos(p)?.drop ?? false).length;
int collected(List<BoardStep> steps) => steps.whereType<ClearStep>().fold(0, (n, s) => n + s.dropsCollected);

void expectShapeIntact(Board b, List<String> shape) {
  for (var y = 0; y < b.height; y++) {
    for (var x = 0; x < b.width; x++) {
      final isVoid = shape[y][x] == '#';
      expect(b.isVoid(x, y), isVoid, reason: 'cell ($x,$y)');
      if (isVoid) expect(b.at(x, y), isNull, reason: 'a piece entered void ($x,$y)');
    }
  }
  expect(b.isFull, isTrue);
}

void main() {
  test('generated shaped boards fill every cell, leave the gaps empty, and start playable', () {
    for (final e in shapes.entries) {
      for (var seed = 0; seed < 10; seed++) {
        final engine = Match3Engine(width: 8, height: 8, typeCount: 6, seed: seed, obstacles: e.value)..generate();
        expectShapeIntact(engine.board, e.value);
        expect(engine.findAnyMove(), isNotNull, reason: '${e.key} seed $seed');
        expect(engine.allMoves().every((m) => !engine.board.isVoid(m.a.x, m.a.y) && !engine.board.isVoid(m.b.x, m.b.y)), isTrue);
      }
    }
  });

  test('runs do not connect across a gap', () {
    final e = Match3Engine.fromLayout(['00#0', '1212', '2121'], typeCount: 3, seed: 1);
    // Swapping into the gap is illegal.
    expect(e.trySwap(const Pos(1, 0), const Pos(2, 0)), isNull);
    expect(e.allMoves().any((m) => m.a == const Pos(2, 0) || m.b == const Pos(2, 0)), isFalse);
  });

  test('pieces fall through a gap and the gap stays empty', () {
    final e = Match3Engine.fromLayout(['01', '#2', '10', '02'], typeCount: 4, seed: 3);
    final top = e.board.at(0, 0)!;
    final steps = e.hammerAt(const Pos(0, 2))!;
    // The piece from the top row crossed the gap into row 2 (this tiny board
    // may shuffle afterwards, so check the fall itself).
    expect(e.board.at(0, 1), isNull);
    expect(e.board.isFull, isTrue);
    final fall = steps.whereType<FallStep>().first;
    expect(fall.moves.any((m) => m.id == top.id && m.from == const Pos(0, 0) && m.to == const Pos(0, 2)), isTrue);
  });

  test('a broom on a row with no cells does nothing', () {
    final e = Match3Engine(width: 8, height: 8, typeCount: 6, seed: 2, obstacles: ['########', ...List.filled(7, '........')])..generate();
    expect(e.sweepRow(0), isNull);
    expect(e.sweepRow(3), isNotNull);
  });

  test('random play on every shape keeps the board whole and playable', () {
    for (final e in shapes.entries) {
      for (var seed = 0; seed < 4; seed++) {
        final engine = Match3Engine(width: 8, height: 8, typeCount: 6, seed: seed, obstacles: e.value)..generate();
        final rng = Random(seed);
        for (var i = 0; i < 40; i++) {
          final moves = engine.allMoves();
          final m = moves[rng.nextInt(moves.length)];
          engine.trySwap(m.a, m.b);
          if (i % 7 == 0) engine.sweepRow(rng.nextInt(8));
          expectShapeIntact(engine.board, e.value);
          expect(engine.findAnyMove(), isNotNull, reason: '${e.key} seed $seed move $i');
        }
      }
    }
  });

  test('keys cross gaps inside columns and are all collected at the bottom', () {
    for (final name in ['ring', 'hourglass', 'U', 'T']) {
      for (var seed = 0; seed < 6; seed++) {
        final engine = Match3Engine(width: 8, height: 8, typeCount: 5, seed: seed, obstacles: shapes[name], dropsTotal: 4, maxDropsOnBoard: 2)
          ..generate();
        expect(keysOn(engine.board), 2, reason: '$name: keys start on the board');
        var got = 0;
        final rng = Random(seed);
        for (var i = 0; i < 160 && got < 4; i++) {
          final moves = engine.allMoves();
          final m = moves[rng.nextInt(moves.length)];
          got += collected(engine.trySwap(m.a, m.b) ?? const []);
          expect(got + keysOn(engine.board) + engine.dropsPending, 4, reason: 'keys are never lost or duplicated');
          expectShapeIntact(engine.board, shapes[name]!);
        }
        expect(got, 4, reason: '$name seed $seed: every key reaches the bottom');
      }
    }
  });
}
