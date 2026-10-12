import 'dart:math';

import 'package:flutter/material.dart';

import '../art/paint_kit.dart';

/// Shared interior-room building blocks (walls, perspective floors, grime).
class RoomKit {
  static void backWall(Canvas c, double floorY, Color top, Color bottom) {
    Pk.gradientRect(c, Rect.fromLTWH(0, 0, 400, floorY), top, bottom);
    // Soft ceiling shadow for depth.
    Pk.gradientRect(c, const Rect.fromLTWH(0, 0, 400, 14), Colors.black.withValues(alpha: 0.16), Colors.transparent);
  }

  /// Checker floor in simple one-point perspective.
  static void checkerFloor(Canvas c, double floorY, Color a, Color b, {int cols = 10}) {
    const vanish = Offset(200, -260);
    final rows = <double>[floorY];
    var y = floorY;
    var step = 9.0;
    while (y < 240) {
      y += step;
      rows.add(min(y, 240));
      step *= 1.35;
    }
    xAt(double baseX, double yy) => vanish.dx + (baseX - vanish.dx) * (yy - vanish.dy) / (240 - vanish.dy);
    for (var r = 0; r < rows.length - 1; r++) {
      for (var k = -6; k < cols + 6; k++) {
        final x0 = -200 + k * 800 / (cols + 2), x1 = -200 + (k + 1) * 800 / (cols + 2);
        final pts = [
          Offset(xAt(x0, rows[r]), rows[r]),
          Offset(xAt(x1, rows[r]), rows[r]),
          Offset(xAt(x1, rows[r + 1]), rows[r + 1]),
          Offset(xAt(x0, rows[r + 1]), rows[r + 1]),
        ];
        Pk.poly(c, pts, Pk.fill((r + k).isEven ? a : b));
      }
    }
    c.drawLine(Offset(0, floorY), Offset(400, floorY), Pk.stroke(Colors.black.withValues(alpha: 0.18), 2));
  }

  /// Plank floor sections (used by attic).
  static void planks(Canvas c, Rect r, Color wood, {double plank = 8}) {
    Pk.gradientRect(c, r, Pk.light(wood, 0.08), Pk.dark(wood, 0.12));
    for (var y = r.top + plank; y < r.bottom; y += plank) {
      c.drawLine(Offset(r.left, y), Offset(r.right, y), Pk.stroke(Pk.dark(wood, 0.3), 0.8));
    }
    var i = 0;
    for (var y = r.top; y < r.bottom; y += plank) {
      final off = (i++ % 3) * 17.0;
      for (var x = r.left + off; x < r.right; x += 52) {
        c.drawLine(Offset(x, y), Offset(x, min(y + plank, r.bottom)), Pk.stroke(Pk.dark(wood, 0.25), 0.8));
      }
    }
  }

  static void stains(Canvas c, double a, int seed) {
    if (a <= 0.02) return;
    for (var i = 0; i < 5; i++) {
      final p = Offset(20 + Pk.rand(seed * 10 + i) * 360, 20 + Pk.rand(seed * 10 + i + 5) * 130);
      c.drawOval(
        Rect.fromCenter(center: p, width: 18 + Pk.rand(i + seed) * 26, height: 10 + Pk.rand(i + seed + 2) * 14),
        Pk.fill(const Color(0xFF5A4E3A).withValues(alpha: 0.16 * a)),
      );
    }
  }

  /// Floating dust motes + cobwebs that fade as the room is restored.
  static void dustOverlay(Canvas c, double a, double t) {
    if (a <= 0.02) return;
    Pk.cobweb(c, const Offset(0, 0), 1.1, a);
    Pk.cobweb(c, const Offset(400, 0), 0.9, a, flipX: true);
    for (var i = 0; i < 14; i++) {
      final x = (Pk.rand(i) * 400 + t * (4 + Pk.rand(i + 3) * 6)) % 400;
      final y = 20 + Pk.rand(i + 7) * 200 + sin(t + i) * 6;
      c.drawCircle(Offset(x, y), 1 + Pk.rand(i + 1), Pk.fill(Colors.white.withValues(alpha: 0.35 * a)));
    }
  }
}
