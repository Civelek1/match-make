import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'tile_art.dart' show paintSparkle;

/// Small drawing toolkit shared by all procedural scenes.
class Pk {
  static Paint fill(Color c) => Paint()..color = c;

  static Paint stroke(Color c, double w) => Paint()
    ..color = c
    ..style = PaintingStyle.stroke
    ..strokeWidth = w
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  static Color mix(Color a, Color b, double t) => Color.lerp(a, b, t.clamp(0.0, 1.0))!;
  static Color dark(Color c, [double t = 0.25]) => Color.lerp(c, Colors.black, t)!;
  static Color light(Color c, [double t = 0.25]) => Color.lerp(c, Colors.white, t)!;
  static Color alpha(Color c, double a) => c.withValues(alpha: (c.a * a).clamp(0.0, 1.0));

  /// Vertical-gradient rounded rect with optional outline.
  static void box(Canvas c, Rect r, Color top, {Color? bottom, double radius = 3, Color? outline, double ow = 1.5}) {
    final rr = RRect.fromRectAndRadius(r, Radius.circular(radius));
    c.drawRRect(rr, Paint()..shader = ui.Gradient.linear(r.topCenter, r.bottomCenter, [top, bottom ?? dark(top, 0.15)]));
    if (outline != null) c.drawRRect(rr, stroke(outline, ow));
  }

  static void gradientRect(Canvas c, Rect r, Color top, Color bottom) {
    c.drawRect(r, Paint()..shader = ui.Gradient.linear(r.topCenter, r.bottomCenter, [top, bottom]));
  }

  static void poly(Canvas c, List<Offset> pts, Paint p) {
    final path = Path()..addPolygon(pts, true);
    c.drawPath(path, p);
  }

  /// Soft ground shadow.
  static void shadow(Canvas c, Offset center, double w, double h, [double a = 0.22]) {
    c.drawOval(
      Rect.fromCenter(center: center, width: w, height: h),
      Paint()
        ..color = Colors.black.withValues(alpha: a)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );
  }

  static void glow(Canvas c, Offset center, double radius, Color color, [double a = 0.5]) {
    c.drawCircle(center, radius, Paint()..shader = ui.Gradient.radial(center, radius, [alpha(color, a), alpha(color, 0)]));
  }

  /// Overshooting pop-in curve: 0 → ~1.12 → 1.
  static double pop(double t) {
    if (t <= 0) return 0;
    if (t >= 1) return 1;
    return Curves.easeOutBack.transform(t);
  }

  /// Run [draw] scaled around [pivot]. Skips entirely when invisible.
  static void scaled(Canvas c, Offset pivot, double sx, void Function() draw, [double? sy]) {
    final y = sy ?? sx;
    if (sx <= 0.001 || y <= 0.001) return;
    if (sx == 1 && y == 1) {
      draw();
      return;
    }
    c.save();
    c.translate(pivot.dx, pivot.dy);
    c.scale(sx, y);
    c.translate(-pivot.dx, -pivot.dy);
    draw();
    c.restore();
  }

  /// Fade [draw] with a layer (use sparingly).
  static void faded(Canvas c, Rect bounds, double opacity, void Function() draw) {
    if (opacity <= 0.01) return;
    if (opacity >= 0.99) {
      draw();
      return;
    }
    c.saveLayer(bounds, Paint()..color = Colors.white.withValues(alpha: opacity));
    draw();
    c.restore();
  }

  static void sparkle(Canvas c, Offset p, double s, Color color) => paintSparkle(c, p, s, fill(color));

  /// Deterministic pseudo-random in [0,1) for stable decoration placement.
  static double rand(int seed) {
    final x = sin(seed * 12.9898 + 78.233) * 43758.5453;
    return x - x.floorToDouble();
  }

  static Color hue(double degrees, [double s = 0.85, double v = 1]) => HSVColor.fromAHSV(1, degrees % 360, s, v).toColor();

  static void cloud(Canvas c, Offset o, double s, Color color) {
    final p = fill(color);
    c.drawCircle(o, 12 * s, p);
    c.drawCircle(o + Offset(13 * s, -5 * s), 15 * s, p);
    c.drawCircle(o + Offset(28 * s, 0), 11 * s, p);
    c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(o.dx - 6 * s, o.dy - 2 * s, 42 * s, 14 * s), Radius.circular(7 * s)), p);
  }

  /// Cartoon flower.
  static void flower(Canvas c, Offset o, double s, Color petal, [Color center = const Color(0xFFFFD447)]) {
    c.drawLine(o, o + Offset(0, 9 * s), stroke(const Color(0xFF3E9A3A), 1.6 * s));
    final p = fill(petal);
    for (var i = 0; i < 5; i++) {
      final a = i * 2 * pi / 5 - pi / 2;
      c.drawCircle(o + Offset(cos(a), sin(a)) * 3.2 * s, 2.6 * s, p);
    }
    c.drawCircle(o, 2 * s, fill(center));
  }

  /// Leafy potted plant.
  static void plant(Canvas c, Offset base, double s, {Color pot = const Color(0xFFE07A4F)}) {
    final leaf = fill(const Color(0xFF4DB848));
    final leafDark = fill(const Color(0xFF3A9A38));
    for (var i = -2; i <= 2; i++) {
      c.save();
      c.translate(base.dx, base.dy - 10 * s);
      c.rotate(i * 0.42);
      c.drawOval(Rect.fromCenter(center: Offset(0, -9 * s), width: 7 * s, height: 18 * s), i.isEven ? leaf : leafDark);
      c.restore();
    }
    final potPath = Path()
      ..moveTo(base.dx - 8 * s, base.dy - 11 * s)
      ..lineTo(base.dx + 8 * s, base.dy - 11 * s)
      ..lineTo(base.dx + 6 * s, base.dy)
      ..lineTo(base.dx - 6 * s, base.dy)
      ..close();
    c.drawPath(potPath, fill(pot));
    c.drawRect(Rect.fromLTWH(base.dx - 9 * s, base.dy - 13 * s, 18 * s, 3.5 * s), fill(dark(pot, 0.1)));
  }

  /// Rounded clump of foliage filling [r].
  static void bushy(Canvas c, Rect r, Color col) {
    final rad = r.height * 0.35;
    c.drawCircle(Offset(r.left + r.width * 0.28, r.bottom - rad), rad, fill(dark(col, 0.12)));
    c.drawCircle(Offset(r.right - r.width * 0.28, r.bottom - rad), rad, fill(dark(col, 0.12)));
    c.drawCircle(Offset(r.center.dx, r.bottom - rad * 1.4), rad * 1.1, fill(col));
    c.drawCircle(Offset(r.center.dx - rad * 0.3, r.bottom - rad * 1.8), rad * 0.35, fill(light(col, 0.2)));
  }

  static void cobweb(Canvas c, Offset corner, double s, double a, {bool flipX = false}) {
    if (a <= 0.01) return;
    final p = stroke(Colors.white.withValues(alpha: 0.55 * a), 0.8);
    final dir = flipX ? -1.0 : 1.0;
    for (var i = 0; i <= 4; i++) {
      final ang = i * pi / 8;
      c.drawLine(corner, corner + Offset(cos(ang) * dir, sin(ang)) * 30 * s, p);
    }
    for (var r = 1; r <= 3; r++) {
      final path = Path();
      for (var i = 0; i <= 4; i++) {
        final ang = i * pi / 8;
        final pt = corner + Offset(cos(ang) * dir, sin(ang)) * (r * 9.0 * s);
        if (i == 0) {
          path.moveTo(pt.dx, pt.dy);
        } else {
          path.lineTo(pt.dx, pt.dy);
        }
      }
      c.drawPath(path, p);
    }
  }
}
