import 'dart:math';

import 'package:flutter/foundation.dart';

import '../audio/audio_service.dart';
import '../economy/economy_config.dart';
import '../economy/economy_service.dart';
import '../save/save_store.dart';
import 'ads_service.dart';
import 'monetization_config.dart';
import 'store_service.dart';

/// Optional ways to earn and buy: rewarded ads (extra moves, free coins,
/// doubled daily reward) and store products (coin packs, starter pack,
/// no-ads). With no-ads every ad reward is granted instantly.
class MonetizationService extends ChangeNotifier {
  final SaveStore _store;
  final EconomyService economy;
  final DailyRewardService daily;
  final AudioService audio;
  final AdsService ads;
  final StoreService shop;

  MonetizationService(this._store, this.economy, this.daily, this.audio, this.ads, this.shop) {
    shop.onGrant = grant;
    ads.addListener(notifyListeners);
    shop.addListener(notifyListeners);
  }

  Future<void> init() async {
    // Independent: a failing consent/ads start must not block the store.
    await Future.wait([_safe(shop.init), _safe(ads.init)]);
  }

  static Future<void> _safe(Future<void> Function() f) async {
    try {
      await f();
    } catch (e) {
      debugPrint('Monetization init failed: $e');
    }
  }

  bool owns(ProductKind p) => _store.data.purchases.contains(p.id);
  bool get noAds => owns(ProductKind.noAds);

  /// Ad rewards can be offered right now.
  bool get adRewardsAvailable => noAds || ads.available;

  /// Plays a rewarded ad (or, with no-ads, nothing). True when earned.
  Future<bool> watch(AdPlacement placement) async {
    if (noAds) return true;
    audio.pauseAll();
    try {
      return await ads.showRewarded(placement);
    } catch (e) {
      debugPrint('Rewarded ad error: $e');
      return false;
    } finally {
      audio.resumeAll();
    }
  }

  // ---- Free coins for an ad (limited per day). ----

  int get adCoinsLeft {
    final d = _store.data;
    return d.adCoinsDay == daily.today ? max(0, AdRewards.coinsPerDay - d.adCoinsCount) : AdRewards.coinsPerDay;
  }

  Future<bool> claimAdCoins() async {
    if (adCoinsLeft <= 0 || !await watch(AdPlacement.freeCoins)) return false;
    final d = _store.data;
    if (d.adCoinsDay != daily.today) {
      d.adCoinsDay = daily.today;
      d.adCoinsCount = 0;
    }
    d.adCoinsCount++;
    economy.addCoins(AdRewards.coins);
    notifyListeners();
    return true;
  }

  // ---- Double today's daily reward. ----

  bool get canDoubleDaily => !daily.canClaim && _store.data.dailyDoubledDay != daily.today;

  Future<DailyReward?> doubleDaily() async {
    if (!canDoubleDaily || !await watch(AdPlacement.doubleDaily)) return null;
    final reward = daily.rewards[daily.todayIndex];
    _store.data.dailyDoubledDay = daily.today;
    if (reward.coins > 0) economy.addCoins(reward.coins);
    if (reward.booster != null) economy.addBooster(reward.booster!, reward.boosterCount);
    _store.commit();
    notifyListeners();
    return reward;
  }

  // ---- Store. ----

  Future<PurchaseResult> buy(ProductKind p) => shop.buy(p);
  Future<void> restore() => shop.restore();

  /// Delivers a product once per order.
  @visibleForTesting
  void grant(ProductKind p, String orderId) {
    final d = _store.data;
    if (!d.grantedOrders.add(orderId)) return;
    if (p.oneTime && !d.purchases.add(p.id)) {
      _store.commit();
      return; // restored an item already owned: nothing more to give
    }
    // Keep the dedupe list small: old orders can't be re-delivered.
    while (d.grantedOrders.length > 200) {
      d.grantedOrders.remove(d.grantedOrders.first);
    }
    if (p.coins > 0) economy.addCoins(p.coins);
    for (final b in p.boosters) {
      economy.addBooster(b, p.boostersEach);
    }
    _store.commit();
    notifyListeners();
  }

  @override
  void dispose() {
    ads.removeListener(notifyListeners);
    shop.removeListener(notifyListeners);
    super.dispose();
  }
}
