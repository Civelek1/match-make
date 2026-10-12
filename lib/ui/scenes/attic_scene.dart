import 'dart:math';

import 'package:flutter/material.dart';

import '../art/paint_kit.dart';
import 'room_kit.dart';
import 'scene_art.dart';

/// LEVEL 5 — Attic. Warm wood, sunset light, cozy.
class AtticScene extends SceneArt {
  @override
  final Map<String, Offset> anchors = const {
    'floor': Offset(200, 214),
    'shelves': Offset(100, 140),
    'boxes': Offset(305, 165),
    'window': Offset(200, 82),
    'furniture': Offset(175, 185),
    'attic_decor': Offset(200, 40),
  };

  @override
  void paint(Canvas c, SceneFrame f) {
    final ov = f.overall;
    final t = f.time;
    final win = f.p('window');

    // Sloped ceiling (fills everything), then the gable back wall.
    final slope = Pk.mix(const Color(0xFF4A3E36), const Color(0xFFA0643A), ov);
    c.drawRect(const Rect.fromLTWH(0, 0, 400, 240), Pk.fill(slope));
    for (var i = 0; i < 12; i++) {
      final x = -60 + i * 22.0;
      c.drawLine(Offset(x, 240), Offset(x + 140, 0), Pk.stroke(Pk.dark(slope, 0.2), 1.2));
      c.drawLine(Offset(460 - i * 22.0, 240), Offset(320 - i * 22.0, 0), Pk.stroke(Pk.dark(slope, 0.2), 1.2));
    }
    final wall = Pk.mix(const Color(0xFF7A6C5E), const Color(0xFFF2D3A6), ov);
    const gable = [Offset(52, 196), Offset(52, 108), Offset(200, 18), Offset(348, 108), Offset(348, 196)];
    Pk.poly(
      c,
      gable,
      Paint()
        ..shader = LinearGradient(
          colors: [Pk.light(wall, 0.06), Pk.dark(wall, 0.1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(const Rect.fromLTWH(52, 18, 296, 178)),
    );

    // Sunset light from the window.
    final beams = f.a('window', 3);
    if (beams > 0) {
      final p = Path()
        ..moveTo(180, 90)
        ..lineTo(220, 90)
        ..lineTo(290, 240)
        ..lineTo(130, 240)
        ..close();
      c.drawPath(p, Pk.fill(const Color(0xFFFFC46B).withValues(alpha: 0.22 * beams)));
    }

    _floor(c, f);

    // Beams.
    final beam = Pk.mix(const Color(0xFF3A302A), const Color(0xFF7A4526), ov);
    c.drawRect(const Rect.fromLTWH(46, 100, 10, 100), Pk.fill(beam));
    c.drawRect(const Rect.fromLTWH(344, 100, 10, 100), Pk.fill(beam));
    c.drawRect(const Rect.fromLTWH(40, 44, 320, 9), Pk.fill(beam));

    _window(c, f, t, win);
    _decorBack(c, f, t);
    _shelves(c, f);
    _boxes(c, f);
    _furniture(c, f, t);
    _decorFront(c, f, t);

    // Mess + dust (neglect).
    final mess = 1 - ov;
    if (mess > 0.02) {
      Pk.faded(c, const Rect.fromLTWH(0, 150, 400, 90), mess, () {
        c.save();
        c.translate(250, 205);
        c.rotate(0.35);
        Pk.box(c, const Rect.fromLTWH(-14, -10, 28, 20), const Color(0xFF8E7F6D), radius: 2);
        c.restore();
        c.drawOval(const Rect.fromLTWH(120, 212, 40, 8), Pk.fill(const Color(0xFF6E6254)));
      });
    }
    RoomKit.dustOverlay(c, mess, t);
  }

  void _floor(Canvas c, SceneFrame f) {
    final stage = f.stage('floor');
    const top = 192.0;
    for (var i = 0; i < 4; i++) {
      final r = Rect.fromLTWH(i * 100.0, top, 100, 48);
      if (stage > i) {
        final a = f.a('floor', i + 1);
        RoomKit.planks(c, r, const Color(0xFF7D7064));
        Pk.faded(c, r, a, () => RoomKit.planks(c, r, const Color(0xFFC98A52)));
      } else {
        RoomKit.planks(c, r, const Color(0xFF7D7064));
        c.drawRect(r, Pk.fill(const Color(0xFF9E9387).withValues(alpha: 0.35)));
      }
    }
    c.drawLine(const Offset(0, top), const Offset(400, top), Pk.stroke(Colors.black.withValues(alpha: 0.25), 2));
  }

  void _window(Canvas c, SceneFrame f, double t, double win) {
    const center = Offset(200, 86);
    final stage = f.stage('window');
    if (stage == 0) {
      // Boarded-up hole.
      c.drawCircle(center, 26, Pk.fill(const Color(0xFF2A221D)));
      for (final a in const [-0.3, 0.25]) {
        c.save();
        c.translate(center.dx, center.dy);
        c.rotate(a);
        Pk.box(c, const Rect.fromLTWH(-34, -6, 68, 11), const Color(0xFF8E7F6D), radius: 2);
        c.restore();
      }
      return;
    }
    Pk.scaled(c, center, f.pop('window', 2), () {
      c.drawCircle(
        center,
        26,
        Paint()
          ..shader = const RadialGradient(colors: [Color(0xFFFFE08A), Color(0xFFFF9A5C), Color(0xFFD9577A)])
              .createShader(Rect.fromCircle(center: center, radius: 30)),
      );
      c.drawCircle(center + const Offset(0, 8), 9, Pk.fill(const Color(0xFFFFF1B0)));
      final hills = Path()
        ..moveTo(center.dx - 30, center.dy + 14)
        ..quadraticBezierTo(center.dx - 10, center.dy + 2, center.dx + 8, center.dy + 12)
        ..quadraticBezierTo(center.dx + 20, center.dy + 6, center.dx + 30, center.dy + 12)
        ..lineTo(center.dx + 30, center.dy + 30)
        ..lineTo(center.dx - 30, center.dy + 30)
        ..close();
      c.save();
      c.clipPath(Path()..addOval(Rect.fromCircle(center: center, radius: 26)));
      c.drawPath(hills, Pk.fill(const Color(0xFF7A3D6A)));
      c.restore();
    });
    Pk.scaled(c, center, f.pop('window', 1), () {
      c.drawCircle(center, 28, Pk.stroke(const Color(0xFFE8B070), 6));
      c.drawCircle(center, 31, Pk.stroke(const Color(0xFF7A4526), 1.5));
      c.drawLine(center - const Offset(0, 26), center + const Offset(0, 26), Pk.stroke(const Color(0xFFE8B070), 3));
      c.drawLine(center - const Offset(26, 0), center + const Offset(26, 0), Pk.stroke(const Color(0xFFE8B070), 3));
    });
    if (f.a('window', 3) > 0) {
      Pk.glow(c, center, 60, const Color(0xFFFFC46B), 0.35 * f.a('window', 3));
    }
    // Flower box (stage 4).
    Pk.scaled(c, center + const Offset(0, 34), f.pop('window', 4), () {
      Pk.box(c, Rect.fromCenter(center: center + const Offset(0, 36), width: 56, height: 9), const Color(0xFFB9642C), radius: 2);
      for (var i = 0; i < 5; i++) {
        Pk.flower(c, center + Offset(-20 + i * 10.0, 26), 0.8, i.isEven ? const Color(0xFFFF6B8B) : const Color(0xFFFFFFFF));
      }
    });
  }

  void _shelves(Canvas c, SceneFrame f) {
    final stage = f.stage('shelves');
    const r = Rect.fromLTWH(66, 112, 62, 80);
    if (stage == 0) {
      c.save();
      c.translate(80, 188);
      c.rotate(-0.1);
      Pk.box(c, const Rect.fromLTWH(0, -6, 50, 6), const Color(0xFF8E7F6D), radius: 1);
      c.restore();
      return;
    }
    Pk.scaled(c, r.bottomCenter, f.pop('shelves', 1), () {
      Pk.shadow(c, r.bottomCenter, 70, 8);
      c.drawRect(Rect.fromLTWH(r.left, r.top, 5, r.height), Pk.fill(const Color(0xFF8B5E3C)));
      c.drawRect(Rect.fromLTWH(r.right - 5, r.top, 5, r.height), Pk.fill(const Color(0xFF8B5E3C)));
      c.drawRect(Rect.fromLTWH(r.left, r.top, r.width, 4), Pk.fill(const Color(0xFF8B5E3C)));
    });
    const bookCols = [Color(0xFFFF5A6E), Color(0xFF45A7F5), Color(0xFFFFC93C), Color(0xFF5BCB4B), Color(0xFF9B6BFF)];
    for (var level = 0; level < 3; level++) {
      final y = r.top + 26 + level * 25.0;
      final s = f.pop('shelves', level + 2);
      Pk.scaled(c, Offset(r.center.dx, y), s, () {
        c.drawRect(Rect.fromLTWH(r.left, y, r.width, 4), Pk.fill(const Color(0xFFA86B38)));
        if (level == 2) {
          Pk.plant(c, Offset(r.left + 16, y), 0.6);
          c.drawOval(Rect.fromLTWH(r.left + 30, y - 10, 12, 10), Pk.fill(const Color(0xFF7CC8FF).withValues(alpha: 0.8)));
          Pk.box(c, Rect.fromLTWH(r.left + 44, y - 12, 9, 12), const Color(0xFFFFE27A), radius: 2);
        } else {
          for (var b = 0; b < 7; b++) {
            final h = 14 + Pk.rand(level * 10 + b) * 6;
            c.drawRect(Rect.fromLTWH(r.left + 7 + b * 7.0, y - h, 6, h), Pk.fill(bookCols[(b + level) % bookCols.length]));
          }
          if (level == 1) {
            c.drawCircle(Offset(r.right - 12, y - 10), 7, Pk.fill(const Color(0xFF45A7F5)));
            c.drawCircle(Offset(r.right - 12, y - 10), 7, Pk.stroke(const Color(0xFF5BCB4B), 2));
          }
        }
      });
    }
  }

  void _boxes(Canvas c, SceneFrame f) {
    final stage = f.stage('boxes');
    if (stage == 0) return;
    void box(Rect r, double s, Color col) {
      Pk.scaled(c, r.bottomCenter, s, () {
        Pk.box(c, r, col, radius: 2, outline: Pk.dark(col, 0.3));
        c.drawLine(r.topCenter, r.bottomCenter.translate(0, -r.height * 0.4), Pk.stroke(Pk.dark(col, 0.25), 3));
        Pk.box(
          c,
          Rect.fromCenter(center: r.center + Offset(0, r.height * 0.15), width: r.width * 0.45, height: r.height * 0.2),
          const Color(0xFFFFF6E6),
          radius: 1,
        );
      });
    }

    Pk.shadow(c, const Offset(305, 192), 90, 8);
    box(const Rect.fromLTWH(272, 160, 38, 32), f.pop('boxes', 1), const Color(0xFFD9A066));
    box(const Rect.fromLTWH(278, 132, 30, 28), f.pop('boxes', 2), const Color(0xFFE3B27A));
    box(const Rect.fromLTWH(312, 166, 30, 26), f.pop('boxes', 3), const Color(0xFFC98E52));
    // Treasure trunk (stage 4).
    Pk.scaled(c, const Offset(250, 206), f.pop('boxes', 4), () {
      Pk.shadow(c, const Offset(250, 207), 60, 8);
      Pk.box(c, const Rect.fromLTWH(226, 186, 48, 20), const Color(0xFF3FA3A8), radius: 3, outline: const Color(0xFF1E6F77));
      c.drawArc(const Rect.fromLTWH(226, 176, 48, 20), pi, pi, true, Pk.fill(const Color(0xFF4FC0C4)));
      c.drawRect(const Rect.fromLTWH(247, 184, 6, 8), Pk.fill(const Color(0xFFFFC93C)));
    });
  }

  void _furniture(Canvas c, SceneFrame f, double t) {
    // Rug (stage 1).
    Pk.scaled(c, const Offset(200, 214), f.pop('furniture', 1), () {
      c.drawOval(Rect.fromCenter(center: const Offset(196, 214), width: 170, height: 30), Pk.fill(const Color(0xFFD95B5B)));
      c.drawOval(
        Rect.fromCenter(center: const Offset(196, 214), width: 146, height: 22),
        Pk.stroke(const Color(0xFFFFD6A0), 2.5),
      );
    });
    // Lamp (stage 3).
    final lamp = f.pop('furniture', 3);
    const lb = Offset(212, 206);
    Pk.scaled(c, lb, lamp, () {
      Pk.glow(c, lb - const Offset(0, 62), 46, const Color(0xFFFFD68A), 0.55);
      c.drawRect(Rect.fromLTWH(lb.dx - 1.5, lb.dy - 58, 3, 58), Pk.fill(const Color(0xFF3B3452)));
      c.drawOval(Rect.fromCenter(center: lb, width: 16, height: 4), Pk.fill(const Color(0xFF3B3452)));
      Pk.poly(c, [
        lb - const Offset(9, 74),
        lb - const Offset(-9, 74),
        lb - const Offset(-13, 58),
        lb - const Offset(13, 58),
      ], Pk.fill(const Color(0xFFFFE3A0)));
    });
    // Armchair (stage 2).
    const ac = Offset(166, 204);
    Pk.scaled(c, ac, f.pop('furniture', 2), () {
      Pk.shadow(c, ac, 64, 9);
      Pk.box(
        c,
        Rect.fromCenter(center: ac - const Offset(0, 34), width: 44, height: 36),
        const Color(0xFF5BA88A),
        radius: 10,
        outline: const Color(0xFF3B7A62),
      );
      Pk.box(
        c,
        Rect.fromCenter(center: ac - const Offset(0, 12), width: 50, height: 16),
        const Color(0xFF6CC09E),
        radius: 6,
        outline: const Color(0xFF3B7A62),
      );
      Pk.box(
        c,
        Rect.fromCenter(center: ac - const Offset(25, 18), width: 10, height: 24),
        const Color(0xFF5BA88A),
        radius: 5,
        outline: const Color(0xFF3B7A62),
      );
      Pk.box(
        c,
        Rect.fromCenter(center: ac - const Offset(-25, 18), width: 10, height: 24),
        const Color(0xFF5BA88A),
        radius: 5,
        outline: const Color(0xFF3B7A62),
      );
      c.drawRect(Rect.fromLTWH(ac.dx - 22, ac.dy - 4, 4, 5), Pk.fill(const Color(0xFF7A4526)));
      c.drawRect(Rect.fromLTWH(ac.dx + 18, ac.dy - 4, 4, 5), Pk.fill(const Color(0xFF7A4526)));
    });
    // Bean bag (stage 4).
    Pk.scaled(c, const Offset(232, 222), f.pop('furniture', 4), () {
      c.drawOval(const Rect.fromLTWH(210, 204, 44, 24), Pk.fill(const Color(0xFFFFB35C)));
      c.drawOval(const Rect.fromLTWH(218, 206, 22, 9), Pk.fill(const Color(0xFFFFD08A)));
    });
  }

  void _decorBack(Canvas c, SceneFrame f, double t) {
    // Fairy lights along the collar beam (stage 1).
    final lights = f.a('attic_decor', 1);
    if (lights > 0) {
      final path = Path()..moveTo(44, 54);
      for (var i = 0; i < 8; i++) {
        path.quadraticBezierTo(62 + i * 40.0, 70, 84 + i * 40.0, 54);
      }
      c.save();
      c.clipRect(Rect.fromLTWH(0, 0, 44 + 320 * lights, 240));
      c.drawPath(path, Pk.stroke(const Color(0xFF3A302A), 1));
      for (var i = 0; i < 16; i++) {
        final x = 54 + i * 20.0;
        final y = 54 + 8 * sin((x - 44) / 40 * pi).abs();
        final tw = 0.55 + 0.45 * sin(t * 3 + i * 1.7);
        const cols = [Color(0xFFFFE066), Color(0xFFFF9BD2), Color(0xFF9CF0FF)];
        Pk.glow(c, Offset(x, y + 2), 7, cols[i % 3], 0.6 * tw);
        c.drawCircle(Offset(x, y + 2), 2, Pk.fill(cols[i % 3]));
      }
      c.restore();
    }
    // Paintings (stage 2).
    Pk.scaled(c, const Offset(118, 88), f.pop('attic_decor', 2), () {
      Pk.box(c, const Rect.fromLTWH(98, 72, 40, 30), const Color(0xFF7CC8FF), radius: 1, outline: const Color(0xFFE5B85C), ow: 3);
      Pk.poly(c, const [Offset(100, 100), Offset(114, 84), Offset(124, 94), Offset(136, 100)], Pk.fill(const Color(0xFF5BCB4B)));
    });
    Pk.scaled(c, const Offset(290, 96), f.pop('attic_decor', 2), () {
      Pk.box(
        c,
        const Rect.fromLTWH(276, 80, 28, 34),
        const Color(0xFFFFE9C8),
        radius: 1,
        outline: const Color(0xFFE5B85C),
        ow: 3,
      );
      Pk.flower(c, const Offset(290, 94), 1.2, const Color(0xFFFF6B8B));
    });
    // Hanging plants from beam (stage 3).
    for (final x in const [96.0, 304.0]) {
      Pk.scaled(c, Offset(x, 53), 1, () {
        c.drawLine(Offset(x, 53), Offset(x, 64), Pk.stroke(const Color(0xFF7A4526), 1));
        c.drawArc(Rect.fromLTWH(x - 10, 60, 20, 12), 0, pi, true, Pk.fill(const Color(0xFFE07A4F)));
        for (var i = 0; i < 4; i++) {
          c.drawLine(
            Offset(x - 7 + i * 5.0, 66),
            Offset(x - 8 + i * 5.0 + sin(t + i) * 2, 76 + Pk.rand(i + x.toInt()) * 14),
            Pk.stroke(const Color(0xFF4DB848), 2.2),
          );
        }
      }, f.pop('attic_decor', 3));
    }
  }

  void _decorFront(Canvas c, SceneFrame f, double t) {
    // Teddy bear on the armchair + candles (stage 4).
    final s = f.pop('attic_decor', 4);
    const bear = Offset(166, 182);
    Pk.scaled(c, bear, s, () {
      c.drawCircle(bear - const Offset(0, 6), 7, Pk.fill(const Color(0xFFC98A52)));
      c.drawCircle(bear - const Offset(0, 16), 6, Pk.fill(const Color(0xFFC98A52)));
      c.drawCircle(bear - const Offset(5, 21), 2.5, Pk.fill(const Color(0xFFC98A52)));
      c.drawCircle(bear - const Offset(-5, 21), 2.5, Pk.fill(const Color(0xFFC98A52)));
      c.drawCircle(bear - const Offset(0, 14), 2, Pk.fill(const Color(0xFFFFE3C4)));
    });
    Pk.scaled(c, const Offset(338, 190), s, () {
      for (var i = 0; i < 3; i++) {
        final x = 326 + i * 9.0;
        final h = 10 + i * 3.0;
        Pk.box(c, Rect.fromLTWH(x, 192 - h, 6, h), const Color(0xFFFFF4E0), radius: 1.5);
        final fl = Offset(x + 3, 188 - h + sin(t * 8 + i) * 0.5);
        Pk.glow(c, fl, 8, const Color(0xFFFFC93C), 0.6);
        c.drawOval(Rect.fromCenter(center: fl, width: 3, height: 5), Pk.fill(const Color(0xFFFF9A3C)));
      }
    });
  }
}
