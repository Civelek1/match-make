import 'package:flutter/foundation.dart';

import '../data/content/game_content.dart';
import '../data/models/chapter_data.dart';
import '../data/models/level_data.dart';
import '../save/save_data.dart';
import '../save/save_store.dart';

class WinOutcome {
  final int stars;
  final int previousStars;
  final bool newBest;
  final bool firstCompletion;
  final LevelData? newlyUnlocked;
  final bool chapterCompletedNow;
  const WinOutcome({
    required this.stars,
    required this.previousStars,
    required this.newBest,
    required this.firstCompletion,
    required this.newlyUnlocked,
    required this.chapterCompletedNow,
  });
}

/// Level unlocks, stars, scores, gallery and chapter progression.
/// Knows nothing about specific chapters — everything comes from [GameContent].
class ProgressService extends ChangeNotifier {
  final GameContent content;
  final SaveStore _store;

  /// Level whose unlock animation should play next time the map opens.
  String? pendingUnlockAnimation;

  ProgressService(this.content, this._store);

  SaveData get _data => _store.data;

  LevelProgress progressOf(String levelId) => _data.levels[levelId] ?? LevelProgress();

  bool isCompleted(String levelId) => _data.levels[levelId]?.completed ?? false;
  int starsOf(String levelId) => _data.levels[levelId]?.stars ?? 0;
  int bestScoreOf(String levelId) => _data.levels[levelId]?.bestScore ?? 0;

  bool isChapterUnlocked(ChapterData c) =>
      c.requiresChapterId == null ||
      _data.debugChapters.contains(c.id) ||
      isChapterCompleted(content.chapter(c.requiresChapterId!)!);

  bool isChapterCompleted(ChapterData c) => c.levelIds.every(isCompleted);

  bool isUnlocked(String levelId) {
    if (_data.debugLocked.contains(levelId)) return false;
    if (_data.debugUnlocked.contains(levelId)) return true;
    final level = content.level(levelId);
    if (level == null) return false;
    final chapter = content.chapter(level.chapterId);
    if (chapter == null || !isChapterUnlocked(chapter)) return false;
    final req = level.unlockRequirement;
    return req == null || isCompleted(req);
  }

  int chapterStars(ChapterData c) => c.levelIds.fold(0, (s, id) => s + starsOf(id));
  int chapterCompletedCount(ChapterData c) => c.levelIds.where(isCompleted).length;

  int get totalStars => content.allLevels.fold(0, (s, l) => s + starsOf(l.id));
  int get totalScore => content.allLevels.fold(0, (s, l) => s + bestScoreOf(l.id));
  int get levelsCompleted => content.allLevels.where((l) => isCompleted(l.id)).length;

  /// The chapter the player is currently working on.
  ChapterData get currentChapter {
    for (final c in content.chapters) {
      if (isChapterUnlocked(c) && !isChapterCompleted(c)) return c;
    }
    return content.chapters.last;
  }

  /// First unlocked, uncompleted level of a chapter (the pulsing node).
  LevelData? currentLevelOf(ChapterData c) {
    for (final id in c.levelIds) {
      if (isUnlocked(id) && !isCompleted(id)) return content.level(id);
    }
    return null;
  }

  // Gallery ------------------------------------------------------------------

  bool isGalleryUnlocked(String levelId) => _data.galleryUnlocked.contains(levelId);
  bool isGalleryNew(String levelId) => isGalleryUnlocked(levelId) && !_data.galleryViewed.contains(levelId);
  int galleryCount(ChapterData c) => c.levelIds.where(isGalleryUnlocked).length;

  void markGalleryViewed(Iterable<String> ids) {
    final before = _data.galleryViewed.length;
    _data.galleryViewed.addAll(ids.where(isGalleryUnlocked));
    if (_data.galleryViewed.length != before) {
      _store.commit();
    }
  }

  // Tutorial / celebrations --------------------------------------------------

  bool get tutorialDone => _data.tutorialDone;
  void completeTutorial() {
    _data.tutorialDone = true;
    _store.commit();
  }

  bool hasSeenTip(String id) => _data.seenTips.contains(id);
  void markTipSeen(String id) {
    if (_data.seenTips.add(id)) _store.commit();
  }

  bool wasChapterCelebrated(String chapterId) => _data.chaptersCelebrated.contains(chapterId);
  void markChapterCelebrated(String chapterId) {
    if (_data.chaptersCelebrated.add(chapterId)) _store.commit();
  }

  // Results ------------------------------------------------------------------

  WinOutcome recordWin(LevelData level, int score, int stars) {
    final chapter = content.chapter(level.chapterId)!;
    final chapterWasComplete = isChapterCompleted(chapter);
    final nextBefore = content.nextLevel(level.id);
    final nextWasUnlocked = nextBefore != null && isUnlocked(nextBefore.id);

    final p = _data.level(level.id);
    final previousStars = p.stars;
    final first = !p.completed;
    final newBest = score > p.bestScore;
    p.completed = true;
    if (stars > p.stars) p.stars = stars; // never downgrade stars
    if (newBest) p.bestScore = score;
    _data.galleryUnlocked.add(level.id);
    _data.debugLocked.remove(level.id);

    final nextUnlockedNow = nextBefore != null && !nextWasUnlocked && isUnlocked(nextBefore.id);
    if (nextUnlockedNow) pendingUnlockAnimation = nextBefore.id;

    _store.commit();
    notifyListeners();
    return WinOutcome(
      stars: stars,
      previousStars: previousStars,
      newBest: newBest,
      firstCompletion: first,
      newlyUnlocked: nextUnlockedNow ? nextBefore : null,
      chapterCompletedNow: !chapterWasComplete && isChapterCompleted(chapter),
    );
  }

  /// Clears progression but keeps settings and profile.
  Future<void> resetProgress() async {
    final settings = _data.settings;
    final profile = _data.profile;
    _store.data = SaveData(settings: settings, profile: profile);
    pendingUnlockAnimation = null;
    await _store.commit();
    notifyListeners();
  }

  // Debug --------------------------------------------------------------------

  void debugUnlock(String id) {
    _data.debugLocked.remove(id);
    _data.debugUnlocked.add(id);
    _store.commit();
    notifyListeners();
  }

  void debugUnlockChapter(String chapterId) {
    _data.debugChapters.add(chapterId);
    _store.commit();
    notifyListeners();
  }

  void debugLock(String id) {
    _data.debugUnlocked.remove(id);
    _data.debugLocked.add(id);
    _store.commit();
    notifyListeners();
  }

  void debugComplete(String id, {int stars = 3}) {
    final level = content.level(id);
    if (level == null) return;
    recordWin(level, level.starThresholds[1], stars);
  }

  void debugAddStars() {
    for (final l in content.allLevels) {
      final p = _data.levels[l.id];
      if (p != null && p.completed && p.stars < 3) p.stars++;
    }
    _store.commit();
    notifyListeners();
  }

  void refresh() => notifyListeners();
}
