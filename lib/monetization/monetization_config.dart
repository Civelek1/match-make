import 'package:flutter/foundation.dart';

import '../economy/economy_config.dart';

/// Ad unit and product ids. The defaults are Google's public TEST ids, which
/// always serve test ads and never pay out. For release, build with the real
/// ids from AdMob (see docs/MONETIZATION.md):
///   --dart-define=ADMOB_REWARDED_ANDROID=ca-app-pub-xxx/yyy
///   --dart-define=ADMOB_REWARDED_IOS=ca-app-pub-xxx/zzz
/// (the AdMob *app* id lives in AndroidManifest/Info.plist).
class AdIds {
  static const _androidRewarded = String.fromEnvironment(
    'ADMOB_REWARDED_ANDROID',
    defaultValue: 'ca-app-pub-3940256099942544/5224354917',
  );
  static const _iosRewarded = String.fromEnvironment(
    'ADMOB_REWARDED_IOS',
    defaultValue: 'ca-app-pub-3940256099942544/1712485313',
  );

  static String get rewarded => defaultTargetPlatform == TargetPlatform.iOS ? _iosRewarded : _androidRewarded;
  static bool get usingTestIds => rewarded.startsWith('ca-app-pub-3940256099942544/');
}

/// Where a rewarded ad is offered.
enum AdPlacement { extraMoves, freeCoins, doubleDaily }

/// Rewards for watching an ad.
class AdRewards {
  static const extraMoves = 5;
  static const coins = 50;
  static const coinsPerDay = 3;
}

/// Store products (same ids in Play Console and App Store Connect).
enum ProductKind {
  coinsSmall('coins_500', coins: 500),
  coinsMedium('coins_1200', coins: 1200),
  coinsLarge('coins_3000', coins: 3000),

  /// One-time bundle: coins plus three of every booster.
  starterPack('starter_pack', coins: 1000, boostersEach: 3, oneTime: true),

  /// One-time: every ad reward is granted instantly, without an ad.
  noAds('no_ads', oneTime: true);

  final String id;
  final int coins;
  final int boostersEach;

  /// Bought once and kept (restorable); otherwise consumable.
  final bool oneTime;

  const ProductKind(this.id, {this.coins = 0, this.boostersEach = 0, this.oneTime = false});

  static ProductKind? byId(String id) {
    for (final p in values) {
      if (p.id == id) return p;
    }
    return null;
  }

  static const coinPacks = [coinsSmall, coinsMedium, coinsLarge];

  /// Boosters in a bundle (all kinds).
  Iterable<BoosterKind> get boosters => boostersEach > 0 ? BoosterKind.values : const [];

  String get nameKey => 'product.$id';
}
