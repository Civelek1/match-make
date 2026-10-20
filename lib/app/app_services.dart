import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../audio/audio_service.dart';
import '../data/content/game_content.dart';
import '../economy/economy_service.dart';
import '../haptics/haptics_service.dart';
import '../leaderboard/leaderboard_service.dart';
import '../localization/localization.dart';
import '../monetization/ads_service.dart';
import '../monetization/monetization_service.dart';
import '../monetization/store_service.dart';
import '../progression/progress_service.dart';
import '../save/save_repository.dart';
import '../save/save_store.dart';
import '../settings/settings_service.dart';
import 'game_navigator.dart';

/// Development tools are compiled in only for debug builds or when built with
/// `--dart-define=MM_DEBUG=true`. Never visible in normal release builds.
/// MM_HIDE_DEBUG hides the tools in debug builds (store screenshots).
const bool kDebugTools = (kDebugMode && !bool.fromEnvironment('MM_HIDE_DEBUG')) || bool.fromEnvironment('MM_DEBUG');

const String kGameVersion = '1.0.0';

/// The leaderboard screen runs on [MockLeaderboardService] (sample players).
/// Keep it off the main menu until a real backend is connected.
const bool kLeaderboardEnabled = false;

/// Composition root: every service is created here and passed down via
/// [AppScope]. Swapping implementations (cloud save, real leaderboard) is a
/// one-line change in [AppServices.create].
class AppServices {
  final GameContent content;
  final SaveStore store;
  final ProgressService progress;
  final EconomyService economy;
  final DailyRewardService daily;
  final SettingsService settings;
  final ProfileService profile;
  final Localization loc;
  final AudioService audio;
  final HapticsService haptics;
  final LeaderboardService leaderboard;
  final MonetizationService monetization;
  final GameNavigator navigator;

  /// Device languages in preference order (injectable for tests).
  final List<String> Function() deviceLanguages;

  AppServices._({
    required this.content,
    required this.store,
    required this.progress,
    required this.economy,
    required this.daily,
    required this.settings,
    required this.profile,
    required this.loc,
    required this.audio,
    required this.haptics,
    required this.leaderboard,
    required this.monetization,
    required this.navigator,
    required this.deviceLanguages,
  });

  factory AppServices.create({
    SaveRepository? repository,
    AudioService? audio,
    DateTime Function()? clock,
    List<String> Function()? deviceLanguages,
    GameContent? content,
    AdsService? ads,
    StoreService? shop,
  }) {
    content ??= GameContent.standard();
    final store = SaveStore(repository ?? LocalSaveRepository());
    final progress = ProgressService(content, store);
    final economy = EconomyService(store, content, progress);
    final settings = SettingsService(store);
    final loc = Localization();
    settings.addListener(() => loc.language = settings.language);
    final daily = DailyRewardService(store, economy, clock: clock);
    audio ??= GameAudioService(settings);
    return AppServices._(
      content: content,
      store: store,
      progress: progress,
      economy: economy,
      daily: daily,
      settings: settings,
      profile: ProfileService(store),
      loc: loc,
      audio: audio,
      haptics: HapticsService(settings),
      leaderboard: MockLeaderboardService(),
      monetization: MonetizationService(store, economy, daily, audio, ads ?? DisabledAdsService(), shop ?? DisabledStoreService()),
      navigator: GameNavigator(),
      deviceLanguages: deviceLanguages ?? () => [for (final l in PlatformDispatcher.instance.locales) l.languageCode],
    );
  }

  Future<void> load() async {
    await store.load();
    // A new install starts in the device language when we support it.
    if (store.firstLaunch) {
      settings.language = deviceLanguages().firstWhere(Localization.supported.containsKey, orElse: () => 'en');
    }
    loc.language = settings.language;
    economy.ensureStarterPack();
    progress.refresh();
    settings.reload();
    economy.reload();
    daily.reload();
    // Consent form, ads and store start in the background.
    unawaited(monetization.init());
  }

  /// Clears progression, coins and boosters; keeps settings and profile.
  Future<void> resetProgress() async {
    await progress.resetProgress();
    economy.ensureStarterPack();
    settings.reload();
    economy.reload();
    daily.reload();
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
