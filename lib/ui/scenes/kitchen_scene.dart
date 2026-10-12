import 'dart:math';

import 'package:flutter/material.dart';

import '../art/paint_kit.dart';
import 'room_kit.dart';
import 'scene_art.dart';

/// LEVEL 2 — Kitchen. Warm cream / wood / orange accents.
class KitchenScene extends SceneArt {
  @override
  final Map<String, Offset> anchors = const {
    'cabinets': Offset(78, 50),
    'counter': Offset(80, 135),
    'fridge': Offset(348, 105),
    'table': Offset(215, 190),
    'kitchen_decor': Offset(215, 60),
  };

  @override
  void paint(Canvas c, SceneFrame f) {
    final ov = f.overall;
    final t = f.time;

    // Walls + floor.
    RoomKit.backWall(
      c,
      172,
      Pk.mix(const Color(0xFFA59C8F), const Color(0xFFFFE7C2), ov),
      Pk.mix(const Color(0xFF8E857A), const Color(0xFFF7D2A0), ov),
    );
    // Wainscot.
    Pk.gradientRect(
      c,
      const Rect.fromLTWH(0, 118, 400, 54),
      Pk.mix(const Color(0xFF8C8375), const Color(0xFFF2C58E), ov),
      Pk.mix(const Color(0xFF7D7468), const Color(0xFFE0A86C), ov),
    );
    c.drawRect(const Rect.fromLTWH(0, 116, 400, 3), Pk.fill(Pk.mix(const Color(0xFF6D665C), const Color(0xFFC9854A), ov)));
    RoomKit.checkerFloor(
      c,
      172,
      Pk.mix(const Color(0xFF8D877D), const Color(0xFFF6E3C4), ov),
      Pk.mix(const Color(0xFF6F6A61), const Color(0xFFD9824B), ov),
    );
    RoomKit.stains(c, 1 - ov, 3);

    _window(c, f);
    _cabinets(c, f);
    _counter(c, f);
    _fridge(c, f);
    _decorBack(c, f);
    _table(c, f);
    _decorFront(c, f, t);
    RoomKit.dustOverlay(c, 1 - ov, t);
  }

  void _window(Canvas c, SceneFrame f) {
    final decor = f.stage('kitchen_decor');
    final clean = f.p('kitchen_decor');
    const r = Rect.fromLTWH(170, 26, 90, 66);
    Pk.box(c, r.inflate(5), const Color(0xFFFFFFFF), radius: 4);
    Pk.gradientRect(
      c,
      r,
      Pk.mix(const Color(0xFF8E9AA0), const Color(0xFF8ED8FF), clean),
      Pk.mix(const Color(0xFFB1B4AA), const Color(0xFFD8F4FF), clean),
    );
    // Outside greenery.
    c.drawOval(
      Rect.fromLTWH(r.left - 10, r.bottom - 22, 60, 30),
      Pk.fill(Pk.mix(const Color(0xFF8C9A7A), const Color(0xFF7CCB5A), clean)),
    );
    c.drawOval(
      Rect.fromLTWH(r.left + 45, r.bottom - 18, 60, 30),
      Pk.fill(Pk.mix(const Color(0xFF7E8C6C), const Color(0xFF5DB548), clean)),
    );
    c.drawLine(r.topCenter, r.bottomCenter, Pk.stroke(Colors.white, 3));
    c.drawLine(r.centerLeft, r.centerRight, Pk.stroke(Colors.white, 3));
    if (decor < 2) {
      final p = Pk.stroke(Colors.white.withValues(alpha: 0.8), 1);
      c.drawPath(
        Path()
          ..moveTo(r.left + 8, r.top + 6)
          ..lineTo(r.left + 20, r.top + 18)
          ..lineTo(r.left + 16, r.top + 28),
        p,
      );
    }
    // Sill.
    Pk.box(c, Rect.fromLTWH(r.left - 10, r.bottom + 4, r.width + 20, 6), const Color(0xFFFFFFFF), radius: 2);
  }

  void _cabinets(Canvas c, SceneFrame f) {
    final stage = f.stage('cabinets');
    for (var i = 0; i < 4; i++) {
      final r = Rect.fromLTWH(12 + i * 33.0, 22, 31, 58);
      if (stage > i) {
        Pk.scaled(c, r.topCenter, 1, () {
          Pk.box(
            c,
            r,
            const Color(0xFF8FC79A),
            bottom: const Color(0xFF6FAE7C),
            radius: 3,
            outline: const Color(0xFF4E8A5C),
            ow: 1.5,
          );
          Pk.box(c, r.deflate(5), const Color(0xFF9FD3A9), radius: 2, outline: const Color(0xFF5E9A6C), ow: 1);
          c.drawCircle(Offset(i.isEven ? r.right - 8 : r.left + 8, r.bottom - 12), 2.2, Pk.fill(const Color(0xFFFFC93C)));
        }, f.pop('cabinets', i + 1));
      } else {
        // Ghost outline of missing cabinet.
        c.drawRRect(RRect.fromRectAndRadius(r, const Radius.circular(3)), Pk.stroke(Colors.black.withValues(alpha: 0.18), 1.2));
        if (i == 1) {
          // Old door hanging crooked.
          c.save();
          c.translate(r.left + 2, r.top + 4);
          c.rotate(0.22);
          Pk.box(c, Rect.fromLTWH(0, 0, 27, 50), const Color(0xFF9E9384), radius: 2);
          c.restore();
        }
      }
    }
    if (stage > 0) {
      c.drawRect(Rect.fromLTWH(10, 18, 33.0 * stage + 4, 5), Pk.fill(const Color(0xFF4E8A5C)));
    }
  }

  void _counter(Canvas c, SceneFrame f) {
    final stage = f.stage('counter');
    const base = Rect.fromLTWH(10, 120, 140, 52);
    if (stage == 0) {
      Pk.box(c, const Rect.fromLTWH(14, 136, 60, 36), const Color(0xFF9A9082), radius: 2);
      Pk.box(c, const Rect.fromLTWH(84, 144, 40, 28), const Color(0xFF8D8375), radius: 2);
      return;
    }
    Pk.scaled(c, base.bottomCenter, 1, () {
      Pk.box(c, base, const Color(0xFF8FC79A), bottom: const Color(0xFF6FAE7C), radius: 2, outline: const Color(0xFF4E8A5C));
      for (var i = 0; i < 3; i++) {
        final d = Rect.fromLTWH(base.left + 5 + i * 45.0, base.top + 10, 40, 38);
        Pk.box(c, d, const Color(0xFF9FD3A9), radius: 2, outline: const Color(0xFF5E9A6C), ow: 1);
        c.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: d.topCenter + const Offset(0, 6), width: 14, height: 3),
            const Radius.circular(2),
          ),
          Pk.fill(const Color(0xFFFFC93C)),
        );
      }
    }, f.pop('counter', 1));
    // Countertop + backsplash.
    final top = f.pop('counter', 2);
    Pk.scaled(c, const Offset(80, 120), top, () {
      for (var y = 0; y < 3; y++) {
        for (var x = 0; x < 9; x++) {
          c.drawRect(Rect.fromLTWH(12 + x * 15.5 + (y.isOdd ? 7 : 0), 92 + y * 8.0, 14, 7), Pk.fill(const Color(0xFFFFFFFF)));
        }
      }
      Pk.box(c, const Rect.fromLTWH(6, 114, 148, 8), const Color(0xFFE3A15E), bottom: const Color(0xFFC57F3E), radius: 2);
    });
    // Stove.
    final stove = f.pop('counter', 3);
    Pk.scaled(c, const Offset(105, 114), stove, () {
      Pk.box(c, const Rect.fromLTWH(84, 110, 44, 5), const Color(0xFF3B3452), radius: 2);
      for (final x in const [96.0, 116.0]) {
        c.drawOval(Rect.fromCenter(center: Offset(x, 112), width: 13, height: 3.5), Pk.stroke(const Color(0xFFFF7A3C), 1.4));
      }
      Pk.box(c, const Rect.fromLTWH(90, 132, 32, 22), const Color(0xFF3B3452), radius: 3);
      Pk.box(c, const Rect.fromLTWH(94, 136, 24, 14), const Color(0xFFFFB56B), radius: 2);
    });
    // Kettle + utensils.
    final extras = f.pop('counter', 4);
    Pk.scaled(c, const Offset(40, 114), extras, () {
      c.drawOval(const Rect.fromLTWH(26, 98, 22, 17), Pk.fill(const Color(0xFFFF5A6E)));
      c.drawRect(const Rect.fromLTWH(34, 94, 6, 5), Pk.fill(const Color(0xFF3B3452)));
      c.drawLine(const Offset(47, 104), const Offset(53, 99), Pk.stroke(const Color(0xFFFF5A6E), 3));
      Pk.box(c, const Rect.fromLTWH(136, 100, 10, 14), const Color(0xFFFFFFFF), radius: 2);
      for (var i = 0; i < 3; i++) {
        c.drawLine(Offset(138 + i * 3.0, 100), Offset(137 + i * 4.0, 90), Pk.stroke(const Color(0xFF8A839B), 1.5));
      }
    });
  }

  void _fridge(Canvas c, SceneFrame f) {
    final stage = f.stage('fridge');
    const r = Rect.fromLTWH(318, 36, 62, 136);
    if (stage == 0) {
      c.drawRRect(RRect.fromRectAndRadius(r, const Radius.circular(10)), Pk.stroke(Colors.black.withValues(alpha: 0.2), 1.5));
      Pk.box(c, const Rect.fromLTWH(326, 140, 44, 32), const Color(0xFFC9A67A), radius: 2);
      c.drawLine(const Offset(326, 150), const Offset(370, 150), Pk.stroke(const Color(0xFFA8844F), 2));
      return;
    }
    final body = f.pop('fridge', 1);
    final color = f.a('fridge', 2);
    Pk.scaled(c, r.bottomCenter, 1, () {
      Pk.shadow(c, r.bottomCenter, 70, 8);
      Pk.box(
        c,
        r,
        Pk.mix(const Color(0xFFE8E4DC), const Color(0xFF9EE3D1), color),
        bottom: Pk.mix(const Color(0xFFC9C4BA), const Color(0xFF6CC9B2), color),
        radius: 12,
        outline: Pk.mix(const Color(0xFF9F998F), const Color(0xFF3E9E86), color),
        ow: 2,
      );
      c.drawLine(
        Offset(r.left + 3, r.top + 48),
        Offset(r.right - 3, r.top + 48),
        Pk.stroke(Pk.dark(const Color(0xFF6CC9B2), 0.3), 2),
      );
      if (color > 0) {
        final h = Pk.fill(Colors.white.withValues(alpha: color));
        c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(r.left + 8, r.top + 14, 4, 26), const Radius.circular(2)), h);
        c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(r.left + 8, r.top + 58, 4, 36), const Radius.circular(2)), h);
      }
    }, body);
    final magnets = f.pop('fridge', 3);
    Pk.scaled(c, const Offset(355, 90), magnets, () {
      Pk.box(c, const Rect.fromLTWH(340, 64, 26, 20), const Color(0xFFFFFFFF), radius: 1);
      c.drawCircle(const Offset(348, 72), 3.5, Pk.fill(const Color(0xFFFFC93C)));
      c.drawLine(const Offset(343, 81), const Offset(363, 78), Pk.stroke(const Color(0xFF45A7F5), 2));
      c.drawCircle(const Offset(353, 64), 3, Pk.fill(const Color(0xFFFF5A6E)));
      c.drawCircle(const Offset(360, 110), 3.5, Pk.fill(const Color(0xFF9B6BFF)));
      c.drawCircle(const Offset(342, 122), 3.5, Pk.fill(const Color(0xFFFF9A3C)));
    });
    final shine = f.pop('fridge', 4);
    Pk.scaled(c, const Offset(350, 36), shine, () {
      Pk.plant(c, const Offset(350, 36), 0.75, pot: const Color(0xFFFF9A3C));
      c.drawLine(const Offset(368, 50), const Offset(374, 80), Pk.stroke(Colors.white.withValues(alpha: 0.6), 3));
    });
  }

  void _decorBack(Canvas c, SceneFrame f) {
    // Curtains (stage 2).
    final cur = f.pop('kitchen_decor', 2);
    Pk.scaled(c, const Offset(215, 18), 1, () {
      for (final dir in const [-1.0, 1.0]) {
        final x = 215 + dir * 44;
        final path = Path()
          ..moveTo(x - 14 * dir, 18)
          ..lineTo(x + 6 * dir, 18)
          ..quadraticBezierTo(x - 2 * dir, 60, x + 4 * dir, 100)
          ..lineTo(x - 14 * dir, 100)
          ..close();
        c.drawPath(path, Pk.fill(const Color(0xFFFF8A5C)));
        c.drawPath(path, Pk.stroke(const Color(0xFFD9603A), 1.2));
      }
      c.drawRect(const Rect.fromLTWH(155, 15, 120, 4), Pk.fill(const Color(0xFF8B5E3C)));
    }, cur);
    // Wall clock (stage 4).
    final clock = f.pop('kitchen_decor', 4);
    const cc = Offset(290, 52);
    Pk.scaled(c, cc, clock, () {
      c.drawCircle(cc, 13, Pk.fill(const Color(0xFFFF9A3C)));
      c.drawCircle(cc, 10, Pk.fill(Colors.white));
      final a = f.time * 0.5;
      c.drawLine(cc, cc + Offset(sin(a), -cos(a)) * 7, Pk.stroke(const Color(0xFF3B2A5A), 1.6));
      c.drawLine(cc, cc + const Offset(4, 0), Pk.stroke(const Color(0xFF3B2A5A), 1.6));
    });
  }

  void _table(Canvas c, SceneFrame f) {
    final stage = f.stage('table');
    const center = Offset(215, 196);
    // Rug (decor 4) sits under the table.
    final rug = f.pop('kitchen_decor', 4);
    Pk.scaled(c, center + const Offset(0, 16), rug, () {
      c.drawOval(Rect.fromCenter(center: center + const Offset(0, 16), width: 150, height: 34), Pk.fill(const Color(0xFFFFC76B)));
      c.drawOval(
        Rect.fromCenter(center: center + const Offset(0, 16), width: 130, height: 26),
        Pk.stroke(const Color(0xFFE88A3C), 2.5),
      );
    });
    if (stage == 0) {
      Pk.box(
        c,
        Rect.fromCenter(center: center + const Offset(-10, 8), width: 30, height: 20),
        const Color(0xFFC9A67A),
        radius: 2,
      );
      return;
    }
    void chair(double dx, double s) {
      final p = center + Offset(dx, 6);
      Pk.scaled(c, p + const Offset(0, 16), s, () {
        Pk.box(
          c,
          Rect.fromCenter(center: p + const Offset(0, -14), width: 20, height: 24),
          const Color(0xFFE08A45),
          radius: 4,
          outline: const Color(0xFFB9642C),
        );
        Pk.box(
          c,
          Rect.fromCenter(center: p, width: 24, height: 7),
          const Color(0xFFE08A45),
          radius: 2,
          outline: const Color(0xFFB9642C),
        );
        c.drawRect(Rect.fromLTWH(p.dx - 10, p.dy + 3, 3, 15), Pk.fill(const Color(0xFFB9642C)));
        c.drawRect(Rect.fromLTWH(p.dx + 7, p.dy + 3, 3, 15), Pk.fill(const Color(0xFFB9642C)));
      });
    }

    chair(-50, f.pop('table', 2));
    chair(50, f.pop('table', 3));
    Pk.scaled(c, center + const Offset(0, 20), f.pop('table', 1), () {
      Pk.shadow(c, center + const Offset(0, 22), 110, 12);
      c.drawRect(Rect.fromLTWH(center.dx - 36, center.dy - 4, 5, 26), Pk.fill(const Color(0xFF8B5E3C)));
      c.drawRect(Rect.fromLTWH(center.dx + 31, center.dy - 4, 5, 26), Pk.fill(const Color(0xFF8B5E3C)));
      Pk.box(
        c,
        Rect.fromCenter(center: center - const Offset(0, 6), width: 92, height: 10),
        const Color(0xFFC98A52),
        bottom: const Color(0xFFA86B38),
        radius: 3,
      );
    });
    Pk.scaled(c, center - const Offset(0, 12), f.pop('table', 4), () {
      c.drawArc(
        Rect.fromCenter(center: center - const Offset(8, 12), width: 26, height: 14),
        0,
        pi,
        true,
        Pk.fill(const Color(0xFFFFFFFF)),
      );
      c.drawCircle(center - const Offset(14, 16), 4.5, Pk.fill(const Color(0xFFFF5A5A)));
      c.drawCircle(center - const Offset(6, 17), 4.5, Pk.fill(const Color(0xFFFFC93C)));
      c.drawCircle(center - const Offset(0, 15), 4, Pk.fill(const Color(0xFF7CCB5A)));
      Pk.box(c, Rect.fromLTWH(center.dx + 18, center.dy - 26, 8, 15), const Color(0xFF45A7F5), radius: 3);
      Pk.flower(c, Offset(center.dx + 22, center.dy - 30), 0.9, const Color(0xFFFF6B8B));
    });
  }

  void _decorFront(Canvas c, SceneFrame f, double t) {
    // Pendant lamps (stage 1).
    final lamps = f.pop('kitchen_decor', 1);
    for (final x in const [190.0, 240.0]) {
      final sway = sin(t * 1.2 + x) * 0.8;
      Pk.scaled(c, Offset(x, 0), 1, () {
        c.drawLine(Offset(x, 0), Offset(x + sway, 112), Pk.stroke(const Color(0xFF3B3452), 1.2));
        Pk.glow(c, Offset(x + sway, 122), 34, const Color(0xFFFFE3A0), 0.55);
        final shade = Path()
          ..moveTo(x + sway - 5, 110)
          ..lineTo(x + sway + 5, 110)
          ..lineTo(x + sway + 12, 122)
          ..lineTo(x + sway - 12, 122)
          ..close();
        c.drawPath(shade, Pk.fill(const Color(0xFFFF9A3C)));
        c.drawOval(Rect.fromCenter(center: Offset(x + sway, 122), width: 18, height: 4), Pk.fill(const Color(0xFFFFF4C2)));
      }, lamps);
    }
    // Floor plant (stage 3).
    Pk.scaled(c, const Offset(296, 186), f.pop('kitchen_decor', 3), () {
      Pk.plant(c, const Offset(296, 186), 1.4, pot: const Color(0xFFE07A4F));
    });
  }
}
