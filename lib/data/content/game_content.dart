import '../models/chapter_data.dart';
import '../models/level_data.dart';
import 'beach_chapter.dart';
import 'farm_chapter.dart';
import 'house_chapter.dart';
import 'mansion_chapter.dart';
import 'restaurant_chapter.dart';

/// Registry of every chapter and level shipped with the game.
///
/// Adding a chapter = add a ChapterData + its LevelData list here (plus art,
/// restoration scenes and localization strings). No gameplay code changes.
class GameContent {
  final List<ChapterData> chapters;
  final Map<String, LevelData> _levels;

  /// Number of "Coming soon" teaser cards shown after the last chapter.
  final int comingSoonChapters;

  GameContent({required this.chapters, required List<LevelData> levels, this.comingSoonChapters = 1})
    : _levels = {for (final l in levels) l.id: l} {
    for (final c in chapters) {
      for (final id in c.levelIds) {
        assert(_levels.containsKey(id), 'Chapter ${c.id} references unknown level $id');
      }
    }
  }

  factory GameContent.standard() => GameContent(
    chapters: const [houseChapter, farmChapter, restaurantChapter, beachChapter, mansionChapter],
    levels: [...houseLevels, ...farmLevels, ...restaurantLevels, ...beachLevels, ...mansionLevels],
  );

  LevelData? level(String id) => _levels[id];
  Iterable<LevelData> get allLevels => _levels.values;

  ChapterData? chapter(String id) {
    for (final c in chapters) {
      if (c.id == id) return c;
    }
    return null;
  }

  List<LevelData> levelsOf(String chapterId) => [for (final id in chapter(chapterId)?.levelIds ?? const <String>[]) _levels[id]!];

  /// Next level in the chapter, or the first level of the following chapter.
  LevelData? nextLevel(String levelId) {
    final lvl = _levels[levelId];
    if (lvl == null) return null;
    final ch = chapter(lvl.chapterId)!;
    final i = ch.levelIds.indexOf(levelId);
    if (i + 1 < ch.levelIds.length) return _levels[ch.levelIds[i + 1]];
    final ci = chapters.indexOf(ch);
    if (ci + 1 < chapters.length) {
      final next = chapters[ci + 1];
      if (next.levelIds.isNotEmpty) return _levels[next.levelIds.first];
    }
    return null;
  }

  bool isLastInChapter(String levelId) {
    final lvl = _levels[levelId];
    if (lvl == null) return false;
    return chapter(lvl.chapterId)!.levelIds.last == levelId;
  }
}
