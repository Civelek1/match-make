import 'dart:math';

import 'package:flutter/material.dart';

import '../art/paint_kit.dart';
import 'room_kit.dart';
import 'scene_art.dart';

/// LEVEL 3 — Bathroom. Clean blue / white / aqua.
class BathroomScene extends SceneArt {
  @override
  final Map<String, Offset> anchors = const {
    'bathtub': Offset(90, 160),
    'sink': Offset(220, 150),
    'mirror': Offset(220, 65),
    'bath_cabinet': Offset(342, 100),
    'plants': Offset(275, 190),
  };

  @override
  void paint(Canvas c, SceneFrame f) {
    final ov = f.overall;
    final t = f.time;

    // Tiled wall.
    final tile = Pk.mix(const Color(0xFFBDB9AA), const Color(0xFFE6FAFF), ov);
    final grout = Pk.mix(const Color(0xFF9A9686), const Color(0xFFB8E6F0), ov);
    RoomKit.backWall(c, 176, tile, Pk.dark(tile, 0.05));
    for (var y = 14.0; y < 176; y += 16) {
      c.drawLine(Offset(0, y), Offset(400, y), Pk.stroke(grout, 1));
    }
    for (var x = 0.0; x < 400; x += 16) {
      c.drawLine(Offset(x, 14), Offset(x, 176), Pk.stroke(grout, 1));
    }
    // Accent band.
    c.drawRect(const Rect.fromLTWH(0, 108, 400, 8), Pk.fill(Pk.mix(const Color(0xFF8E9C9C), const Color(0xFF2EC4D6), ov)));
    RoomKit.checkerFloor(
      c,
      176,
      Pk.mix(const Color(0xFF8D8A80), const Color(0xFFFFFFFF), ov),
      Pk.mix(const Color(0xFF6E6B62), const Color(0xFF7AD3E3), ov),
    );
    // Grime drips.
    final grime = 1 - ov;
    if (grime > 0.02) {
      for (var i = 0; i < 6; i++) {
        final x = 20 + Pk.rand(i + 70) * 360;
        c.drawLine(
          Offset(x, 30 + Pk.rand(i) * 30),
          Offset(x, 70 + Pk.rand(i + 1) * 60),
          Pk.stroke(const Color(0xFF7A6E4E).withValues(alpha: 0.3 * grime), 3),
        );
      }
    }

    _plantsBack(c, f, t);
    _mirror(c, f, t);
    _cabinet(c, f);
    _bathtub(c, f, t);
    _sink(c, f);
    _plantsFront(c, f);
    RoomKit.dustOverlay(c, grime * 0.8, t);
  }

  void _bathtub(Canvas c, SceneFrame f, double t) {
    final stage = f.stage('bathtub');
    const r = Rect.fromLTWH(18, 136, 150, 48);
    if (stage == 0) {
      c.drawRRect(RRect.fromRectAndRadius(r, const Radius.circular(20)), Pk.stroke(Colors.black.withValues(alpha: 0.2), 1.5));
      Pk.box(c, const Rect.fromLTWH(60, 164, 44, 20), const Color(0xFF9E9384), radius: 3);
      return;
    }
    // Claw feet (stage 2) drawn behind.
    final feet = f.pop('bathtub', 2);
    for (final x in const [36.0, 150.0]) {
      Pk.scaled(c, Offset(x, 196), feet, () {
        c.drawOval(Rect.fromCenter(center: Offset(x, 192), width: 12, height: 14), Pk.fill(const Color(0xFFFFC93C)));
      });
    }
    Pk.scaled(c, r.bottomCenter, f.pop('bathtub', 1), () {
      Pk.shadow(c, r.bottomCenter + const Offset(0, 10), 170, 14);
      final path = Path()
        ..moveTo(r.left, r.top)
        ..lineTo(r.right, r.top)
        ..quadraticBezierTo(r.right, r.bottom, r.right - 30, r.bottom)
        ..lineTo(r.left + 30, r.bottom)
        ..quadraticBezierTo(r.left, r.bottom, r.left, r.top)
        ..close();
      c.drawPath(path, Pk.fill(Colors.white));
      c.drawPath(path, Pk.stroke(const Color(0xFF9AD7E6), 2));
      c.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(r.left - 4, r.top - 5, r.width + 8, 8), const Radius.circular(4)),
        Pk.fill(const Color(0xFFF4FDFF)),
      );
    });
    if (feet > 0) {
      c.drawLine(
        Offset(r.left + 14, r.top + 12),
        Offset(r.left + 20, r.bottom - 10),
        Pk.stroke(const Color(0xFFD6F3FA).withValues(alpha: feet), 5),
      );
    }
    // Faucet + water (stage 3).
    final water = f.pop('bathtub', 3);
    Pk.scaled(c, Offset(r.right - 16, r.top), water, () {
      c.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(r.right - 22, r.top - 22, 6, 20), const Radius.circular(3)),
        Pk.fill(const Color(0xFFC9D6DC)),
      );
      c.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(r.right - 36, r.top - 24, 20, 5), const Radius.circular(3)),
        Pk.fill(const Color(0xFFC9D6DC)),
      );
      c.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(r.left + 4, r.top - 1, r.width - 8, 5), const Radius.circular(3)),
        Pk.fill(const Color(0xFF7FDBF0)),
      );
    });
    // Bubbles + duck (stage 4).
    final bubbles = f.pop('bathtub', 4);
    if (bubbles > 0) {
      for (var i = 0; i < 9; i++) {
        final p = Offset(r.left + 14 + i * 15.0, r.top - 3 - sin(t * 2 + i) * 1.5 - (i.isEven ? 4 : 0));
        c.drawCircle(p, (5 + Pk.rand(i) * 4) * bubbles, Pk.fill(Colors.white));
        c.drawCircle(p, (5 + Pk.rand(i) * 4) * bubbles, Pk.stroke(const Color(0xFFB8E6F0), 0.8));
      }
      final duck = Offset(r.left + 60, r.top - 10 + sin(t * 1.5) * 1.2);
      Pk.scaled(c, duck, bubbles, () {
        c.drawOval(Rect.fromCenter(center: duck, width: 16, height: 10), Pk.fill(const Color(0xFFFFD447)));
        c.drawCircle(duck + const Offset(5, -6), 4.5, Pk.fill(const Color(0xFFFFD447)));
        c.drawOval(Rect.fromCenter(center: duck + const Offset(10, -5.5), width: 5, height: 3), Pk.fill(const Color(0xFFFF8A3C)));
        c.drawCircle(duck + const Offset(6, -7), 0.9, Pk.fill(const Color(0xFF3B2A5A)));
      });
    }
  }

  void _sink(Canvas c, SceneFrame f) {
    final stage = f.stage('sink');
    const r = Rect.fromLTWH(188, 132, 64, 50);
    if (stage == 0) {
      Pk.box(c, const Rect.fromLTWH(200, 150, 40, 32), const Color(0xFF9E9384), radius: 2);
      return;
    }
    Pk.scaled(c, r.bottomCenter, f.pop('sink', 1), () {
      Pk.shadow(c, r.bottomCenter + const Offset(0, 2), 80, 9);
      Pk.box(c, r, const Color(0xFF3FB6C9), bottom: const Color(0xFF2B8BA8), radius: 4, outline: const Color(0xFF1E6F87));
      Pk.box(c, Rect.fromLTWH(r.left + 5, r.top + 8, 26, 38), const Color(0xFF55C8DA), radius: 3);
      Pk.box(c, Rect.fromLTWH(r.left + 33, r.top + 8, 26, 38), const Color(0xFF55C8DA), radius: 3);
      c.drawCircle(Offset(r.left + 27, r.top + 26), 1.8, Pk.fill(Colors.white));
      c.drawCircle(Offset(r.left + 37, r.top + 26), 1.8, Pk.fill(Colors.white));
    });
    Pk.scaled(c, Offset(r.center.dx, r.top), f.pop('sink', 2), () {
      c.drawOval(Rect.fromCenter(center: Offset(r.center.dx, r.top - 2), width: 74, height: 14), Pk.fill(Colors.white));
      c.drawOval(Rect.fromCenter(center: Offset(r.center.dx, r.top - 3), width: 52, height: 7), Pk.fill(const Color(0xFFCFEFF7)));
    });
    Pk.scaled(c, Offset(r.center.dx, r.top - 6), f.pop('sink', 3), () {
      c.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(r.center.dx - 3, r.top - 20, 6, 14), const Radius.circular(3)),
        Pk.fill(const Color(0xFFC9D6DC)),
      );
      c.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(r.center.dx - 3, r.top - 21, 14, 5), const Radius.circular(3)),
        Pk.fill(const Color(0xFFC9D6DC)),
      );
    });
    Pk.scaled(c, Offset(r.right, r.top), f.pop('sink', 4), () {
      Pk.box(c, Rect.fromLTWH(r.left + 2, r.top - 17, 8, 12), const Color(0xFFFF9BD2), radius: 2);
      c.drawRect(Rect.fromLTWH(r.left + 5, r.top - 21, 2, 4), Pk.fill(const Color(0xFF8A839B)));
      c.drawRect(Rect.fromLTWH(r.right + 4, r.top - 12, 2, 4), Pk.fill(const Color(0xFFC9D6DC)));
      Pk.box(c, Rect.fromLTWH(r.right + 1, r.top - 8, 10, 30), const Color(0xFFFFC93C), radius: 2);
      c.drawLine(Offset(r.right + 2, r.top + 14), Offset(r.right + 10, r.top + 14), Pk.stroke(const Color(0xFFE59A12), 1.5));
    });
  }

  void _mirror(Canvas c, SceneFrame f, double t) {
    final stage = f.stage('mirror');
    const center = Offset(220, 64);
    final frame = Rect.fromCenter(center: center, width: 58, height: 72);
    if (stage == 0) {
      c.drawRRect(RRect.fromRectAndRadius(frame, const Radius.circular(29)), Pk.stroke(Colors.black.withValues(alpha: 0.2), 1.5));
      return;
    }
    // Bulbs (stage 3) glow behind.
    final bulbs = f.pop('mirror', 3);
    if (bulbs > 0) {
      for (var i = 0; i < 7; i++) {
        final a = pi + i * pi / 6;
        final p = center + Offset(cos(a) * 36, sin(a) * 42 + 4);
        Pk.glow(c, p, 9 * bulbs, const Color(0xFFFFE9A0), 0.7);
        c.drawCircle(p, 3.2 * bulbs, Pk.fill(const Color(0xFFFFF7D6)));
      }
    }
    Pk.scaled(c, center, f.pop('mirror', 1), () {
      c.drawRRect(RRect.fromRectAndRadius(frame.inflate(4), const Radius.circular(33)), Pk.fill(const Color(0xFFE5B85C)));
      c.drawRRect(RRect.fromRectAndRadius(frame, const Radius.circular(29)), Pk.fill(const Color(0xFF9E9384)));
    });
    Pk.scaled(c, center, f.pop('mirror', 2), () {
      final rr = RRect.fromRectAndRadius(frame, const Radius.circular(29));
      c.drawRRect(rr, Pk.fill(const Color(0xFFBFEFFA)));
      c.save();
      c.clipRRect(rr);
      c.drawLine(
        frame.topLeft + const Offset(10, 30),
        frame.topLeft + const Offset(40, 0),
        Pk.stroke(Colors.white.withValues(alpha: 0.8), 6),
      );
      c.drawLine(
        frame.topLeft + const Offset(18, 44),
        frame.topLeft + const Offset(50, 12),
        Pk.stroke(Colors.white.withValues(alpha: 0.6), 3),
      );
      c.restore();
    });
    final shine = f.pop('mirror', 4);
    if (shine > 0) {
      final tw = 0.6 + 0.4 * sin(t * 3);
      Pk.sparkle(c, frame.topRight + const Offset(-8, 12), 5 * shine * tw, Colors.white);
      Pk.sparkle(c, frame.bottomLeft + const Offset(10, -16), 3.5 * shine * (1.4 - tw), Colors.white);
    }
  }

  void _cabinet(Canvas c, SceneFrame f) {
    final stage = f.stage('bath_cabinet');
    const r = Rect.fromLTWH(304, 40, 80, 136);
    if (stage == 0) {
      c.drawRRect(RRect.fromRectAndRadius(r, const Radius.circular(4)), Pk.stroke(Colors.black.withValues(alpha: 0.2), 1.5));
      return;
    }
    Pk.scaled(c, r.bottomCenter, 1, () {
      Pk.shadow(c, r.bottomCenter, 90, 9);
      Pk.box(c, r, const Color(0xFFFFFFFF), bottom: const Color(0xFFE3EEF2), radius: 4, outline: const Color(0xFF9AC6D4), ow: 2);
      for (final y in const [78.0, 112.0]) {
        c.drawRect(Rect.fromLTWH(r.left + 4, y, r.width - 8, 4), Pk.fill(const Color(0xFFCDE3EA)));
      }
    }, f.pop('bath_cabinet', 1));
    Pk.scaled(c, Offset(r.center.dx, r.bottom), 1, () {
      Pk.box(
        c,
        Rect.fromLTWH(r.left + 4, 120, r.width / 2 - 6, 52),
        const Color(0xFF55C8DA),
        radius: 3,
        outline: const Color(0xFF2B8BA8),
      );
      Pk.box(
        c,
        Rect.fromLTWH(r.center.dx + 2, 120, r.width / 2 - 6, 52),
        const Color(0xFF55C8DA),
        radius: 3,
        outline: const Color(0xFF2B8BA8),
      );
      c.drawCircle(Offset(r.center.dx - 5, 146), 2, Pk.fill(Colors.white));
      c.drawCircle(Offset(r.center.dx + 5, 146), 2, Pk.fill(Colors.white));
    }, f.pop('bath_cabinet', 2));
    Pk.scaled(c, const Offset(344, 78), f.pop('bath_cabinet', 3), () {
      const cols = [Color(0xFFFF9BD2), Color(0xFF9B6BFF), Color(0xFF5BCB4B), Color(0xFFFFC93C)];
      for (var i = 0; i < 4; i++) {
        final x = r.left + 10 + i * 16.0;
        Pk.box(c, Rect.fromLTWH(x, 58 - (i.isOdd ? 4 : 0), 10, 20 + (i.isOdd ? 4 : 0)), cols[i], radius: 3);
        c.drawRect(Rect.fromLTWH(x + 3, 54 - (i.isOdd ? 4 : 0), 4, 4), Pk.fill(const Color(0xFF8A839B)));
      }
    });
    Pk.scaled(c, const Offset(344, 112), f.pop('bath_cabinet', 4), () {
      const cols = [Color(0xFFFF8E98), Color(0xFF7CC8FF), Color(0xFFFFE27A)];
      for (var i = 0; i < 3; i++) {
        Pk.box(c, Rect.fromLTWH(r.left + 12, 104 - i * 8.0, r.width - 24, 8), cols[i], radius: 3);
      }
    });
  }

  void _plantsBack(Canvas c, SceneFrame f, double t) {
    // Hanging plant (stage 3).
    Pk.scaled(c, const Offset(60, 0), 1, () {
      c.drawLine(const Offset(60, 0), const Offset(60, 36), Pk.stroke(const Color(0xFF8B5E3C), 1.2));
      c.drawArc(const Rect.fromLTWH(46, 30, 28, 20), 0, pi, true, Pk.fill(const Color(0xFFE07A4F)));
      for (var i = 0; i < 5; i++) {
        final x = 48 + i * 6.0;
        final len = 16 + Pk.rand(i + 30) * 22;
        final sway = sin(t + i) * 2;
        c.drawLine(Offset(x, 40), Offset(x + sway, 40 + len), Pk.stroke(const Color(0xFF4DB848), 2.5));
      }
    }, f.pop('plants', 3));
    // Wall art (stage 4).
    Pk.scaled(c, const Offset(274, 58), f.pop('plants', 4), () {
      Pk.box(
        c,
        const Rect.fromLTWH(260, 40, 30, 36),
        const Color(0xFFFFFFFF),
        radius: 2,
        outline: const Color(0xFFE5B85C),
        ow: 2.5,
      );
      c.drawCircle(const Offset(275, 52), 6, Pk.fill(const Color(0xFFFFC93C)));
      Pk.poly(c, const [Offset(263, 73), Offset(275, 58), Offset(287, 73)], Pk.fill(const Color(0xFF2EC4D6)));
    });
  }

  void _plantsFront(Canvas c, SceneFrame f) {
    // Bath mat (stage 2).
    Pk.scaled(c, const Offset(95, 212), f.pop('plants', 2), () {
      final rr = RRect.fromRectAndRadius(
        Rect.fromCenter(center: const Offset(95, 212), width: 90, height: 18),
        const Radius.circular(9),
      );
      c.drawRRect(rr, Pk.fill(const Color(0xFFFF9BD2)));
      c.drawRRect(rr.deflate(3), Pk.stroke(Colors.white.withValues(alpha: 0.7), 1.5));
    });
    // Floor plant (stage 1).
    Pk.scaled(c, const Offset(278, 204), f.pop('plants', 1), () {
      Pk.shadow(c, const Offset(278, 205), 26, 6);
      Pk.plant(c, const Offset(278, 204), 1.6, pot: const Color(0xFFFFFFFF));
    });
    // Candles on tub (stage 4).
    Pk.scaled(c, const Offset(40, 130), f.pop('plants', 4), () {
      for (var i = 0; i < 2; i++) {
        final x = 30 + i * 11.0;
        Pk.box(c, Rect.fromLTWH(x, 118 - i * 4.0, 7, 12 + i * 4.0), const Color(0xFFFFF4E0), radius: 1.5);
        Pk.glow(c, Offset(x + 3.5, 114 - i * 4.0), 8, const Color(0xFFFFC93C), 0.6);
        c.drawOval(
          Rect.fromCenter(center: Offset(x + 3.5, 114 - i * 4.0), width: 3, height: 5),
          Pk.fill(const Color(0xFFFF9A3C)),
        );
      }
    });
  }
}
