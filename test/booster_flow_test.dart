import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:match_make/app/app_services.dart';
import 'package:match_make/app/game_navigator.dart';
import 'package:match_make/app/game_root.dart';
import 'package:match_make/audio/audio_service.dart';
import 'package:match_make/economy/economy_config.dart';
import 'package:match_make/game/gameplay_controller.dart';
import 'package:match_make/match3/board.dart';
import 'package:match_make/save/save_repository.dart';
import 'package:match_make/ui/board/board_view.dart';
import 'package:match_make/ui/gameplay/gameplay_screen.dart';

import 'app_flow_test.dart' show run, tapText;

GameplayController controllerOf(WidgetTester t) {
  final state = t.state(find.byType(GameplayScreen)) as dynamic;
  // ignore: avoid_dynamic_calls
  return state.c as GameplayController;
}

Future<AppServices> boot(WidgetTester t) async {
  t.view.physicalSize = const Size(1170, 2532);
  t.view.devicePixelRatio = 3;
  addTearDown(t.view.reset);
  final services = AppServices.create(repository: MemorySaveRepository(), audio: SilentAudioService());
  await t.pumpWidget(MatchMakeApp(services: services));
  await run(t, 3.5);
  services.progress.completeTutorial();
  return services;
}

Future<void> openLevel(WidgetTester t, AppServices s, String id) async {
  s.progress.debugUnlock(id);
  s.navigator.go(AppScreen.playing, arg: id, force: true);
  await run(t, 1.5);
  expect(find.byType(GameplayScreen), findsOneWidget);
}

Future<void> tapCell(WidgetTester t, GameplayController c, Pos p) async {
  final r = c.board.cellRectGlobal(p)!;
  await t.tapAt(r.center);
  await run(t, 0.2);
}

void main() {
  testWidgets('hammer, shuffle and the paid continue work from the UI', (t) async {
    final s = await boot(t);
    final coins0 = s.economy.coins;
    await openLevel(t, s, 'farmyard'); // level 6: shuffle (4) + hammer (6)

    // The intro introduces both boosters with their gift.
    expect(find.text('NEW! Hammer, Shuffle'), findsOneWidget);
    await tapText(t, 'PLAY');
    await run(t, 1.5);
    expect(s.economy.count(BoosterKind.hammer), 3);
    expect(s.economy.count(BoosterKind.shuffle), 3);
    final c = controllerOf(t);
    expect(c.levelBoosters, [BoosterKind.hammer, BoosterKind.shuffle]);

    // Arm the hammer, then smash a piece: no move is spent.
    final moves = c.movesLeft;
    await t.tap(find.bySemanticsLabel('Hammer'));
    await run(t, 0.3);
    expect(c.armed, BoosterKind.hammer);
    expect(find.text('Tap a piece to smash it'), findsOneWidget);
    final target = Pos(3, c.session.engine.board.height - 1);
    final id = c.session.engine.board.atPos(target)!.id;
    await tapCell(t, c, target);
    await run(t, 2.5);
    expect(c.armed, isNull);
    expect(s.economy.count(BoosterKind.hammer), 2);
    expect(c.movesLeft, moves);
    expect(c.session.engine.board.find(id), isNull);
    expect(c.phase, PlayPhase.playing);

    // Tapping the armed booster again cancels it without using it.
    await t.tap(find.bySemanticsLabel('Hammer'));
    await run(t, 0.2);
    await t.tap(find.bySemanticsLabel('Hammer'));
    await run(t, 0.2);
    expect(c.armed, isNull);
    expect(s.economy.count(BoosterKind.hammer), 2);

    // Shuffle fires immediately.
    await t.tap(find.bySemanticsLabel('Shuffle'));
    await run(t, 2);
    expect(s.economy.count(BoosterKind.shuffle), 2);
    expect(c.movesLeft, moves);

    // Out of moves: continue costs coins and refuses when too poor.
    c.debugLose();
    await run(t, 1);
    expect(find.text('+5 MOVES'), findsWidgets);
    s.economy.spendCoins(s.economy.coins);
    await tapText(t, '+5 MOVES');
    expect(c.phase, PlayPhase.lost);
    s.economy.addCoins(1000);
    await tapText(t, '+5 MOVES');
    await run(t, 0.5);
    expect(c.phase, PlayPhase.playing);
    expect(c.movesLeft, 5);
    expect(s.economy.coins, 1000 - 300);
    expect(c.continuePrice, 600);
    expect(coins0, greaterThan(0));
  });

  testWidgets('start boosters are chosen on the intro and placed on the board', (t) async {
    final s = await boot(t);
    final level = s.content.allLevels.firstWhere((l) => l.number == 13);
    await openLevel(t, s, level.id);
    expect(find.text('START WITH'), findsOneWidget);
    final c = controllerOf(t);
    expect(c.startBoosters, [BoosterKind.startRocket, BoosterKind.startBomb]);

    await t.tap(find.bySemanticsLabel('Bomb Start'));
    await run(t, 0.3);
    expect(c.selectedStart, {BoosterKind.startBomb});
    await tapText(t, 'PLAY');
    await run(t, 1);
    expect(s.economy.count(BoosterKind.startBomb), s.economy.config.unlockGift - 1);
    final specials = [
      for (final p in c.session.engine.board.positions)
        if (c.session.engine.board.atPos(p)?.special == SpecialKind.bomb) p,
    ];
    expect(specials.length, 1);
    expect(c.hasProgress, isTrue);
  });

  testWidgets('the shop sells unlocked boosters for coins', (t) async {
    final s = await boot(t);
    for (final l in s.content.allLevels.where((l) => l.number < 6)) {
      s.progress.recordWin(l, 20000, 2);
    }
    s.economy.addCoins(500);
    await run(t, 0.5);
    await tapText(t, 'SHOP');
    expect(find.text('Hammer'), findsWidgets);
    expect(find.text('Unlocks at level 9'), findsOneWidget); // broom still locked
    final coins = s.economy.coins;
    await t.tap(find.bySemanticsLabel('BUY ${BoosterKind.hammer.price}'));
    await run(t, 0.5);
    expect(s.economy.count(BoosterKind.hammer), 1);
    expect(s.economy.coins, coins - BoosterKind.hammer.price);
    expect(find.byType(BoardView), findsNothing);
  });
}
