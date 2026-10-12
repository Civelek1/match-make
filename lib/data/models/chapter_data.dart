/// A chapter groups several levels that restore one location (House, Farm...).
class ChapterData {
  final String id;
  final int number;

  /// Ordered level ids. Unlock order follows each level's unlockRequirement.
  final List<String> levelIds;

  /// Chapter that must be completed before this one opens (null = first).
  final String? requiresChapterId;

  /// Key for the chapter map / main-menu artwork.
  final String mapArtId;

  const ChapterData({
    required this.id,
    required this.number,
    required this.levelIds,
    required this.mapArtId,
    this.requiresChapterId,
  });

  String get nameKey => 'chapter.$id';
  int get maxStars => levelIds.length * 3;
}
