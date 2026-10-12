import 'package:flutter/foundation.dart';

import '../data/content/game_content.dart';
import '../data/models/level_data.dart';
import '../progression/progress_service.dart';
import '../save/save_data.dart';
import '../save/save_store.dart';
import 'economy_config.dart';

/// Coins and booster inventory. Every mutation commits the save.
class EconomyService extends ChangeNotifier {
  final SaveStore _store;
  final GameContent content;
  final ProgressService progress;
  final EconomyConfig config;

  EconomyService(this._store, this.content, this.progress, {this.config = const EconomyConfig()});

  SaveData get _data => _store.data;

  int get coins => _data.coins;
  int count(BoosterKind kind) => _data.boosters[kind.name] ?? 0;

  /// Gives a brand-new (or pre-economy) save its starter coins once.
  void ensureStarterPack() {
    if (_data.seenTips.add('starter_pack')) {
      _data.coins += config.starterCoins;
      _commit();
    }
  }

  void addCoins(int amount) {
    if (amount <= 0) return;
    _data.coins += amount;
    _commit();
  }

  /// Returns false (and changes nothing) when the player can't afford it.
  bool spendCoins(int amount) {
    if (amount < 0 || _data.coins < amount) return false;
    _data.coins -= amount;
    _commit();
    return true;
  }

  void addBooster(BoosterKind kind, [int n = 1]) {
    if (n <= 0) return;
    _data.boosters[kind.name] = count(kind) + n;
    _commit();
  }

  /// Uses one booster from the inventory. False if none are owned.
  bool consume(BoosterKind kind) {
    final have = count(kind);
    if (have <= 0) return false;
    if (have == 1) {
      _data.boosters.remove(kind.name);
    } else {
      _data.boosters[kind.name] = have - 1;
    }
    _commit();
    return true;
  }

  /// Buys one booster with coins.
  bool buy(BoosterKind kind) {
    if (!isUnlocked(kind) || _data.coins < kind.price) return false;
    _data.coins -= kind.price;
    _data.boosters[kind.name] = count(kind) + 1;
    _commit();
    return true;
  }

  /// A booster is available once the player has reached its unlock level.
  bool isUnlocked(BoosterKind kind) {
    for (final l in content.allLevels) {
      if (l.number == kind.unlockLevel) return progress.isUnlocked(l.id) || progress.isCompleted(l.id);
    }
    return false;
  }

  /// Boosters this level is the first chance to use (shown on the intro card).
  List<BoosterKind> newBoostersFor(LevelData level) => [
    for (final b in BoosterKind.values)
      if (level.number >= b.unlockLevel && !progress.hasSeenTip(_tip(b))) b,
  ];

  /// Gifts [EconomyConfig.unlockGift] of every newly available booster.
  List<BoosterKind> introduceBoosters(LevelData level) {
    final fresh = newBoostersFor(level);
    for (final b in fresh) {
      _data.seenTips.add(_tip(b));
      _data.boosters[b.name] = count(b) + config.unlockGift;
    }
    if (fresh.isNotEmpty) _commit();
    return fresh;
  }

  /// Boosters the player may use on [level] (unlocked by its number).
  bool availableOn(BoosterKind kind, LevelData level) => level.number >= kind.unlockLevel;

  /// Coins for a win, granted immediately. See [EconomyConfig].
  int grantWinReward(WinOutcome o) {
    var coins = 0;
    if (o.firstCompletion) {
      coins = config.firstWinBase + config.firstWinPerStar * o.stars;
    } else {
      coins = config.replayWin + config.replayPerNewStar * (o.stars - o.previousStars).clamp(0, 3);
    }
    if (o.chapterCompletedNow) coins += config.chapterBonus;
    addCoins(coins);
    return coins;
  }

  int continuePrice(int continuesUsed) => config.continuePrice(continuesUsed);

  static String _tip(BoosterKind b) => 'booster_${b.name}';

  void _commit() {
    _store.commit();
    notifyListeners();
  }

  /// Call after the save store is replaced (e.g. reset).
  void reload() => notifyListeners();
}

/// Seven-day login calendar. Claiming on consecutive days advances the
/// streak; missing a day restarts at day 1; day 7 loops back to day 1.
class DailyRewardService extends ChangeNotifier {
  final SaveStore _store;
  final EconomyService economy;
  final DateTime Function() clock;

  DailyRewardService(this._store, this.economy, {DateTime Function()? clock}) : clock = clock ?? DateTime.now;

  DailyData get _d => _store.data.daily;
  List<DailyReward> get rewards => economy.config.daily;

  /// Whole local calendar days since 2020-01-01 (DST-safe).
  static int dayNumber(DateTime t) => DateTime.utc(t.year, t.month, t.day).difference(DateTime.utc(2020)).inDays + 1;

  int get _today => dayNumber(clock());

  bool get canClaim => _d.lastDay != _today;

  bool get _continuing => _d.lastDay == _today - 1;

  /// Calendar slot (0..6) for today: the one to claim, or the one claimed.
  int get todayIndex {
    if (canClaim) return _continuing ? _d.streak % rewards.length : 0;
    return (_d.streak - 1) % rewards.length;
  }

  /// Slots already collected in the current cycle (for the calendar UI).
  bool isCollected(int index) => canClaim ? index < todayIndex : index <= todayIndex;

  /// Grants today's reward. Returns null if it was already claimed.
  DailyReward? claim() {
    if (!canClaim) return null;
    final index = todayIndex;
    final reward = rewards[index];
    _d.streak = _continuing ? _d.streak + 1 : 1;
    _d.lastDay = _today;
    if (reward.coins > 0) economy.addCoins(reward.coins);
    if (reward.booster != null) economy.addBooster(reward.booster!, reward.boosterCount);
    _store.commit();
    notifyListeners();
    return reward;
  }

  void reload() => notifyListeners();
}
