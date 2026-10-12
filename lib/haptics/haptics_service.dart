import 'package:flutter/services.dart';

import '../settings/settings_service.dart';

/// Haptic feedback gated by the vibration setting. No-ops where unsupported.
class HapticsService {
  final SettingsService settings;
  HapticsService(this.settings);

  void _run(Future<void> Function() f) {
    if (!settings.vibration) return;
    f().catchError((_) {});
  }

  void button() => _run(HapticFeedback.selectionClick);
  void match() => _run(HapticFeedback.lightImpact);
  void special() => _run(HapticFeedback.mediumImpact);
  void success() => _run(HapticFeedback.heavyImpact);
  void error() => _run(HapticFeedback.vibrate);
}
