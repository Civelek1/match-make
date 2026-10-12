import 'dart:math';

import 'package:flutter/material.dart';

import '../art/paint_kit.dart';
import 'scene_art.dart';

/// LEVEL 1 — Garden. Objectives: grass, fence, flowers, tree, bench.
class GardenScene extends SceneArt {
  @override
  final Map<String, Offset> anchors = const {
    'grass': Offset(200, 190),
    'fence': Offset(275, 128),
    'flowers': Offset(170, 222),
    'tree': Offset(300, 80),
    'bench': Offset(318, 178),
  };

  static const _dryTop = Color(0xFFD2B77E);
  static const _dryBottom = Color(0xFFB39460);
  static const _lushTop = Color(0xFF8EDB5E);
  static const _lushBottom = Color(0xFF55B23F);

  @override
  void paint(Canvas c, SceneFrame f) {
    final t = f.time;
    final ov = f.overall;
    final grass = f.p('grass');

    // Sky + sun + clouds.
    Pk.gradientRect(
      c,
      const Rect.fromLTWH(0, 0, 400, 150),
      Pk.mix(const Color(0xFFA9C7D3), const Color(0xFF63C3FF), ov),
      Pk.mix(const Color(0xFFEADFC6), const Color(0xFFFFF0C8), ov),
    );
    Pk.glow(c, const Offset(352, 34), 46, const Color(0xFFFFF1A8), 0.4 + 0.4 * ov);
    c.drawCircle(const Offset(352, 34), 17, Pk.fill(Pk.mix(const Color(0xFFF3E4B0), const Color(0xFFFFE066), ov)));
    for (var i = 0; i < 3; i++) {
      final x = (i * 150 + t * (5 + i * 2)) % 520 - 60;
      Pk.cloud(c, Offset(x, 22.0 + i * 16), 0.75 + i * 0.12, Colors.white.withValues(alpha: 0.85));
    }

    // Distant hills.
    final hills = Path()
      ..moveTo(0, 128)
      ..quadraticBezierTo(80, 92, 170, 118)
      ..quadraticBezierTo(270, 88, 400, 116)
      ..lineTo(400, 150)
      ..lineTo(0, 150)
      ..close();
    c.drawPath(hills, Pk.fill(Pk.mix(const Color(0xFFB7B38F), const Color(0xFF9ED67A), grass)));

    _house(c, ov);

    // Lawn.
    Pk.gradientRect(
      c,
      const Rect.fromLTWH(0, 138, 400, 102),
      Pk.mix(_dryTop, _lushTop, grass),
      Pk.mix(_dryBottom, _lushBottom, grass),
    );
    // Dry patches fade away.
    for (var i = 0; i < 7; i++) {
      final a = (1 - grass) * 0.55;
      if (a <= 0.02) break;
      c.drawOval(
        Rect.fromCenter(
          center: Offset(30 + Pk.rand(i) * 340, 160 + Pk.rand(i + 9) * 70),
          width: 30 + Pk.rand(i + 3) * 30,
          height: 8,
        ),
        Pk.fill(const Color(0xFF9C7A45).withValues(alpha: a)),
      );
    }
    // Weeds (neglect) fade.
    final weedA = (1 - ov) * 0.9;
    if (weedA > 0.02) {
      for (var i = 0; i < 9; i++) {
        final base = Offset(20 + Pk.rand(i + 40) * 360, 150 + Pk.rand(i + 50) * 80);
        final p = Pk.stroke(const Color(0xFF7D6B3A).withValues(alpha: weedA), 1.4);
        for (var k = -1; k <= 1; k++) {
          c.drawLine(base, base + Offset(k * 4.0, -7 - Pk.rand(i + k) * 4), p);
        }
      }
    }
    // Grass tufts appear per stage.
    for (var s = 1; s <= 4; s++) {
      final sc = f.pop('grass', s);
      if (sc <= 0) continue;
      for (var i = 0; i < 7; i++) {
        final seed = s * 17 + i;
        final base = Offset(12 + Pk.rand(seed) * 376, 148 + Pk.rand(seed + 5) * 86);
        Pk.scaled(c, base, sc, () => _tuft(c, base, 0.9 + Pk.rand(seed + 2) * 0.5, t, seed));
      }
    }

    // Stepping stones (bench stage 4).
    final stones = f.pop('bench', 4);
    for (var i = 0; i < 4; i++) {
      final p = Offset(72 + i * 22.0, 172 + i * 13.0);
      Pk.scaled(c, p, stones, () {
        c.drawOval(Rect.fromCenter(center: p + const Offset(0, 1.5), width: 17, height: 7), Pk.fill(const Color(0x33000000)));
        c.drawOval(Rect.fromCenter(center: p, width: 17, height: 7), Pk.fill(const Color(0xFFD9D2C3)));
      });
    }

    _trees(c, f);
    _fence(c, f);
    _bench(c, f);
    _flowers(c, f);

    // Butterflies once the garden is lively.
    if (ov > 0.55) {
      final a = ((ov - 0.55) / 0.3).clamp(0.0, 1.0);
      for (var i = 0; i < 2; i++) {
        final p = Offset(180 + 120 * sin(t * 0.4 + i * 2.1), 120 + 30 * sin(t * 0.9 + i));
        _butterfly(c, p, t * 14 + i, i == 0 ? const Color(0xFFFF8FC7) : const Color(0xFF8FD3FF), a);
      }
    }
  }

  void _house(Canvas c, double ov) {
    final wall = Pk.mix(const Color(0xFFD9CDB8), const Color(0xFFFFF1DA), ov);
    // Wall with slight isometric side.
    Pk.poly(c, const [Offset(128, 60), Offset(150, 70), Offset(150, 150), Offset(128, 146)], Pk.fill(Pk.dark(wall, 0.15)));
    Pk.box(c, const Rect.fromLTWH(8, 60, 120, 88), wall, radius: 2);
    // Roof.
    Pk.poly(c, const [
      Offset(-6, 64),
      Offset(64, 14),
      Offset(142, 64),
    ], Pk.fill(Pk.mix(const Color(0xFF9A6A5E), const Color(0xFFD9573F), ov)));
    Pk.poly(c, const [
      Offset(64, 14),
      Offset(142, 64),
      Offset(160, 72),
      Offset(84, 20),
    ], Pk.fill(Pk.mix(const Color(0xFF7D554B), const Color(0xFFB24330), ov)));
    c.drawLine(const Offset(-6, 64), const Offset(142, 64), Pk.stroke(const Color(0x33000000), 3));
    // Door.
    Pk.box(c, const Rect.fromLTWH(56, 104, 26, 44), Pk.mix(const Color(0xFF8C7563), const Color(0xFF3FA3E0), ov), radius: 5);
    c.drawCircle(const Offset(77, 128), 1.8, Pk.fill(const Color(0xFFFFD447)));
    // Windows (light up as garden comes alive).
    for (final x in const [22.0, 94.0]) {
      final r = Rect.fromLTWH(x, 78, 22, 22);
      Pk.box(c, r.inflate(2.5), Colors.white, radius: 3);
      Pk.box(c, r, Pk.mix(const Color(0xFF7F8A91), const Color(0xFFFFE9A6), ov), radius: 2);
      c.drawLine(r.topCenter, r.bottomCenter, Pk.stroke(Colors.white, 1.5));
      c.drawLine(r.centerLeft, r.centerRight, Pk.stroke(Colors.white, 1.5));
    }
    // Cracks fade out.
    final cr = (1 - ov) * 0.6;
    if (cr > 0.02) {
      final p = Pk.stroke(Colors.black.withValues(alpha: cr * 0.5), 1);
      c.drawPath(
        Path()
          ..moveTo(30, 110)
          ..lineTo(36, 118)
          ..lineTo(33, 126)
          ..lineTo(40, 134),
        p,
      );
      c.drawPath(
        Path()
          ..moveTo(110, 66)
          ..lineTo(106, 74)
          ..lineTo(112, 80),
        p,
      );
    }
  }

  void _tuft(Canvas c, Offset base, double s, double t, int seed) {
    final sway = sin(t * 2 + seed) * 1.2;
    final p1 = Pk.stroke(const Color(0xFF3E9A3A), 1.8 * s);
    final p2 = Pk.stroke(const Color(0xFF6BCF4E), 1.6 * s);
    c.drawLine(base, base + Offset(-3 * s + sway, -7 * s), p1);
    c.drawLine(base, base + Offset(sway, -9 * s), p2);
    c.drawLine(base, base + Offset(3 * s + sway, -6.5 * s), p1);
  }

  void _trees(Canvas c, SceneFrame f) {
    final stage = f.stage('tree');
    const a = Offset(236, 138), b = Offset(362, 136);
    // Stumps before restoration.
    for (final (i, base) in [(0, a), (1, b)]) {
      final needed = i == 0 ? 1 : 3;
      if (stage < needed) {
        Pk.shadow(c, base + const Offset(0, 1), 22, 6);
        Pk.box(c, Rect.fromCenter(center: base - const Offset(0, 4), width: 14, height: 9), const Color(0xFF8B6A48), radius: 2);
        c.drawOval(Rect.fromCenter(center: base - const Offset(0, 8.5), width: 14, height: 4), Pk.fill(const Color(0xFFC9A67A)));
      }
    }
    // Tree A: sapling (s1) then full crown (s2).
    final s1 = f.pop('tree', 1);
    final s2 = f.pop('tree', 2);
    if (s1 > 0) {
      final grow = 0.45 + 0.55 * s2;
      Pk.scaled(c, a, s1, () => _tree(c, a, grow, f.pop('tree', 4), f.time, const Color(0xFF4FB548)));
    }
    final s3 = f.pop('tree', 3);
    if (s3 > 0) {
      Pk.scaled(c, b, s3, () => _tree(c, b, 0.9, f.pop('tree', 4), f.time + 1, const Color(0xFF3FA84A), blossom: true));
    }
  }

  void _tree(Canvas c, Offset base, double grow, double fruit, double t, Color leaf, {bool blossom = false}) {
    final h = 62 * grow;
    Pk.shadow(c, base + const Offset(0, 1), 50 * grow, 10 * grow);
    Pk.box(c, Rect.fromLTWH(base.dx - 4.5 * grow, base.dy - h * 0.55, 9 * grow, h * 0.55), const Color(0xFF8B5E3C), radius: 2);
    final sway = sin(t * 0.8) * 1.5;
    final center = base + Offset(sway, -h * 0.72);
    final r = 26 * grow;
    final dark = Pk.dark(leaf, 0.18);
    c.drawCircle(center + Offset(-r * 0.55, r * 0.2), r * 0.7, Pk.fill(dark));
    c.drawCircle(center + Offset(r * 0.55, r * 0.25), r * 0.68, Pk.fill(dark));
    c.drawCircle(center, r * 0.85, Pk.fill(leaf));
    c.drawCircle(center + Offset(-r * 0.25, -r * 0.35), r * 0.45, Pk.fill(Pk.light(leaf, 0.2)));
    if (fruit > 0) {
      final col = blossom ? const Color(0xFFFFB3D1) : const Color(0xFFFF5A5A);
      for (var i = 0; i < 7; i++) {
        final p = center + Offset((Pk.rand(i + 3) - 0.5) * r * 1.6, (Pk.rand(i + 11) - 0.4) * r * 1.2);
        Pk.scaled(c, p, fruit, () => c.drawCircle(p, blossom ? 2.6 : 2.4, Pk.fill(col)));
      }
    }
  }

  void _fence(Canvas c, SceneFrame f) {
    final stage = f.stage('fence');
    const y = 150.0;
    const x0 = 158.0, w = 60.0;
    for (var i = 0; i < 4; i++) {
      final left = x0 + i * w;
      if (stage > i) {
        final s = f.pop('fence', i + 1);
        Pk.scaled(c, Offset(left + w / 2, y), 1, () => _fenceSection(c, left, y, w), s);
      } else {
        // Broken pickets lying around.
        final p = Pk.fill(const Color(0xFFA89C8A));
        c.save();
        c.translate(left + 18, y - 4);
        c.rotate(-0.5);
        c.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(0, -14, 6, 18), const Radius.circular(1.5)), p);
        c.restore();
        c.save();
        c.translate(left + 36, y - 2);
        c.rotate(1.3);
        c.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(0, -10, 5, 16), const Radius.circular(1.5)), p);
        c.restore();
        Pk.box(c, Rect.fromLTWH(left + 46, y - 16, 6, 16), const Color(0xFF9C917F), radius: 1);
      }
    }
  }

  void _fenceSection(Canvas c, double left, double y, double w) {
    const wood = Color(0xFFFFFFFF);
    const shade = Color(0xFFD9D0E6);
    c.drawRect(Rect.fromLTWH(left, y - 20, w, 4), Pk.fill(shade));
    c.drawRect(Rect.fromLTWH(left, y - 10, w, 4), Pk.fill(shade));
    for (var k = 0; k < 5; k++) {
      final x = left + 3 + k * (w - 6) / 5;
      final path = Path()
        ..moveTo(x, y)
        ..lineTo(x, y - 26)
        ..lineTo(x + 4, y - 30)
        ..lineTo(x + 8, y - 26)
        ..lineTo(x + 8, y)
        ..close();
      c.drawPath(path, Pk.fill(wood));
      c.drawPath(path, Pk.stroke(const Color(0xFFB9AFC9), 1));
    }
  }

  void _bench(Canvas c, SceneFrame f) {
    final stage = f.stage('bench');
    const base = Offset(318, 192);
    if (stage == 0) {
      // Old broken bench.
      Pk.shadow(c, base, 60, 8);
      c.save();
      c.translate(base.dx, base.dy - 12);
      c.rotate(0.18);
      c.drawRRect(
        RRect.fromRectAndRadius(const Rect.fromLTWH(-28, -3, 56, 6), const Radius.circular(2)),
        Pk.fill(const Color(0xFF8E857A)),
      );
      c.restore();
      Pk.box(c, Rect.fromLTWH(base.dx - 24, base.dy - 12, 4, 12), const Color(0xFF6F665C));
    }
    final frame = f.pop('bench', 1);
    Pk.scaled(c, base, frame, () {
      Pk.shadow(c, base, 70, 9);
      final leg = Pk.fill(const Color(0xFF4A3A33));
      c.drawRect(Rect.fromLTWH(base.dx - 28, base.dy - 14, 4, 14), leg);
      c.drawRect(Rect.fromLTWH(base.dx + 24, base.dy - 14, 4, 14), leg);
      c.drawRect(Rect.fromLTWH(base.dx - 30, base.dy - 24, 3, 12), leg);
      c.drawRect(Rect.fromLTWH(base.dx + 27, base.dy - 24, 3, 12), leg);
    });
    final seat = f.pop('bench', 2);
    Pk.scaled(c, base, seat, () {
      final wood = Pk.fill(const Color(0xFFE08A45));
      final woodDark = Pk.fill(const Color(0xFFB9642C));
      c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(base.dx - 32, base.dy - 16, 64, 5), const Radius.circular(2)), wood);
      c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(base.dx - 32, base.dy - 12, 64, 2), const Radius.circular(1)), woodDark);
      c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(base.dx - 31, base.dy - 30, 62, 5), const Radius.circular(2)), wood);
      c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(base.dx - 31, base.dy - 23, 62, 4), const Radius.circular(2)), wood);
    });
    // Lamp post (stage 3).
    final lamp = f.pop('bench', 3);
    const lb = Offset(372, 198);
    Pk.scaled(c, lb, lamp, () {
      Pk.shadow(c, lb, 18, 5);
      c.drawRect(Rect.fromLTWH(lb.dx - 2, lb.dy - 56, 4, 56), Pk.fill(const Color(0xFF3B3452)));
      Pk.glow(c, lb - const Offset(0, 60), 22, const Color(0xFFFFE9A0), 0.7);
      Pk.box(
        c,
        Rect.fromCenter(center: lb - const Offset(0, 60), width: 12, height: 14),
        const Color(0xFFFFF4C2),
        radius: 3,
        outline: const Color(0xFF3B3452),
        ow: 2,
      );
    });
  }

  void _flowers(Canvas c, SceneFrame f) {
    final stage = f.stage('flowers');
    const beds = [Offset(38, 222), Offset(122, 228), Offset(212, 226), Offset(292, 228)];
    const colors = [Color(0xFFFF6B8B), Color(0xFFFFC93C), Color(0xFFB57BFF), Color(0xFFFF8A3C), Color(0xFFFFFFFF)];
    for (var i = 0; i < beds.length; i++) {
      final bed = beds[i];
      c.drawOval(Rect.fromCenter(center: bed + const Offset(0, 2), width: 62, height: 16), Pk.fill(const Color(0xFF6E4B2E)));
      c.drawOval(Rect.fromCenter(center: bed, width: 58, height: 12), Pk.fill(const Color(0xFF8A5E3A)));
      if (stage > i) {
        final s = f.pop('flowers', i + 1);
        for (var k = 0; k < 6; k++) {
          final p = bed + Offset(-22 + k * 8.8, -6 - (k.isEven ? 3 : 0));
          final local = ((s - k * 0.06) / 0.7).clamp(0.0, 1.0);
          Pk.scaled(c, p + const Offset(0, 8), Pk.pop(local), () {
            Pk.flower(c, p, 1.1, colors[(i + k) % colors.length]);
          });
        }
      }
    }
  }

  void _butterfly(Canvas c, Offset p, double phase, Color color, double a) {
    final flap = 0.4 + 0.6 * sin(phase).abs();
    final paint = Pk.fill(color.withValues(alpha: a));
    c.drawOval(Rect.fromCenter(center: p + Offset(-3 * flap, -1), width: 6 * flap, height: 7), paint);
    c.drawOval(Rect.fromCenter(center: p + Offset(3 * flap, -1), width: 6 * flap, height: 7), paint);
    c.drawLine(p + const Offset(0, -3), p + const Offset(0, 3), Pk.stroke(Colors.black.withValues(alpha: 0.6 * a), 1.2));
  }
}
