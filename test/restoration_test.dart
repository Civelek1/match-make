import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:match_make/data/content/game_content.dart';
import 'package:match_make/data/models/level_data.dart';
import 'package:match_make/restoration/restoration_state.dart';
import 'package:match_make/ui/scenes/house_map_art.dart';
import 'package:match_make/ui/scenes/prop_kit.dart';
import 'package:match_make/ui/scenes/scene_art.dart';

void main() {
  final content = GameContent.standard();

  test('milestones map to stages 0..4', () {
    const o = ObjectiveData(id: 'fence', tileTypeId: 'fence', target: 20);
    expect(o.stageFor(0), 0);
    expect(o.stageFor(4), 0);
    expect(o.stageFor(5), 1);
    expect(o.stageFor(10), 2);
    expect(o.stageFor(15), 3);
    expect(o.stageFor(19), 3);
    expect(o.stageFor(20), 4);
  });

  test('restoration fires stage callbacks as amounts grow', () {
    final level = content.level('garden')!;
    final r = RestorationState(level);
    final events = <(String, int, bool)>[];
    r.onStage = (id, s, done) => events.add((id, s, done));
    r.setAmount('fence', 5);
    r.setAmount('fence', 6);
    r.setAmount('fence', 20);
    expect(events.first, ('fence', 1, false));
    expect(events.last, ('fence', 4, true));
    expect(events.length, 2);
    expect(r.stage('fence'), 4);
  });

  test('every level has scene art with an anchor per objective', () {
    for (final l in content.allLevels) {
      final art = sceneArtFor(l.environmentId);
      expect(art, isNotNull, reason: l.environmentId);
      for (final o in l.objectives) {
        expect(art!.anchors.containsKey(o.id), isTrue, reason: '${l.id}/${o.id}');
      }
    }
  });

  test('every prop, scene state and chapter map paints without errors', () {
    final canvas = Canvas(PictureRecorder());
    for (final k in PK.values) {
      PropKit.paint(canvas, k, const Rect.fromLTWH(10, 10, 60, 50), const Color(0xFF45A7F5), const Color(0xFFFFC93C), 1.5);
    }
    for (final l in content.allLevels) {
      final art = sceneArtFor(l.environmentId)!;
      final partial = RestorationState(l);
      for (final o in l.objectives) {
        partial.setAmount(o.id, o.target ~/ 2);
      }
      for (final s in [RestorationState(l), partial, RestorationState.completed(l)]) {
        art.paint(canvas, SceneFrame(s, SceneClock.now + 5));
      }
    }
    for (final c in content.chapters) {
      final map = chapterMapArtFor(c.mapArtId);
      expect(map, isNotNull, reason: c.id);
      for (final id in c.levelIds) {
        expect(map!.nodes.containsKey(id), isTrue, reason: '${c.id}/$id node');
      }
      map!.paint(canvas, const Size(390, 800), {}, 1);
      map.paint(canvas, const Size(390, 800), c.levelIds.toSet(), 1, celebrate: true);
    }
  });

  test('completed state reports full progress', () {
    final r = RestorationState.completed(content.level('attic')!);
    expect(r.overall(), 1);
  });
}
