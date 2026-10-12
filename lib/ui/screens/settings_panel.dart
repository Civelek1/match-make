import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../../app/game_navigator.dart';
import '../theme/game_colors.dart';
import '../widgets/game_button.dart';
import '../widgets/game_panel.dart';
import '../widgets/game_text.dart';
import '../widgets/game_widgets.dart';

/// Settings rows shared by the Settings screen and the in-game pause menu.
class SettingsPanel extends StatelessWidget {
  /// Hide destructive / navigation options while inside a level.
  final bool inGame;
  final VoidCallback? onClose;
  const SettingsPanel({super.key, this.inGame = false, this.onClose});

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    return ListenableBuilder(
      listenable: Listenable.merge([s.settings, s.loc]),
      builder: (context, _) {
        final loc = s.loc;
        return GamePanel(
          // The Settings screen already shows the title in its header.
          title: inGame ? loc.t('settings.title') : null,
          ribbon: GameColors.blue,
          onClose: onClose,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _row(
                Icons.music_note_rounded,
                loc.t('settings.music'),
                GameToggle(value: s.settings.music, onChanged: (v) => s.settings.music = v),
              ),
              _row(
                Icons.volume_up_rounded,
                loc.t('settings.sfx'),
                GameToggle(value: s.settings.sfx, onChanged: (v) => s.settings.sfx = v),
              ),
              _row(
                Icons.vibration_rounded,
                loc.t('settings.vibration'),
                GameToggle(
                  value: s.settings.vibration,
                  onChanged: (v) {
                    s.settings.vibration = v;
                    if (v) s.haptics.special();
                  },
                ),
              ),
              _row(
                Icons.translate_rounded,
                loc.t('settings.language'),
                LanguageSelector(value: s.settings.language, onChanged: (v) => s.settings.language = v),
              ),
              if (!inGame) ...[
                const SizedBox(height: 12),
                GameButton.secondary(
                  label: loc.t('settings.profile'),
                  icon: Icons.person_rounded,
                  tone: ButtonTone.purple,
                  width: double.infinity,
                  onTap: () => s.navigator.go(AppScreen.profile, style: TransitionStyle.slideUp),
                ),
                const SizedBox(height: 8),
                GameButton.secondary(
                  label: loc.t('settings.about'),
                  icon: Icons.info_rounded,
                  tone: ButtonTone.blue,
                  width: double.infinity,
                  onTap: () => _about(context),
                ),
                const SizedBox(height: 8),
                GameButton.secondary(
                  label: loc.t('settings.reset'),
                  icon: Icons.restart_alt_rounded,
                  tone: ButtonTone.red,
                  width: double.infinity,
                  onTap: () => _reset(context),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _row(IconData icon, String label, Widget control) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: GameColors.orange,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: GameColors.orangeDark, width: 2),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: GameColors.ink),
          ),
        ),
        control,
      ],
    ),
  );

  Future<void> _reset(BuildContext context) async {
    final s = context.services;
    final ok = await showConfirmModal(
      context,
      title: s.loc.t('settings.reset_confirm'),
      message: s.loc.t('settings.reset_msg'),
      confirmLabel: s.loc.t('settings.reset_yes'),
      cancelLabel: s.loc.t('common.cancel'),
    );
    if (!ok) return;
    await s.progress.resetProgress();
    s.settings.reload();
    if (context.mounted) {
      showGameToast(context, s.loc.t('settings.reset_done'), icon: Icons.check_circle_rounded);
    }
  }

  void _about(BuildContext context) {
    final s = context.services;
    showGameModal<void>(
      context,
      builder: (ctx) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Material(
            type: MaterialType.transparency,
            child: GamePanel(
              title: s.loc.t('settings.about'),
              ribbon: GameColors.purple,
              onClose: () => Navigator.of(ctx).pop(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const GameText('MATCH MAKE', size: 30, color: GameColors.gold),
                  const SizedBox(height: 10),
                  BodyText(s.loc.t('settings.about_text')),
                  const SizedBox(height: 10),
                  BodyText(s.loc.t('settings.version', {'v': kGameVersion}), color: GameColors.inkSoft, size: 13),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
