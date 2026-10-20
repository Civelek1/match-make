import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:match_make/app/app_services.dart';
import 'package:match_make/audio/audio_service.dart';
import 'package:match_make/economy/economy_config.dart';
import 'package:match_make/monetization/ads_service.dart';
import 'package:match_make/monetization/monetization_config.dart';
import 'package:match_make/monetization/store_service.dart';
import 'package:match_make/save/save_repository.dart';
import 'package:match_make/ui/screens/shop_panel.dart';

class _FakeAds extends AdsService {
  bool reward = true;
  int shown = 0;
  @override
  bool get available => true;
  @override
  bool get privacyOptionsRequired => false;
  @override
  Future<void> init() async {}
  @override
  Future<bool> showRewarded(AdPlacement placement) async {
    shown++;
    return reward;
  }

  @override
  Future<void> showPrivacyOptions() async {}
}

void main() {
  var now = DateTime(2026, 10, 20, 10);

  Future<(AppServices, _FakeAds)> boot({AdsService? ads}) async {
    final fake = _FakeAds();
    final s = AppServices.create(
      repository: MemorySaveRepository(),
      audio: SilentAudioService(),
      clock: () => now,
      ads: ads ?? fake,
      shop: FakeStoreService(),
    );
    await s.load();
    return (s, fake);
  }

  setUp(() => now = DateTime(2026, 10, 20, 10));

  test('coin pack pays once per order', () async {
    final (s, _) = await boot();
    final start = s.economy.coins;
    s.monetization.grant(ProductKind.coinsMedium, 'order-1');
    s.monetization.grant(ProductKind.coinsMedium, 'order-1'); // re-delivered
    expect(s.economy.coins, start + 1200);
    expect(await s.monetization.buy(ProductKind.coinsSmall), PurchaseResult.success);
    expect(s.economy.coins, start + 1700);
  });

  test('starter pack is one-time and survives a restore', () async {
    final (s, _) = await boot();
    final coins = s.economy.coins;
    final hammers = s.economy.count(BoosterKind.hammer);
    s.monetization.grant(ProductKind.starterPack, 'a');
    expect(s.monetization.owns(ProductKind.starterPack), isTrue);
    expect(s.economy.coins, coins + 1000);
    expect(s.economy.count(BoosterKind.hammer), hammers + 3);
    s.monetization.grant(ProductKind.starterPack, 'restore-b'); // restore on a new order id
    expect(s.economy.coins, coins + 1000);
  });

  test('ad coins: three a day, reset the next day', () async {
    final (s, ads) = await boot();
    final start = s.economy.coins;
    for (var i = 0; i < 4; i++) {
      await s.monetization.claimAdCoins();
    }
    expect(s.economy.coins, start + 3 * AdRewards.coins);
    expect(ads.shown, 3);
    expect(s.monetization.adCoinsLeft, 0);
    now = now.add(const Duration(days: 1));
    expect(s.monetization.adCoinsLeft, AdRewards.coinsPerDay);
  });

  test('a skipped ad gives nothing', () async {
    final (s, ads) = await boot();
    ads.reward = false;
    final start = s.economy.coins;
    expect(await s.monetization.claimAdCoins(), isFalse);
    expect(s.economy.coins, start);
    expect(s.monetization.adCoinsLeft, AdRewards.coinsPerDay);
  });

  test('daily reward doubles once, only after claiming', () async {
    final (s, _) = await boot();
    expect(s.monetization.canDoubleDaily, isFalse);
    final r = s.daily.claim()!;
    final afterClaim = s.economy.coins;
    expect(await s.monetization.doubleDaily(), isNotNull);
    expect(s.economy.coins, afterClaim + r.coins);
    expect(s.monetization.canDoubleDaily, isFalse);
    expect(await s.monetization.doubleDaily(), isNull);
  });

  test('no-ads grants ad rewards without ads', () async {
    final (s, _) = await boot(ads: DisabledAdsService());
    expect(s.monetization.adRewardsAvailable, isFalse);
    await s.monetization.buy(ProductKind.noAds);
    expect(s.monetization.noAds, isTrue);
    expect(s.monetization.adRewardsAvailable, isTrue);
    expect(await s.monetization.watch(AdPlacement.extraMoves), isTrue);
    final start = s.economy.coins;
    expect(await s.monetization.claimAdCoins(), isTrue);
    expect(s.economy.coins, start + AdRewards.coins);
  });

  test('purchases and ad counters persist across a reload', () async {
    final repo = MemorySaveRepository();
    final a = AppServices.create(repository: repo, audio: SilentAudioService(), clock: () => now, shop: FakeStoreService());
    await a.load();
    a.monetization.grant(ProductKind.noAds, 'x');
    await a.store.commit();
    final b = AppServices.create(repository: repo, audio: SilentAudioService(), clock: () => now);
    await b.load();
    expect(b.monetization.noAds, isTrue);
  });

  testWidgets('shop shows store items and buying adds coins', (t) async {
    t.view.physicalSize = const Size(1170, 2532);
    t.view.devicePixelRatio = 3;
    addTearDown(t.view.reset);
    final (s, _) = await boot();
    await t.pumpWidget(
      AppScope(
        services: s,
        child: MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(onPressed: () => showShop(context), child: const Text('open')),
              ),
            ),
          ),
        ),
      ),
    );
    await t.tap(find.text('open'));
    for (var i = 0; i < 10; i++) {
      await t.pump(const Duration(milliseconds: 100));
    }
    expect(find.text(s.loc.t('product.no_ads')), findsOneWidget);
    expect(find.text(s.loc.t('product.coins_500')), findsOneWidget);
    final start = s.economy.coins;
    final price = s.monetization.shop.price(ProductKind.coinsSmall)!;
    await t.ensureVisible(find.text(price));
    await t.tap(find.text(price));
    for (var i = 0; i < 10; i++) {
      await t.pump(const Duration(milliseconds: 100));
    }
    expect(s.economy.coins, start + 500);
    await t.pump(const Duration(seconds: 4));
  });
}
