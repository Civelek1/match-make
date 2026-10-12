import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../data/models/level_data.dart';
import '../../match3/board.dart';
import '../art/paint_kit.dart';
import '../art/tile_art.dart';
import '../theme/game_colors.dart';
import '../widgets/game_text.dart';

/// Compact objective chip: piece icon, progress ring, "12/20", check when done.
/// Bumps whenever its value increases.
class ObjectiveCounter extends StatefulWidget {
  final ObjectiveData objective;
  final int value;
  final double size;
  const ObjectiveCounter({super.key, required this.objective, required this.value, this.size = 44});

  @override
  State<ObjectiveCounter> createState() => _ObjectiveCounterState();
}

class _ObjectiveCounterState extends State<ObjectiveCounter> with SingleTickerProviderStateMixin {
  late final AnimationController _bump = AnimationController(vsync: this, duration: const Duration(milliseconds: 380));

  @override
  void didUpdateWidget(ObjectiveCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value > oldWidget.value) _bump.forward(from: 0);
  }

  @override
  void dispose() {
    _bump.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final o = widget.objective;
    final done = widget.value >= o.target;
    final frac = (widget.value / o.target).clamp(0.0, 1.0);
    final s = widget.size;
    return AnimatedBuilder(
      animation: _bump,
      builder: (context, child) {
        final k = _bump.value;
        final scale = 1 + sin(k * pi) * 0.22 * (1 - k * 0.5);
        return Transform.scale(scale: scale, child: child);
      },
      child: SizedBox(
        width: s + 8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: s,
              height: s,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(end: frac),
                      duration: const Duration(milliseconds: 400),
                      builder: (context, v, _) => CustomPaint(painter: _RingPainter(v, done)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(s * 0.13),
                    child: TileIcon(o.tileTypeId, size: s * 0.74),
                  ),
                  if (done)
                    Positioned(
                      right: -4,
                      bottom: -4,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.elasticOut,
                        builder: (context, v, child) => Transform.scale(scale: v, child: child),
                        child: Container(
                          width: s * 0.44,
                          height: s * 0.44,
                          decoration: BoxDecoration(
                            color: GameColors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(Icons.check_rounded, color: Colors.white, size: s * 0.32),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            FittedBox(
              child: GameText(
                done ? '${o.target}/${o.target}' : '${widget.value}/${o.target}',
                size: 13,
                strokeWidth: 3,
                color: done ? const Color(0xFFB9FF9C) : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double value;
  final bool done;
  _RingPainter(this.value, this.done);

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.width / 2;
    canvas.drawCircle(c, r, Paint()..color = Colors.black.withValues(alpha: 0.3));
    canvas.drawCircle(c, r - 2, Paint()..color = Colors.white.withValues(alpha: 0.18));
    canvas.drawArc(
      Rect.fromCircle(center: c, radius: r - 2),
      -pi / 2,
      2 * pi * value,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round
        ..color = done ? GameColors.green : GameColors.gold,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.value != value || old.done != done;
}

/// Prominent moves counter; pulses red when running low.
class MovesBubble extends StatelessWidget {
  final int moves;
  final String label;
  const MovesBubble({super.key, required this.moves, required this.label});

  @override
  Widget build(BuildContext context) {
    final low = moves <= 5;
    return TweenAnimationBuilder<double>(
      key: ValueKey(moves),
      tween: Tween(begin: 1.25, end: 1),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutBack,
      builder: (context, s, child) => Transform.scale(scale: s, child: child),
      child: Container(
        width: 78,
        padding: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: low ? const [Color(0xFFFF8E98), GameColors.red] : const [Color(0xFF9B7BFF), Color(0xFF6A3FD6)],
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), offset: const Offset(0, 4), blurRadius: 4)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1),
            ),
            GameText('$moves', size: 24, strokeWidth: 4),
          ],
        ),
      ),
    );
  }
}

/// Score with count-up animation and a star progress bar.
class ScoreBar extends StatelessWidget {
  final int score;
  final List<int> thresholds;
  final String label;
  const ScoreBar({super.key, required this.score, required this.thresholds, required this.label});

  @override
  Widget build(BuildContext context) {
    final max3 = thresholds[1].toDouble();
    return TweenAnimationBuilder<double>(
      tween: Tween(end: score.toDouble()),
      duration: const Duration(milliseconds: 500),
      builder: (context, v, _) {
        final frac = (v / max3).clamp(0.0, 1.0);
        return Row(
          children: [
            SizedBox(
              width: 96,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1),
                  ),
                  GameText('${v.round()}', size: 18, strokeWidth: 3, align: TextAlign.left),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, c) {
                  final w = c.maxWidth;
                  return SizedBox(
                    height: 26,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 1.5),
                          ),
                        ),
                        Container(
                          height: 12,
                          width: max(10.0, w * frac),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [GameColors.gold, GameColors.orange]),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        for (final (i, t) in [(0, 0.0), (1, thresholds[0] / max3), (2, 1.0)])
                          Positioned(
                            left: (w * t - 12).clamp(-6, w - 18),
                            child: Icon(
                              Icons.star_rounded,
                              size: 24,
                              color: frac >= t && (i > 0 || score > 0) ? GameColors.star : GameColors.starEmpty,
                              shadows: const [Shadow(color: GameColors.ink, offset: Offset(0, 1.5))],
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Flyer {
  String tileTypeId = '';
  String objectiveId = '';
  int amount = 0;
  Offset from = Offset.zero, to = Offset.zero, ctrl = Offset.zero;
  double born = -10, dur = 0.6;
  bool active = false;
}

/// Overlay that flies objective icons from the board to the HUD counters.
class FlyLayer extends StatefulWidget {
  final void Function(String objectiveId, int amount) onArrive;
  const FlyLayer({super.key, required this.onArrive});

  @override
  State<FlyLayer> createState() => FlyLayerState();
}

class FlyLayerState extends State<FlyLayer> with SingleTickerProviderStateMixin {
  final List<_Flyer> _pool = List.generate(30, (_) => _Flyer());
  late final Ticker _ticker;
  final _repaint = ValueNotifier<double>(0);
  final TileArtCache _art = TileArtCache();
  final Stopwatch _clock = Stopwatch()..start();
  final _rng = Random();

  double get _now => _clock.elapsedMicroseconds / 1e6;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick)..start();
  }

  void _tick(Duration _) {
    final now = _now;
    var any = false;
    for (final f in _pool) {
      if (!f.active) continue;
      any = true;
      if (now - f.born >= f.dur) {
        f.active = false;
        widget.onArrive(f.objectiveId, f.amount);
      }
    }
    if (any) _repaint.value = now;
  }

  /// Global coordinates in; converted to this layer's local space.
  void fly(String tileTypeId, String objectiveId, int amount, Offset fromGlobal, Offset toGlobal) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) {
      widget.onArrive(objectiveId, amount);
      return;
    }
    final f = _pool.firstWhere(
      (f) => !f.active,
      orElse: () {
        // Pool exhausted: land the oldest immediately.
        final oldest = _pool.reduce((a, b) => a.born < b.born ? a : b);
        oldest.active = false;
        widget.onArrive(oldest.objectiveId, oldest.amount);
        return oldest;
      },
    );
    final from = box.globalToLocal(fromGlobal), to = box.globalToLocal(toGlobal);
    f
      ..tileTypeId = tileTypeId
      ..objectiveId = objectiveId
      ..amount = amount
      ..from = from
      ..to = to
      ..ctrl = Offset((from.dx + to.dx) / 2 + (_rng.nextDouble() - 0.5) * 120, min(from.dy, to.dy) - 40 - _rng.nextDouble() * 60)
      ..born = _now + _rng.nextDouble() * 0.08
      ..dur = 0.55 + _rng.nextDouble() * 0.15
      ..active = true;
  }

  @override
  void dispose() {
    // Land everything so objective counts stay correct.
    for (final f in _pool) {
      f.active = false;
    }
    _ticker.dispose();
    _art.clear();
    _repaint.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    return IgnorePointer(
      child: CustomPaint(size: Size.infinite, painter: _FlyPainter(this, dpr)),
    );
  }
}

class _FlyPainter extends CustomPainter {
  final FlyLayerState s;
  final double dpr;
  final Paint _p = Paint()..filterQuality = FilterQuality.medium;
  _FlyPainter(this.s, this.dpr) : super(repaint: s._repaint);

  @override
  void paint(Canvas canvas, Size size) {
    final now = s._now;
    for (final f in s._pool) {
      if (!f.active) continue;
      final k = ((now - f.born) / f.dur).clamp(0.0, 1.0);
      final e = Curves.easeInCubic.transform(k);
      final a = Offset.lerp(f.from, f.ctrl, e)!, b = Offset.lerp(f.ctrl, f.to, e)!;
      final p = Offset.lerp(a, b, e)!;
      final sz = 34.0 * (k < 0.15 ? 0.7 + k * 3 : 1.15 - e * 0.45);
      final img = s._art.get(f.tileTypeId, SpecialKind.none, 34 * dpr);
      // Trail sparkle.
      Pk.sparkle(canvas, Offset.lerp(p, f.from, 0.08)!, 5 * (1 - k), Colors.white.withValues(alpha: 0.8));
      canvas.drawImageRect(
        img,
        Rect.fromLTWH(0, 0, img.width.toDouble(), img.height.toDouble()),
        Rect.fromCenter(center: p, width: sz, height: sz),
        _p,
      );
    }
  }

  @override
  bool shouldRepaint(_FlyPainter old) => false;
}
