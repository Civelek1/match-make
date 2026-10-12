import 'package:flutter/material.dart';

/// Icon shown on chapter cards / headers. Unknown chapters fall back to a map pin.
IconData chapterIcon(String chapterId) => switch (chapterId) {
  'house' => Icons.house_rounded,
  'farm' => Icons.agriculture_rounded,
  'restaurant' => Icons.restaurant_rounded,
  'beach' => Icons.beach_access_rounded,
  'mansion' => Icons.castle_rounded,
  _ => Icons.place_rounded,
};
