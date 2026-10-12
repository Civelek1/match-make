import 'dart:math';

import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../../app/game_navigator.dart';
import '../../audio/audio_service.dart';
import '../../data/models/chapter_data.dart';
import '../../data/models/level_data.dart';
import '../../restoration/restoration_state.dart';
import '../scenes/scene_art.dart';
import '../theme/game_colors.dart';
import '../widgets/game_button.dart';
import '../widgets/game_text.dart';
import '../widgets/game_widgets.dart';
import '../widgets/screen_frame.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late final Set<String> _newOnOpen;

  @override
  void initState() {
    super.initState();
    final s = context.services;
    _newOnOpen = {
      for (final l in s.content.allLevels)
        if (s.progress.isGalleryNew(l.id)) l.id,
    };
    if (_newOnOpen.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 700), () {
        if (mounted) s.audio.play(Sfx.galleryUnlock);
      });
      s.progress.markGalleryViewed(_newOnOpen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    final loc = s.loc;
    return ScreenFrame(
      title: loc.t('gallery.title'),
      ribbon: GameColors.purple,
      colors: const [Color(0xFF8E6BFF), Color(0xFFD47BFF), Color(0xFFFFC2E2)],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [for (final chapter in s.content.chapters) ..._chapterSection(context, chapter)],
      ),
    );
  }

  List<Widget> _chapterSection(BuildContext context, ChapterData chapter) {
    final s = context.services;
    final loc = s.loc;
    final count = s.progress.galleryCount(chapter);
    final total = chapter.levelIds.length;
    final complete = count == total;
    final name = loc.t(chapter.nameKey);
    return [
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 2),
        ),
        child: Column(
          children: [
            Row(
              children: [
                if (complete) const _CollectionBadge(),
                if (complete) const SizedBox(width: 8),
                Expanded(
                  child: GameText(
                    complete
                        ? loc.t('gallery.collection_complete', {'chapter': name})
                        : loc.t('gallery.collection', {'chapter': name}),
                    size: 17,
                    strokeWidth: 3,
                    align: TextAlign.left,
                    color: complete ? GameColors.gold : Colors.white,
                  ),
                ),
                GameText('$count / $total', size: 18, strokeWidth: 3),
              ],
            ),
            const SizedBox(height: 8),
            GameProgressBar(value: count / total, height: 16, fill: GameColors.gold),
            if (!s.progress.isChapterUnlocked(chapter) && chapter.requiresChapterId != null) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.lock_rounded, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      loc.t('chapter.requires', {'name': loc.t(s.content.chapter(chapter.requiresChapterId!)!.nameKey)}),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
      const SizedBox(height: 12),
      LayoutBuilder(
        builder: (context, c) {
          final cols = c.maxWidth > 520 ? 3 : 2;
          final w = (c.maxWidth - (cols - 1) * 12) / cols;
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final l in s.content.levelsOf(chapter.id))
                SizedBox(
                  width: w,
                  child: GalleryCard(level: l, isNew: _newOnOpen.contains(l.id)),
                ),
            ],
          );
        },
      ),
      const SizedBox(height: 20),
    ];
  }
}

class _CollectionBadge extends StatelessWidget {
  const _CollectionBadge();

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(begin: 0, end: 1),
    duration: const Duration(milliseconds: 900),
    curve: Curves.elasticOut,
    builder: (context, v, child) => Transform.scale(scale: v, child: child),
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(colors: [Color(0xFFFFE27A), GameColors.goldDark]),
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: const Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 26),
    ),
  );
}

class GalleryCard extends StatefulWidget {
  final LevelData level;
  final bool isNew;
  const GalleryCard({super.key, required this.level, this.isNew = false});

  @override
  State<GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<GalleryCard> with SingleTickerProviderStateMixin {
  final _shake = ShakeController();
  late final AnimationController _shine = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));
  late RestorationState _state;

  @override
  void initState() {
    super.initState();
    final unlocked = context.services.progress.isGalleryUnlocked(widget.level.id);
    _state = unlocked ? RestorationState.completed(widget.level) : RestorationState(widget.level);
    if (widget.isNew) {
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) _shine.forward();
      });
    }
  }

  @override
  void dispose() {
    _shine.dispose();
    _shake.dispose();
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    final loc = s.loc;
    final l = widget.level;
    final unlocked = s.progress.isGalleryUnlocked(l.id);
    return Shake(
      controller: _shake,
      child: Pressable(
        sound: false,
        onTap: () {
          if (unlocked) {
            s.audio.play(Sfx.click);
            s.navigator.go(AppScreen.galleryDetail, arg: l.id, style: TransitionStyle.zoomIn);
          } else {
            s.audio.play(Sfx.locked);
            s.haptics.error();
            _shake.shake();
            showGameToast(
              context,
              loc.t('level.locked_title', {'name': loc.t(l.nameKey)}),
              message: loc.t('gallery.locked_msg', {'n': l.number}),
              icon: Icons.lock_rounded,
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: GameColors.cream,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: unlocked ? GameColors.gold : GameColors.panelBorder, width: 4),
            boxShadow: const [BoxShadow(color: Color(0x55000000), blurRadius: 8, offset: Offset(0, 5))],
          ),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 5 / 3.4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SceneView(environmentId: l.environmentId, state: _state, animate: false),
                      if (!unlocked) ...[
                        const ColoredBox(color: Color(0xAA2A2438)),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.lock_rounded,
                                color: Colors.white,
                                size: 36,
                                shadows: [Shadow(color: Colors.black54, offset: Offset(0, 2), blurRadius: 3)],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  loc.t('gallery.locked_msg', {'n': l.number}),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 11.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (widget.isNew)
                        AnimatedBuilder(
                          animation: _shine,
                          builder: (context, _) {
                            final x = -1.5 + _shine.value * 3;
                            return IgnorePointer(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(x - 0.4, -1),
                                    end: Alignment(x + 0.4, 1),
                                    colors: [
                                      Colors.white.withValues(alpha: 0),
                                      Colors.white.withValues(alpha: 0.7),
                                      Colors.white.withValues(alpha: 0),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      if (widget.isNew)
                        Positioned(
                          top: 6,
                          left: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: GameColors.red, borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              loc.t('gallery.new'),
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 11),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
                child: Column(
                  children: [
                    FittedBox(
                      child: Text(
                        loc.t(l.nameKey),
                        style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.ink, fontSize: 16),
                      ),
                    ),
                    if (unlocked)
                      StarDisplay(stars: s.progress.starsOf(l.id), size: 20)
                    else
                      Text(
                        loc.t('common.locked'),
                        style: const TextStyle(fontWeight: FontWeight.w800, color: GameColors.inkSoft, fontSize: 12),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Full view of a restored location with a BEFORE / AFTER toggle.
class GalleryDetailScreen extends StatefulWidget {
  final String levelId;
  const GalleryDetailScreen({super.key, required this.levelId});

  @override
  State<GalleryDetailScreen> createState() => _GalleryDetailScreenState();
}

class _GalleryDetailScreenState extends State<GalleryDetailScreen> {
  late final LevelData? _level = context.services.content.level(widget.levelId);
  bool _after = true;
  RestorationState? _state;
  int _serial = 0;

  @override
  void initState() {
    super.initState();
    if (_level != null) _state = RestorationState.completed(_level);
  }

  @override
  void dispose() {
    _state?.dispose();
    super.dispose();
  }

  void _toggle(bool after) {
    if (after == _after || _level == null) return;
    final old = _state;
    setState(() {
      _after = after;
      _serial++;
      _state = RestorationState(_level);
    });
    // AFTER replays the restoration stage by stage — very satisfying.
    if (after) {
      Future.delayed(const Duration(milliseconds: 250), () {
        if (mounted && _after) {
          _state!.completeAll();
          context.services.audio.play(Sfx.restore);
        }
      });
    }
    // The outgoing scene still fades out using the old state; dispose after.
    Future.delayed(const Duration(milliseconds: 800), () => old?.dispose());
  }

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    final loc = s.loc;
    final l = _level;
    if (l == null || !s.progress.isGalleryUnlocked(l.id)) {
      // Unknown or locked level: fail gracefully back to the gallery.
      return ScreenFrame(
        title: loc.t('gallery.title'),
        child: Center(child: BodyText(loc.t('error.generic'), color: Colors.white)),
      );
    }
    final theme = EnvironmentTheme.of(l.environmentId);
    return ScreenFrame(
      title: loc.t(l.nameKey),
      ribbon: theme.accent,
      colors: [theme.bgTop, theme.bgBottom, Colors.black87],
      child: LayoutBuilder(
        builder: (context, c) {
          final sceneH = min(c.maxWidth * 0.8, c.maxHeight * 0.55);
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
            child: Column(
              children: [
                Container(
                  height: sceneH,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white, width: 5),
                    boxShadow: const [BoxShadow(color: Color(0x88000000), blurRadius: 16, offset: Offset(0, 8))],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(19),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 450),
                      child: SceneView(key: ValueKey(_serial), environmentId: l.environmentId, state: _state!, parallax: true),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                _BeforeAfterToggle(after: _after, onChanged: _toggle),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: GameColors.cream,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: GameColors.panelBorder, width: 4),
                  ),
                  child: Column(
                    children: [
                      GameText(loc.t(l.nameKey), size: 28, color: GameColors.gold),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_circle_rounded, color: GameColors.green, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            loc.t('gallery.completed'),
                            style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.greenDark),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      StarDisplay(stars: s.progress.starsOf(l.id), size: 36, animate: true, arc: true),
                      const SizedBox(height: 6),
                      Text(
                        '${loc.t('gallery.best_score')}: ${s.progress.bestScoreOf(l.id)}',
                        style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.ink, fontSize: 17),
                      ),
                      const SizedBox(height: 14),
                      GameButton(
                        label: loc.t('gallery.replay'),
                        icon: Icons.replay_rounded,
                        width: double.infinity,
                        onTap: () => s.navigator.go(AppScreen.playing, arg: l.id, style: TransitionStyle.zoomIn),
                      ),
                      const SizedBox(height: 8),
                      GameButton.secondary(
                        label: loc.t('common.back'),
                        icon: Icons.arrow_back_rounded,
                        width: double.infinity,
                        onTap: s.navigator.back,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BeforeAfterToggle extends StatelessWidget {
  final bool after;
  final ValueChanged<bool> onChanged;
  const _BeforeAfterToggle({required this.after, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final loc = context.services.loc;
    Widget seg(String label, bool value) => Expanded(
      child: Pressable(
        onTap: () => onChanged(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: after == value ? (value ? GameColors.green : GameColors.orange) : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(child: GameText(label, size: 17, strokeWidth: 3, color: after == value ? Colors.white : Colors.white70)),
        ),
      ),
    );
    return Container(
      constraints: const BoxConstraints(maxWidth: 340),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white, width: 2.5),
      ),
      child: Row(children: [seg(loc.t('gallery.before'), false), seg(loc.t('gallery.after'), true)]),
    );
  }
}
