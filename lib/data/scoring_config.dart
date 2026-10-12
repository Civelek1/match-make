/// All score values live here so balancing never means hunting magic numbers.
class ScoringConfig {
  final int pointsPerPiece;
  final int rocketCreatedBonus;
  final int bombCreatedBonus;
  final int colorBombCreatedBonus;
  final int specialActivatedBonus;

  /// Each cascade level adds this much to the multiplier (1.0, 1.5, 2.0 ...).
  final double cascadeMultiplierStep;
  final double maxMultiplier;
  final int remainingMoveBonus;

  /// Points per point of damage dealt to a crate, ice layer or chain.
  final int obstacleHitBonus;

  const ScoringConfig({
    this.pointsPerPiece = 100,
    this.rocketCreatedBonus = 500,
    this.bombCreatedBonus = 750,
    this.colorBombCreatedBonus = 1000,
    this.specialActivatedBonus = 250,
    this.cascadeMultiplierStep = 0.5,
    this.maxMultiplier = 4.0,
    this.remainingMoveBonus = 1000,
    this.obstacleHitBonus = 150,
  });

  double multiplierFor(int cascade) {
    final m = 1.0 + cascade * cascadeMultiplierStep;
    return m > maxMultiplier ? maxMultiplier : m;
  }
}
