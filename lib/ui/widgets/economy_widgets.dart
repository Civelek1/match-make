import 'dart:math';

import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../../economy/economy_config.dart';
import '../../match3/board.dart';
import '../art/tile_art.dart';
import '../theme/game_colors.dart';
import 'game_button.dart';
import 'game_text.dart';

/// Painted gold coin (no asset needed).
class CoinIcon extends StatelessWidget {
  final double size;
  const CoinIcon({super.key, this.size = 26});

  @override
  Widget build(BuildContext context) => CustomPaint(size: Size.square(size), painter: const _CoinPainter());
}

class _CoinPainter extends CustomPainter {
  const _CoinPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width / 2;
    final c = Offset(r, r);
    canvas.drawCircle(c + Offset(0, r * 0.12), r * 0.92, Paint()..color = GameColors.goldDark);
    canvas.drawCircle(c, r * 0.92, Paint()..color = GameColors.gold);
    canvas.drawCircle(
      c,
      r * 0.66,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.12
        ..color = GameColors.goldDark.withValues(alpha: 0.7),
    );
    // Five-point star stamp.
    final star = Path();
    for (var i = 0; i < 10; i++) {
      final a = -pi / 2 + i * pi / 5;
      final rr = i.isEven ? r * 0.42 : r * 0.18;
      final p = c + Offset(cos(a), sin(a)) * rr;
      i == 0 ? star.moveTo(p.dx, p.dy) : star.lineTo(p.dx, p.dy);
    }
    star.close();
    canvas.drawPath(star, Paint()..color = const Color(0xFFFFF3B0));
    canvas.drawCircle(
      c,
      r * 0.92,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.08
        ..color = const Color(0xFFB8740A),
    );
  }

  @override
  bool shouldRepaint(_CoinPainter oldDelegate) => false;
}

/// Header chip with the live coin balance. Tapping opens the shop.
class CoinChip extends StatelessWidget {
  final VoidCallback? onTap;
  const CoinChip({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    return ListenableBuilder(
      listenable: s.economy,
      builder: (context, _) => Semantics(
        button: onTap != null,
        label: '${s.economy.coins} ${s.loc.t('shop.coins')}',
        child: Pressable(
          onTap: onTap ?? () {},
          child: Container(
            padding: const EdgeInsets.fromLTRB(4, 4, 6, 4),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.7), width: 2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CoinIcon(size: 26),
                const SizedBox(width: 4),
                GameText('${s.economy.coins}', size: 17, strokeWidth: 3),
                if (onTap != null) ...[
                  const SizedBox(width: 4),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: GameColors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: const Icon(Icons.add_rounded, size: 16, color: Colors.white),
                  ),
                ] else
                  const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Visual for a booster: start boosters show the special piece they place.
class BoosterIcon extends StatelessWidget {
  final BoosterKind kind;
  final double size;
  const BoosterIcon(this.kind, {super.key, this.size = 40});

  static Color colorOf(BoosterKind k) => switch (k) {
    BoosterKind.hammer => GameColors.orange,
    BoosterKind.broom => GameColors.blue,
    BoosterKind.shuffle => GameColors.purple,
    BoosterKind.startRocket || BoosterKind.startBomb || BoosterKind.startRainbow => GameColors.gold,
  };

  @override
  Widget build(BuildContext context) {
    switch (kind) {
      case BoosterKind.startRocket:
        return TileIcon('flower', size: size, special: SpecialKind.rocketH);
      case BoosterKind.startBomb:
        return TileIcon('fence', size: size, special: SpecialKind.bomb);
      case BoosterKind.startRainbow:
        return TileIcon('flower', size: size, special: SpecialKind.colorBomb);
      case BoosterKind.hammer:
      case BoosterKind.broom:
      case BoosterKind.shuffle:
        final icon = switch (kind) {
          BoosterKind.hammer => Icons.gavel_rounded,
          BoosterKind.broom => Icons.cleaning_services_rounded,
          _ => Icons.shuffle_rounded,
        };
        final color = colorOf(kind);
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              center: const Alignment(-0.3, -0.4),
              colors: [Color.lerp(color, Colors.white, 0.35)!, color, Color.lerp(color, Colors.black, 0.2)!],
              stops: const [0, 0.6, 1],
            ),
            border: Border.all(color: Color.lerp(color, Colors.black, 0.35)!, width: size * 0.05),
          ),
          child: Icon(
            icon,
            size: size * 0.56,
            color: Colors.white,
            shadows: [Shadow(color: Color.lerp(color, Colors.black, 0.5)!, offset: Offset(0, size * 0.03))],
          ),
        );
    }
  }
}

/// Small count bubble (or a "+" when none are owned) for booster buttons.
class CountBadge extends StatelessWidget {
  final int count;
  final double size;
  const CountBadge({super.key, required this.count, this.size = 20});

  @override
  Widget build(BuildContext context) {
    final empty = count <= 0;
    return Container(
      constraints: BoxConstraints(minWidth: size, minHeight: size),
      padding: EdgeInsets.symmetric(horizontal: size * 0.2),
      decoration: BoxDecoration(
        color: empty ? GameColors.green : GameColors.red,
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(color: Colors.white, width: 1.8),
      ),
      alignment: Alignment.center,
      child: empty
          ? Icon(Icons.add_rounded, size: size * 0.8, color: Colors.white)
          : Text(
              '$count',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: size * 0.6, height: 1.1),
            ),
    );
  }
}

/// "+N" coin line used on result screens.
class CoinReward extends StatelessWidget {
  final int amount;
  final double size;
  const CoinReward({super.key, required this.amount, this.size = 26});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: amount.toDouble()),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (context, v, _) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CoinIcon(size: size),
          const SizedBox(width: 6),
          GameText('+${v.round()}', size: size * 0.9, color: GameColors.gold, stroke: GameColors.ink, strokeWidth: 3),
        ],
      ),
    );
  }
}
