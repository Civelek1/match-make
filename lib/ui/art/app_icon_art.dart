import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../theme/game_colors.dart';
import 'paint_kit.dart';
import 'tile_art.dart';

/// The app icon: the logo's red "M" piece above the wooden MAKE plank, on a
/// sky backdrop. Drawn in a 1024×1024 space. Used to generate the launcher,
/// store and web icons (see tool/icons/) and in the About panel.
///
/// [background] / [foreground] let the adaptive Android icon take the two
/// layers separately; [inset] shrinks the artwork into the adaptive safe zone.
class AppIconPainter extends CustomPainter {
  final bool background;
  final bool foreground;
  final double inset;
  final String fontFamily;

  const AppIconPainter({
    this.background = true,
    this.foreground = true,
    this.inset = 0,
    this.fontFamily = 'Roboto',
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 1024, size.height / 1024);
    if (background) _background(canvas);
    if (foreground) {
      canvas.save();
      final k = 1 - inset;
      canvas.translate(512 * (1 - k), 512 * (1 - k));
      canvas.scale(k);
      _foreground(canvas);
      canvas.restore();
    }
    canvas.restore();
  }

  void _background(Canvas c) {
    const full = Rect.fromLTWH(0, 0, 1024, 1024);
    c.drawRect(
      full,
      Paint()
        ..shader = ui.Gradient.linear(
          full.topCenter,
          full.bottomCenter,
          const [Color(0xFF6FCBFF), Color(0xFF3E95F0), Color(0xFF2A6FD6)],
          const [0, 0.55, 1],
        ),
    );
    // Warm sun glow from the top left, like the in-game key light.
    c.drawRect(
      full,
      Paint()
        ..blendMode = BlendMode.screen
        ..shader = ui.Gradient.radial(const Offset(260, 170), 620, [
          const Color(0xFFFFE6A8).withValues(alpha: 0.75),
          const Color(0xFFFFE6A8).withValues(alpha: 0),
        ]),
    );
    // Soft clouds.
    for (final (o, r) in [
      (const Offset(150, 790), 150.0),
      (const Offset(330, 860), 170.0),
      (const Offset(880, 820), 190.0),
      (const Offset(700, 900), 150.0),
    ]) {
      c.drawCircle(o, r, Paint()..color = Colors.white.withValues(alpha: 0.22));
    }
    // Sparkles.
    for (final (o, r) in [
      (const Offset(812, 214), 46.0),
      (const Offset(196, 300), 26.0),
      (const Offset(870, 420), 20.0),
    ]) {
      _sparkle(c, o, r, Colors.white.withValues(alpha: 0.9));
    }
  }

  void _foreground(Canvas c) {
    // The M piece.
    const gem = Rect.fromLTWH(262, 150, 500, 500);
    final shape = slotPath(0, gem);
    final color = slotColors[0];
    c.save();
    c.translate(gem.center.dx, gem.center.dy);
    c.rotate(-0.08);
    c.translate(-gem.center.dx, -gem.center.dy);
    c.drawPath(
      shape.shift(const Offset(0, 40)),
      Paint()..color = GameColors.ink.withValues(alpha: 0.9),
    );
    c.drawPath(
      shape,
      Paint()
        ..shader = ui.Gradient.linear(
          gem.topCenter,
          gem.bottomCenter,
          [Pk.light(color, 0.35), color, Pk.dark(color, 0.12)],
          const [0, 0.55, 1],
        ),
    );
    c.save();
    c.clipPath(shape);
    // Inner shade toward the bottom and a glossy cap.
    c.drawCircle(
      gem.center + const Offset(40, 120),
      300,
      Paint()
        ..shader = ui.Gradient.radial(gem.center + const Offset(40, 160), 300, [
          Pk.dark(color, 0.25).withValues(alpha: 0),
          Pk.dark(color, 0.3).withValues(alpha: 0.55),
        ]),
    );
    c.drawOval(
      Rect.fromLTWH(
        gem.left + 90,
        gem.top + 34,
        gem.width - 180,
        gem.height * 0.34,
      ),
      Paint()
        ..shader = ui.Gradient.linear(
          Offset(0, gem.top + 34),
          Offset(0, gem.top + 34 + gem.height * 0.34),
          [
            Colors.white.withValues(alpha: 0.65),
            Colors.white.withValues(alpha: 0.05),
          ],
        ),
    );
    c.restore();
    c.drawPath(shape, Pk.stroke(GameColors.ink, 30));
    _text(
      c,
      'M',
      gem.center + const Offset(0, 14),
      300,
      Colors.white,
      GameColors.ink,
      34,
    );
    c.restore();

    // The MAKE plank.
    const plank = Rect.fromLTWH(186, 640, 652, 220);
    c.save();
    c.translate(plank.center.dx, plank.center.dy);
    c.rotate(-0.035);
    final pr = Rect.fromCenter(
      center: Offset.zero,
      width: plank.width,
      height: plank.height,
    );
    final rr = RRect.fromRectAndRadius(pr, const Radius.circular(54));
    c.drawRRect(
      rr.shift(const Offset(0, 30)),
      Paint()..color = GameColors.ink.withValues(alpha: 0.9),
    );
    c.drawRRect(
      rr,
      Paint()
        ..shader = ui.Gradient.linear(
          pr.topCenter,
          pr.bottomCenter,
          const [Color(0xFFF7C17E), Color(0xFFE29A52), Color(0xFFC07834)],
          const [0, 0.5, 1],
        ),
    );
    for (final y in [-0.2, 0.2]) {
      c.drawLine(
        Offset(pr.left + 40, pr.height * y),
        Offset(pr.right - 40, pr.height * y),
        Pk.stroke(const Color(0xFFA8642C).withValues(alpha: 0.45), 7),
      );
    }
    c.drawRRect(rr, Pk.stroke(GameColors.ink, 28));
    for (final x in [pr.left + 64, pr.right - 64]) {
      c.drawCircle(Offset(x, 0), 18, Paint()..color = const Color(0xFF8A839B));
      c.drawCircle(
        Offset(x - 5, -5),
        7,
        Paint()..color = Colors.white.withValues(alpha: 0.8),
      );
    }
    _text(
      c,
      'MAKE',
      const Offset(0, 6),
      150,
      GameColors.gold,
      GameColors.ink,
      30,
    );
    c.restore();
  }

  void _sparkle(Canvas c, Offset o, double r, Color color) {
    final p = Path();
    for (var i = 0; i < 8; i++) {
      final a = i * pi / 4 - pi / 2;
      final rad = i.isEven ? r : r * 0.28;
      final pt = o + Offset(cos(a) * rad, sin(a) * rad);
      i == 0 ? p.moveTo(pt.dx, pt.dy) : p.lineTo(pt.dx, pt.dy);
    }
    c.drawPath(p..close(), Paint()..color = color);
  }

  void _text(
    Canvas c,
    String s,
    Offset center,
    double size,
    Color fill,
    Color stroke,
    double strokeWidth,
  ) {
    TextPainter tp(Paint? fg, Color? color) => TextPainter(
      text: TextSpan(
        text: s,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: size,
          fontWeight: FontWeight.w900,
          height: 1,
          foreground: fg,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final st = tp(
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeJoin = StrokeJoin.round
        ..color = stroke,
      null,
    );
    final fl = tp(null, fill);
    final o = center - Offset(fl.width / 2, fl.height / 2);
    st.paint(c, o + Offset(0, size * 0.06));
    st.paint(c, o);
    fl.paint(c, o);
  }

  @override
  bool shouldRepaint(AppIconPainter old) =>
      old.background != background ||
      old.foreground != foreground ||
      old.inset != inset;
}
