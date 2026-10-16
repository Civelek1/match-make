import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../restoration/restoration_state.dart';
import '../art/lighting.dart';
import '../art/paint_kit.dart';
import 'attic_scene.dart';
import 'bathroom_scene.dart';
import 'chapter_scenes.dart';
import 'chapter_scenes_2.dart';
import 'chapter_scenes_b1.dart';
import 'chapter_scenes_b2.dart';
import 'chapter_scenes_b3.dart';
import 'chapter_scenes_b4.dart';
import 'gaming_room_scene.dart';
import 'garden_scene.dart';
import 'kitchen_scene.dart';

/// Read-only view of restoration progress at one instant, handed to scenes.
class SceneFrame {
  final RestorationState state;
  final double time;
  const SceneFrame(this.state, this.time);

  int stage(String id) => state.stage(id);

  /// Appear progress (0..1) of stage [s] (1-based) of objective [id].
  double a(String id, int s) => state.appear(id, s, time);

  /// Pop-in scale for stage [s].
  double pop(String id, int s) => Pk.pop(a(id, s));

  double p(String id) => state.progress(id, time);
  double get overall => state.overall(time);
}

/// A procedural restoration environment drawn in a 400×240 design space.
/// Replace with sprite-based art later by implementing the same interface.
abstract class SceneArt {
  static const Size designSize = Size(400, 240);

  /// Where sparkles burst when an objective advances.
  Map<String, Offset> get anchors;

  void paint(Canvas canvas, SceneFrame f);
}

final Map<String, SceneArt Function()> _registry = {
  'garden': GardenScene.new,
  'kitchen': KitchenScene.new,
  'bathroom': BathroomScene.new,
  'gaming_room': GamingRoomScene.new,
  'attic': AtticScene.new,
  ...chapterScenes,
  ...chapterScenes2,
  ...batch1Scenes,
  ...batch2Scenes,
  ...batch3Scenes,
  ...batch4Scenes,
};

final Map<String, SceneArt> _cache = {};

SceneArt? sceneArtFor(String environmentId) {
  final f = _registry[environmentId];
  if (f == null) return null;
  return _cache[environmentId] ??= f();
}

class _Burst {
  Offset pos = Offset.zero;
  Offset vel = Offset.zero;
  double born = -10;
  double life = 1;
  Color color = Colors.white;
  double size = 3;
  bool star = true;
}

/// Renders a [SceneArt] for a [RestorationState], scaled to cover its box,
/// with milestone sparkle bursts and ambient animation.
class SceneView extends StatefulWidget {
  final String environmentId;
  final RestorationState state;
  final BoxFit fit;

  /// Extra slow pan/zoom for gallery viewing.
  final bool parallax;
  final bool animate;

  const SceneView({
    super.key,
    required this.environmentId,
    required this.state,
    this.fit = BoxFit.cover,
    this.parallax = false,
    this.animate = true,
  });

  @override
  State<SceneView> createState() => SceneViewState();
}

class SceneViewState extends State<SceneView> with SingleTickerProviderStateMixin {
  Ticker? _ticker;
  final _time = ValueNotifier<double>(SceneClock.now);
  final List<_Burst> _pool = List.generate(90, (_) => _Burst());
  int _poolNext = 0;
  final Map<String, int> _lastStages = {};
  final _rng = Random();

  @override
  void initState() {
    super.initState();
    _snapshotStages();
    widget.state.addListener(_onState);
    if (widget.animate) {
      _ticker = createTicker((_) => _time.value = SceneClock.now)..start();
    }
  }

  @override
  void didUpdateWidget(SceneView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state) {
      oldWidget.state.removeListener(_onState);
      widget.state.addListener(_onState);
      _snapshotStages();
    }
  }

  void _snapshotStages() {
    for (final o in widget.state.level.objectives) {
      _lastStages[o.id] = widget.state.stage(o.id);
    }
  }

  void _onState() {
    final art = sceneArtFor(widget.environmentId);
    for (final o in widget.state.level.objectives) {
      final s = widget.state.stage(o.id);
      if (s > (_lastStages[o.id] ?? 0)) {
        final anchor = art?.anchors[o.id] ?? const Offset(200, 140);
        burst(anchor, big: s == o.stageCount);
      }
      _lastStages[o.id] = s;
    }
  }

  /// Spawns a sparkle burst at a design-space point.
  void burst(Offset at, {bool big = false}) {
    final now = SceneClock.now;
    final n = big ? 26 : 14;
    const colors = [Color(0xFFFFF3A0), Colors.white, Color(0xFFFFC93C), Color(0xFF9CF08A), Color(0xFFFF9BD2)];
    for (var i = 0; i < n; i++) {
      final b = _pool[_poolNext];
      _poolNext = (_poolNext + 1) % _pool.length;
      final ang = _rng.nextDouble() * 2 * pi;
      final spd = 25 + _rng.nextDouble() * (big ? 90 : 55);
      b
        ..pos = at
        ..vel = Offset(cos(ang), sin(ang) - 0.6) * spd
        ..born = now + _rng.nextDouble() * 0.12
        ..life = 0.7 + _rng.nextDouble() * 0.6
        ..color = colors[i % colors.length]
        ..size = 2 + _rng.nextDouble() * (big ? 4 : 3)
        ..star = i.isEven;
    }
  }

  /// Bursts at every anchor (level-complete celebration).
  void celebrate() {
    final art = sceneArtFor(widget.environmentId);
    if (art == null) return;
    for (final a in art.anchors.values) {
      burst(a, big: true);
    }
  }

  @override
  void dispose() {
    widget.state.removeListener(_onState);
    _ticker?.dispose();
    _time.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: _ScenePainter(
          art: sceneArtFor(widget.environmentId),
          state: widget.state,
          time: _time,
          bursts: _pool,
          fit: widget.fit,
          parallax: widget.parallax,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class _ScenePainter extends CustomPainter {
  final SceneArt? art;
  final RestorationState state;
  final ValueNotifier<double> time;
  final List<_Burst> bursts;
  final BoxFit fit;
  final bool parallax;

  _ScenePainter({
    required this.art,
    required this.state,
    required this.time,
    required this.bursts,
    required this.fit,
    required this.parallax,
  }) : super(repaint: time);

  @override
  void paint(Canvas canvas, Size size) {
    final ds = SceneArt.designSize;
    final sx = size.width / ds.width, sy = size.height / ds.height;
    var scale = fit == BoxFit.contain ? min(sx, sy) : max(sx, sy);
    final t = time.value;
    var dx = (size.width - ds.width * scale) / 2;
    var dy = (size.height - ds.height * scale) / 2;
    if (parallax) {
      final z = 1.06 + 0.03 * sin(t * 0.25);
      scale *= z;
      dx = (size.width - ds.width * scale) / 2 + sin(t * 0.3) * 10;
      dy = (size.height - ds.height * scale) / 2 + cos(t * 0.23) * 5;
    }
    canvas.save();
    canvas.clipRect(Offset.zero & size);
    canvas.translate(dx, dy);
    canvas.scale(scale);
    final f = SceneFrame(state, t);
    if (art != null) {
      try {
        art!.paint(canvas, f);
        Lighting.grade(canvas, f.overall);
      } catch (e) {
        // Broken art must never break the level; show a neutral backdrop.
        canvas.drawRect(Offset.zero & ds, Paint()..color = const Color(0xFFB9E4F5));
      }
    } else {
      canvas.drawRect(Offset.zero & ds, Paint()..color = const Color(0xFFB9E4F5));
    }
    // Sparkle bursts.
    for (final b in bursts) {
      final age = t - b.born;
      if (age < 0 || age > b.life) continue;
      final k = age / b.life;
      final p = b.pos + b.vel * age + Offset(0, 40 * age * age);
      final c = b.color.withValues(alpha: (1 - k).clamp(0, 1));
      if (b.star) {
        Pk.sparkle(canvas, p, b.size * (1.2 - k * 0.5), c);
      } else {
        canvas.drawCircle(p, b.size * 0.6 * (1 - k * 0.5), Paint()..color = c);
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_ScenePainter old) => old.art != art || old.state != state || old.fit != fit;
}
