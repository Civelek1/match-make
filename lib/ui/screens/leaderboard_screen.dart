import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../../leaderboard/leaderboard_service.dart';
import '../theme/game_colors.dart';
import '../widgets/game_button.dart';
import '../widgets/game_text.dart';
import '../widgets/game_widgets.dart';
import '../widgets/screen_frame.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

enum _Status { loading, ready, offline, error }

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  LeaderboardCategory _cat = LeaderboardCategory.global;
  _Status _status = _Status.loading;
  LeaderboardPage? _page;
  int _request = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final s = context.services;
    final id = ++_request;
    setState(() => _status = _Status.loading);
    final me = PlayerSnapshot(
      name: s.playerName(),
      avatarId: s.profile.avatarId,
      score: s.progress.totalScore,
      stars: s.progress.totalStars,
    );
    try {
      final page = await s.leaderboard.fetch(_cat, me);
      if (!mounted || id != _request) return;
      setState(() {
        _page = page;
        _status = _Status.ready;
      });
    } on LeaderboardOfflineException {
      if (mounted && id == _request) setState(() => _status = _Status.offline);
    } catch (_) {
      if (mounted && id == _request) setState(() => _status = _Status.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.services.loc;
    return ScreenFrame(
      title: loc.t('lb.title'),
      ribbon: GameColors.orange,
      colors: const [Color(0xFFFFB347), Color(0xFFFF8A65), Color(0xFFB36BFF)],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              children: [
                for (final c in LeaderboardCategory.values)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: _Tab(
                        label: loc.t('lb.${c.name}'),
                        selected: c == _cat,
                        onTap: () {
                          if (c == _cat) return;
                          _cat = c;
                          _load();
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(child: _body(context)),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    final loc = context.services.loc;
    switch (_status) {
      case _Status.loading:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 44, height: 44, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 5)),
              const SizedBox(height: 12),
              GameText(loc.t('lb.loading'), size: 16, strokeWidth: 3),
            ],
          ),
        );
      case _Status.offline:
      case _Status.error:
        final offline = _status == _Status.offline;
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: GameColors.cream,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: GameColors.panelBorder, width: 4),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(offline ? Icons.wifi_off_rounded : Icons.cloud_off_rounded, size: 60, color: GameColors.orange),
                  const SizedBox(height: 8),
                  GameText(offline ? loc.t('lb.offline') : loc.t('lb.error'), size: 22, color: GameColors.gold),
                  const SizedBox(height: 8),
                  BodyText(loc.t('lb.offline_msg')),
                  const SizedBox(height: 16),
                  GameButton.secondary(
                    label: loc.t('common.retry'),
                    icon: Icons.refresh_rounded,
                    tone: ButtonTone.green,
                    onTap: _load,
                  ),
                  const SizedBox(height: 8),
                  GameButton.secondary(
                    label: loc.t('common.back'),
                    icon: Icons.arrow_back_rounded,
                    onTap: context.services.navigator.back,
                  ),
                ],
              ),
            ),
          ),
        );
      case _Status.ready:
        final page = _page!;
        final playerVisible = page.player.rank <= 12;
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                itemCount: page.entries.length,
                itemBuilder: (context, i) => TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: Duration(milliseconds: 300 + (i.clamp(0, 10)) * 45),
                  curve: Curves.easeOutCubic,
                  builder: (context, v, child) => Opacity(
                    opacity: v,
                    child: Transform.translate(offset: Offset(40 * (1 - v), 0), child: child),
                  ),
                  child: LeaderboardRow(entry: page.entries[i], youLabel: loc.t('lb.you')),
                ),
              ),
            ),
            if (!playerVisible)
              Container(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                decoration: const BoxDecoration(
                  color: Color(0x55000000),
                  border: Border(top: BorderSide(color: Colors.white54, width: 2)),
                ),
                child: LeaderboardRow(entry: page.player, youLabel: loc.t('lb.you')),
              ),
          ],
        );
    }
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _Tab({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) => Pressable(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: selected ? GameColors.cream : Colors.black.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: selected ? GameColors.panelBorder : Colors.white54, width: 3),
      ),
      child: Center(
        child: FittedBox(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: selected ? GameColors.ink : Colors.white),
          ),
        ),
      ),
    ),
  );
}

class LeaderboardRow extends StatelessWidget {
  final LeaderboardEntry entry;
  final String youLabel;
  const LeaderboardRow({super.key, required this.entry, required this.youLabel});

  @override
  Widget build(BuildContext context) {
    final e = entry;
    final medal = switch (e.rank) {
      1 => const Color(0xFFFFC93C),
      2 => const Color(0xFFC9D2E0),
      3 => const Color(0xFFE39A5C),
      _ => null,
    };
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: e.isPlayer ? const Color(0xFFFFF0B8) : GameColors.cream,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: e.isPlayer ? GameColors.gold : GameColors.panelBorder, width: e.isPlayer ? 4 : 2.5),
        boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 4, offset: Offset(0, 3))],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: medal != null
                ? Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: medal,
                      border: Border.all(color: Colors.white, width: 2.5),
                    ),
                    child: Center(child: GameText('${e.rank}', size: 16, strokeWidth: 3)),
                  )
                : Center(
                    child: Text(
                      '${e.rank}',
                      style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.inkSoft, fontSize: 16),
                    ),
                  ),
          ),
          const SizedBox(width: 6),
          ProfileAvatar(avatarId: e.avatarId, size: 38, selected: e.isPlayer),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.isPlayer ? '${e.name} ($youLabel)' : e.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.ink, fontSize: 15),
                ),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, size: 15, color: GameColors.star),
                    Text(
                      '${e.stars}',
                      style: const TextStyle(fontWeight: FontWeight.w800, color: GameColors.inkSoft, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            _fmt(e.score),
            style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.purpleDark, fontSize: 17),
          ),
        ],
      ),
    );
  }

  static String _fmt(int v) {
    final s = v.toString();
    final b = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
      b.write(s[i]);
    }
    return b.toString();
  }
}
