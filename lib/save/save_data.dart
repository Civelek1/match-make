/// Persistent player data. Every field has a safe default so partially
/// corrupted or older saves still load.
class LevelProgress {
  bool completed;
  int stars;
  int bestScore;

  LevelProgress({this.completed = false, this.stars = 0, this.bestScore = 0});

  Map<String, dynamic> toJson() => {'c': completed, 's': stars, 'b': bestScore};

  factory LevelProgress.fromJson(Object? j) {
    if (j is! Map) return LevelProgress();
    return LevelProgress(completed: j['c'] == true, stars: _int(j['s']).clamp(0, 3), bestScore: _int(j['b']).clamp(0, 1 << 40));
  }
}

class SettingsData {
  bool music;
  bool sfx;
  bool vibration;
  String language;

  SettingsData({this.music = true, this.sfx = true, this.vibration = true, this.language = 'en'});

  Map<String, dynamic> toJson() => {'music': music, 'sfx': sfx, 'vib': vibration, 'lang': language};

  factory SettingsData.fromJson(Object? j) {
    if (j is! Map) return SettingsData();
    return SettingsData(
      music: j['music'] != false,
      sfx: j['sfx'] != false,
      vibration: j['vib'] != false,
      language: j['lang'] is String ? j['lang'] as String : 'en',
    );
  }
}

class ProfileData {
  String name;
  String avatarId;

  ProfileData({this.name = '', this.avatarId = 'fox'});

  Map<String, dynamic> toJson() => {'name': name, 'avatar': avatarId};

  factory ProfileData.fromJson(Object? j) {
    if (j is! Map) return ProfileData();
    return ProfileData(
      name: j['name'] is String ? j['name'] as String : '',
      avatarId: j['avatar'] is String ? j['avatar'] as String : 'fox',
    );
  }
}

/// Daily login reward state.
class DailyData {
  /// Day number (see DailyRewardService.dayNumber) of the last claim; 0 = never.
  int lastDay;

  /// Consecutive days claimed, including [lastDay].
  int streak;

  DailyData({this.lastDay = 0, this.streak = 0});

  Map<String, dynamic> toJson() => {'d': lastDay, 's': streak};

  factory DailyData.fromJson(Object? j) {
    if (j is! Map) return DailyData();
    return DailyData(lastDay: _int(j['d']).clamp(0, 1 << 30), streak: _int(j['s']).clamp(0, 1 << 20));
  }
}

class SaveData {
  /// v2 (chapters 2–5): adds seenTips + debugChapters.
  /// v3 (economy): adds coins, booster inventory and daily rewards.
  /// Older saves load unchanged because every new field has a default.
  static const currentVersion = 3;

  final Map<String, LevelProgress> levels;
  final Set<String> galleryUnlocked;

  /// Gallery cards the player has already seen unlocked (for the shine FX).
  final Set<String> galleryViewed;

  /// Debug-panel overrides.
  final Set<String> debugUnlocked;
  final Set<String> debugLocked;

  /// Chapters whose completion celebration was already shown.
  final Set<String> chaptersCelebrated;

  /// One-time tutorial cards already shown (e.g. obstacle intros).
  final Set<String> seenTips;

  /// Debug-panel chapter overrides.
  final Set<String> debugChapters;
  final SettingsData settings;
  final ProfileData profile;
  bool tutorialDone;

  /// Soft currency earned by playing.
  int coins;

  /// Owned boosters by BoosterKind.name.
  final Map<String, int> boosters;
  final DailyData daily;

  SaveData({
    Map<String, LevelProgress>? levels,
    Set<String>? galleryUnlocked,
    Set<String>? galleryViewed,
    Set<String>? debugUnlocked,
    Set<String>? debugLocked,
    Set<String>? chaptersCelebrated,
    Set<String>? seenTips,
    Set<String>? debugChapters,
    SettingsData? settings,
    ProfileData? profile,
    this.tutorialDone = false,
    this.coins = 0,
    Map<String, int>? boosters,
    DailyData? daily,
  }) : levels = levels ?? {},
       galleryUnlocked = galleryUnlocked ?? {},
       galleryViewed = galleryViewed ?? {},
       debugUnlocked = debugUnlocked ?? {},
       debugLocked = debugLocked ?? {},
       chaptersCelebrated = chaptersCelebrated ?? {},
       seenTips = seenTips ?? {},
       debugChapters = debugChapters ?? {},
       settings = settings ?? SettingsData(),
       profile = profile ?? ProfileData(),
       boosters = boosters ?? {},
       daily = daily ?? DailyData();

  LevelProgress level(String id) => levels.putIfAbsent(id, LevelProgress.new);

  Map<String, dynamic> toJson() => {
    'v': currentVersion,
    'levels': {for (final e in levels.entries) e.key: e.value.toJson()},
    'gallery': galleryUnlocked.toList(),
    'galleryViewed': galleryViewed.toList(),
    'dbgUnlocked': debugUnlocked.toList(),
    'dbgLocked': debugLocked.toList(),
    'celebrated': chaptersCelebrated.toList(),
    'tips': seenTips.toList(),
    'dbgChapters': debugChapters.toList(),
    'settings': settings.toJson(),
    'profile': profile.toJson(),
    'tutorial': tutorialDone,
    'coins': coins,
    'boosters': boosters,
    'daily': daily.toJson(),
  };

  /// Throws [FormatException] only if the root isn't a map at all.
  factory SaveData.fromJson(Object? j) {
    if (j is! Map) throw const FormatException('Save root is not an object');
    final levelsJson = j['levels'];
    final boostersJson = j['boosters'];
    return SaveData(
      levels: {
        if (levelsJson is Map)
          for (final e in levelsJson.entries)
            if (e.key is String) e.key as String: LevelProgress.fromJson(e.value),
      },
      galleryUnlocked: _strings(j['gallery']),
      galleryViewed: _strings(j['galleryViewed']),
      debugUnlocked: _strings(j['dbgUnlocked']),
      debugLocked: _strings(j['dbgLocked']),
      chaptersCelebrated: _strings(j['celebrated']),
      seenTips: _strings(j['tips']),
      debugChapters: _strings(j['dbgChapters']),
      settings: SettingsData.fromJson(j['settings']),
      profile: ProfileData.fromJson(j['profile']),
      tutorialDone: j['tutorial'] == true,
      coins: _int(j['coins']).clamp(0, 1 << 40),
      boosters: {
        if (boostersJson is Map)
          for (final e in boostersJson.entries)
            if (e.key is String && _int(e.value) > 0) e.key as String: _int(e.value).clamp(0, 9999),
      },
      daily: DailyData.fromJson(j['daily']),
    );
  }
}

int _int(Object? v) => v is int ? v : (v is num ? v.toInt() : 0);

Set<String> _strings(Object? v) => {
  if (v is List)
    for (final s in v)
      if (s is String) s,
};
