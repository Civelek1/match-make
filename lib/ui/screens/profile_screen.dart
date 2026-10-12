import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../theme/game_colors.dart';
import '../widgets/game_button.dart';
import '../widgets/game_panel.dart';
import '../widgets/game_text.dart';
import '../widgets/game_widgets.dart';
import '../widgets/screen_frame.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _name = TextEditingController(text: context.services.profile.name);
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      if (!_focus.hasFocus) _commit();
    });
  }

  void _commit() {
    final p = context.services.profile;
    if (_name.text.trim() != p.name) p.name = _name.text;
  }

  @override
  void dispose() {
    _commit();
    _name.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    final loc = s.loc;
    return ListenableBuilder(
      listenable: Listenable.merge([s.profile, s.progress, s.loc]),
      builder: (context, _) => ScreenFrame(
        title: loc.t('profile.title'),
        ribbon: GameColors.purple,
        colors: const [Color(0xFF6A5CFF), Color(0xFF9B6BFF), Color(0xFFFFB8E0)],
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            // Keep the name field above the on-screen keyboard.
            padding: EdgeInsets.fromLTRB(16, 12, 16, 24 + MediaQuery.viewInsetsOf(context).bottom),
            child: Center(
              child: GamePanel(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ProfileAvatar(avatarId: s.profile.avatarId, size: 96, selected: true),
                    const SizedBox(height: 8),
                    GameText(s.playerName(), size: 26, color: GameColors.gold),
                    const SizedBox(height: 14),
                    _label(loc.t('profile.name')),
                    TextField(
                      controller: _name,
                      focusNode: _focus,
                      maxLength: 16,
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _commit(),
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: GameColors.ink),
                      decoration: InputDecoration(
                        hintText: loc.t('profile.name_hint'),
                        counterText: '',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: GameColors.panelBorder, width: 3),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: GameColors.panelBorder, width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: GameColors.orange, width: 3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    _label(loc.t('profile.avatar')),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        for (final a in avatars)
                          Pressable(
                            onTap: () => s.profile.avatarId = a.id,
                            child: AnimatedScale(
                              scale: a.id == s.profile.avatarId ? 1.12 : 1,
                              duration: const Duration(milliseconds: 200),
                              child: ProfileAvatar(avatarId: a.id, size: 56, selected: a.id == s.profile.avatarId),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _stat(Icons.star_rounded, GameColors.star, loc.t('profile.total_stars'), '${s.progress.totalStars}'),
                    _stat(
                      Icons.emoji_events_rounded,
                      GameColors.orange,
                      loc.t('profile.total_score'),
                      '${s.progress.totalScore}',
                    ),
                    _stat(
                      Icons.check_circle_rounded,
                      GameColors.green,
                      loc.t('profile.levels_completed'),
                      '${s.progress.levelsCompleted} / ${s.content.allLevels.length}',
                    ),
                    _stat(
                      Icons.house_rounded,
                      GameColors.blue,
                      loc.t('profile.current_chapter'),
                      loc.t(s.progress.currentChapter.nameKey),
                    ),
                    const SizedBox(height: 12),
                    GameButton.secondary(
                      label: loc.t('common.back'),
                      icon: Icons.arrow_back_rounded,
                      width: double.infinity,
                      onTap: s.navigator.back,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      t,
      style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.inkSoft, letterSpacing: 1.5, fontSize: 12),
    ),
  );

  Widget _stat(IconData icon, Color color, String label, String value) => Container(
    margin: const EdgeInsets.symmetric(vertical: 3),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
    child: Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w800, color: GameColors.ink),
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.purpleDark, fontSize: 16),
        ),
      ],
    ),
  );
}
