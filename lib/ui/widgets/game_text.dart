import 'package:flutter/material.dart';

import '../theme/game_colors.dart';

/// Chunky outlined game-style text (fill + stroke + drop shadow).
class GameText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final Color stroke;
  final double strokeWidth;
  final TextAlign align;
  final int? maxLines;
  final FontWeight weight;
  final double letterSpacing;
  final bool shadow;

  const GameText(
    this.text, {
    super.key,
    this.size = 20,
    this.color = Colors.white,
    this.stroke = GameColors.ink,
    this.strokeWidth = 4,
    this.align = TextAlign.center,
    this.maxLines,
    this.weight = FontWeight.w900,
    this.letterSpacing = 0.5,
    this.shadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final base = TextStyle(fontSize: size, fontWeight: weight, letterSpacing: letterSpacing, height: 1.1);
    final overflow = maxLines == null ? null : TextOverflow.ellipsis;
    return Stack(
      children: [
        if (strokeWidth > 0)
          Text(
            text,
            textAlign: align,
            maxLines: maxLines,
            overflow: overflow,
            style: base.copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = strokeWidth
                ..strokeJoin = StrokeJoin.round
                ..color = stroke,
              shadows: shadow ? [Shadow(color: stroke.withValues(alpha: 0.9), offset: Offset(0, strokeWidth * 0.6))] : null,
            ),
          ),
        Text(
          text,
          textAlign: align,
          maxLines: maxLines,
          overflow: overflow,
          style: base.copyWith(color: color),
        ),
      ],
    );
  }
}

/// Regular body text in the game's palette.
class BodyText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final TextAlign align;
  final FontWeight weight;
  const BodyText(
    this.text, {
    super.key,
    this.size = 15,
    this.color = GameColors.ink,
    this.align = TextAlign.center,
    this.weight = FontWeight.w700,
  });

  @override
  Widget build(BuildContext context) => Text(
    text,
    textAlign: align,
    style: TextStyle(fontSize: size, color: color, fontWeight: weight, height: 1.25),
  );
}
