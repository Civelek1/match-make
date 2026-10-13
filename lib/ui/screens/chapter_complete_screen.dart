import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../../app/game_navigator.dart';
import '../../audio/audio_service.dart';
import '../scenes/house_map_art.dart';
import '../theme/chapter_icons.dart';
import '../theme/game_colors.dart';
import '../widgets/confetti.dart';
import '../widgets/game_button.dart';
import '../widgets/game_panel.dart';
import '../widgets/game_text.dart';

/// "HOUSE RESTORED!" celebration with the fully restored map and a teaser.
class ChapterCompleteScreen extends StatefulWidget {
  final String chapterId;
  const ChapterCompleteScreen({super.key, required this.chapterId});

  @override
  State<ChapterCompleteScreen> createState() => _ChapterCompleteScreenState();
}

class _ChapterCompleteScreenState extends State<ChapterCompleteScreen> {
  @override
  void initState() {
    super.initState();
    final s = context.services;
    s.audio.playMusic(MusicTrack.menu);
    s.audio.play(Sfx.levelComplete);
    s.haptics.success();
    s.progress.markChapterCelebrated(widget.chapterId);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    final loc = s.loc;
    final chapter = s.content.chapter(widget.chapterId) ?? s.content.chapters.first;
    final art = chapterMapArtFor(chapter.mapArtId);
    final done = s.progress.chapterCompletedCount(chapter);
    final total = chapter.levelIds.length;
    final idx = s.content.chapters.indexOf(chapter);
    final next = idx >= 0 && idx + 1 < s.content.chapters.length ? s.content.chapters[idx + 1] : null;
    final nextOpen = next != null && s.progress.isChapterUnlocked(next);
    return Stack(
      fit: StackFit.expand,
      children: [
        if (art != null) ChapterMapView(art: art, completed: chapter.levelIds.toSet(), celebrate: true),
        const ColoredBox(color: Color(0x33000000)),
        const IgnorePointer(child: Confetti(count: 120, loop: true)),
        SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.5, end: 1),
                duration: const Duration(milliseconds: 700),
                curve: Curves.elasticOut,
                builder: (context, v, child) => Transform.scale(scale: v, child: child),
                child: GamePanel(
                  title: loc.t('chapter.complete'),
                  ribbon: GameColors.green,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GameText(
                        loc.t('chapter.restored_title', {'name': loc.t(chapter.nameKey)}),
                        size: 34,
                        color: GameColors.gold,
                      ),
                      const SizedBox(height: 6),
                      BodyText(loc.t('chapter.areas_completed', {'done': done, 'total': total}), size: 18),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star_rounded, color: GameColors.star, size: 34),
                          GameText('${s.progress.chapterStars(chapter)} / ${chapter.maxStars}', size: 24),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF3E3A50), Color(0xFF5A4F7A)]),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.white54, width: 2),
                        ),
                        child: Column(
                          children: [
                            Text(
                              loc.t('chapter.next'),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Icon(nextOpen ? chapterIcon(next.id) : Icons.lock_clock_rounded, color: Colors.white, size: 36),
                            GameText(
                              nextOpen ? loc.t('chapter.next_open', {'name': loc.t(next.nameKey)}) : loc.t('chapter.coming_soon'),
                              size: 22,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      if (nextOpen) ...[
                        const SizedBox(height: 16),
                        GameButton.primary(
                          label: loc.t('chapter.play_next'),
                          icon: Icons.arrow_forward_rounded,
                          width: double.infinity,
                          onTap: () => s.navigator.go(AppScreen.chapterMap, arg: next.id, style: TransitionStyle.zoomIn),
                        ),
                      ],
                      const SizedBox(height: 16),
                      GameButton(
                        label: loc.t('menu.gallery'),
                        icon: Icons.photo_library_rounded,
                        tone: ButtonTone.purple,
                        width: double.infinity,
                        onTap: () => s.navigator.go(AppScreen.gallery, style: TransitionStyle.slideUp),
                      ),
                      const SizedBox(height: 8),
                      GameButton.secondary(
                        label: loc.t('common.home'),
                        icon: Icons.home_rounded,
                        width: double.infinity,
                        onTap: () => s.navigator.go(AppScreen.mainMenu, style: TransitionStyle.zoomOut),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
