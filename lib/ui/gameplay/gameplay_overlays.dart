import 'dart:math';

import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../../app/game_navigator.dart';
import '../../audio/audio_service.dart';
import '../../data/models/level_data.dart';
import '../../game/gameplay_controller.dart';
import '../../match3/board.dart';
import '../art/tile_art.dart';
import '../screens/settings_panel.dart';
import '../theme/game_colors.dart';
import '../widgets/confetti.dart';
import '../widgets/game_button.dart';
import '../widgets/game_panel.dart';
import '../widgets/game_text.dart';
import '../widgets/game_widgets.dart';

/// Dimmed full-screen layer with a centred panel.
class _Scrim extends StatelessWidget {
  final Widget child;
  final double dim;
  const _Scrim({required this.child, this.dim = 0.5});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: Colors.black.withValues(alpha: dim),
    child: SafeArea(
      child: Center(
        child: SingleChildScrollView(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24), child: child),
      ),
    ),
  );
}

String _specialKey(SpecialFeature f) => switch (f) {
  SpecialFeature.rocket => 'rocket',
  SpecialFeature.bomb => 'bomb',
  SpecialFeature.colorBomb => 'colorBomb',
};

// -----------------------------------------------------------------------------
// Level intro card
// -----------------------------------------------------------------------------

class LevelIntroOverlay extends StatelessWidget {
  final GameplayController c;
  const LevelIntroOverlay({super.key, required this.c});

  @override
  Widget build(BuildContext context) {
    final loc = context.services.loc;
    final level = c.level;
    return _Scrim(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.6, end: 1),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutBack,
        builder: (context, s, child) => Transform.scale(scale: s, child: child),
        child: GamePanel(
          title: loc.t('common.level_n', {'n': level.number}),
          ribbon: EnvironmentTheme.of(level.environmentId).accent,
          onClose: () => context.services.navigator.go(AppScreen.chapterMap, style: TransitionStyle.zoomOut),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GameText(loc.t(level.nameKey), size: 34, color: GameColors.gold),
              const SizedBox(height: 4),
              BodyText(loc.t(level.descKey), color: GameColors.inkSoft, size: 14),
              const SizedBox(height: 14),
              Text(
                loc.t('intro.restore'),
                style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.inkSoft, letterSpacing: 2, fontSize: 13),
              ),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final o in level.objectives)
                    Container(
                      padding: const EdgeInsets.fromLTRB(4, 4, 10, 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: GameColors.creamDark, width: 2),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TileIcon(o.tileTypeId, size: 30),
                          const SizedBox(width: 4),
                          Text(
                            '${loc.t(o.nameKey)} ×${o.target}',
                            style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.ink, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              if (level.introduces != null) ...[
                const SizedBox(height: 14),
                _NewSpecialCard(feature: level.introduces!, tileTypeId: level.tileTypeIds.first),
              ],
              if (level.introducesObstacle != null && !context.services.progress.hasSeenTip('obstacle_${level.introducesObstacle}')) ...[
                const SizedBox(height: 14),
                _NewObstacleCard(obstacle: level.introducesObstacle!),
              ],
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.swap_horiz_rounded, color: GameColors.purple, size: 28),
                  const SizedBox(width: 4),
                  GameText(
                    loc.t('intro.moves', {'n': level.moves}),
                    size: 22,
                    color: GameColors.purple,
                    stroke: Colors.white,
                    strokeWidth: 3,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              GameButton.primary(label: loc.t('intro.play'), icon: Icons.play_arrow_rounded, width: 240, onTap: c.start),
            ],
          ),
        ),
      ),
    );
  }
}

/// One-time card explaining a new obstacle (crate / ice / chain).
class _NewObstacleCard extends StatelessWidget {
  final String obstacle;
  const _NewObstacleCard({required this.obstacle});

  @override
  Widget build(BuildContext context) {
    final loc = context.services.loc;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F4FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: GameColors.blue, width: 2.5),
      ),
      child: Row(
        children: [
          TileIcon(obstacle, size: 46),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${loc.t('intro.new')} ${loc.t('obstacle.$obstacle')}',
                  style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.blueDark, fontSize: 15),
                ),
                const SizedBox(height: 2),
                Text(
                  loc.t('obstacle.$obstacle.how'),
                  style: const TextStyle(fontWeight: FontWeight.w700, color: GameColors.ink, fontSize: 12.5, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NewSpecialCard extends StatelessWidget {
  final SpecialFeature feature;
  final String tileTypeId;
  const _NewSpecialCard({required this.feature, required this.tileTypeId});

  @override
  Widget build(BuildContext context) {
    final loc = context.services.loc;
    final key = _specialKey(feature);
    final kind = switch (feature) {
      SpecialFeature.rocket => SpecialKind.rocketH,
      SpecialFeature.bomb => SpecialKind.bomb,
      SpecialFeature.colorBomb => SpecialKind.colorBomb,
    };
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0C2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: GameColors.gold, width: 2.5),
      ),
      child: Row(
        children: [
          TileIcon(tileTypeId, size: 46, special: kind),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${loc.t('intro.new')} ${loc.t('special.$key')}',
                  style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.orangeDark, fontSize: 15),
                ),
                Text(
                  loc.t('special.$key.how'),
                  style: const TextStyle(fontWeight: FontWeight.w700, color: GameColors.ink, fontSize: 12.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Tutorial
// -----------------------------------------------------------------------------

class TutorialOverlay extends StatefulWidget {
  final GameplayController c;
  final GlobalKey objectivesKey;
  final GlobalKey sceneKey;
  const TutorialOverlay({super.key, required this.c, required this.objectivesKey, required this.sceneKey});

  @override
  State<TutorialOverlay> createState() => _TutorialOverlayState();
}

class _TutorialOverlayState extends State<TutorialOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat();

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  Rect? _rectOf(GlobalKey key) {
    final box = key.currentContext?.findRenderObject() as RenderBox?;
    final me = context.findRenderObject() as RenderBox?;
    if (box == null || me == null || !box.hasSize) return null;
    return me.globalToLocal(box.localToGlobal(Offset.zero)) & box.size;
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    final loc = context.services.loc;
    final name = loc.t(c.level.nameKey);
    final step = c.tutorialStep;
    if (step < 0) return const SizedBox.shrink();

    if (step == 0) {
      final m = c.tutorialMove;
      // Rebuilt every animation frame: cell positions are only known after
      // the board has been laid out.
      return IgnorePointer(
        child: AnimatedBuilder(
          animation: _anim,
          builder: (context, _) {
            final me = context.findRenderObject() as RenderBox?;
            final ra = m == null ? null : c.board.cellRectGlobal(m.a);
            final rb = m == null ? null : c.board.cellRectGlobal(m.b);
            Offset? a, b;
            if (me != null && me.hasSize && ra != null && rb != null) {
              a = me.globalToLocal(ra.center);
              b = me.globalToLocal(rb.center);
            }
            return Stack(
              children: [
                if (a != null)
                  Positioned(
                    left: 20,
                    right: 20,
                    top: max(0, min(a.dy, b!.dy) - 110),
                    child: _Bubble(text: loc.t('tutorial.match')),
                  ),
                if (a != null)
                  AnimatedBuilder(
                    animation: _anim,
                    builder: (context, _) {
                      final k = Curves.easeInOut.transform((_anim.value * 1.4).clamp(0.0, 1.0));
                      final p = Offset.lerp(a!, b!, k)!;
                      return Positioned(
                        left: p.dx - 6,
                        top: p.dy - 4,
                        child: Opacity(
                          opacity: _anim.value > 0.85 ? (1 - (_anim.value - 0.85) / 0.15) : 1,
                          child: const Icon(
                            Icons.touch_app_rounded,
                            size: 52,
                            color: Colors.white,
                            shadows: [Shadow(color: GameColors.ink, blurRadius: 4, offset: Offset(0, 2))],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        ),
      );
    }

    final target = step == 1 ? _rectOf(widget.objectivesKey) : _rectOf(widget.sceneKey);
    final text = step == 1 ? loc.t('tutorial.collect', {'name': name}) : loc.t('tutorial.watch', {'name': name});
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.services.audio.play(Sfx.click);
        c.advanceTutorial();
      },
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _SpotlightPainter(target))),
          if (target != null)
            Positioned(
              left: 20,
              right: 20,
              top: step == 1 ? target.bottom + 12 : target.bottom + 70,
              child: Column(
                children: [
                  _Bubble(text: text),
                  const SizedBox(height: 8),
                  AnimatedBuilder(
                    animation: _anim,
                    builder: (context, child) => Opacity(opacity: 0.5 + 0.5 * sin(_anim.value * pi * 2).abs(), child: child),
                    child: GameText(loc.t('tutorial.tap'), size: 15, strokeWidth: 3),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _SpotlightPainter extends CustomPainter {
  final Rect? hole;
  _SpotlightPainter(this.hole);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()..addRect(Offset.zero & size);
    if (hole != null) {
      path.addRRect(RRect.fromRectAndRadius(hole!.inflate(6), const Radius.circular(18)));
      path.fillType = PathFillType.evenOdd;
    }
    canvas.drawPath(path, Paint()..color = Colors.black.withValues(alpha: 0.55));
    if (hole != null) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(hole!.inflate(6), const Radius.circular(18)),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = GameColors.gold,
      );
    }
  }

  @override
  bool shouldRepaint(_SpotlightPainter old) => old.hole != hole;
}

class _Bubble extends StatelessWidget {
  final String text;
  const _Bubble({required this.text});

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      constraints: const BoxConstraints(maxWidth: 360),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: GameColors.cream,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: GameColors.panelBorder, width: 4),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: BodyText(text, size: 18, weight: FontWeight.w900),
    ),
  );
}

// -----------------------------------------------------------------------------
// Pause
// -----------------------------------------------------------------------------

class PauseOverlay extends StatelessWidget {
  final GameplayController c;
  final VoidCallback onRestart;
  final VoidCallback onHome;
  const PauseOverlay({super.key, required this.c, required this.onRestart, required this.onHome});

  @override
  Widget build(BuildContext context) {
    final loc = context.services.loc;
    return _Scrim(
      dim: 0.55,
      child: GamePanel(
        title: loc.t('pause.title'),
        ribbon: GameColors.purple,
        maxWidth: 340,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GameButton(label: loc.t('pause.resume'), icon: Icons.play_arrow_rounded, width: double.infinity, onTap: c.resume),
            const SizedBox(height: 10),
            GameButton.secondary(
              label: loc.t('pause.restart'),
              icon: Icons.refresh_rounded,
              tone: ButtonTone.orange,
              width: double.infinity,
              onTap: onRestart,
            ),
            const SizedBox(height: 8),
            GameButton.secondary(
              label: loc.t('pause.settings'),
              icon: Icons.settings_rounded,
              tone: ButtonTone.blue,
              width: double.infinity,
              onTap: () => showGameModal<void>(
                context,
                builder: (ctx) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Material(
                      type: MaterialType.transparency,
                      child: SettingsPanel(inGame: true, onClose: () => Navigator.of(ctx).pop()),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            GameButton.secondary(
              label: loc.t('pause.home'),
              icon: Icons.home_rounded,
              tone: ButtonTone.red,
              width: double.infinity,
              onTap: onHome,
            ),
            if (kDebugTools) ...[
              const SizedBox(height: 12),
              Text(
                loc.t('debug.title'),
                style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.inkSoft),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                alignment: WrapAlignment.center,
                children: [
                  _DebugChip('Test Win', () {
                    c.resume();
                    c.debugWin();
                  }),
                  _DebugChip('Test Lose', () {
                    c.resume();
                    c.debugLose();
                  }),
                  _DebugChip('Shuffle', () {
                    c.resume();
                    c.debugShuffle();
                  }),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DebugChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _DebugChip(this.label, this.onTap);

  @override
  Widget build(BuildContext context) => Pressable(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: GameColors.ink, borderRadius: BorderRadius.circular(10)),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12),
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Win
// -----------------------------------------------------------------------------

class WinOverlay extends StatelessWidget {
  final GameplayController c;
  const WinOverlay({super.key, required this.c});

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    final loc = s.loc;
    final o = c.outcome!;
    final level = c.level;
    final last = s.content.isLastInChapter(level.id);
    final next = s.content.nextLevel(level.id);
    return Stack(
      children: [
        _Scrim(
          dim: 0.45,
          child: GamePanel(
            title: loc.t('win.title'),
            ribbon: GameColors.green,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StarDisplay(
                  stars: o.stars,
                  size: 54,
                  animate: true,
                  arc: true,
                  onStarShown: (_) {
                    s.audio.play(Sfx.star);
                    s.haptics.match();
                  },
                ),
                const SizedBox(height: 6),
                GameText(loc.t(level.nameKey), size: 24, color: GameColors.gold),
                const SizedBox(height: 10),
                _scoreLine(loc.t('win.score'), c.session.score),
                _scoreLine(loc.t('win.moves_bonus'), c.session.moveBonus),
                const Divider(color: GameColors.creamDark, thickness: 2),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: c.session.finalScore.toDouble()),
                  duration: const Duration(milliseconds: 1400),
                  curve: Curves.easeOutCubic,
                  builder: (context, v, _) =>
                      GameText('${v.round()}', size: 36, color: Colors.white, stroke: GameColors.purpleDark),
                ),
                if (o.newBest && !o.firstCompletion)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: GameText(loc.t('win.new_best'), size: 16, color: GameColors.gold, strokeWidth: 3),
                  ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      loc.t('win.restoration'),
                      style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.ink, fontSize: 13),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(child: GameProgressBar(value: 1, height: 18, label: '100%')),
                  ],
                ),
                if (o.newlyUnlocked != null || o.firstCompletion) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9FFD9),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: GameColors.green, width: 2),
                    ),
                    child: Column(
                      children: [
                        if (o.newlyUnlocked != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.lock_open_rounded, color: GameColors.greenDark),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  loc.t('win.unlocked', {'name': loc.t(o.newlyUnlocked!.nameKey)}),
                                  style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.greenDark),
                                ),
                              ),
                            ],
                          ),
                        if (o.firstCompletion)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.photo_library_rounded, color: GameColors.purple, size: 20),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  loc.t('win.gallery'),
                                  style: const TextStyle(fontWeight: FontWeight.w800, color: GameColors.purpleDark),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                GameButton.primary(
                  label: last ? loc.t('win.continue') : loc.t('win.next'),
                  icon: Icons.arrow_forward_rounded,
                  width: double.infinity,
                  onTap: () {
                    if (last) {
                      s.navigator.go(AppScreen.chapterComplete, arg: level.chapterId, style: TransitionStyle.zoomOut);
                    } else if (next != null && s.progress.isUnlocked(next.id)) {
                      s.navigator.go(AppScreen.playing, arg: next.id, style: TransitionStyle.zoomIn, force: true);
                    } else {
                      s.navigator.go(AppScreen.chapterMap, style: TransitionStyle.zoomOut);
                    }
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: GameButton.secondary(
                        label: loc.t('win.replay'),
                        icon: Icons.refresh_rounded,
                        tone: ButtonTone.orange,
                        onTap: () => s.navigator.go(AppScreen.playing, arg: level.id, style: TransitionStyle.fade, force: true),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GameButton.secondary(
                        label: loc.t('common.home'),
                        icon: Icons.home_rounded,
                        tone: ButtonTone.blue,
                        onTap: () => s.navigator.go(AppScreen.chapterMap, style: TransitionStyle.zoomOut),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Positioned.fill(child: IgnorePointer(child: Confetti())),
      ],
    );
  }

  Widget _scoreLine(String label, int value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w800, color: GameColors.inkSoft, fontSize: 15),
        ),
        const Spacer(),
        Text(
          '$value',
          style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.ink, fontSize: 16),
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// Lose
// -----------------------------------------------------------------------------

class LoseOverlay extends StatelessWidget {
  final GameplayController c;
  const LoseOverlay({super.key, required this.c});

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    final loc = s.loc;
    final remaining = [
      for (final o in c.level.objectives)
        if ((c.session.progress[o.id] ?? 0) < o.target) o,
    ];
    return _Scrim(
      dim: 0.55,
      child: GamePanel(
        title: loc.t('lose.title'),
        ribbon: GameColors.red,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.hourglass_bottom_rounded,
              size: 56,
              color: GameColors.orange,
              shadows: [Shadow(color: GameColors.orangeDark, offset: Offset(0, 3))],
            ),
            const SizedBox(height: 6),
            Text(
              loc.t('lose.remaining'),
              style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.inkSoft, letterSpacing: 1),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                for (final o in remaining)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TileIcon(o.tileTypeId, size: 42),
                      Text(
                        '${c.session.progress[o.id]}/${o.target}',
                        style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.ink),
                      ),
                      Text(
                        loc.t(o.nameKey),
                        style: const TextStyle(fontWeight: FontWeight.w700, color: GameColors.inkSoft, fontSize: 11),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 10),
            GameProgressBar(
              value: c.session.completion,
              height: 18,
              fill: GameColors.orange,
              label: '${(c.session.completion * 100).round()}%',
            ),
            if (s.rewards.extraMovesAvailable) ...[
              const SizedBox(height: 12),
              GameButton.secondary(
                label: loc.t('lose.extra_moves'),
                icon: Icons.add_circle_rounded,
                tone: ButtonTone.purple,
                onTap: () async {
                  if (await s.rewards.requestExtraMoves()) c.continueWithExtraMoves(5);
                },
              ),
            ],
            const SizedBox(height: 16),
            GameButton.primary(
              label: loc.t('lose.try_again'),
              icon: Icons.refresh_rounded,
              width: double.infinity,
              onTap: () => s.navigator.go(AppScreen.playing, arg: c.level.id, force: true),
            ),
            const SizedBox(height: 8),
            GameButton.secondary(
              label: loc.t('common.home'),
              icon: Icons.home_rounded,
              tone: ButtonTone.blue,
              width: double.infinity,
              onTap: () => s.navigator.go(AppScreen.chapterMap, style: TransitionStyle.zoomOut),
            ),
          ],
        ),
      ),
    );
  }
}
