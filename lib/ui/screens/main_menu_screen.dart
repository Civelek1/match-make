import 'dart:math';

import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../../app/game_navigator.dart';
import '../../audio/audio_service.dart';
import '../debug/debug_panel.dart';
import '../scenes/house_map_art.dart';
import '../theme/chapter_icons.dart';
import '../theme/game_colors.dart';
import '../widgets/confetti.dart';
import '../widgets/economy_widgets.dart';
import '../widgets/game_button.dart';
import '../widgets/game_text.dart';
import '../widgets/game_widgets.dart';
import '../widgets/logo.dart';
import 'daily_reward_panel.dart';
import 'shop_panel.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  void initState() {
    super.initState();
    context.services.audio.playMusic(MusicTrack.menu);
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybePromptDaily());
  }

  /// Returning players see the calendar once per session while a reward is
  /// waiting (never on the very first launch, before any level is played).
  void _maybePromptDaily() {
    if (!mounted) return;
    final s = context.services;
    if (s.daily.promptedThisSession || !s.daily.canClaim || s.progress.levelsCompleted == 0) return;
    s.daily.promptedThisSession = true;
    showDailyReward(context);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    return ListenableBuilder(
      listenable: Listenable.merge([s.progress, s.loc, s.profile]),
      builder: (context, _) {
        final loc = s.loc;
        final chapter = s.progress.currentChapter;
        final done = s.progress.chapterCompletedCount(chapter);
        final completedIds = {
          for (final id in chapter.levelIds)
            if (s.progress.isCompleted(id)) id,
        };
        final art = chapterMapArtFor(chapter.mapArtId);
        final allDone = done == chapter.levelIds.length;
        return Stack(
          fit: StackFit.expand,
          children: [
            if (art != null)
              Transform.translate(
                offset: const Offset(0, 40),
                child: Transform.scale(
                  scale: 1.08,
                  child: ChapterMapView(art: art, completed: completedIds),
                ),
              ),
            // Legibility gradients.
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x66000000), Color(0x00000000), Color(0x00000000), Color(0x88000000)],
                  stops: [0, 0.3, 0.55, 1],
                ),
              ),
            ),
            if (allDone) const IgnorePointer(child: _SoftConfetti()),
            SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Flexible(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Pressable(
                                  onTap: () => s.navigator.go(AppScreen.profile, style: TransitionStyle.slideUp),
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(4, 4, 14, 4),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.35),
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Colors.white.withValues(alpha: 0.7), width: 2),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ProfileAvatar(avatarId: s.profile.avatarId, size: 40),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(maxWidth: 130),
                                            child: GameText(s.playerName(), size: 16, strokeWidth: 3, maxLines: 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (kDebugTools)
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: GameIconButton(
                                  icon: Icons.bug_report_rounded,
                                  tone: ButtonTone.cream,
                                  size: 40,
                                  onTap: () => showDebugPanel(context),
                                ),
                              ),
                            CoinChip(onTap: () => showShop(context)),
                            const SizedBox(width: 8),
                            CounterChip(icon: Icons.star_rounded, text: '${s.progress.totalStars}'),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Stack(
                          children: [
                            Center(
                              child: LayoutBuilder(builder: (context, c) => MatchMakeLogo(width: min(c.maxWidth * 0.7, 330))),
                            ),
                            const Positioned(left: 0, top: 6, child: DailyButton()),
                          ],
                        ),
                        if (allDone)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: GameText(loc.t('menu.all_restored'), size: 22, color: GameColors.gold),
                          ),
                        const Spacer(),
                        _chapterCard(
                          context,
                          chapter.id,
                          loc.t(chapter.nameKey),
                          loc.t('chapter.label', {'n': chapter.number}),
                          done,
                          chapter.levelIds.length,
                          s.progress.chapterStars(chapter),
                          chapter.maxStars,
                        ),
                        const SizedBox(height: 12),
                        _PulsingPlay(
                          child: GameButton.primary(
                            label: loc.t('menu.play'),
                            icon: Icons.play_arrow_rounded,
                            width: double.infinity,
                            onTap: () => s.navigator.go(AppScreen.chapterMap, arg: chapter.id, style: TransitionStyle.zoomIn),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            if (kLeaderboardEnabled) ...[
                              Expanded(
                                child: _MenuTile(
                                  icon: Icons.emoji_events_rounded,
                                  label: loc.t('menu.leaderboard'),
                                  tone: ButtonTone.orange,
                                  onTap: () => s.navigator.go(AppScreen.leaderboard, style: TransitionStyle.slideUp),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                            Expanded(
                              child: _MenuTile(
                                icon: Icons.photo_library_rounded,
                                label: loc.t('menu.gallery'),
                                tone: ButtonTone.purple,
                                onTap: () => s.navigator.go(AppScreen.gallery, style: TransitionStyle.slideUp),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _MenuTile(
                                icon: Icons.shopping_basket_rounded,
                                label: loc.t('menu.shop'),
                                tone: ButtonTone.green,
                                onTap: () => showShop(context),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _MenuTile(
                                icon: Icons.settings_rounded,
                                label: loc.t('menu.settings'),
                                tone: ButtonTone.blue,
                                onTap: () => s.navigator.go(AppScreen.settings, style: TransitionStyle.slideUp),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _chapterCard(BuildContext context, String chapterId, String name, String label, int done, int total, int stars, int maxStars) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
      decoration: BoxDecoration(
        color: GameColors.cream.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: GameColors.panelBorder, width: 4),
        boxShadow: const [BoxShadow(color: Color(0x55000000), blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(chapterIcon(chapterId), color: GameColors.orange, size: 30),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.inkSoft, fontSize: 11, letterSpacing: 1.5),
                    ),
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.ink, fontSize: 20),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.star_rounded, color: GameColors.star, size: 24),
              Text(
                '$stars/$maxStars',
                style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.ink, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 8),
          GameProgressBar(value: done / total, height: 20, label: '$done / $total', track: const Color(0x33000000)),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final ButtonTone tone;
  final VoidCallback onTap;
  const _MenuTile({required this.icon, required this.label, required this.tone, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // The whole tile (icon + label) is tappable.
    return Semantics(
      button: true,
      label: label,
      child: Pressable(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IgnorePointer(
              child: GameIconButton(icon: icon, tone: tone, size: 62, onTap: onTap),
            ),
            const SizedBox(height: 6),
            FittedBox(child: GameText(label, size: 14, strokeWidth: 3)),
          ],
        ),
      ),
    );
  }
}

/// Gentle breathing to draw the eye to PLAY.
class _PulsingPlay extends StatefulWidget {
  final Widget child;
  const _PulsingPlay({required this.child});

  @override
  State<_PulsingPlay> createState() => _PulsingPlayState();
}

class _PulsingPlayState extends State<_PulsingPlay> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
    scale: Tween(begin: 1.0, end: 1.035).animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut)),
    child: widget.child,
  );
}

class _SoftConfetti extends StatelessWidget {
  const _SoftConfetti();

  @override
  Widget build(BuildContext context) => const Opacity(opacity: 0.6, child: Confetti(count: 40, loop: true));
}
