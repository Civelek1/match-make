import 'package:flutter_test/flutter_test.dart';
import 'package:match_make/data/content/game_content.dart';
import 'package:match_make/economy/economy_config.dart';
import 'package:match_make/economy/economy_service.dart';
import 'package:match_make/progression/progress_service.dart';
import 'package:match_make/save/save_repository.dart';
import 'package:match_make/save/save_store.dart';

class _World {
  final MemorySaveRepository repo;
  final SaveStore store;
  final ProgressService progress;
  final EconomyService economy;
  final DailyRewardService daily;
  DateTime now;

  _World._(this.repo, this.store, this.progress, this.economy, this.daily, this.now);

  static Future<_World> create({String? raw, DateTime? now}) async {
    final repo = MemorySaveRepository(raw);
    final store = SaveStore(repo);
    await store.load();
    final content = GameContent.standard();
    final progress = ProgressService(content, store);
    final economy = EconomyService(store, content, progress)..ensureStarterPack();
    late _World w;
    final daily = DailyRewardService(store, economy, clock: () => w.now);
    w = _World._(repo, store, progress, economy, daily, now ?? DateTime(2026, 3, 10, 9));
    return w;
  }
}

void main() {
  final content = GameContent.standard();
  const cfg = EconomyConfig();

  test('new players get the starter coins exactly once', () async {
    final w = await _World.create();
    expect(w.economy.coins, cfg.starterCoins);
    w.economy.ensureStarterPack();
    expect(w.economy.coins, cfg.starterCoins);
    await w.store.commit();
    final w2 = await _World.create(raw: w.repo.raw);
    expect(w2.economy.coins, cfg.starterCoins);
  });

  test('a v2 save upgrades to v3 with starter coins and keeps progress', () async {
    const v2 = '{"v":2,"levels":{"garden":{"c":true,"s":3,"b":35000}},"gallery":["garden"],"tips":["obstacle_crate"]}';
    final w = await _World.create(raw: v2);
    expect(w.progress.starsOf('garden'), 3);
    expect(w.progress.hasSeenTip('obstacle_crate'), isTrue);
    expect(w.economy.coins, cfg.starterCoins);
    await w.store.commit();
    expect(w.repo.raw, contains('"v":3'));
    expect(w.repo.raw, contains('"coins":${cfg.starterCoins}'));
  });

  test('spending, buying and consuming never go negative', () async {
    final w = await _World.create();
    expect(w.economy.spendCoins(cfg.starterCoins + 1), isFalse);
    expect(w.economy.coins, cfg.starterCoins);
    expect(w.economy.consume(BoosterKind.hammer), isFalse);

    // Locked boosters can't be bought.
    w.economy.addCoins(10000);
    expect(w.economy.isUnlocked(BoosterKind.hammer), isFalse);
    expect(w.economy.buy(BoosterKind.hammer), isFalse);

    // Reaching level 6 unlocks the hammer in the shop.
    for (final l in content.allLevels.where((l) => l.number < 6)) {
      w.progress.recordWin(l, 20000, 2);
    }
    expect(w.economy.isUnlocked(BoosterKind.hammer), isTrue);
    final before = w.economy.coins;
    expect(w.economy.buy(BoosterKind.hammer), isTrue);
    expect(w.economy.coins, before - BoosterKind.hammer.price);
    expect(w.economy.count(BoosterKind.hammer), 1);
    expect(w.economy.consume(BoosterKind.hammer), isTrue);
    expect(w.economy.count(BoosterKind.hammer), 0);
    expect(w.economy.consume(BoosterKind.hammer), isFalse);
  });

  test('boosters are introduced once with a gift on their unlock level', () async {
    final w = await _World.create();
    final level4 = content.allLevels.firstWhere((l) => l.number == 4);
    final level3 = content.allLevels.firstWhere((l) => l.number == 3);
    expect(w.economy.newBoostersFor(level3), isEmpty);
    expect(w.economy.newBoostersFor(level4), [BoosterKind.shuffle]);
    expect(w.economy.introduceBoosters(level4), [BoosterKind.shuffle]);
    expect(w.economy.count(BoosterKind.shuffle), cfg.unlockGift);
    expect(w.economy.introduceBoosters(level4), isEmpty);
    expect(w.economy.count(BoosterKind.shuffle), cfg.unlockGift);

    // Jumping ahead introduces everything unlocked so far, once.
    final level16 = content.allLevels.firstWhere((l) => l.number == 16);
    expect(w.economy.introduceBoosters(level16).toSet(), BoosterKind.values.toSet()..remove(BoosterKind.shuffle));
    expect(w.economy.newBoostersFor(level16), isEmpty);
  });

  test('win rewards: first clear, replay, new stars and chapter bonus', () async {
    final w = await _World.create();
    final start = w.economy.coins;
    final garden = content.level('garden')!;
    var o = w.progress.recordWin(garden, 20000, 2);
    expect(w.economy.grantWinReward(o), cfg.firstWinBase + 2 * cfg.firstWinPerStar);

    o = w.progress.recordWin(garden, 20000, 2);
    expect(w.economy.grantWinReward(o), cfg.replayWin);

    o = w.progress.recordWin(garden, 40000, 3);
    expect(w.economy.grantWinReward(o), cfg.replayWin + cfg.replayPerNewStar);

    for (final id in ['kitchen', 'bathroom', 'gaming_room']) {
      w.economy.grantWinReward(w.progress.recordWin(content.level(id)!, 20000, 1));
    }
    o = w.progress.recordWin(content.level('attic')!, 20000, 1);
    expect(o.chapterCompletedNow, isTrue);
    expect(w.economy.grantWinReward(o), cfg.firstWinBase + cfg.firstWinPerStar + cfg.chapterBonus);
    expect(w.economy.coins, greaterThan(start));
  });

  test('continue prices escalate and then hold', () {
    expect(cfg.continuePrice(0), cfg.continuePrices.first);
    expect(cfg.continuePrice(1), cfg.continuePrices[1]);
    expect(cfg.continuePrice(99), cfg.continuePrices.last);
  });

  group('daily rewards', () {
    test('claim once per day, streak advances on consecutive days', () async {
      final w = await _World.create();
      final coins0 = w.economy.coins;
      expect(w.daily.canClaim, isTrue);
      expect(w.daily.todayIndex, 0);
      expect(w.daily.claim()!.coins, cfg.daily[0].coins);
      expect(w.economy.coins, coins0 + cfg.daily[0].coins);
      expect(w.daily.canClaim, isFalse);
      expect(w.daily.claim(), isNull);
      expect(w.daily.isCollected(0), isTrue);
      expect(w.daily.isCollected(1), isFalse);

      // Same day, late evening: still claimed.
      w.now = DateTime(2026, 3, 10, 23, 59);
      expect(w.daily.canClaim, isFalse);

      // Next day: day 2.
      w.now = DateTime(2026, 3, 11, 0, 1);
      expect(w.daily.canClaim, isTrue);
      expect(w.daily.todayIndex, 1);
      w.daily.claim();
      // Day 3 gives a hammer.
      w.now = DateTime(2026, 3, 12, 8);
      expect(w.daily.claim()!.booster, BoosterKind.hammer);
      expect(w.economy.count(BoosterKind.hammer), 1);
    });

    test('missing a day restarts the calendar', () async {
      final w = await _World.create();
      w.daily.claim();
      w.now = DateTime(2026, 3, 11, 9);
      w.daily.claim();
      w.now = DateTime(2026, 3, 13, 9); // skipped the 12th
      expect(w.daily.todayIndex, 0);
      expect(w.daily.isCollected(0), isFalse);
      w.daily.claim();
      expect(w.daily.todayIndex, 0);
      expect(w.daily.isCollected(0), isTrue);
    });

    test('day 7 loops back to day 1 and state survives reload', () async {
      final w = await _World.create();
      for (var d = 0; d < 7; d++) {
        w.now = DateTime(2026, 3, 10 + d, 9);
        expect(w.daily.todayIndex, d);
        w.daily.claim();
      }
      expect(w.economy.count(BoosterKind.startRainbow), 1);
      w.now = DateTime(2026, 3, 17, 9);
      expect(w.daily.todayIndex, 0);
      await w.store.commit();
      final w2 = await _World.create(raw: w.repo.raw, now: DateTime(2026, 3, 17, 10));
      expect(w2.daily.canClaim, isTrue);
      expect(w2.daily.todayIndex, 0);
      expect(w2.economy.count(BoosterKind.startRainbow), 1);
    });

    test('daylight-saving changes do not break day counting', () {
      // Europe DST starts on the last Sunday of March.
      final a = DailyRewardService.dayNumber(DateTime(2026, 3, 28, 23, 30));
      final b = DailyRewardService.dayNumber(DateTime(2026, 3, 29, 0, 30));
      final c = DailyRewardService.dayNumber(DateTime(2026, 3, 30, 0, 30));
      expect(b - a, 1);
      expect(c - b, 1);
    });
  });

  test('large coin and score values survive a round trip (web ints too)', () async {
    final w = await _World.create();
    w.economy.addCoins(5000000000);
    w.progress.recordWin(content.level('garden')!, 7000000000, 3);
    await w.store.commit();
    final w2 = await _World.create(raw: w.repo.raw);
    expect(w2.economy.coins, w.economy.coins);
    expect(w2.progress.bestScoreOf('garden'), 7000000000);
  });

  test('corrupt economy fields fall back to defaults', () async {
    const raw = '{"v":3,"coins":"lots","boosters":{"hammer":-4,"broom":"x","shuffle":2,"5":1},"daily":[1,2]}';
    final w = await _World.create(raw: raw);
    expect(w.economy.count(BoosterKind.hammer), 0);
    expect(w.economy.count(BoosterKind.broom), 0);
    expect(w.economy.count(BoosterKind.shuffle), 2);
    expect(w.daily.canClaim, isTrue);
    expect(w.economy.coins, cfg.starterCoins);
  });
}
