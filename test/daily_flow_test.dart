import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:match_make/app/app_services.dart';
import 'package:match_make/app/game_navigator.dart';
import 'package:match_make/app/game_root.dart';
import 'package:match_make/audio/audio_service.dart';
import 'package:match_make/save/save_repository.dart';

import 'app_flow_test.dart' show run, tapText;

void main() {
  testWidgets('daily calendar pops up for returning players and pays out', (t) async {
    t.view.physicalSize = const Size(1170, 2532);
    t.view.devicePixelRatio = 3;
    addTearDown(t.view.reset);
    var now = DateTime(2026, 5, 4, 10);
    final services = AppServices.create(repository: MemorySaveRepository(), audio: SilentAudioService(), clock: () => now);
    await t.pumpWidget(MatchMakeApp(services: services));
    await run(t, 3.5);

    // First launch: no popup yet.
    expect(find.text('DAILY REWARD'), findsNothing);

    // After a level, coming back to the menu shows today's reward.
    services.progress.debugComplete('garden');
    services.navigator.go(AppScreen.chapterMap, force: true);
    await run(t, 1);
    services.navigator.go(AppScreen.mainMenu, force: true);
    await run(t, 1.5);
    expect(find.text('DAILY REWARD'), findsWidgets);
    expect(find.text('DAY 1'), findsOneWidget);
    final coins = services.economy.coins;
    await tapText(t, 'CLAIM');
    await run(t, 1);
    expect(services.economy.coins, coins + services.economy.config.daily[0].coins);
    expect(find.text('Come back tomorrow for the next reward!'), findsOneWidget);
    await tapText(t, 'OK');
    await run(t, 0.6);
    expect(find.text('DAILY REWARD'), findsNothing);

    // It does not pop up again this session; the button still opens it.
    services.navigator.go(AppScreen.chapterMap, force: true);
    await run(t, 1);
    services.navigator.go(AppScreen.mainMenu, force: true);
    await run(t, 1.5);
    expect(find.text('DAILY REWARD'), findsNothing);

    // Next day: day 2 is ready behind the calendar button.
    now = now.add(const Duration(days: 1));
    services.daily.reload();
    await run(t, 0.3);
    await t.tap(find.bySemanticsLabel('DAILY REWARD'));
    await run(t, 1);
    expect(services.daily.todayIndex, 1);
    await tapText(t, 'CLAIM');
    expect(services.economy.coins, coins + services.economy.config.daily[0].coins + services.economy.config.daily[1].coins);
  });
}
