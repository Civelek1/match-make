import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../../leaderboard/leaderboard_service.dart';
import '../theme/game_colors.dart';
import '../widgets/game_button.dart';
import '../widgets/game_panel.dart';
import '../widgets/game_widgets.dart';

/// Development-only tools. Only reachable when [kDebugTools] is true
/// (debug builds or `--dart-define=MM_DEBUG=true`).
Future<void> showDebugPanel(BuildContext context) {
  if (!kDebugTools) return Future.value();
  return showGameModal<void>(context, builder: (ctx) => const _DebugPanel());
}

class _DebugPanel extends StatelessWidget {
  const _DebugPanel();

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Material(
          type: MaterialType.transparency,
          child: ListenableBuilder(
            listenable: s.progress,
            builder: (context, _) => GamePanel(
              title: s.loc.t('debug.title'),
              ribbon: GameColors.ink,
              onClose: () => Navigator.of(context).pop(),
              maxWidth: 480,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.72),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        alignment: WrapAlignment.center,
                        children: [
                          _chip('Add Stars', s.progress.debugAddStars),
                          _chip('Unlock All', () {
                            for (final c in s.content.chapters) {
                              s.progress.debugUnlockChapter(c.id);
                              for (final id in c.levelIds) {
                                s.progress.debugUnlock(id);
                              }
                            }
                          }),
                          _chip('Complete All', () {
                            for (final l in s.content.allLevels) {
                              s.progress.debugComplete(l.id);
                            }
                          }),
                          _chip('Reset Save', () async {
                            await s.progress.resetProgress();
                            if (context.mounted) showGameToast(context, 'Save reset');
                          }),
                          if (s.leaderboard is MockLeaderboardService)
                            _chip(
                              (s.leaderboard as MockLeaderboardService).simulateOffline ? 'Leaderboard: OFFLINE' : 'Leaderboard: online',
                              () {
                                final m = s.leaderboard as MockLeaderboardService;
                                m.simulateOffline = !m.simulateOffline;
                                s.progress.refresh();
                              },
                            ),
                        ],
                      ),
                      for (final c in s.content.chapters) ...[
                        const Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${c.number}. ${s.loc.t(c.nameKey)}  ${s.progress.isChapterUnlocked(c) ? 'open' : 'locked'}',
                                style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.ink, fontSize: 14),
                              ),
                            ),
                            _chip('Unlock Chapter', () => s.progress.debugUnlockChapter(c.id)),
                            _chip('Complete Chapter', () {
                              for (final id in c.levelIds) {
                                s.progress.debugComplete(id);
                              }
                            }),
                          ],
                        ),
                        for (final l in s.content.levelsOf(c.id))
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${l.number}. ${s.loc.t(l.nameKey)}  '
                                    '${s.progress.isCompleted(l.id) ? '✓${s.progress.starsOf(l.id)}★' : (s.progress.isUnlocked(l.id) ? 'open' : 'locked')}',
                                    style: const TextStyle(fontWeight: FontWeight.w700, color: GameColors.ink, fontSize: 12.5),
                                  ),
                                ),
                                _chip('Unlock', () => s.progress.debugUnlock(l.id)),
                                _chip('Lock', () => s.progress.debugLock(l.id)),
                                _chip('Complete', () => s.progress.debugComplete(l.id)),
                              ],
                            ),
                          ),
                      ],
                      const SizedBox(height: 8),
                      const Text(
                        'Test Win / Test Lose / Shuffle are in the in-level pause menu.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: GameColors.inkSoft),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _chip(String label, VoidCallback onTap) => Padding(
    padding: const EdgeInsets.only(left: 4),
    child: Pressable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
        decoration: BoxDecoration(color: GameColors.ink, borderRadius: BorderRadius.circular(9)),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 11),
        ),
      ),
    ),
  );
}
