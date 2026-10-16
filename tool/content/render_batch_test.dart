// Renders one content batch so its art can be checked by eye: for every
// chapter the map (half and fully restored), and for every level the fully
// restored scene (gallery) and the board after a few moves.
//
//   flutter test --dart-define=MM_HIDE_DEBUG=true --dart-define=BATCH=2 tool/content/render_batch_test.dart
//
// Output: build/batch_render/b<N>/*.png (432×768 logical at 2.5x).
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:match_make/app/app_services.dart';
import 'package:match_make/app/game_navigator.dart';
import 'package:match_make/app/game_root.dart';
import 'package:match_make/audio/audio_service.dart';
import 'package:match_make/data/content/game_content.dart';
import 'package:match_make/economy/economy_config.dart';
import 'package:match_make/economy/economy_service.dart';
import 'package:match_make/save/save_repository.dart';
import 'package:match_make/ui/gameplay/gameplay_screen.dart';
import 'package:match_make/data/content/batch_1.dart';
import 'package:match_make/data/content/batch_2.dart';
import 'package:match_make/data/content/batch_3.dart';
import 'package:match_make/data/content/batch_4.dart';

final _now = DateTime(2026, 10, 13, 10);
const _batch = int.fromEnvironment('BATCH', defaultValue: 1);
const _out = 'build/batch_render/b$_batch';

Future<void> _loadFonts() async {
  final root = Platform.environment['FLUTTER_ROOT']!;
  final dir = '$root/bin/cache/artifacts/material_fonts';
  ByteData bytes(String f) => ByteData.sublistView(File('$dir/$f').readAsBytesSync());
  final roboto = FontLoader('Roboto');
  for (final f in ['Roboto-Regular.ttf', 'Roboto-Medium.ttf', 'Roboto-Bold.ttf', 'Roboto-Black.ttf']) {
    roboto.addFont(Future.value(bytes(f)));
  }
  await roboto.load();
  await (FontLoader('MaterialIcons')..addFont(Future.value(bytes('MaterialIcons-Regular.otf')))).load();
}

/// A mid-game player: everything up to and including [doneThrough] completed.
String _save(String lang, int doneThrough, {bool dailyReady = false}) {
  final content = GameContent.standard();
  final levels = <String, dynamic>{};
  final done = <String>[];
  for (final c in content.chapters) {
    for (final l in content.levelsOf(c.id)) {
      if (l.number > doneThrough) continue;
      levels[l.id] = {'c': true, 's': l.number % 4 == 0 ? 2 : 3, 'b': l.starThresholds[1] + 2500};
      done.add(l.id);
    }
  }
  final celebrated = [
    for (final c in content.chapters)
      if (c.levelIds.every(done.contains)) c.id,
  ];
  final today = DailyRewardService.dayNumber(_now);
  // Batches are built in isolation (earlier batches may be missing), so open
  // every chapter and the levels being rendered directly.
  final open = [
    for (final l in content.allLevels)
      if (l.number <= doneThrough + 1) l.id,
  ];
  return jsonEncode({
    'dbgChapters': [for (final c in content.chapters) c.id],
    'dbgUnlocked': open,
    'v': 3,
    'levels': levels,
    'gallery': done,
    'galleryViewed': done,
    'celebrated': celebrated,
    'tips': ['starter_pack', 'obstacle_crate', 'obstacle_ice', 'obstacle_chain', 'obstacle_key', for (final b in BoosterKind.values) 'booster_${b.name}'],
    'tutorial': true,
    'coins': 1450,
    'boosters': {for (final b in BoosterKind.values) b.name: 3},
    'daily': {'d': dailyReady ? today - 1 : today, 's': dailyReady ? 3 : 4},
    'settings': {'lang': lang},
    'profile': {'name': lang == 'tr' ? 'Ayşe' : 'Emma', 'avatar': 'fox'},
  });
}

void main() {
  final boundary = GlobalKey();

  Future<void> run(WidgetTester t, double seconds) async {
    for (var i = 0; i < (seconds * 20).ceil(); i++) {
      await t.pump(const Duration(milliseconds: 50));
    }
  }

  Future<void> shot(WidgetTester t, String path) async {
    // Scene art is cached to images off the fake clock: let that real async
    // work finish and repaint before capturing.
    for (var i = 0; i < 3; i++) {
      await t.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 250)));
      await run(t, 0.1);
    }
    await t.runAsync(() async {
      final ro = boundary.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final img = await ro.toImage(pixelRatio: t.view.devicePixelRatio);
      final data = await img.toByteData(format: ui.ImageByteFormat.png);
      File(path)
        ..createSync(recursive: true)
        ..writeAsBytesSync(data!.buffer.asUint8List());
    });
  }

  Future<AppServices> boot(WidgetTester t, String raw) async {
    t.view.physicalSize = const Size(1080, 1920);
    t.view.devicePixelRatio = 2.5; // 432×768 logical
    await t.pumpWidget(const SizedBox()); // drop the previous app's state
    final services = AppServices.create(repository: MemorySaveRepository(raw), audio: SilentAudioService(), clock: () => _now);
    await t.pumpWidget(RepaintBoundary(key: boundary, child: MatchMakeApp(services: services)));
    await run(t, 3.5);
    return services;
  }

  dynamic controller(WidgetTester t) => (t.state(find.byType(GameplayScreen)) as dynamic).c;

  Future<void> play(WidgetTester t, int moves, {double settle = 2.6}) async {
    final c = controller(t);
    for (var i = 0; i < moves; i++) {
      final m = c.session.engine.findAnyMove();
      if (m == null || !(c.inputEnabled as bool)) break;
      c.onSwapRequested(m.a, m.b);
      await run(t, settle);
    }
  }

  setUpAll(_loadFonts);

  testWidgets('render batch $_batch', (t) async {
    addTearDown(t.view.reset);
    final chapters = [batch1Chapters, batch2Chapters, batch3Chapters, batch4Chapters][_batch - 1];
    for (final ch in chapters) {
      final content = GameContent.standard();
      final levels = content.levelsOf(ch.id);
      final first = levels.first.number, last = levels.last.number;
      var s = await boot(t, _save('tr', first + 1));
      s.navigator.go(AppScreen.chapterMap, arg: ch.id, force: true);
      await run(t, 1.5);
      await shot(t, '$_out/${ch.id}_map_half.png');
      s = await boot(t, _save('tr', last));
      s.navigator.go(AppScreen.chapterMap, arg: ch.id, force: true);
      await run(t, 1.5);
      await shot(t, '$_out/${ch.id}_map_done.png');
      for (final l in levels) {
        s.navigator.go(AppScreen.galleryDetail, arg: l.id, force: true);
        await run(t, 2.2);
        await shot(t, '$_out/${l.number}_${l.id}_scene.png');
        s.navigator.go(AppScreen.playing, arg: l.id, force: true);
        await run(t, 1.5);
        controller(t).start();
        await run(t, 2.5);
        await play(t, 3);
        await shot(t, '$_out/${l.number}_${l.id}_board.png');
      }
    }
  }, timeout: const Timeout(Duration(minutes: 15)));
}
