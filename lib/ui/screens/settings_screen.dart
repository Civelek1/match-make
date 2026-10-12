import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../theme/game_colors.dart';
import '../widgets/screen_frame.dart';
import 'settings_panel.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.services.loc;
    return ListenableBuilder(
      listenable: loc,
      builder: (context, _) => ScreenFrame(
        title: loc.t('settings.title'),
        ribbon: GameColors.blue,
        child: const SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Center(child: SettingsPanel()),
        ),
      ),
    );
  }
}
