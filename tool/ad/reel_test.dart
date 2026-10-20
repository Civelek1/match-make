// Records a 15-second vertical (1080×1920, 30 fps) promo video from the real
// game: a neglected room, real swaps on the real board with a finger overlay,
// the room restoring, and the restored room with the logo and tagline.
//
//   flutter test --dart-define=MM_HIDE_DEBUG=true tool/ad/reel_test.dart --name "reel tr"
//   flutter test --dart-define=MM_HIDE_DEBUG=true tool/ad/reel_test.dart --name "reel en"
//   python3 tool/ad/mix_reel.py
//
// Output: build/ad/reel_<lang>_video.mp4 + reel_<lang>_events.json (sound
// cues), mixed by mix_reel.py into build/ad/MatchMake_reel_<lang>.mp4.
import 'dart:convert';
import 'dart:io';
import 'dart:math';
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
import 'package:match_make/data/models/level_data.dart';
import 'package:match_make/economy/economy_config.dart';
import 'package:match_make/economy/economy_service.dart';
import 'package:match_make/match3/board.dart';
import 'package:match_make/match3/match3_engine.dart';
import 'package:match_make/restoration/restoration_state.dart';
import 'package:match_make/save/save_repository.dart';
import 'package:match_make/ui/gameplay/gameplay_screen.dart';
import 'package:match_make/ui/scenes/scene_art.dart';
import 'package:match_make/ui/widgets/game_text.dart';
import 'package:match_make/ui/widgets/logo.dart';

const _fps = 30;
const _w = 1080, _h = 1920;
const _levelId = 'lodge_lounge';
const _out = 'build/ad';

/// The lounge with small targets so each match visibly restores the room.
GameContent _adContent() {
  final std = GameContent.standard();
  LevelData ad(LevelData l) => LevelData(
    id: l.id,
    chapterId: l.chapterId,
    number: l.number,
    environmentId: l.environmentId,
    moves: 40,
    difficulty: l.difficulty,
    specials: l.specials,
    tileTypeIds: l.tileTypeIds,
    obstacles: [for (final r in l.obstacles!) r.replaceAll(RegExp('[^#]'), '.')],
    objectives: [
      for (final o in l.objectives)
        if (o.tileTypeId != 'ice') ObjectiveData(id: o.id, tileTypeId: o.tileTypeId, target: 7),
    ],
    starThresholds: l.starThresholds,
  );
  return GameContent(chapters: std.chapters, levels: [for (final l in std.allLevels) l.id == _levelId ? ad(l) : l]);
}

class _RecordingAudio implements AudioService {
  final List<Map<String, Object>> events = [];
  double Function() at = () => 0;
  @override
  void play(Sfx sfx) => events.add({'t': at(), 's': sfx.name});
  @override
  void playMusic(MusicTrack track) {}
  @override
  void pauseAll() {}
  @override
  void resumeAll() {}
  @override
  void dispose() {}
}

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

String _save(String lang) {
  final content = GameContent.standard();
  final levels = <String, dynamic>{};
  for (final c in content.chapters) {
    for (final l in content.levelsOf(c.id)) {
      if (l.number < 32) levels[l.id] = {'c': true, 's': 3, 'b': l.starThresholds[1] + 2500};
    }
  }
  return jsonEncode({
    'v': 3,
    'levels': levels,
    'tips': ['starter_pack', 'obstacle_crate', 'obstacle_ice', 'obstacle_chain', 'obstacle_key', for (final b in BoosterKind.values) 'booster_${b.name}'],
    'tutorial': true,
    'coins': 1450,
    'boosters': {for (final b in BoosterKind.values) b.name: 3},
    'settings': {'lang': lang},
    'daily': {'d': DailyRewardService.dayNumber(_now), 's': 1},
  });
}

final _now = DateTime(2026, 10, 20, 10);

/// Tagline shown over the restored room.
const _tagline = {'en': 'MATCH. RENOVATE. REPEAT.', 'tr': 'EŞLEŞTİR. YENİLE. TEKRARLA.'};

void main() {
  final boundary = GlobalKey();
  final sceneKey = GlobalKey<SceneViewState>();
  var clock = 100.0; // drives SceneClock (scene and flying pieces)
  var frames = 0;
  late Process ffmpeg;

  setUpAll(() async {
    await _loadFonts();
    SceneClock.debugTimeSource = () => clock;
  });

  Future<void> tick(WidgetTester t) async {
    clock += 1 / _fps;
    await t.pump(const Duration(microseconds: 1000000 ~/ _fps));
  }

  Future<void> capture(WidgetTester t) async {
    await t.runAsync(() async {
      final ro = boundary.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final img = await ro.toImage(pixelRatio: t.view.devicePixelRatio);
      final data = await img.toByteData(format: ui.ImageByteFormat.rawRgba);
      img.dispose();
      ffmpeg.stdin.add(data!.buffer.asUint8List());
      await ffmpeg.stdin.flush();
    });
    frames++;
  }

  Future<void> record(WidgetTester t, int n, [void Function(int i)? each]) async {
    for (var i = 0; i < n; i++) {
      each?.call(i);
      await tick(t);
      await capture(t);
    }
  }

  /// Lets real async image work (scene art caches) finish before recording.
  Future<void> warm(WidgetTester t, {double seconds = 0.6}) async {
    for (var i = 0; i < 3; i++) {
      await t.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 250)));
      for (var k = 0; k < (seconds * _fps / 3).ceil(); k++) {
        await tick(t);
      }
    }
  }

  for (final lang in ['tr', 'en']) {
    testWidgets('reel $lang', (t) async {
      t.view.physicalSize = const Size(1080, 1920);
      t.view.devicePixelRatio = 3; // 360×640 logical
      addTearDown(t.view.reset);
      Directory(_out).createSync(recursive: true);
      frames = 0;
      ffmpeg = await t.runAsync(
        () => Process.start('ffmpeg', [
          '-y', '-v', 'error', '-f', 'rawvideo', '-pix_fmt', 'rgba', '-s', '${_w}x$_h', '-r', '$_fps', '-i', '-',
          '-c:v', 'libx264', '-preset', 'medium', '-crf', '18', '-pix_fmt', 'yuv420p', '$_out/reel_${lang}_video.mp4',
        ]),
      ) as Process;
      final audio = _RecordingAudio()..at = () => frames / _fps;
      final content = _adContent();
      final level = content.level(_levelId)!;

      // ---- 0–3 s: the neglected room, slow push-in. ----
      final before = RestorationState(level);
      final zoom = ValueNotifier<double>(1);
      final lift = ValueNotifier<double>(0); // scene's vertical alignment
      Widget sceneShot(RestorationState state, {Widget? overlay}) => RepaintBoundary(
        key: boundary,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: DefaultTextStyle(
            style: const TextStyle(fontFamily: 'Roboto'),
            child: ColoredBox(
            color: Colors.black,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Blurred, darkened copy fills the tall frame behind the room.
                ImageFiltered(
                  imageFilter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(Color(0x66000000), BlendMode.darken),
                    child: SceneView(environmentId: level.environmentId, state: state, fit: BoxFit.cover, animate: false),
                  ),
                ),
                ValueListenableBuilder<double>(
                  valueListenable: zoom,
                  builder: (_, z, child) => Transform.scale(scale: z, child: child),
                  child: ValueListenableBuilder<double>(
                    valueListenable: lift,
                    builder: (_, y, child) => Align(alignment: Alignment(0, y), child: child),
                    child: AspectRatio(
                      aspectRatio: 400 / 240,
                      child: SceneView(key: sceneKey, environmentId: level.environmentId, state: state),
                    ),
                  ),
                ),
                ?overlay,
              ],
            ),
          ),
          ),
        ),
      );
      await t.pumpWidget(
        sceneShot(
          before,
          overlay: const DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(radius: 0.95, colors: [Color(0x00000000), Color(0xB0000000)]),
            ),
          ),
        ),
      );
      await warm(t);
      await record(t, 3 * _fps, (i) => zoom.value = 1.35 + 0.25 * Curves.easeInOut.transform(i / (3 * _fps)));

      // ---- 3–12 s: real gameplay with a finger. ----
      await t.pumpWidget(const SizedBox());
      final services = AppServices.create(repository: MemorySaveRepository(_save(lang)), audio: audio, content: content, clock: () => _now);
      final finger = ValueNotifier<Offset?>(null);
      await t.pumpWidget(
        RepaintBoundary(
          key: boundary,
          child: Stack(
            textDirection: TextDirection.ltr,
            children: [
              MatchMakeApp(services: services),
              Positioned.fill(
                child: IgnorePointer(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: ValueListenableBuilder<Offset?>(
                      valueListenable: finger,
                      builder: (_, p, _) => Stack(
                        children: [
                          if (p != null)
                            Positioned(
                              // Fingertip of the icon sits ~40% across, ~12% down.
                              left: p.dx - 26,
                              top: p.dy - 8,
                              child: const Icon(
                                Icons.touch_app_rounded,
                                size: 64,
                                color: Colors.white,
                                shadows: [Shadow(color: Color(0x99000000), blurRadius: 8, offset: Offset(0, 3))],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      for (var i = 0; i < 3.5 * _fps; i++) {
        await tick(t);
      }
      services.navigator.go(AppScreen.playing, arg: _levelId, force: true);
      await warm(t, seconds: 1.5);
      final c = (t.state(find.byType(GameplayScreen)) as dynamic).c;
      c
        ..toggleStartBooster(BoosterKind.startRocket)
        ..start();
      await warm(t, seconds: 2.4);
      audio.events.clear();

      Move pick() {
        final engine = c.session.engine;
        final Board b = engine.board;
        final moves = (engine.allMoves() as List).cast<Move>();
        int run(Map<Pos, int?> g, Pos p) {
          final ty = g[p];
          if (ty == null) return 0;
          var best = 0;
          for (final d in const [Pos(1, 0), Pos(0, 1)]) {
            var n = 1;
            for (var k = 1; g[Pos(p.x + d.x * k, p.y + d.y * k)] == ty; k++) {
              n++;
            }
            for (var k = 1; g[Pos(p.x - d.x * k, p.y - d.y * k)] == ty; k++) {
              n++;
            }
            best = max(best, n);
          }
          return best;
        }

        double score(Move m) {
          final ta = b.atPos(m.a), tb = b.atPos(m.b);
          if ((ta?.isSpecial ?? false) || (tb?.isSpecial ?? false)) return 100;
          final g = <Pos, int?>{for (final p in b.positions) p: b.atPos(p)?.isSpecial == false ? b.atPos(p)?.type : null};
          final tmp = g[m.a];
          g[m.a] = g[m.b];
          g[m.b] = tmp;
          // Lower rows first looks livelier (cascades), bigger matches first.
          return max(run(g, m.a), run(g, m.b)) * 10 + (m.a.y + m.b.y) / 4;
        }

        moves.sort((x, y) => score(y).compareTo(score(x)));
        return moves.first;
      }

      final end = 12 * _fps;
      while (frames < end) {
        if (!(c.inputEnabled as bool)) {
          await record(t, 1);
          continue;
        }
        final m = pick();
        final from = c.board.cellCenterGlobal(m.a) as Offset?;
        final to = c.board.cellCenterGlobal(m.b) as Offset?;
        if (from == null || to == null) break;
        // Finger lands, slides to the neighbour, lifts.
        await record(t, 6, (i) => finger.value = from);
        await record(t, 6, (i) => finger.value = Offset.lerp(from, to, Curves.easeInOut.transform((i + 1) / 6)));
        c.onSwapRequested(m.a, m.b);
        await record(t, 4);
        finger.value = null;
        await record(t, 2);
      }
      finger.value = null;
      while (frames < end) {
        await record(t, 1);
      }
      final gameplayEvents = List.of(audio.events);

      // ---- 12–15 s: the restored room, logo and tagline. ----
      final after = RestorationState(level);
      final reveal = ValueNotifier<double>(0);
      zoom.value = 1.5;
      await t.pumpWidget(const SizedBox());
      await t.pumpWidget(
        sceneShot(
          after,
          overlay: ValueListenableBuilder<double>(
            valueListenable: reveal,
            builder: (_, r, _) => Opacity(
              opacity: r,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x00000000), Color(0x00000000), Color(0xCC1B1340)],
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 0.62),
                    child: Transform.scale(
                      scale: 0.85 + 0.15 * Curves.easeOutBack.transform(r),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/images/mascot.png', height: 92),
                          const MatchMakeLogo(width: 300, animateIn: false),
                          const SizedBox(height: 10),
                          GameText(_tagline[lang]!, size: 22, strokeWidth: 4),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      await warm(t);
      for (final o in level.objectives) {
        after.setAmount(o.id, o.target);
      }
      sceneKey.currentState?.celebrate();
      audio.events.add({'t': frames / _fps, 's': 'levelComplete'});
      await record(t, 3 * _fps, (i) {
        zoom.value = 1.5 - 0.12 * Curves.easeOut.transform(i / (3 * _fps));
        // Room alone first, then it rises and the logo comes in under it.
        final k = Curves.easeInOut.transform(((i - 30) / 20).clamp(0.0, 1.0));
        lift.value = -0.42 * k;
        reveal.value = ((i - 38) / 16).clamp(0.0, 1.0);
      });

      await t.runAsync(() async {
        await ffmpeg.stdin.close();
        await ffmpeg.exitCode;
      });
      File('$_out/reel_${lang}_events.json').writeAsStringSync(
        jsonEncode([...gameplayEvents, audio.events.last]),
      );
      expect(frames, 15 * _fps);
    }, timeout: const Timeout(Duration(minutes: 20)));
  }
}
