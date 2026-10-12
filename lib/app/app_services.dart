import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../audio/audio_service.dart';
import '../data/content/game_content.dart';
import '../haptics/haptics_service.dart';
import '../leaderboard/leaderboard_service.dart';
import '../localization/localization.dart';
import '../monetization/rewards_service.dart';
import '../progression/progress_service.dart';
import '../save/save_repository.dart';
import '../save/save_store.dart';
import '../settings/settings_service.dart';
import 'game_navigator.dart';

/// Development tools are compiled in only for debug builds or when built with
/// `--dart-define=MM_DEBUG=true`. Never visible in normal release builds.
const bool kDebugTools = kDebugMode || bool.fromEnvironment('MM_DEBUG');

const String kGameVersion = '1.0.0';

/// Composition root: every service is created here and passed down via
/// [AppScope]. Swapping implementations (cloud save, real leaderboard) is a
/// one-line change in [AppServices.create].
class AppServices {
  final GameContent content;
  final SaveStore store;
  final ProgressService progress;
  final SettingsService settings;
  final ProfileService profile;
  final Localization loc;
  final AudioService audio;
  final HapticsService haptics;
  final LeaderboardService leaderboard;
  final RewardsService rewards;
  final GameNavigator navigator;

  AppServices._({
    required this.content,
    required this.store,
    required this.progress,
    required this.settings,
    required this.profile,
    required this.loc,
    required this.audio,
    required this.haptics,
    required this.leaderboard,
    required this.rewards,
    required this.navigator,
  });

  factory AppServices.create({SaveRepository? repository, AudioService? audio}) {
    final content = GameContent.standard();
    final store = SaveStore(repository ?? LocalSaveRepository());
    final settings = SettingsService(store);
    final loc = Localization();
    settings.addListener(() => loc.language = settings.language);
    return AppServices._(
      content: content,
      store: store,
      progress: ProgressService(content, store),
      settings: settings,
      profile: ProfileService(store),
      loc: loc,
      audio: audio ?? GameAudioService(settings),
      haptics: HapticsService(settings),
      leaderboard: MockLeaderboardService(),
      rewards: const DisabledRewardsService(),
      navigator: GameNavigator(),
    );
  }

  Future<void> load() async {
    await store.load();
    loc.language = settings.language;
    progress.refresh();
    settings.reload();
  }

  String playerName() => profile.name.isEmpty ? loc.t('common.default_name') : profile.name;
}

class AppScope extends InheritedWidget {
  final AppServices services;
  const AppScope({super.key, required this.services, required super.child});

  static AppServices of(BuildContext context) => context.getInheritedWidgetOfExactType<AppScope>()!.services;

  @override
  bool updateShouldNotify(AppScope oldWidget) => services != oldWidget.services;
}

extension AppContext on BuildContext {
  AppServices get services => AppScope.of(this);
  String tr(String key, [Map<String, Object>? args]) => AppScope.of(this).loc.t(key, args);
}
