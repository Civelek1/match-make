import 'dart:math';

import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../../audio/audio_service.dart';
import '../../economy/economy_config.dart';
import '../theme/game_colors.dart';
import '../widgets/confetti.dart';
import '../widgets/economy_widgets.dart';
import '../widgets/game_button.dart';
import '../widgets/game_panel.dart';
import '../widgets/game_text.dart';
import '../widgets/game_widgets.dart';

/// Seven-day login calendar with today's reward to claim.
Future<void> showDailyReward(BuildContext context) {
  return showGameModal<void>(
    context,
    builder: (ctx) => Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Material(
          type: MaterialType.transparency,
          child: _DailyPanel(onClose: () => Navigator.of(ctx).pop()),
        ),
      ),
    ),
  );
}

class _DailyPanel extends StatefulWidget {
  final VoidCallback onClose;
  const _DailyPanel({required this.onClose});

  @override
  State<_DailyPanel> createState() => _DailyPanelState();
}

class _DailyPanelState extends State<_DailyPanel> {
  DailyReward? _justClaimed;

  void _claim() {
    final s = context.services;
    final r = s.daily.claim();
    if (r == null) return;
    s.audio.play(Sfx.galleryUnlock);
    s.haptics.success();
    setState(() => _justClaimed = r);
  }

  Future<void> _double() async {
    final s = context.services;
    final r = await s.monetization.doubleDaily();
    if (!mounted) return;
    if (r == null) {
      showGameToast(context, s.loc.t('ad.unavailable'));
      return;
    }
    s.audio.play(Sfx.galleryUnlock);
    s.haptics.success();
    showGameToast(context, s.loc.t('daily.doubled'), icon: Icons.check_circle_rounded);
    setState(() => _justClaimed = r);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    final loc = s.loc;
    final daily = s.daily;
    return ListenableBuilder(
      listenable: daily,
      builder: (context, _) {
        final today = daily.todayIndex;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            GamePanel(
              title: loc.t('daily.title'),
              ribbon: GameColors.orange,
              onClose: widget.onClose,
              maxWidth: 420,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    loc.t('daily.tip'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w700, color: GameColors.inkSoft, fontSize: 12.5, height: 1.3),
                  ),
                  const SizedBox(height: 12),
                  LayoutBuilder(
                    builder: (context, cons) {
                      final w = (cons.maxWidth - 3 * 8) / 4;
                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: [
                          for (var i = 0; i < daily.rewards.length; i++)
                            SizedBox(
                              width: i == daily.rewards.length - 1 ? w * 2 + 8 : w,
                              child: _DaySlot(
                                day: i + 1,
                                reward: daily.rewards[i],
                                collected: daily.isCollected(i),
                                today: i == today && daily.canClaim,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  if (daily.canClaim)
                    GameButton.primary(label: loc.t('daily.claim'), icon: Icons.card_giftcard_rounded, width: 240, onTap: _claim)
                  else ...[
                    if (_justClaimed != null) _ClaimedLine(reward: _justClaimed!),
                    const SizedBox(height: 6),
                    Text(
                      loc.t('daily.claimed'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w800, color: GameColors.ink, fontSize: 14),
                    ),
                    ListenableBuilder(
                      listenable: s.monetization,
                      builder: (context, _) {
                        final m = s.monetization;
                        if (!m.canDoubleDaily || !m.adRewardsAvailable) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GameButton.secondary(
                            label: loc.t(m.noAds ? 'daily.double_vip' : 'daily.double'),
                            icon: m.noAds ? Icons.card_giftcard_rounded : Icons.smart_display_rounded,
                            tone: ButtonTone.purple,
                            width: 240,
                            onTap: _double,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    GameButton.secondary(label: loc.t('common.ok'), tone: ButtonTone.green, width: 200, onTap: widget.onClose),
                  ],
                ],
              ),
            ),
            if (_justClaimed != null) const Positioned.fill(child: IgnorePointer(child: Confetti(count: 50))),
          ],
        );
      },
    );
  }
}

class _DaySlot extends StatefulWidget {
  final int day;
  final DailyReward reward;
  final bool collected;
  final bool today;
  const _DaySlot({required this.day, required this.reward, required this.collected, required this.today});

  @override
  State<_DaySlot> createState() => _DaySlotState();
}

class _DaySlotState extends State<_DaySlot> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100));

  @override
  void initState() {
    super.initState();
    if (widget.today) _pulse.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(_DaySlot old) {
    super.didUpdateWidget(old);
    if (widget.today && !_pulse.isAnimating) {
      _pulse.repeat(reverse: true);
    } else if (!widget.today && _pulse.isAnimating) {
      _pulse.stop();
      _pulse.value = 0;
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.services.loc;
    final r = widget.reward;
    final big = widget.day == 7;
    final border = widget.today ? GameColors.orange : (widget.collected ? GameColors.green : GameColors.creamDark);
    return Semantics(
      label: '${loc.t('daily.day', {'n': widget.day})}${widget.collected ? ' ✓' : ''}',
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (context, child) => Transform.scale(scale: 1 + 0.05 * sin(_pulse.value * pi / 2), child: child),
        child: Container(
          height: 92,
          padding: const EdgeInsets.fromLTRB(4, 4, 4, 6),
          decoration: BoxDecoration(
            color: widget.collected ? const Color(0xFFEAFBE3) : (big ? const Color(0xFFFFF0C2) : Colors.white),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: border, width: widget.today ? 3.5 : 2),
            boxShadow: [if (widget.today) BoxShadow(color: GameColors.orange.withValues(alpha: 0.5), blurRadius: 10)],
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Text(
                    loc.t('daily.day', {'n': widget.day}),
                    style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.inkSoft, fontSize: 11, letterSpacing: 0.5),
                  ),
                  Expanded(
                    child: Opacity(
                      opacity: widget.collected ? 0.45 : 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (r.coins > 0) CoinIcon(size: big ? 34 : 30),
                          if (r.coins > 0 && r.booster != null) const SizedBox(width: 6),
                          if (r.booster != null) BoosterIcon(r.booster!, size: big ? 36 : 32),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    [if (r.coins > 0) '${r.coins}', if (r.booster != null) '${r.boosterCount}×'].join(' + '),
                    style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.ink, fontSize: 13),
                  ),
                ],
              ),
              if (widget.collected)
                const Positioned(right: 0, top: 0, child: Icon(Icons.check_circle_rounded, color: GameColors.green, size: 22)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClaimedLine extends StatelessWidget {
  final DailyReward reward;
  const _ClaimedLine({required this.reward});

  @override
  Widget build(BuildContext context) {
    final loc = context.services.loc;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (reward.coins > 0) CoinReward(amount: reward.coins, size: 28),
        if (reward.coins > 0 && reward.booster != null) const SizedBox(width: 14),
        if (reward.booster != null) ...[
          BoosterIcon(reward.booster!, size: 30),
          const SizedBox(width: 6),
          GameText('+${reward.boosterCount} ${loc.t(reward.booster!.nameKey)}', size: 18, color: GameColors.gold, strokeWidth: 3),
        ],
      ],
    );
  }
}

/// Main-menu calendar button with a red dot while a reward is waiting.
class DailyButton extends StatelessWidget {
  const DailyButton({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    return ListenableBuilder(
      listenable: s.daily,
      builder: (context, _) => Semantics(
        button: true,
        label: s.loc.t('daily.title'),
        excludeSemantics: true,
        child: Pressable(
          onTap: () => showDailyReward(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  IgnorePointer(
                    child: GameIconButton(icon: Icons.calendar_month_rounded, tone: ButtonTone.orange, size: 52, onTap: () {}),
                  ),
                  if (s.daily.canClaim)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: GameColors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.5),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              GameText(s.loc.t('menu.daily'), size: 12, strokeWidth: 3),
            ],
          ),
        ),
      ),
    );
  }
}
