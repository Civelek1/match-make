import 'dart:math';

import 'package:flutter/material.dart';

import '../art/paint_kit.dart';
import 'prop_kit.dart';
import 'room_kit.dart';
import 'scene_art.dart';

/// One prop placed in the 400×240 scene.
class Prop {
  final PK kind;
  final Rect r;
  final Color a;
  final Color b;
  const Prop(this.kind, this.r, this.a, [this.b = const Color(0xFFFFC93C)]);
}

/// Props restored by one objective. With n props, prop k appears at stage
/// 1 + floor(k·4/n); stage 4 adds a finishing sparkle to all of them.
class ObjectiveProps {
  final String id;
  final List<Prop> props;
  const ObjectiveProps(this.id, this.props);

  int stageFor(int k) => 1 + (k * 4 / props.length).floor();
}

enum FloorStyle { checker, planks, tiles, carpet, sand, stone }

/// Background for a [PropScene]; neglected colours lerp to restored ones as
/// the whole location is restored.
class Backdrop {
  final bool outdoor;
  final Color topN, topR, bottomN, bottomR;
  final Color groundN, groundR;
  final double horizon;
  final FloorStyle floor;
  final Color floorAltN, floorAltR;
  final bool sea;
  final bool skyline;
  final bool night;

  const Backdrop.outdoor({
    required this.groundN,
    required this.groundR,
    this.topN = const Color(0xFFA9C7D3),
    this.topR = const Color(0xFF63C3FF),
    this.bottomN = const Color(0xFFEADFC6),
    this.bottomR = const Color(0xFFFFF0C8),
    this.horizon = 140,
    this.sea = false,
    this.skyline = false,
    this.night = false,
    this.floor = FloorStyle.sand,
  }) : outdoor = true,
       floorAltN = groundN,
       floorAltR = groundR;

  const Backdrop.indoor({
    required this.topN,
    required this.topR,
    required this.groundN,
    required this.groundR,
    required this.floorAltN,
    required this.floorAltR,
    this.floor = FloorStyle.checker,
    this.horizon = 172,
    this.night = false,
    this.skyline = false,
  }) : outdoor = false,
       bottomN = topN,
       bottomR = topR,
       sea = false;

  void paint(Canvas c, double ov, double t) {
    if (outdoor) {
      Pk.gradientRect(c, Rect.fromLTWH(0, 0, 400, horizon + 10), Pk.mix(topN, topR, ov), Pk.mix(bottomN, bottomR, ov));
      if (night) {
        for (var i = 0; i < 20; i++) {
          c.drawCircle(Offset(Pk.rand(i) * 400, Pk.rand(i + 5) * horizon * 0.8), 1 + Pk.rand(i + 2), Pk.fill(Colors.white.withValues(alpha: 0.4 + 0.5 * ov)));
        }
        c.drawCircle(const Offset(340, 36), 14, Pk.fill(Pk.mix(const Color(0xFFBDB6A4), const Color(0xFFFFF4C2), ov)));
      } else {
        Pk.glow(c, const Offset(350, 34), 46, const Color(0xFFFFF1A8), 0.3 + 0.4 * ov);
        c.drawCircle(const Offset(350, 34), 16, Pk.fill(Pk.mix(const Color(0xFFF3E4B0), const Color(0xFFFFE066), ov)));
        for (var i = 0; i < 3; i++) {
          final x = (i * 150 + t * (5 + i * 2)) % 520 - 60;
          Pk.cloud(c, Offset(x, 22.0 + i * 16), 0.7 + i * 0.12, Colors.white.withValues(alpha: 0.85));
        }
      }
      if (skyline) {
        for (var i = 0; i < 12; i++) {
          final bw = 22 + Pk.rand(i) * 18;
          final bh = 30 + Pk.rand(i + 9) * 60;
          final x = i * 34.0 - 8;
          c.drawRect(Rect.fromLTWH(x, horizon - bh, bw, bh + 12), Pk.fill(Pk.mix(const Color(0xFF7F8290), night ? const Color(0xFF2E2A5A) : const Color(0xFF8FA8C9), ov)));
          for (var k = 0; k < 4; k++) {
            if (Pk.rand(i * 7 + k) > 0.5) {
              c.drawRect(Rect.fromLTWH(x + 4 + (k % 2) * 9, horizon - bh + 6 + (k ~/ 2) * 12, 5, 6), Pk.fill(Colors.amber.withValues(alpha: 0.6 * ov)));
            }
          }
        }
      } else if (sea) {
        Pk.gradientRect(c, Rect.fromLTWH(0, horizon - 40, 400, 55), Pk.mix(const Color(0xFF7FA3AE), const Color(0xFF2EB6E0), ov), Pk.mix(const Color(0xFF98B8B8), const Color(0xFF6FE0F0), ov));
        for (var i = 0; i < 5; i++) {
          final y = horizon - 30 + i * 9.0;
          c.drawLine(Offset((t * 12 + i * 70) % 440 - 40, y), Offset((t * 12 + i * 70) % 440, y), Pk.stroke(Colors.white.withValues(alpha: 0.5), 1.5));
        }
      } else {
        final hills = Path()
          ..moveTo(0, horizon - 10)
          ..quadraticBezierTo(90, horizon - 45, 180, horizon - 18)
          ..quadraticBezierTo(290, horizon - 50, 400, horizon - 20)
          ..lineTo(400, horizon + 10)
          ..lineTo(0, horizon + 10)
          ..close();
        c.drawPath(hills, Pk.fill(Pk.mix(const Color(0xFFB7B38F), const Color(0xFF9ED67A), ov)));
      }
      Pk.gradientRect(c, Rect.fromLTWH(0, horizon, 400, 240 - horizon), Pk.mix(groundN, groundR, ov), Pk.dark(Pk.mix(groundN, groundR, ov), 0.12));
      if (floor == FloorStyle.stone) {
        for (var i = 0; i < 8; i++) {
          c.drawLine(Offset(i * 55.0, horizon), Offset(i * 55.0 - 30, 240), Pk.stroke(Colors.black.withValues(alpha: 0.08), 1.5));
        }
      }
      return;
    }
    RoomKit.backWall(c, horizon, Pk.mix(topN, topR, ov), Pk.dark(Pk.mix(topN, topR, ov), 0.08));
    if (night) {
      Pk.gradientRect(c, Rect.fromLTWH(0, 0, 400, horizon), Colors.black.withValues(alpha: 0.25), Colors.transparent);
    }
    final fa = Pk.mix(groundN, groundR, ov), fb = Pk.mix(floorAltN, floorAltR, ov);
    final floorRect = Rect.fromLTWH(0, horizon, 400, 240 - horizon);
    switch (floor) {
      case FloorStyle.checker:
      case FloorStyle.tiles:
        RoomKit.checkerFloor(c, horizon, fa, fb);
      case FloorStyle.planks:
        RoomKit.planks(c, floorRect, fa);
      case FloorStyle.carpet:
        Pk.gradientRect(c, floorRect, fa, fb);
        c.drawLine(Offset(0, horizon), Offset(400, horizon), Pk.stroke(Colors.black.withValues(alpha: 0.2), 2));
      case FloorStyle.sand:
      case FloorStyle.stone:
        Pk.gradientRect(c, floorRect, fa, fb);
    }
  }

  /// Dirt, weeds, cobwebs and dust that fade as the location is restored.
  void neglect(Canvas c, double ov, double t) {
    final a = 1 - ov;
    if (a <= 0.02) return;
    if (outdoor) {
      for (var i = 0; i < 9; i++) {
        final base = Offset(20 + Pk.rand(i + 40) * 360, horizon + 10 + Pk.rand(i + 50) * (220 - horizon));
        final p = Pk.stroke(const Color(0xFF7D6B3A).withValues(alpha: a * 0.9), 1.4);
        for (var k = -1; k <= 1; k++) {
          c.drawLine(base, base + Offset(k * 4.0, -7 - Pk.rand(i + k) * 4), p);
        }
      }
      for (var i = 0; i < 5; i++) {
        c.drawOval(Rect.fromCenter(center: Offset(30 + Pk.rand(i + 70) * 340, horizon + 20 + Pk.rand(i + 80) * (200 - horizon)), width: 26, height: 7),
            Pk.fill(const Color(0xFF6E5A3A).withValues(alpha: 0.35 * a)));
      }
    } else {
      RoomKit.stains(c, a, 5);
      RoomKit.dustOverlay(c, a, t);
    }
  }
}

/// Data-driven restoration scene built from props per objective.
class PropScene extends SceneArt {
  final Backdrop backdrop;
  final List<ObjectiveProps> objectives;

  /// Extra static decoration drawn before props (e.g. building facade).
  final void Function(Canvas c, double overall, double t)? scenery;

  PropScene({required this.backdrop, required this.objectives, this.scenery});

  @override
  late final Map<String, Offset> anchors = {for (final o in objectives) o.id: o.props.first.r.center};

  @override
  void paint(Canvas c, SceneFrame f) {
    final ov = f.overall;
    final t = f.time;
    backdrop.paint(c, ov, t);
    scenery?.call(c, ov, t);

    // Wall props first, then floor props back-to-front.
    final items = <(ObjectiveProps, int)>[
      for (final o in objectives)
        for (var k = 0; k < o.props.length; k++) (o, k),
    ]..sort((x, y) {
        final px = x.$1.props[x.$2], py = y.$1.props[y.$2];
        final wx = wallProps.contains(px.kind) ? 0 : 1, wy = wallProps.contains(py.kind) ? 0 : 1;
        if (wx != wy) return wx - wy;
        return px.r.bottom.compareTo(py.r.bottom);
      });

    for (final (o, k) in items) {
      final p = o.props[k];
      final s = o.stageFor(k);
      if (f.stage(o.id) < s) {
        _ghost(c, p);
        continue;
      }
      final pop = f.pop(o.id, s);
      final pivot = wallProps.contains(p.kind) ? p.r.center : p.r.bottomCenter;
      Pk.scaled(c, pivot, pop, () {
        try {
          PropKit.paint(c, p.kind, p.r, p.a, p.b, t);
        } catch (_) {
          // A broken prop must never take the whole scene down.
        }
      });
      final polish = f.a(o.id, 4);
      if (polish > 0) {
        final tw = 0.5 + 0.5 * sin(t * 3 + p.r.left);
        Pk.sparkle(c, p.r.topRight + const Offset(-3, 3), 3.5 * polish * tw, Colors.white);
      }
    }
    backdrop.neglect(c, ov, t);
  }

  void _ghost(Canvas c, Prop p) {
    final rr = RRect.fromRectAndRadius(p.r, const Radius.circular(4));
    c.drawRRect(rr, Pk.stroke(Colors.black.withValues(alpha: 0.16), 1.2));
    if (!wallProps.contains(p.kind) && p.r.width > 20) {
      // Broken plank debris where the prop will go.
      c.save();
      c.translate(p.r.center.dx, p.r.bottom - 3);
      c.rotate(0.25);
      c.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset.zero, width: p.r.width * 0.45, height: 4), const Radius.circular(1.5)),
          Pk.fill(const Color(0xFF8E857A).withValues(alpha: 0.7)));
      c.restore();
    }
  }
}
