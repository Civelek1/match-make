/// Extension point for future optional monetization (rewarded ads for extra
/// moves, cosmetics, no-ads...). Nothing is sold in this build: the default
/// implementation reports itself unavailable and the UI hides reward buttons.
abstract class RewardsService {
  bool get extraMovesAvailable;

  /// Resolves true when the player earned the reward.
  Future<bool> requestExtraMoves();
}

class DisabledRewardsService implements RewardsService {
  const DisabledRewardsService();

  @override
  bool get extraMovesAvailable => false;

  @override
  Future<bool> requestExtraMoves() async => false;
}
