import 'dart:math';

import 'package:flutter/material.dart';

import '../art/paint_kit.dart';
import 'room_kit.dart';
import 'scene_art.dart';

/// LEVEL 4 — Gaming Room. Dark room with vibrant RGB accents.
class GamingRoomScene extends SceneArt {
  @override
  final Map<String, Offset> anchors = const {
    'desk': Offset(200, 150),
    'pc': Offset(332, 140),
    'gaming_chair': Offset(200, 190),
    'monitor': Offset(200, 100),
    'rgb': Offset(200, 12),
    'gaming_decor': Offset(60, 60),
  };

  @override
  void paint(Canvas c, SceneFrame f) {
    final ov = f.overall;
    final t = f.time;
    final rgb = f.p('rgb');

    RoomKit.backWall(
      c,
      176,
      Pk.mix(const Color(0xFF45424D), const Color(0xFF241C4D), ov),
      Pk.mix(const Color(0xFF38353F), const Color(0xFF1A1438), ov),
    );
    // Wall panels.
    for (var x = 0.0; x < 400; x += 50) {
      c.drawLine(Offset(x, 14), Offset(x, 176), Pk.stroke(Colors.white.withValues(alpha: 0.04), 1));
    }
    RoomKit.checkerFloor(
      c,
      176,
      Pk.mix(const Color(0xFF4A4750), const Color(0xFF2A2350), ov),
      Pk.mix(const Color(0xFF3E3B44), const Color(0xFF221C44), ov),
    );

    // Ambient RGB wash (stage 4).
    final wash = f.a('rgb', 4);
    if (wash > 0) {
      Pk.glow(c, const Offset(80, 200), 150, Pk.hue(t * 40), 0.25 * wash);
      Pk.glow(c, const Offset(330, 200), 150, Pk.hue(t * 40 + 180), 0.25 * wash);
    }

    // Leftover boxes (neglect).
    final junk = 1 - ov;
    if (junk > 0.02) {
      Pk.faded(c, const Rect.fromLTWH(0, 120, 400, 120), junk, () {
        Pk.box(c, const Rect.fromLTWH(30, 176, 40, 30), const Color(0xFFB08A5A), radius: 2);
        Pk.box(c, const Rect.fromLTWH(40, 152, 30, 26), const Color(0xFFC49B68), radius: 2);
        Pk.box(c, const Rect.fromLTWH(345, 190, 36, 26), const Color(0xFFB08A5A), radius: 2);
      });
    }

    _decorBack(c, f, t);
    _rgbStrips(c, f, t, rgb);
    _monitor(c, f, t);
    _desk(c, f, t);
    _pc(c, f, t);
    _chair(c, f, t);
    _decorFront(c, f);
    RoomKit.dustOverlay(c, junk * 0.6, t);
  }

  void _rgbStrips(Canvas c, SceneFrame f, double t, double rgb) {
    void strip(Offset a, Offset b, double s, double hueOffset) {
      if (s <= 0) return;
      final end = Offset.lerp(a, b, s)!;
      const n = 24;
      for (var i = 0; i < n; i++) {
        final p0 = Offset.lerp(a, end, i / n)!, p1 = Offset.lerp(a, end, (i + 1) / n)!;
        final col = Pk.hue(t * 90 + hueOffset + i * 12);
        c.drawLine(p0, p1, Pk.stroke(col.withValues(alpha: 0.35), 7));
        c.drawLine(p0, p1, Pk.stroke(col, 2.5));
      }
    }

    strip(const Offset(0, 10), const Offset(200, 10), f.a('rgb', 1), 0);
    strip(const Offset(200, 10), const Offset(400, 10), f.a('rgb', 2), 180);
  }

  void _desk(Canvas c, SceneFrame f, double t) {
    final stage = f.stage('desk');
    const top = Rect.fromLTWH(96, 136, 208, 10);
    if (stage == 0) {
      Pk.box(c, const Rect.fromLTWH(150, 150, 60, 26), const Color(0xFF6E6A78), radius: 2);
      return;
    }
    // Under-desk glow (rgb stage 3).
    final under = f.a('rgb', 3);
    if (under > 0) {
      c.drawLine(
        Offset(top.left + 4, top.bottom + 2),
        Offset(top.left + 4 + (top.width - 8) * under, top.bottom + 2),
        Pk.stroke(Pk.hue(t * 90 + 90), 3),
      );
      Pk.glow(c, top.bottomCenter + const Offset(0, 16), 90 * under, Pk.hue(t * 90 + 90), 0.3);
    }
    Pk.scaled(c, top.bottomCenter, f.pop('desk', 1), () {
      Pk.shadow(c, const Offset(200, 190), 220, 12);
      c.drawRect(Rect.fromLTWH(top.left + 6, top.bottom, 7, 44), Pk.fill(const Color(0xFF1A1726)));
      c.drawRect(Rect.fromLTWH(top.right - 13, top.bottom, 7, 44), Pk.fill(const Color(0xFF1A1726)));
      Pk.box(c, top, const Color(0xFF3A3450), bottom: const Color(0xFF26213A), radius: 3, outline: const Color(0xFF14111F));
    });
    Pk.scaled(c, Offset(top.left + 30, top.bottom), f.pop('desk', 2), () {
      Pk.box(
        c,
        Rect.fromLTWH(top.left + 14, top.bottom, 36, 40),
        const Color(0xFF2E2944),
        radius: 2,
        outline: const Color(0xFF14111F),
      );
      for (var i = 0; i < 3; i++) {
        c.drawLine(
          Offset(top.left + 22, top.bottom + 9 + i * 12.0),
          Offset(top.left + 42, top.bottom + 9 + i * 12.0),
          Pk.stroke(const Color(0xFF7A3CFF), 1.5),
        );
      }
    });
    Pk.scaled(c, top.center, f.pop('desk', 3), () {
      final pad = RRect.fromRectAndRadius(
        Rect.fromCenter(center: top.center + const Offset(8, -1), width: 132, height: 7),
        const Radius.circular(3),
      );
      c.drawRRect(pad, Pk.fill(const Color(0xFF14111F)));
      c.drawRRect(pad, Pk.stroke(Pk.hue(t * 60 + 200), 1.2));
    });
    Pk.scaled(c, top.center, f.pop('desk', 4), () {
      final kb = Rect.fromCenter(center: top.center + const Offset(-4, -3), width: 64, height: 6);
      c.drawRRect(RRect.fromRectAndRadius(kb, const Radius.circular(2)), Pk.fill(const Color(0xFF26213A)));
      for (var i = 0; i < 12; i++) {
        c.drawRect(Rect.fromLTWH(kb.left + 2 + i * 5.0, kb.top + 1.5, 3.5, 3), Pk.fill(Pk.hue(t * 120 + i * 30)));
      }
      c.drawOval(
        Rect.fromCenter(center: top.center + const Offset(48, -3), width: 9, height: 6),
        Pk.fill(const Color(0xFF26213A)),
      );
      c.drawCircle(top.center + const Offset(48, -4), 1.2, Pk.fill(Pk.hue(t * 120)));
      // Headphone stand.
      c.drawRect(Rect.fromLTWH(top.left + 16, top.top - 26, 3, 26), Pk.fill(const Color(0xFF3A3450)));
      c.drawArc(Rect.fromLTWH(top.left + 7, top.top - 32, 21, 18), pi, pi, false, Pk.stroke(const Color(0xFFFF4FD8), 3));
      c.drawOval(Rect.fromLTWH(top.left + 5, top.top - 24, 6, 9), Pk.fill(const Color(0xFFFF4FD8)));
      c.drawOval(Rect.fromLTWH(top.left + 24, top.top - 24, 6, 9), Pk.fill(const Color(0xFFFF4FD8)));
    });
  }

  void _monitor(Canvas c, SceneFrame f, double t) {
    final stage = f.stage('monitor');
    const screen = Rect.fromLTWH(146, 72, 108, 58);
    if (stage == 0) return;
    Pk.scaled(c, const Offset(200, 136), f.pop('monitor', 1), () {
      c.drawRect(const Rect.fromLTWH(196, 118, 8, 18), Pk.fill(const Color(0xFF1A1726)));
      c.drawOval(Rect.fromCenter(center: const Offset(200, 136), width: 36, height: 5), Pk.fill(const Color(0xFF1A1726)));
    });
    Pk.scaled(c, screen.center, f.pop('monitor', 2), () {
      Pk.box(c, screen.inflate(4), const Color(0xFF1A1726), radius: 5);
      c.drawRect(screen, Pk.fill(const Color(0xFF0B0A12)));
    });
    final on = f.a('monitor', 3);
    if (on > 0) {
      c.save();
      c.clipRect(screen);
      Pk.faded(c, screen, on, () {
        // Original mini "game" on screen: sunset, hills, bouncing hero.
        Pk.gradientRect(c, screen, const Color(0xFF6A5CFF), const Color(0xFFFF8AC8));
        c.drawCircle(screen.center + const Offset(24, -6), 10, Pk.fill(const Color(0xFFFFE066)));
        final hill = Path()
          ..moveTo(screen.left, screen.bottom - 12)
          ..quadraticBezierTo(screen.left + 30, screen.bottom - 30, screen.left + 60, screen.bottom - 14)
          ..quadraticBezierTo(screen.left + 85, screen.bottom - 28, screen.right, screen.bottom - 16)
          ..lineTo(screen.right, screen.bottom)
          ..lineTo(screen.left, screen.bottom)
          ..close();
        c.drawPath(hill, Pk.fill(const Color(0xFF2E1F66)));
        final hx = screen.left + 20 + ((t * 30) % 70);
        final hy = screen.bottom - 20 - (sin(t * 6)).abs() * 10;
        Pk.box(c, Rect.fromLTWH(hx, hy, 7, 8), const Color(0xFF5BFFB0), radius: 2);
      });
      c.restore();
      Pk.glow(c, screen.center, 80, const Color(0xFF9B6BFF), 0.25 * on);
    }
    Pk.scaled(c, const Offset(280, 110), f.pop('monitor', 4), () {
      final side = [const Offset(262, 80), const Offset(300, 88), const Offset(300, 124), const Offset(262, 128)];
      Pk.poly(c, side, Pk.fill(const Color(0xFF1A1726)));
      Pk.poly(c, [
        const Offset(265, 84),
        const Offset(297, 91),
        const Offset(297, 121),
        const Offset(265, 124),
      ], Pk.fill(Pk.mix(const Color(0xFF2E7BFF), const Color(0xFF5BFFB0), 0.5 + 0.5 * sin(t))));
      c.drawRect(const Rect.fromLTWH(279, 124, 5, 12), Pk.fill(const Color(0xFF1A1726)));
    });
  }

  void _pc(Canvas c, SceneFrame f, double t) {
    final stage = f.stage('pc');
    const r = Rect.fromLTWH(312, 104, 44, 84);
    if (stage == 0) return;
    final glow = f.a('pc', 4);
    if (glow > 0) Pk.glow(c, r.center, 70, Pk.hue(t * 60 + 120), 0.35 * glow);
    Pk.scaled(c, r.bottomCenter, f.pop('pc', 1), () {
      Pk.shadow(c, r.bottomCenter, 56, 8);
      Pk.box(c, r, const Color(0xFF2A2540), bottom: const Color(0xFF1A1726), radius: 4, outline: const Color(0xFF0E0C16), ow: 2);
    });
    Pk.scaled(c, r.center, f.pop('pc', 2), () {
      Pk.box(c, r.deflate(5), const Color(0x663B5BFF), radius: 3, outline: const Color(0xFF6A7BFF), ow: 1);
      c.drawLine(
        r.topLeft + const Offset(10, 10),
        r.topLeft + const Offset(22, 30),
        Pk.stroke(Colors.white.withValues(alpha: 0.25), 3),
      );
    });
    final fans = f.pop('pc', 3);
    if (fans > 0) {
      for (var i = 0; i < 3; i++) {
        final cc = Offset(r.center.dx, r.top + 18 + i * 24.0);
        final col = Pk.hue(t * 90 + i * 60);
        c.drawCircle(cc, 9 * fans, Pk.stroke(col, 2.2));
        c.save();
        c.translate(cc.dx, cc.dy);
        c.rotate(t * 8 + i);
        for (var k = 0; k < 4; k++) {
          c.rotate(pi / 2);
          c.drawOval(Rect.fromLTWH(-2, -7 * fans, 4, 7 * fans), Pk.fill(Colors.white.withValues(alpha: 0.5)));
        }
        c.restore();
      }
    }
  }

  void _chair(Canvas c, SceneFrame f, double t) {
    final stage = f.stage('gaming_chair');
    const base = Offset(200, 228);
    if (stage == 0) return;
    Pk.scaled(c, base, f.pop('gaming_chair', 1), () {
      Pk.shadow(c, base, 64, 10);
      final leg = Pk.stroke(const Color(0xFF1A1726), 3.5);
      for (final dx in const [-24.0, -12.0, 12.0, 24.0]) {
        c.drawLine(base - const Offset(0, 8), base + Offset(dx, -1), leg);
        c.drawCircle(base + Offset(dx, 0), 3, Pk.fill(const Color(0xFF0E0C16)));
      }
      c.drawRect(Rect.fromLTWH(base.dx - 3, base.dy - 26, 6, 20), Pk.fill(const Color(0xFF3A3450)));
    });
    Pk.scaled(c, base - const Offset(0, 26), f.pop('gaming_chair', 2), () {
      Pk.box(
        c,
        Rect.fromCenter(center: base - const Offset(0, 30), width: 58, height: 12),
        const Color(0xFF26213A),
        radius: 6,
        outline: const Color(0xFF0E0C16),
      );
    });
    final back = f.pop('gaming_chair', 3);
    Pk.scaled(c, base - const Offset(0, 34), back, () {
      final path = Path()
        ..moveTo(base.dx - 26, base.dy - 34)
        ..lineTo(base.dx - 30, base.dy - 88)
        ..quadraticBezierTo(base.dx, base.dy - 104, base.dx + 30, base.dy - 88)
        ..lineTo(base.dx + 26, base.dy - 34)
        ..close();
      c.drawPath(path, Pk.fill(const Color(0xFF26213A)));
      c.drawPath(path, Pk.stroke(const Color(0xFF0E0C16), 2));
    });
    final stripes = f.pop('gaming_chair', 4);
    if (stripes > 0 && back > 0) {
      final p = Pk.stroke(const Color(0xFFFF4FD8).withValues(alpha: stripes), 4);
      c.drawLine(base + const Offset(-14, -38), base + const Offset(-17, -90), p);
      c.drawLine(base + const Offset(14, -38), base + const Offset(17, -90), p);
      c.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: base - const Offset(0, 84), width: 26 * stripes, height: 9),
          const Radius.circular(5),
        ),
        Pk.fill(const Color(0xFF7A3CFF)),
      );
    }
  }

  void _decorBack(Canvas c, SceneFrame f, double t) {
    // Poster (stage 1): original planet art.
    Pk.scaled(c, const Offset(56, 60), f.pop('gaming_decor', 1), () {
      Pk.box(c, const Rect.fromLTWH(30, 26, 52, 70), const Color(0xFF1B1F5E), radius: 2, outline: const Color(0xFFFFFFFF), ow: 2);
      c.drawCircle(const Offset(56, 56), 14, Pk.fill(const Color(0xFFFF8A4C)));
      c.drawOval(Rect.fromCenter(center: const Offset(56, 56), width: 42, height: 9), Pk.stroke(const Color(0xFFFFE066), 2));
      for (var i = 0; i < 6; i++) {
        c.drawCircle(Offset(34 + Pk.rand(i) * 44, 30 + Pk.rand(i + 4) * 60), 1, Pk.fill(Colors.white));
      }
      c.drawRect(const Rect.fromLTWH(36, 82, 40, 6), Pk.fill(const Color(0xFF5BFFB0)));
    });
    // Shelf with figures (stage 2).
    Pk.scaled(c, const Offset(340, 56), f.pop('gaming_decor', 2), () {
      c.drawRect(const Rect.fromLTWH(300, 56, 84, 5), Pk.fill(const Color(0xFF3A3450)));
      const cols = [Color(0xFFFF4FD8), Color(0xFF5BFFB0), Color(0xFFFFE066), Color(0xFF45A7F5)];
      for (var i = 0; i < 4; i++) {
        final x = 308 + i * 19.0;
        Pk.box(c, Rect.fromLTWH(x, 42, 9, 14), cols[i], radius: 3);
        c.drawCircle(Offset(x + 4.5, 38), 5, Pk.fill(cols[i]));
      }
    });
    // Neon sign (stage 3).
    final neon = f.a('gaming_decor', 3);
    if (neon > 0) {
      final flick = sin(t * 13) > -0.8 ? 1.0 : 0.55;
      final col = const Color(0xFF5BF7FF).withValues(alpha: neon * flick);
      Pk.glow(c, const Offset(130, 45), 40, const Color(0xFF5BF7FF), 0.3 * neon);
      final p = Pk.stroke(col, 3);
      // "GG" drawn with strokes.
      for (final x in const [112.0, 136.0]) {
        c.drawArc(Rect.fromLTWH(x, 32, 20, 26), 0.4, 2 * pi - 1.2, false, p);
        c.drawLine(Offset(x + 20, 47), Offset(x + 12, 47), p);
      }
    }
  }

  void _decorFront(Canvas c, SceneFrame f) {
    // Rug + plant (stage 4).
    final s = f.pop('gaming_decor', 4);
    Pk.scaled(c, const Offset(200, 222), s, () {
      c.drawOval(Rect.fromCenter(center: const Offset(200, 224), width: 180, height: 26), Pk.stroke(const Color(0xFF7A3CFF), 3));
    });
    Pk.scaled(c, const Offset(28, 214), s, () => Pk.plant(c, const Offset(28, 214), 1.5, pot: const Color(0xFF7A3CFF)));
  }
}
