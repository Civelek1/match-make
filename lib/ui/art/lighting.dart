import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Shared lighting for the procedural scenes: one key light from the upper
/// left, soft contact shadows, ambient occlusion where surfaces meet, and a
/// final grade. Everything here is gradient-based (no blurs), so it is cheap
/// enough to run every frame. All coordinates are in the 400×240 scene space.
class Lighting {
  static const _black = Color(0xFF1B1030);
  static const _warm = Color(0xFFFFE2A8);

  static Color _a(Color c, double a) => c.withValues(alpha: a.clamp(0.0, 1.0));

  /// Soft oval shadow where an object meets the floor.
  static void contactShadow(Canvas c, Rect r, {double strength = 1}) {
    final center = Offset(r.center.dx + r.width * 0.04, r.bottom - 1);
    final w = r.width * 1.08, h = (r.height * 0.14).clamp(5.0, 16.0);
    c.save();
    c.translate(center.dx, center.dy);
    c.scale(1, h / w);
    c.drawCircle(
      Offset.zero,
      w / 2,
      Paint()
        ..shader = ui.Gradient.radial(
          Offset.zero,
          w / 2,
          [_a(_black, 0.34 * strength), _a(_black, 0.14 * strength), _a(_black, 0)],
          [0, 0.55, 1],
        ),
    );
    c.restore();
  }

  /// Gives a just-drawn object volume: a highlight on its lit top/left and
  /// shade toward its bottom/right. Uses [BlendMode.srcATop], so it only
  /// touches pixels already on the current layer.
  static void volume(Canvas c, Rect r, {bool wall = false}) {
    final k = wall ? 0.55 : 1.0;
    final area = r.inflate(2);
    c.drawRect(
      area,
      Paint()
        ..blendMode = BlendMode.srcATop
        ..shader = ui.Gradient.linear(
          r.topCenter,
          r.bottomCenter,
          [_a(Colors.white, 0.30 * k), _a(Colors.white, 0), _a(_black, 0), _a(_black, 0.32 * k)],
          const [0, 0.28, 0.55, 1],
        ),
    );
    c.drawRect(
      area,
      Paint()
        ..blendMode = BlendMode.srcATop
        ..shader = ui.Gradient.linear(
          r.centerLeft,
          r.centerRight,
          [_a(Colors.white, 0.14 * k), _a(Colors.white, 0), _a(_black, 0.18 * k)],
          const [0, 0.45, 1],
        ),
    );
  }

  /// Interior depth: occlusion along the wall/floor seam and in the corners,
  /// a skirting board, a sheen on the floor and a darker foreground.
  static void room(Canvas c, double horizon, Color wall, double ov) {
    // Skirting board.
    final skirt = Rect.fromLTWH(0, horizon - 7, 400, 7);
    c.drawRect(
      skirt,
      Paint()
        ..shader = ui.Gradient.linear(skirt.topCenter, skirt.bottomCenter, [
          Color.lerp(wall, Colors.white, 0.35)!,
          Color.lerp(wall, _black, 0.18)!,
        ]),
    );
    // Occlusion where the wall meets the floor.
    _band(c, Rect.fromLTWH(0, horizon - 34, 400, 27), _a(_black, 0), _a(_black, 0.16));
    _band(c, Rect.fromLTWH(0, horizon, 400, 22), _a(_black, 0.26), _a(_black, 0));
    // Corners.
    _hband(c, const Rect.fromLTWH(0, 0, 46, 240), _a(_black, 0.22), _a(_black, 0));
    _hband(c, const Rect.fromLTWH(354, 0, 46, 240), _a(_black, 0), _a(_black, 0.22));
    // Ceiling.
    _band(c, const Rect.fromLTWH(0, 0, 400, 30), _a(_black, 0.18), _a(_black, 0));
    // Floor sheen under the light and a darker foreground.
    final sheen = Rect.fromLTWH(60, horizon + 6, 280, (240 - horizon) * 0.7);
    c.save();
    c.translate(sheen.center.dx, sheen.center.dy);
    c.scale(1, sheen.height / sheen.width);
    c.drawCircle(
      Offset.zero,
      sheen.width / 2,
      Paint()
        ..blendMode = BlendMode.screen
        ..shader = ui.Gradient.radial(Offset.zero, sheen.width / 2, [_a(Colors.white, 0.10 + 0.10 * ov), _a(Colors.white, 0)]),
    );
    c.restore();
    _band(c, const Rect.fromLTWH(0, 196, 400, 44), _a(_black, 0), _a(_black, 0.20));
  }

  /// Exterior depth: haze on the horizon, a darker foreground.
  static void outdoor(Canvas c, double horizon, double ov) {
    _band(c, Rect.fromLTWH(0, horizon - 34, 400, 34), _a(Colors.white, 0), _a(Colors.white, 0.22 + 0.08 * ov));
    _band(c, Rect.fromLTWH(0, horizon, 400, 18), _a(Colors.white, 0.18), _a(Colors.white, 0));
    _band(c, const Rect.fromLTWH(0, 190, 400, 50), _a(_black, 0), _a(_black, 0.18));
  }

  /// Final grade over a whole scene: warm key light that grows as the place
  /// is restored, and a soft vignette.
  static void grade(Canvas c, double ov) {
    const key = Offset(110, -30);
    c.drawRect(
      const Rect.fromLTWH(0, 0, 400, 240),
      Paint()
        ..blendMode = BlendMode.screen
        ..shader = ui.Gradient.radial(
          key,
          330,
          [_a(_warm, 0.10 + 0.16 * ov), _a(_warm, 0.04 + 0.05 * ov), _a(_warm, 0)],
          const [0, 0.5, 1],
        ),
    );
    c.save();
    c.translate(200, 120);
    c.scale(1, 0.62);
    c.drawCircle(
      Offset.zero,
      250,
      Paint()..shader = ui.Gradient.radial(Offset.zero, 250, [_a(_black, 0), _a(_black, 0), _a(_black, 0.30)], const [0, 0.62, 1]),
    );
    c.restore();
  }

  /// The same grade for any canvas area (chapter maps use screen space).
  static void gradeRect(Canvas c, Rect area, double ov) {
    final key = area.topLeft + Offset(area.width * 0.28, -area.height * 0.06);
    final reach = area.longestSide * 0.9;
    c.drawRect(
      area,
      Paint()
        ..blendMode = BlendMode.screen
        ..shader = ui.Gradient.radial(key, reach, [_a(_warm, 0.08 + 0.12 * ov), _a(_warm, 0)]),
    );
    c.save();
    c.translate(area.center.dx, area.center.dy);
    c.scale(area.width / area.height, 1);
    final rad = area.height * 0.62;
    c.drawCircle(
      Offset.zero,
      rad,
      Paint()..shader = ui.Gradient.radial(Offset.zero, rad, [_a(_black, 0), _a(_black, 0), _a(_black, 0.26)], const [0, 0.6, 1]),
    );
    c.restore();
  }

  static void _band(Canvas c, Rect r, Color top, Color bottom) {
    c.drawRect(r, Paint()..shader = ui.Gradient.linear(r.topCenter, r.bottomCenter, [top, bottom]));
  }

  static void _hband(Canvas c, Rect r, Color left, Color right) {
    c.drawRect(r, Paint()..shader = ui.Gradient.linear(r.centerLeft, r.centerRight, [left, right]));
  }
}
