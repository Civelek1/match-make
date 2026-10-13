import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../art/paint_kit.dart';
import '../art/tile_art.dart';
import '../theme/game_colors.dart';

/// Named explicitly so the logo looks the same everywhere (and in rendered
/// store art); platforms without Roboto fall back to their system font.
const kLogoFont = 'Roboto';

/// MATCH MAKE logo: "MATCH" spelled on real game-piece shapes (matching),
/// "MAKE" on a nailed wooden plank (building / restoration).
class MatchMakeLogo extends StatefulWidget {
  final double width;
  final bool animateIn;
  const MatchMakeLogo({super.key, this.width = 320, this.animateIn = true});

  @override
  State<MatchMakeLogo> createState() => _MatchMakeLogoState();
}

class _MatchMakeLogoState extends State<MatchMakeLogo> with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final _t = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((e) => _t.value = e.inMicroseconds / 1e6)..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _t.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Match Make',
      child: RepaintBoundary(
        child: CustomPaint(size: Size(widget.width, widget.width * 0.56), painter: _LogoPainter(_t, widget.animateIn)),
      ),
    );
  }
}

class _LogoPainter extends CustomPainter {
  final ValueNotifier<double> t;
  final bool animateIn;
  _LogoPainter(this.t, this.animateIn) : super(repaint: t);

  static const _letters = ['M', 'A', 'T', 'C', 'H'];
  static const _slots = [0, 1, 2, 3, 4];

  @override
  void paint(Canvas canvas, Size size) {
    final time = t.value;
    final w = size.width;
    final tile = w / 5.6;
    final gap = (w - tile * 5) / 6;
    // While the shine sweeps, draw the logo into its own layer so the
    // srcATop shine only lands on the logo, never on what's behind it (web).
    final cycle = (time % 4.0) / 1.2;
    final shine = cycle < 1 && time > 1.3;
    final bounds = Rect.fromLTWH(-tile, -tile, w + tile * 2, size.height + tile * 2);
    if (shine) canvas.saveLayer(bounds, Paint());

    // MATCH tiles.
    for (var i = 0; i < 5; i++) {
      final delay = i * 0.09;
      final k = animateIn ? ((time - 0.15 - delay) / 0.5).clamp(0.0, 1.0) : 1.0;
      if (k <= 0) continue;
      final drop = (1 - Curves.bounceOut.transform(k)) * -tile * 2.2;
      final bob = sin(time * 2 + i * 0.9) * tile * 0.03;
      final cx = gap + tile / 2 + i * (tile + gap);
      final cy = tile * 0.62 + drop + bob;
      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate((i.isEven ? -1 : 1) * 0.07);
      final r = Rect.fromCenter(center: Offset.zero, width: tile, height: tile);
      final path = slotPath(_slots[i], r);
      final color = slotColors[_slots[i]];
      canvas.drawPath(path.shift(Offset(0, tile * 0.07)), Paint()..color = GameColors.ink);
      canvas.drawPath(path, Paint()..shader = ui.Gradient.linear(r.topCenter, r.bottomCenter, [Pk.light(color, 0.3), color]));
      canvas.drawPath(path, Pk.stroke(GameColors.ink, tile * 0.06));
      canvas.save();
      canvas.clipPath(path);
      canvas.drawOval(
        Rect.fromLTWH(r.left + tile * 0.18, r.top + tile * 0.08, tile * 0.64, tile * 0.28),
        Paint()..color = Colors.white.withValues(alpha: 0.4),
      );
      canvas.restore();
      _text(canvas, _letters[i], Offset(0, _slots[i] == 4 ? tile * 0.1 : tile * 0.02), tile * 0.52, Colors.white);
      canvas.restore();
    }

    // MAKE plank.
    final pk = animateIn ? ((time - 0.75) / 0.45).clamp(0.0, 1.0) : 1.0;
    if (pk > 0) {
      final s = Pk.pop(pk);
      final plank = Rect.fromCenter(center: Offset(w / 2, size.height * 0.76), width: w * 0.74, height: size.height * 0.36);
      canvas.save();
      canvas.translate(plank.center.dx, plank.center.dy);
      canvas.rotate(-0.03);
      canvas.scale(s);
      final pr = Rect.fromCenter(center: Offset.zero, width: plank.width, height: plank.height);
      final rr = RRect.fromRectAndRadius(pr, Radius.circular(pr.height * 0.22));
      canvas.drawRRect(rr.shift(Offset(0, pr.height * 0.09)), Paint()..color = GameColors.ink);
      canvas.drawRRect(
        rr,
        Paint()..shader = ui.Gradient.linear(pr.topCenter, pr.bottomCenter, [const Color(0xFFF2B36B), const Color(0xFFC9803E)]),
      );
      for (final y in [-0.18, 0.16]) {
        canvas.drawLine(
          Offset(pr.left + 10, pr.height * y),
          Offset(pr.right - 10, pr.height * y),
          Pk.stroke(const Color(0xFFA8642C).withValues(alpha: 0.6), 1.5),
        );
      }
      canvas.drawRRect(rr, Pk.stroke(GameColors.ink, tile * 0.06));
      for (final x in [pr.left + pr.height * 0.28, pr.right - pr.height * 0.28]) {
        canvas.drawCircle(Offset(x, 0), pr.height * 0.07, Paint()..color = const Color(0xFF8A839B));
        canvas.drawCircle(Offset(x - 1, -1), pr.height * 0.03, Paint()..color = Colors.white.withValues(alpha: 0.7));
      }
      _text(canvas, 'MAKE', const Offset(0, 0), pr.height * 0.66, GameColors.gold, stroke: GameColors.ink);
      canvas.restore();
    }

    // Shine sweep across everything every few seconds.
    if (shine) {
      final x = -w * 0.3 + cycle * w * 1.6;
      canvas.saveLayer(bounds, Paint()..blendMode = BlendMode.srcATop);
      canvas.drawRect(
        bounds,
        Paint()
          ..shader = ui.Gradient.linear(
            Offset(x - 40, 0),
            Offset(x + 40, size.height),
            [Colors.white.withValues(alpha: 0), Colors.white.withValues(alpha: 0.55), Colors.white.withValues(alpha: 0)],
            [0, 0.5, 1],
          ),
      );
      canvas.restore();
      canvas.restore();
    }
    // Sparkles.
    for (var i = 0; i < 3; i++) {
      final tw = (sin(time * 2.5 + i * 2.1) + 1) / 2;
      final p = Offset(w * (0.12 + i * 0.38), size.height * (0.12 + (i % 2) * 0.55));
      Pk.sparkle(canvas, p, 3 + 6 * tw, Colors.white.withValues(alpha: tw));
    }
  }

  // Laid-out text is cached: the logo repaints every frame for its animation.
  final Map<String, (TextPainter, TextPainter)> _textCache = {};

  void _text(Canvas c, String s, Offset center, double size, Color color, {Color stroke = GameColors.ink}) {
    final key = '$s|${size.toStringAsFixed(1)}|${color.toARGB32()}|${stroke.toARGB32()}';
    final (strokeTp, fillTp) = _textCache[key] ??= _layoutText(s, size, color, stroke);
    final o = center - Offset(fillTp.width / 2, fillTp.height / 2);
    strokeTp.paint(c, o + Offset(0, size * 0.06));
    strokeTp.paint(c, o);
    fillTp.paint(c, o);
  }

  (TextPainter, TextPainter) _layoutText(String s, double size, Color color, Color stroke) {
    final strokeTp = TextPainter(
      text: TextSpan(
        text: s,
        style: TextStyle(
          fontFamily: kLogoFont,
          fontSize: size,
          fontWeight: FontWeight.w900,
          letterSpacing: size * 0.04,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = size * 0.16
            ..strokeJoin = StrokeJoin.round
            ..color = stroke,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final fillTp = TextPainter(
      text: TextSpan(
        text: s,
        style: TextStyle(
          fontFamily: kLogoFont,
          fontSize: size,
          fontWeight: FontWeight.w900,
          color: color,
          letterSpacing: size * 0.04,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    return (strokeTp, fillTp);
  }

  @override
  bool shouldRepaint(_LogoPainter old) => false;
}

/// Soft animated backdrop (gradient, drifting clouds, floating sparkles).
class AnimatedBackdrop extends StatefulWidget {
  final List<Color> colors;
  final Widget? child;
  final bool clouds;
  const AnimatedBackdrop({
    super.key,
    this.colors = const [Color(0xFF5EC2FF), Color(0xFFB6E7FF), Color(0xFFFFE3B3)],
    this.child,
    this.clouds = true,
  });

  @override
  State<AnimatedBackdrop> createState() => _AnimatedBackdropState();
}

class _AnimatedBackdropState extends State<AnimatedBackdrop> with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final _t = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((e) => _t.value = e.inMicroseconds / 1e6)..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _t.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      RepaintBoundary(child: CustomPaint(painter: _BackdropPainter(_t, widget.colors, widget.clouds))),
      if (widget.child != null) widget.child!,
    ],
  );
}

class _BackdropPainter extends CustomPainter {
  final ValueNotifier<double> t;
  final List<Color> colors;
  final bool clouds;
  _BackdropPainter(this.t, this.colors, this.clouds) : super(repaint: t);

  @override
  void paint(Canvas canvas, Size size) {
    final time = t.value;
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = ui.Gradient.linear(Offset.zero, Offset(0, size.height), colors, [
          for (var i = 0; i < colors.length; i++) i / (colors.length - 1),
        ]),
    );
    // Slow radial light.
    Pk.glow(canvas, Offset(size.width * (0.5 + 0.2 * sin(time * 0.2)), size.height * 0.25), size.width * 0.9, Colors.white, 0.25);
    if (clouds) {
      for (var i = 0; i < 4; i++) {
        final s = size.width / 360 * (1 + i * 0.25);
        final x = ((i * 137 + time * (6 + i * 3)) % (size.width + 160)) - 100;
        Pk.cloud(canvas, Offset(x, size.height * (0.08 + i * 0.12)), s, Colors.white.withValues(alpha: 0.55));
      }
    }
    // Floating particles.
    for (var i = 0; i < 22; i++) {
      final speed = 12 + Pk.rand(i) * 20;
      final y = size.height - ((time * speed + Pk.rand(i + 7) * size.height) % (size.height + 40));
      final x = Pk.rand(i + 3) * size.width + sin(time * 0.8 + i) * 14;
      final a = 0.25 + 0.35 * Pk.rand(i + 11);
      if (i % 3 == 0) {
        Pk.sparkle(canvas, Offset(x, y), 3 + Pk.rand(i + 5) * 4, Colors.white.withValues(alpha: a));
      } else {
        canvas.drawCircle(Offset(x, y), 2 + Pk.rand(i + 5) * 3, Paint()..color = Colors.white.withValues(alpha: a * 0.7));
      }
    }
  }

  @override
  bool shouldRepaint(_BackdropPainter old) => old.colors != colors;
}
