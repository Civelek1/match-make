import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:match_make/app/app_services.dart';
import 'package:match_make/app/game_navigator.dart';
import 'package:match_make/app/game_root.dart';
import 'package:match_make/audio/audio_service.dart';
import 'package:match_make/leaderboard/leaderboard_service.dart';
import 'package:match_make/save/save_repository.dart';
import 'package:match_make/ui/gameplay/gameplay_screen.dart';
import 'package:match_make/ui/screens/chapter_map_screen.dart';
import 'package:match_make/ui/screens/gallery_screen.dart';
import 'package:match_make/ui/screens/leaderboard_screen.dart';
import 'package:match_make/ui/screens/main_menu_screen.dart';
import 'package:match_make/ui/screens/settings_screen.dart';

/// Pumps frames for [seconds] (the game has continuous ambient animation,
/// so pumpAndSettle would never settle).
Future<void> run(WidgetTester t, double seconds) async {
  final steps = (seconds * 20).ceil();
  for (var i = 0; i < steps; i++) {
    await t.pump(const Duration(milliseconds: 50));
  }
}

Future<void> tapText(WidgetTester t, String text) async {
  final f = find.text(text);
  expect(f, findsWidgets, reason: 'missing "$text"');
  await t.tap(f.last, warnIfMissed: false);
  await run(t, 0.9);
}

void main() {
  testWidgets('first-launch flow through menus, a level and progression', (t) async {
    t.view.physicalSize = const Size(1170, 2532);
    t.view.devicePixelRatio = 3;
    addTearDown(t.view.reset);

    final repo = MemorySaveRepository();
    final services = AppServices.create(repository: repo, audio: SilentAudioService());
    await t.pumpWidget(MatchMakeApp(services: services));
    await run(t, 3.5);
    expect(find.byType(MainMenuScreen), findsOneWidget);

    // Settings: toggle music, switch language to Turkish and back.
    await tapText(t, 'SETTINGS');
    expect(find.byType(SettingsScreen), findsOneWidget);
    await t.tap(find.text('ON').first);
    await run(t, 0.3);
    expect(services.settings.music, isFalse);
    await t.tap(find.text('Türkçe'));
    await run(t, 0.3);
    expect(find.text('AYARLAR'), findsWidgets);
    await t.tap(find.text('English'));
    await run(t, 0.3);
    services.navigator.back();
    await run(t, 0.9);

    // Gallery: everything locked.
    await tapText(t, 'GALLERY');
    expect(find.byType(GalleryScreen), findsOneWidget);
    expect(find.text('0 / 5'), findsWidgets);
    services.navigator.back();
    await run(t, 0.9);

    // The mock leaderboard stays off the menu until a real backend exists,
    // but the screen still loads data and handles offline.
    expect(find.text('RANKS'), kLeaderboardEnabled ? findsWidgets : findsNothing);
    services.navigator.go(AppScreen.leaderboard);
    await run(t, 0.9);
    expect(find.byType(LeaderboardScreen), findsOneWidget);
    await run(t, 1);
    expect(find.textContaining('(YOU)'), findsWidgets);
    (services.leaderboard as MockLeaderboardService).simulateOffline = true;
    await tapText(t, 'WEEKLY');
    await run(t, 1);
    expect(find.text("You're offline."), findsWidgets);
    (services.leaderboard as MockLeaderboardService).simulateOffline = false;
    services.navigator.back();
    await run(t, 0.9);

    // Play → chapter map; locked Kitchen can't be entered.
    await tapText(t, 'PLAY');
    expect(find.byType(ChapterMapScreen), findsOneWidget);
    await t.tap(find.text('KITCHEN').first, warnIfMissed: false);
    await run(t, 0.9);
    expect(find.byType(GameplayScreen), findsNothing);

    // Garden: intro card → play → tutorial appears.
    await t.tap(find.text('GARDEN').first, warnIfMissed: false);
    await run(t, 1.2);
    expect(find.byType(GameplayScreen), findsOneWidget);
    expect(find.text('RESTORE'), findsOneWidget);
    await tapText(t, 'PLAY');
    await run(t, 1.5);
    expect(find.text('Match 3 identical pieces!'), findsOneWidget);

    // Force a win through the controller-backed debug path.
    services.navigator.go(AppScreen.playing, arg: 'garden', force: true);
    await run(t, 1.2);
    await tapText(t, 'PLAY');
    await run(t, 1);
    services.progress.completeTutorial();
    final gameplay = t.state(find.byType(GameplayScreen)) as dynamic;
    // ignore: avoid_dynamic_calls
    gameplay.c.debugWin();
    await run(t, 3);
    expect(find.text('LEVEL COMPLETE!'), findsWidgets);
    expect(services.progress.isCompleted('garden'), isTrue);
    expect(services.progress.isUnlocked('kitchen'), isTrue);

    // Next level goes straight to the Kitchen intro.
    await tapText(t, 'NEXT LEVEL');
    await run(t, 1);
    expect(find.text('KITCHEN'), findsWidgets);
    expect(find.text('RESTORE'), findsOneWidget);

    // Progress persisted.
    await services.store.commit();
    expect(repo.raw, contains('garden'));

    // Finishing the House opens the Farm; its first level explains crates once.
    for (final id in ['kitchen', 'bathroom', 'gaming_room', 'attic']) {
      services.progress.debugComplete(id);
    }
    services.navigator.go(AppScreen.chapterMap, arg: 'farm', force: true);
    await run(t, 1.5);
    expect(find.text('FARMYARD'), findsWidgets);
    services.navigator.go(AppScreen.playing, arg: 'farmyard', force: true);
    await run(t, 1.5);
    expect(find.text('NEW! Crate'), findsOneWidget);
    await tapText(t, 'PLAY');
    await run(t, 1.5);
    services.navigator.go(AppScreen.playing, arg: 'farmyard', force: true);
    await run(t, 1.5);
    expect(find.text('RESTORE'), findsOneWidget);
    expect(find.text('NEW! Crate'), findsNothing);

    // Locked chapters cannot be entered.
    services.navigator.go(AppScreen.playing, arg: 'entrance', force: true);
    await run(t, 1.5);
    expect(find.byType(GameplayScreen), findsNothing);
  });

  testWidgets('a name typed on the profile screen is kept when leaving with Back', (t) async {
    t.view.physicalSize = const Size(1170, 2532);
    t.view.devicePixelRatio = 3;
    addTearDown(t.view.reset);

    final services = AppServices.create(repository: MemorySaveRepository(), audio: SilentAudioService());
    await t.pumpWidget(MatchMakeApp(services: services));
    await run(t, 3.5);
    services.navigator.go(AppScreen.profile);
    await run(t, 0.9);
    await t.enterText(find.byType(TextField), 'Ayşe');
    await run(t, 0.2);
    services.navigator.back();
    await run(t, 0.9);
    expect(services.profile.name, 'Ayşe');
    expect(t.takeException(), isNull);
  });
}
