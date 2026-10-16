import 'package:flutter/material.dart';

import 'batch_1_theme.dart';
import 'batch_2_theme.dart';
import 'batch_3_theme.dart';
import 'batch_4_theme.dart';

class GameColors {
  static const ink = Color(0xFF3B2A5A); // text stroke / outlines
  static const inkSoft = Color(0xFF6B5A8A);
  static const cream = Color(0xFFFFF6E6);
  static const creamDark = Color(0xFFF3DDB8);
  static const panelBorder = Color(0xFFE2B77A);
  static const gold = Color(0xFFFFC93C);
  static const goldDark = Color(0xFFE59A12);
  static const green = Color(0xFF5BCB4B);
  static const greenDark = Color(0xFF2F9A35);
  static const blue = Color(0xFF45A7F5);
  static const blueDark = Color(0xFF2270C9);
  static const orange = Color(0xFFFF9A3C);
  static const orangeDark = Color(0xFFE0621B);
  static const red = Color(0xFFFF5D6C);
  static const redDark = Color(0xFFD1304A);
  static const purple = Color(0xFF9B6BFF);
  static const purpleDark = Color(0xFF6A3FD6);
  static const grey = Color(0xFFB9B3C7);
  static const greyDark = Color(0xFF8A839B);
  static const skyTop = Color(0xFF6EC6FF);
  static const skyBottom = Color(0xFFFFE3B3);
  static const star = Color(0xFFFFD447);
  static const starEmpty = Color(0xFFD9CBE6);
}

/// Per-location palette so each level feels distinct.
class EnvironmentTheme {
  final Color bgTop;
  final Color bgBottom;
  final Color boardFrame;
  final Color cellA;
  final Color cellB;
  final Color accent;
  final bool dark;

  const EnvironmentTheme({
    required this.bgTop,
    required this.bgBottom,
    required this.boardFrame,
    required this.cellA,
    required this.cellB,
    required this.accent,
    this.dark = false,
  });

  static const _fallback = EnvironmentTheme(
    bgTop: Color(0xFF7FD4FF),
    bgBottom: Color(0xFFB5F0A0),
    boardFrame: Color(0xFF3E8E4E),
    cellA: Color(0x33FFFFFF),
    cellB: Color(0x1FFFFFFF),
    accent: GameColors.green,
  );

  static const Map<String, EnvironmentTheme> _themes = {
    'garden': _fallback,
    'kitchen': EnvironmentTheme(
      bgTop: Color(0xFFFFD9A8),
      bgBottom: Color(0xFFFFB877),
      boardFrame: Color(0xFFA8622E),
      cellA: Color(0x40FFF3E0),
      cellB: Color(0x26FFF3E0),
      accent: GameColors.orange,
    ),
    'bathroom': EnvironmentTheme(
      bgTop: Color(0xFFBDF2FF),
      bgBottom: Color(0xFF6FD3E8),
      boardFrame: Color(0xFF2B8BA8),
      cellA: Color(0x40FFFFFF),
      cellB: Color(0x26FFFFFF),
      accent: Color(0xFF2EC4D6),
    ),
    'gaming_room': EnvironmentTheme(
      bgTop: Color(0xFF2B1B55),
      bgBottom: Color(0xFF14102E),
      boardFrame: Color(0xFF7A3CFF),
      cellA: Color(0x26B38CFF),
      cellB: Color(0x14B38CFF),
      accent: Color(0xFFFF4FD8),
      dark: true,
    ),
    'attic': EnvironmentTheme(
      bgTop: Color(0xFFFFB86B),
      bgBottom: Color(0xFFB0643A),
      boardFrame: Color(0xFF7A4526),
      cellA: Color(0x33FFE7C4),
      cellB: Color(0x1FFFE7C4),
      accent: Color(0xFFFF8A4C),
    ),
  };

  static EnvironmentTheme _t(int top, int bottom, int frame, int accent, {bool dark = false}) => EnvironmentTheme(
    bgTop: Color(top),
    bgBottom: Color(bottom),
    boardFrame: Color(frame),
    cellA: dark ? const Color(0x26B38CFF) : const Color(0x38FFFFFF),
    cellB: dark ? const Color(0x14B38CFF) : const Color(0x20FFFFFF),
    accent: Color(accent),
    dark: dark,
  );

  /// Chapters 2–5, one palette per location.
  static final Map<String, EnvironmentTheme> _chapterThemes = {
    // Farm: sunny greens and barn reds.
    'farmyard': _t(0xFFBDEB9C, 0xFF7CC35A, 0xFF5E8A2E, 0xFF7ACB52),
    'barn': _t(0xFFFFC9A0, 0xFFD2744A, 0xFF8C3A24, 0xFFE0533F),
    'chicken_coop': _t(0xFFFFF0B0, 0xFFE8C66B, 0xFF9A7A2E, 0xFFFFB347),
    'workshop': _t(0xFFCFE0F2, 0xFF8FA8C9, 0xFF4E6385, 0xFF45A7F5),
    'farmhouse': _t(0xFFFFE0B8, 0xFFE8A06A, 0xFF8B5E3C, 0xFFFF9A3C),
    // Restaurant: warm reds, creams and night blues.
    'entrance': _t(0xFFFFD9C2, 0xFFEE9A7A, 0xFF9A3B2E, 0xFFE0533F),
    'rest_kitchen': _t(0xFFE6F7F2, 0xFF9FD6C8, 0xFF3E8A78, 0xFF2EC4A6),
    'dining_hall': _t(0xFFF6C8C8, 0xFFB84A5A, 0xFF6E1F2E, 0xFFD94A6A),
    'terrace': _t(0xFFFFE6B8, 0xFFF0A86A, 0xFF9A5A2E, 0xFFFF8A4C),
    'vip_room': _t(0xFF3A1F5E, 0xFF1E0E30, 0xFF9B6BFF, 0xFFFFC93C, dark: true),
    // Beach resort: aqua, sand and sunset.
    'beach': _t(0xFFA8EEFF, 0xFFFFE0A0, 0xFF2B8BA8, 0xFF2EC4D6),
    'pool': _t(0xFFB8F6FF, 0xFF5FD0E8, 0xFF1E7F9A, 0xFF4FD6E8),
    'beach_bar': _t(0xFFFFE0B0, 0xFFF0A860, 0xFF9A5A2E, 0xFFFF7AB6),
    'hotel_room': _t(0xFFD8F1F0, 0xFF8FC8D0, 0xFF3E7F8A, 0xFF45A7F5),
    'rooftop': _t(0xFF2B1B55, 0xFF14102E, 0xFFFF4FD8, 0xFFFF7AD9, dark: true),
    // Mansion: royal purples and gold.
    'front_yard': _t(0xFFC8F0B0, 0xFF7ACB6A, 0xFF4E7A3E, 0xFF5BCB4B),
    'grand_hall': _t(0xFFF6EBD6, 0xFFD9B98C, 0xFF8B6A3C, 0xFFFFC93C),
    'luxury_bedroom': _t(0xFFF3D8E0, 0xFFC87A96, 0xFF7A2E4A, 0xFFE8A0B8),
    'cinema_room': _t(0xFF2A1433, 0xFF12081C, 0xFFD94A6A, 0xFFFF4F7A, dark: true),
    'penthouse': _t(0xFF3B2F5A, 0xFF1B1433, 0xFFB38CFF, 0xFFFFC93C, dark: true),
    // Castle.
    'castle_gate': _t(0xFFCFE3F5, 0xFF8FB0C9, 0xFF4E6385, 0xFFFFC93C),
    'banquet_hall': _t(0xFFFFE0B8, 0xFFD9955E, 0xFF8B4A2E, 0xFFE0533F),
    'castle_library': _t(0xFFE8D8C0, 0xFFB08A60, 0xFF6E4B3A, 0xFFB38CFF),
    'armory': _t(0xFFD6DCE6, 0xFF8E99AE, 0xFF3E4A63, 0xFFFF9A3C),
    'throne_room': _t(0xFFEAD6F5, 0xFFA77BC9, 0xFF5B2E7A, 0xFFFFC93C),
    // Mountain Lodge.
    'lodge_front': _t(0xFFE6F4FF, 0xFFA9CCE8, 0xFF4E7AA0, 0xFF45A7F5),
    'lodge_lounge': _t(0xFFFFE3C2, 0xFFE0A066, 0xFF8B4A2E, 0xFFFF9A3C),
    'ski_room': _t(0xFFDFF0FB, 0xFF8FB9D9, 0xFF2E5E86, 0xFF4FD6E8),
    'lodge_spa': _t(0xFFE3F7F2, 0xFF8FD3C3, 0xFF2E7F6E, 0xFF4FD6E8),
    'lodge_suite': _t(0xFFFFE6D6, 0xFFD99A7A, 0xFF7A3E2E, 0xFFE8A0B8),
    // Harbor.
    'harbor_dock': _t(0xFFCDEEFF, 0xFF7FC4E8, 0xFF1E5F8A, 0xFF2EC4D6),
    'fish_market': _t(0xFFDFF3FF, 0xFF8FC8E0, 0xFF2E6E8A, 0xFFFF9A3C),
    'boathouse': _t(0xFFD8E6F2, 0xFF8FA8C9, 0xFF3E5470, 0xFF45A7F5),
    'lighthouse_base': _t(0xFFD2ECFF, 0xFF6FAED8, 0xFF1B4E7A, 0xFFFFC93C),
    'keeper_cottage': _t(0xFFE6F0F6, 0xFF9FB8C9, 0xFF3E5A70, 0xFFFF9A3C),
    // Museum.
    'museum_steps': _t(0xFFF0F2F8, 0xFFB9C3D9, 0xFF56607A, 0xFFFFC93C),
    'sculpture_hall': _t(0xFFF6F2EA, 0xFFD3C7B0, 0xFF7A6A4E, 0xFFFFC93C),
    'art_gallery': _t(0xFFFBF6EE, 0xFFE3D3BC, 0xFF8B6A3C, 0xFFFF7AB6),
    'history_hall': _t(0xFFF2E6D0, 0xFFC9A87A, 0xFF6E4B2E, 0xFF45A7F5),
    'museum_cafe': _t(0xFFFFEEDC, 0xFFE8B98A, 0xFF8B5E3C, 0xFFE0533F),
    // Theater.
    'theater_front': _t(0xFF3A2A5E, 0xFF1B1433, 0xFFFF4FD8, 0xFFFFC93C, dark: true),
    'theater_lobby': _t(0xFFF6E6D2, 0xFFD9A87A, 0xFF7A2E3A, 0xFFFFC93C),
    'dressing_room': _t(0xFFFBE3EE, 0xFFE09AB8, 0xFF7A2E5A, 0xFFFF7AD9),
    'concert_hall': _t(0xFF2E1F4A, 0xFF140C24, 0xFFB38CFF, 0xFFFFC93C, dark: true),
    'grand_stage': _t(0xFF2B1B3A, 0xFF12081C, 0xFFFFC93C, 0xFFFF4F7A, dark: true),
  };

  static EnvironmentTheme of(String id) =>
      _themes[id] ?? _chapterThemes[id] ?? batch1Themes[id] ?? batch2Themes[id] ?? batch3Themes[id] ?? batch4Themes[id] ?? _fallback;
}
