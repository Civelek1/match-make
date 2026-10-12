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

class SaveData {
  /// v2 (chapters 2–5): adds seenTips + debugChapters. Older saves load
  /// unchanged because every new field defaults to empty.
  static const currentVersion = 2;

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
  }) : levels = levels ?? {},
       galleryUnlocked = galleryUnlocked ?? {},
       galleryViewed = galleryViewed ?? {},
       debugUnlocked = debugUnlocked ?? {},
       debugLocked = debugLocked ?? {},
       chaptersCelebrated = chaptersCelebrated ?? {},
       seenTips = seenTips ?? {},
       debugChapters = debugChapters ?? {},
       settings = settings ?? SettingsData(),
       profile = profile ?? ProfileData();

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
  };

  /// Throws [FormatException] only if the root isn't a map at all.
  factory SaveData.fromJson(Object? j) {
    if (j is! Map) throw const FormatException('Save root is not an object');
    final levelsJson = j['levels'];
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
    );
  }
}

int _int(Object? v) => v is int ? v : (v is num ? v.toInt() : 0);

Set<String> _strings(Object? v) => {
  if (v is List)
    for (final s in v)
      if (s is String) s,
};
