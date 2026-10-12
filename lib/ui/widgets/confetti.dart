import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../art/paint_kit.dart';

class _Piece {
  double x = 0, y = 0, vx = 0, vy = 0, rot = 0, vr = 0, size = 0, delay = 0;
  Color color = Colors.white;
  bool circle = false;
}

/// Celebratory confetti burst from the top (pooled, fixed-size).
class Confetti extends StatefulWidget {
  final int count;
  final bool loop;
  const Confetti({super.key, this.count = 90, this.loop = false});

  @override
  State<Confetti> createState() => _ConfettiState();
}

class _ConfettiState extends State<Confetti> with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final _t = ValueNotifier<double>(0);
  late final List<_Piece> _pieces;
  final _rng = Random();

  static const _colors = [
    Color(0xFFFF5A6E),
    Color(0xFFFFC93C),
    Color(0xFF5BCB4B),
    Color(0xFF45A7F5),
    Color(0xFFAE6BFF),
    Color(0xFFFF9A3C),
  ];

  @override
  void initState() {
    super.initState();
    _pieces = List.generate(widget.count, (_) => _spawn(_Piece(), initial: true));
    _ticker = createTicker((e) => _t.value = e.inMicroseconds / 1e6)..start();
  }

  _Piece _spawn(_Piece p, {bool initial = false}) {
    p
      ..x = _rng.nextDouble()
      ..y = -0.05 - _rng.nextDouble() * 0.2
      ..vx = (_rng.nextDouble() - 0.5) * 0.25
      ..vy = 0.25 + _rng.nextDouble() * 0.35
      ..rot = _rng.nextDouble() * pi
      ..vr = (_rng.nextDouble() - 0.5) * 12
      ..size = 6 + _rng.nextDouble() * 7
      ..delay = initial ? _rng.nextDouble() * 0.8 : 0
      ..color = _colors[_rng.nextInt(_colors.length)]
      ..circle = _rng.nextInt(4) == 0;
    return p;
  }

  @override
  void dispose() {
    _ticker.dispose();
    _t.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => RepaintBoundary(
    child: CustomPaint(size: Size.infinite, painter: _ConfettiPainter(_pieces, _t, widget.loop)),
  );
}

class _ConfettiPainter extends CustomPainter {
  final List<_Piece> pieces;
  final ValueNotifier<double> t;
  final bool loop;
  _ConfettiPainter(this.pieces, this.t, this.loop) : super(repaint: t);

  @override
  void paint(Canvas canvas, Size size) {
    final time = t.value;
    final paint = Paint();
    for (final p in pieces) {
      var age = time - p.delay;
      if (age < 0) continue;
      if (loop) age = age % 4.5;
      final y = (p.y + p.vy * age + 0.05 * age * age) * size.height;
      if (y > size.height + 20) continue;
      final x = (p.x + p.vx * age + 0.02 * sin(age * 3 + p.rot)) * size.width;
      final fade = loop ? 1.0 : (1 - ((age - 3.2) / 1.0).clamp(0.0, 1.0));
      if (fade <= 0) continue;
      paint.color = Pk.alpha(p.color, fade);
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.rot + p.vr * age);
      if (p.circle) {
        canvas.drawCircle(Offset.zero, p.size * 0.4, paint);
      } else {
        canvas.drawRect(
          Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.5 * (0.4 + sin(age * 8 + p.rot).abs())),
          paint,
        );
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => false;
}
