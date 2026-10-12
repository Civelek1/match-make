import 'dart:math';

import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../../app/game_navigator.dart';
import '../../audio/audio_service.dart';
import '../../data/models/chapter_data.dart';
import '../../data/models/level_data.dart';
import '../art/paint_kit.dart';
import '../scenes/house_map_art.dart';
import '../theme/chapter_icons.dart';
import '../theme/game_colors.dart';
import '../widgets/economy_widgets.dart';
import '../widgets/game_button.dart';
import '../widgets/game_panel.dart';
import '../widgets/game_text.dart';
import '../widgets/game_widgets.dart';
import 'shop_panel.dart';

/// Illustrated chapter map with level nodes connected by a path.
class ChapterMapScreen extends StatefulWidget {
  final String? chapterId;
  const ChapterMapScreen({super.key, this.chapterId});

  @override
  State<ChapterMapScreen> createState() => _ChapterMapScreenState();
}

class _ChapterMapScreenState extends State<ChapterMapScreen> {
  late String _chapterId;

  @override
  void initState() {
    super.initState();
    final s = context.services;
    _chapterId = widget.chapterId ?? s.progress.currentChapter.id;
    s.audio.playMusic(MusicTrack.menu);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    return ListenableBuilder(
      listenable: Listenable.merge([s.progress, s.loc]),
      builder: (context, _) {
        final chapter = s.content.chapter(_chapterId) ?? s.content.chapters.first;
        final levels = s.content.levelsOf(chapter.id);
        final art = chapterMapArtFor(chapter.mapArtId);
        final completed = {
          for (final l in levels)
            if (s.progress.isCompleted(l.id)) l.id,
        };
        final current = s.progress.currentLevelOf(chapter);
        return Stack(
          fit: StackFit.expand,
          children: [
            if (art != null)
              LayoutBuilder(
                builder: (context, cons) {
                  final layout = MapLayout(Size(cons.maxWidth, cons.maxHeight));
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: ChapterMapView(art: art, completed: completed),
                      ),
                      Positioned.fill(
                        child: IgnorePointer(
                          child: CustomPaint(
                            painter: _PathPainter(
                              [for (final l in levels) layout.toLocal(art.nodes[l.id] ?? Offset.zero)],
                              [for (final l in levels) s.progress.isCompleted(l.id)],
                              layout.scale,
                            ),
                          ),
                        ),
                      ),
                      for (final l in levels)
                        if (art.nodes[l.id] != null)
                          _positionedNode(
                            context,
                            l,
                            layout.toLocal(art.nodes[l.id]!),
                            layout.scale,
                            current?.id == l.id,
                            Size(cons.maxWidth, cons.maxHeight),
                          ),
                    ],
                  );
                },
              ),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                    child: Row(
                      children: [
                        GameIconButton(
                          icon: Icons.home_rounded,
                          tone: ButtonTone.orange,
                          size: 48,
                          semanticLabel: s.loc.t('common.home'),
                          onTap: () => s.navigator.go(AppScreen.mainMenu, style: TransitionStyle.zoomOut),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Center(
                            child: Ribbon(
                              text: '${s.loc.t('chapter.label', {'n': chapter.number})} — ${s.loc.t(chapter.nameKey)}',
                              color: GameColors.orange,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        CounterChip(icon: Icons.star_rounded, text: '${s.progress.chapterStars(chapter)}/${chapter.maxStars}'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
                    child: Align(alignment: Alignment.centerRight, child: CoinChip(onTap: () => showShop(context))),
                  ),
                  const Spacer(),
                  _chapterStrip(context, chapter),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _positionedNode(BuildContext context, LevelData l, Offset p, double scale, bool isCurrent, Size box) {
    final size = (62 * scale).clamp(52.0, 84.0);
    return Positioned(
      left: p.dx - size,
      top: p.dy - size / 2,
      width: size * 2,
      child: LevelNode(
        level: l,
        size: size,
        isCurrent: isCurrent,
        onPlay: () => context.services.navigator.go(
          AppScreen.playing,
          arg: l.id,
          style: TransitionStyle.zoomIn,
          focus: Alignment(p.dx / box.width * 2 - 1, p.dy / box.height * 2 - 1),
        ),
      ),
    );
  }

  Widget _chapterStrip(BuildContext context, ChapterData current) {
    final s = context.services;
    final loc = s.loc;
    String requirement(ChapterData c) {
      final req = c.requiresChapterId == null ? null : s.content.chapter(c.requiresChapterId!);
      return req == null ? loc.t('chapter.locked_msg') : loc.t('chapter.requires', {'name': loc.t(req.nameKey)});
    }

    final cards = <Widget>[
      for (final c in s.content.chapters)
        _ChapterCard(
          title: loc.t(c.nameKey),
          subtitle: loc.t('chapter.label', {'n': c.number}),
          stars: '${s.progress.chapterStars(c)}/${c.maxStars}',
          icon: chapterIcon(c.id),
          note: s.progress.isChapterUnlocked(c) ? null : requirement(c),
          selected: c.id == current.id,
          locked: !s.progress.isChapterUnlocked(c),
          onTap: () {
            if (!s.progress.isChapterUnlocked(c)) {
              showGameToast(
                context,
                loc.t('level.locked_title', {'name': loc.t(c.nameKey)}),
                message: requirement(c),
                icon: Icons.lock_rounded,
              );
              return;
            }
            setState(() => _chapterId = c.id);
          },
        ),
      for (var i = 0; i < s.content.comingSoonChapters; i++)
        _ChapterCard(
          title: loc.t('chapter.coming_soon'),
          subtitle: loc.t('chapter.next'),
          locked: true,
          onTap: () => showGameToast(
            context,
            loc.t('chapter.next'),
            message: loc.t('chapter.coming_soon'),
            icon: Icons.construction_rounded,
          ),
        ),
    ];
    return SizedBox(
      height: 86,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: cards.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (_, i) => Center(child: cards[i]),
      ),
    );
  }
}

class _ChapterCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? stars;
  final bool selected;
  final bool locked;
  final IconData icon;
  final String? note;
  final VoidCallback onTap;
  const _ChapterCard({
    required this.title,
    required this.subtitle,
    this.stars,
    this.icon = Icons.place_rounded,
    this.note,
    this.selected = false,
    this.locked = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      child: Container(
        width: 170,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: locked ? const Color(0xE63E3A50) : GameColors.cream,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? GameColors.gold : (locked ? Colors.white24 : GameColors.panelBorder),
            width: selected ? 4 : 3,
          ),
          boxShadow: const [BoxShadow(color: Color(0x55000000), blurRadius: 8, offset: Offset(0, 4))],
        ),
        child: Row(
          children: [
            Icon(locked ? Icons.lock_rounded : icon, color: locked ? Colors.white70 : GameColors.orange, size: 30),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      letterSpacing: 1,
                      color: locked ? Colors.white60 : GameColors.inkSoft,
                    ),
                  ),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: locked ? Colors.white : GameColors.ink),
                  ),
                  if (note != null)
                    Text(
                      note!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 10, color: Colors.white70, height: 1.15),
                    )
                  else if (stars != null)
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, size: 16, color: GameColors.star),
                        Text(
                          stars!,
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: GameColors.ink),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A level node: locked (dark + padlock), current (pulsing), completed
/// (check + stars). Plays an unlock animation when it just opened.
class LevelNode extends StatefulWidget {
  final LevelData level;
  final double size;
  final bool isCurrent;
  final VoidCallback onPlay;
  const LevelNode({super.key, required this.level, required this.size, required this.isCurrent, required this.onPlay});

  @override
  State<LevelNode> createState() => _LevelNodeState();
}

class _LevelNodeState extends State<LevelNode> with TickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
    ..repeat(reverse: true);
  late final AnimationController _unlock = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100));
  final _shake = ShakeController();
  bool _playingUnlock = false;

  @override
  void initState() {
    super.initState();
    final s = context.services;
    if (s.progress.pendingUnlockAnimation == widget.level.id) {
      _playingUnlock = true;
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!mounted) return;
        s.audio.play(Sfx.unlock);
        s.haptics.special();
        _unlock.forward().whenComplete(() {
          if (!mounted) return;
          s.progress.pendingUnlockAnimation = null;
          setState(() => _playingUnlock = false);
        });
      });
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    _unlock.dispose();
    _shake.dispose();
    super.dispose();
  }

  void _tap() {
    final s = context.services;
    final unlocked = s.progress.isUnlocked(widget.level.id) && !_playingUnlock;
    if (!unlocked) {
      _shake.shake();
      s.audio.play(Sfx.locked);
      s.haptics.error();
      final req = widget.level.unlockRequirement == null ? null : s.content.level(widget.level.unlockRequirement!);
      showGameToast(
        context,
        s.loc.t('level.locked_title', {'name': s.loc.t(widget.level.nameKey)}),
        message: req == null ? s.loc.t('chapter.locked_msg') : s.loc.t('level.locked_msg', {'req': s.loc.t(req.nameKey)}),
        icon: Icons.lock_rounded,
      );
      return;
    }
    s.audio.play(Sfx.click);
    s.haptics.button();
    widget.onPlay();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    final id = widget.level.id;
    final completed = s.progress.isCompleted(id);
    final unlocked = s.progress.isUnlocked(id);
    final showLock = !unlocked || _playingUnlock;
    final stars = s.progress.starsOf(id);
    final size = widget.size;

    final colors = completed
        ? const [Color(0xFF8BE36B), GameColors.green, GameColors.greenDark]
        : unlocked
        ? const [Color(0xFFFFD66B), GameColors.orange, GameColors.orangeDark]
        : const [Color(0xFF9A94AA), Color(0xFF6E6880), Color(0xFF4A4558)];

    return Semantics(
      button: true,
      label: '${s.loc.t(widget.level.nameKey)} ${showLock ? s.loc.t('common.locked') : ''}',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _tap,
        child: Shake(
          controller: _shake,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: Listenable.merge([_pulse, _unlock]),
                builder: (context, child) {
                  final pulse = widget.isCurrent && !showLock ? 1 + 0.07 * _pulse.value : 1.0;
                  final u = _unlock.value;
                  final unlockPop = _playingUnlock ? 1 + 0.25 * sin(u * pi) : 1.0;
                  return Transform.scale(scale: pulse * unlockPop, child: child);
                },
                child: SizedBox(
                  width: size * 1.3,
                  height: size * 1.2,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      if (widget.isCurrent && !showLock)
                        AnimatedBuilder(
                          animation: _pulse,
                          builder: (context, _) => Container(
                            width: size * (1.15 + 0.2 * _pulse.value),
                            height: size * (1.15 + 0.2 * _pulse.value),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: GameColors.gold.withValues(alpha: 0.45 * (1 - _pulse.value * 0.6)),
                            ),
                          ),
                        ),
                      Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: colors.sublist(0, 2),
                          ),
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(color: colors[2], offset: const Offset(0, 5)),
                            const BoxShadow(color: Color(0x66000000), blurRadius: 8, offset: Offset(0, 8)),
                          ],
                        ),
                        child: Center(
                          child: completed
                              ? Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: size * 0.6,
                                  shadows: const [Shadow(color: GameColors.greenDark, offset: Offset(0, 2))],
                                )
                              : GameText('${widget.level.number}', size: size * 0.45, strokeWidth: 4, stroke: colors[2]),
                        ),
                      ),
                      if (showLock)
                        AnimatedBuilder(
                          animation: _unlock,
                          builder: (context, _) {
                            final u = _unlock.value;
                            return Positioned(
                              right: size * 0.02,
                              bottom: size * 0.0 - u * size * 0.6,
                              child: Opacity(
                                opacity: (1 - u).clamp(0, 1),
                                child: Transform.rotate(
                                  angle: u * 1.2,
                                  child: Icon(
                                    u > 0.2 ? Icons.lock_open_rounded : Icons.lock_rounded,
                                    color: GameColors.gold,
                                    size: size * 0.5,
                                    shadows: const [Shadow(color: GameColors.ink, offset: Offset(0, 2), blurRadius: 2)],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      if (_playingUnlock)
                        AnimatedBuilder(
                          animation: _unlock,
                          builder: (context, _) => IgnorePointer(
                            child: CustomPaint(size: Size(size * 2, size * 2), painter: _BurstPainter(_unlock.value)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (completed) StarDisplay(stars: stars, size: size * 0.3),
              Container(
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: showLock ? const Color(0xCC3E3A50) : const Color(0xE6FFFFFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  s.loc.t(widget.level.nameKey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: (size * 0.2).clamp(11, 15),
                    color: showLock ? Colors.white : GameColors.ink,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BurstPainter extends CustomPainter {
  final double t;
  _BurstPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    if (t <= 0.15) return;
    final k = ((t - 0.15) / 0.85).clamp(0.0, 1.0);
    final c = size.center(Offset.zero);
    for (var i = 0; i < 12; i++) {
      final a = i * pi / 6;
      final p = c + Offset(cos(a), sin(a)) * size.width * 0.5 * Curves.easeOut.transform(k);
      Pk.sparkle(canvas, p, 7 * (1 - k), (i.isEven ? GameColors.gold : Colors.white).withValues(alpha: 1 - k));
    }
  }

  @override
  bool shouldRepaint(_BurstPainter old) => old.t != t;
}

/// Dotted path between nodes; completed segments glow gold.
class _PathPainter extends CustomPainter {
  final List<Offset> points;
  final List<bool> completed;
  final double scale;
  _PathPainter(this.points, this.completed, this.scale);

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < points.length - 1; i++) {
      final a = points[i], b = points[i + 1];
      final done = completed[i];
      final dist = (b - a).distance;
      final n = (dist / (14 * scale)).floor();
      for (var k = 1; k < n; k++) {
        final p = Offset.lerp(a, b, k / n)!;
        canvas.drawCircle(p, 5 * scale, Paint()..color = Colors.black.withValues(alpha: 0.25));
        canvas.drawCircle(p, 4 * scale, Paint()..color = done ? GameColors.gold : Colors.white.withValues(alpha: 0.85));
      }
    }
  }

  @override
  bool shouldRepaint(_PathPainter old) => true;
}
