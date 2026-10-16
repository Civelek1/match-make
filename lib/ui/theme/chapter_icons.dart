import 'package:flutter/material.dart';

import 'batch_1_theme.dart';
import 'batch_2_theme.dart';
import 'batch_3_theme.dart';
import 'batch_4_theme.dart';

/// Icon shown on chapter cards / headers. Unknown chapters fall back to a map pin.
IconData chapterIcon(String chapterId) => switch (chapterId) {
  'house' => Icons.house_rounded,
  'farm' => Icons.agriculture_rounded,
  'restaurant' => Icons.restaurant_rounded,
  'beach' => Icons.beach_access_rounded,
  'mansion' => Icons.castle_rounded,
  'castle' => Icons.fort_rounded,
  'lodge' => Icons.downhill_skiing_rounded,
  'harbor' => Icons.anchor_rounded,
  'museum' => Icons.museum_rounded,
  'theater' => Icons.theater_comedy_rounded,
  _ => batch1Icons[chapterId] ?? batch2Icons[chapterId] ?? batch3Icons[chapterId] ?? batch4Icons[chapterId] ?? Icons.place_rounded,
};
