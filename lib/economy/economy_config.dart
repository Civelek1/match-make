/// Boosters the player can own and spend.
///
/// In-level boosters are used during play and never cost a move; start
/// boosters are picked on the level intro card and place a special piece on
/// the board before the first move.
enum BoosterKind {
  /// Smashes one piece (or one layer of a crate / chain).
  hammer(price: 250, unlockLevel: 6, preLevel: false),

  /// Clears one whole row.
  broom(price: 300, unlockLevel: 9, preLevel: false),

  /// Reshuffles all free pieces.
  shuffle(price: 150, unlockLevel: 4, preLevel: false),

  /// Starts the level with a rocket on the board.
  startRocket(price: 200, unlockLevel: 11, preLevel: true),

  /// Starts the level with a bomb on the board.
  startBomb(price: 250, unlockLevel: 13, preLevel: true),

  /// Starts the level with a colour bomb on the board.
  startRainbow(price: 400, unlockLevel: 16, preLevel: true);

  /// Coin price in the shop.
  final int price;

  /// Level number from which the booster becomes available (and is gifted).
  final int unlockLevel;
  final bool preLevel;

  const BoosterKind({required this.price, required this.unlockLevel, required this.preLevel});

  static List<BoosterKind> get inLevel => [for (final b in values) if (!b.preLevel) b];
  static List<BoosterKind> get start => [for (final b in values) if (b.preLevel) b];

  String get nameKey => 'booster.$name';
  String get howKey => 'booster.$name.how';
}

/// One daily-calendar reward.
class DailyReward {
  final int coins;
  final BoosterKind? booster;
  final int boosterCount;
  const DailyReward({this.coins = 0, this.booster, this.boosterCount = 0});
}

/// All economy numbers in one place so balancing never means hunting
/// magic numbers. Earn rate: ~60 coins per first clear + ~100 a day from the
/// calendar, so a continue costs roughly five levels of play.
class EconomyConfig {
  /// Coins for a first clear: base + per star.
  final int firstWinBase;
  final int firstWinPerStar;

  /// Coins for replaying an already completed level.
  final int replayWin;

  /// Extra coins for gaining stars on a replay, per new star.
  final int replayPerNewStar;

  /// Bonus when a whole chapter is completed for the first time.
  final int chapterBonus;

  /// Moves added by a continue, and its escalating coin prices (the last
  /// price repeats).
  final int continueMoves;
  final List<int> continuePrices;

  /// Free boosters given when a booster unlocks.
  final int unlockGift;

  /// Coins every new player starts with.
  final int starterCoins;

  final List<DailyReward> daily;

  const EconomyConfig({
    this.firstWinBase = 40,
    this.firstWinPerStar = 10,
    this.replayWin = 10,
    this.replayPerNewStar = 15,
    this.chapterBonus = 250,
    this.continueMoves = 5,
    this.continuePrices = const [300, 600, 900],
    this.unlockGift = 3,
    this.starterCoins = 200,
    this.daily = const [
      DailyReward(coins: 50),
      DailyReward(coins: 75),
      DailyReward(booster: BoosterKind.hammer, boosterCount: 1),
      DailyReward(coins: 100),
      DailyReward(booster: BoosterKind.shuffle, boosterCount: 2),
      DailyReward(coins: 150),
      DailyReward(coins: 250, booster: BoosterKind.startRainbow, boosterCount: 1),
    ],
  });

  int continuePrice(int continuesUsed) =>
      continuePrices[continuesUsed.clamp(0, continuePrices.length - 1)];
}
