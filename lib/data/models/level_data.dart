/// Special pieces a level is allowed to create. Used to introduce mechanics
/// gradually (Rocket in level 2, Bomb in level 3, ...).
enum SpecialFeature { rocket, bomb, colorBomb }

enum Difficulty { easy, easyMedium, medium, mediumHard, hard }

/// One restoration target inside a level, e.g. "Fence ×20".
///
/// Matching tiles of [tileTypeId] adds to the objective. Every time the
/// progress crosses one of the [milestones] (fractions of [target]) the
/// environment advances one visual stage.
class ObjectiveData {
  final String id;
  final String tileTypeId;
  final int target;
  final List<double> milestones;

  const ObjectiveData({
    required this.id,
    required this.tileTypeId,
    required this.target,
    this.milestones = const [0.25, 0.5, 0.75, 1.0],
  });

  int get stageCount => milestones.length;

  /// Visual stage (0..stageCount) reached with [amount] collected.
  int stageFor(int amount) {
    final fraction = amount / target;
    var stage = 0;
    for (final m in milestones) {
      if (fraction + 1e-9 >= m) stage++;
    }
    return stage;
  }

  String get nameKey => 'obj.$id';

  /// Objectives can also count obstacle damage (tileTypeId crate / ice / chain).
  static const obstacleIds = {'crate', 'ice', 'chain'};
  bool get isObstacle => obstacleIds.contains(tileTypeId);
}

/// Fully data-driven level definition. Gameplay code never branches on a
/// specific level id; everything it needs lives here.
class LevelData {
  final String id;
  final String chapterId;
  final int number;

  /// Key into the scene registry (restoration artwork) and theme registry.
  final String environmentId;
  final int gridWidth;
  final int gridHeight;
  final int moves;

  /// Tile types spawned on the board. Index in this list = engine type index.
  final List<String> tileTypeIds;
  final List<ObjectiveData> objectives;

  /// Final-score thresholds for 2 and 3 stars. Completing gives 1 star.
  final List<int> starThresholds;

  /// Level id that must be completed first (null = unlocked from start).
  final String? unlockRequirement;
  final Set<SpecialFeature> specials;

  /// Mechanic highlighted on the level intro card.
  final SpecialFeature? introduces;
  final Difficulty difficulty;

  /// Whether the first-time tutorial may run on this level.
  final bool hasTutorial;

  /// Obstacle layout rows (legend in Match3Engine.parseObstacle); null = none.
  final List<String>? obstacles;

  /// Obstacle explained on the intro card the first time it appears
  /// (value: crate / ice / chain).
  final String? introducesObstacle;

  const LevelData({
    required this.id,
    required this.chapterId,
    required this.number,
    required this.environmentId,
    this.gridWidth = 8,
    this.gridHeight = 8,
    required this.moves,
    required this.tileTypeIds,
    required this.objectives,
    required this.starThresholds,
    this.unlockRequirement,
    this.specials = const {},
    this.introduces,
    this.difficulty = Difficulty.easy,
    this.hasTutorial = false,
    this.obstacles,
    this.introducesObstacle,
  });

  String get nameKey => 'level.$id';
  String get descKey => 'level.$id.desc';

  int tileIndexOf(String tileTypeId) => tileTypeIds.indexOf(tileTypeId);

  int starsForScore(int score) {
    if (score >= starThresholds[1]) return 3;
    if (score >= starThresholds[0]) return 2;
    return 1;
  }
}
