import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../theme/game_colors.dart';
import 'game_button.dart';
import 'game_panel.dart';
import 'logo.dart';

/// Standard menu screen: animated backdrop, back button, ribbon title,
/// safe-area aware and width-capped for tablets.
class ScreenFrame extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Color>? colors;
  final Color ribbon;
  final Widget? trailing;
  final VoidCallback? onBack;

  const ScreenFrame({
    super.key,
    required this.title,
    required this.child,
    this.colors,
    this.ribbon = GameColors.orange,
    this.trailing,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    return AnimatedBackdrop(
      colors: colors ?? const [Color(0xFF7B6CFF), Color(0xFF55B7FF), Color(0xFFA6F0FF)],
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                  child: Row(
                    children: [
                      GameIconButton(
                        icon: Icons.arrow_back_rounded,
                        tone: ButtonTone.orange,
                        size: 48,
                        semanticLabel: s.loc.t('common.back'),
                        onTap: onBack ?? s.navigator.back,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Center(
                          child: Ribbon(text: title, color: ribbon, fontSize: 24),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(width: 48, child: trailing),
                    ],
                  ),
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
