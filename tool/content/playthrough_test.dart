// Plays every level once (start, two moves, win) and opens every chapter
// map and chapter-complete screen. Slow (~4 min):
//   flutter test tool/content/playthrough_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:match_make/app/app_services.dart';
import 'package:match_make/app/game_navigator.dart';
import 'package:match_make/app/game_root.dart';
import 'package:match_make/audio/audio_service.dart';
import 'package:match_make/game/gameplay_controller.dart';
import 'package:match_make/save/save_repository.dart';
import 'package:match_make/ui/gameplay/gameplay_screen.dart';
import 'package:match_make/ui/screens/chapter_complete_screen.dart';
import 'package:match_make/ui/screens/chapter_map_screen.dart';

void main() {
  testWidgets('play through all levels and chapter transitions', (t) async {
    t.view.physicalSize = const Size(1080, 1920);
    t.view.devicePixelRatio = 2.5;
    addTearDown(t.view.reset);
    Future<void> run(double s) async {
      for (var i = 0; i < (s * 20).ceil(); i++) {
        await t.pump(const Duration(milliseconds: 50));
      }
    }

    final s = AppServices.create(repository: MemorySaveRepository(), audio: SilentAudioService());
    await t.pumpWidget(MatchMakeApp(services: s));
    await run(3.5);
    final problems = <String>[];
    for (final ch in s.content.chapters) {
      s.navigator.go(AppScreen.chapterMap, arg: ch.id, force: true);
      await run(1.2);
      if (find.byType(ChapterMapScreen).evaluate().isEmpty) problems.add('map ${ch.id} did not open');
      for (final l in s.content.levelsOf(ch.id)) {
        if (!s.progress.isUnlocked(l.id)) problems.add('${l.number} ${l.id} locked after previous win');
        s.navigator.go(AppScreen.playing, arg: l.id, force: true);
        await run(1.2);
        final st = find.byType(GameplayScreen);
        if (st.evaluate().isEmpty) {
          problems.add('${l.number} ${l.id} did not open');
          continue;
        }
        final c = (t.state(st) as dynamic).c as GameplayController;
        c.start();
        await run(2.0);
        for (var i = 0; i < 2; i++) {
          final m = c.session.engine.findAnyMove();
          if (m == null || !c.inputEnabled) break;
          c.onSwapRequested(m.a, m.b);
          await run(2.5);
        }
        c.debugWin();
        await run(3.0);
        if (c.phase != PlayPhase.won) problems.add('${l.number} ${l.id}: phase ${c.phase}');
        if (!s.progress.isCompleted(l.id)) problems.add('${l.number} ${l.id}: not recorded');
        final ex = t.takeException();
        if (ex != null) problems.add('${l.number} ${l.id}: $ex');
      }
      s.navigator.go(AppScreen.chapterComplete, arg: ch.id, force: true);
      await run(2.0);
      if (find.byType(ChapterCompleteScreen).evaluate().isEmpty) problems.add('chapter complete ${ch.id} missing');
      final ex = t.takeException();
      if (ex != null) problems.add('chapter ${ch.id}: $ex');
    }
    // ignore: avoid_print
    print('PLAYTHROUGH levels=${s.progress.levelsCompleted} coins=${s.economy.coins} problems=${problems.length}');
    for (final p in problems.take(30)) {
      // ignore: avoid_print
      print('PROBLEM $p');
    }
    expect(problems, isEmpty);
  }, timeout: const Timeout(Duration(minutes: 20)));
}
