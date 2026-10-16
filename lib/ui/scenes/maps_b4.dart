import 'dart:math';

import 'package:flutter/material.dart';

import '../art/paint_kit.dart';
import 'house_map_art.dart';
import 'location_map_art.dart';

/// Chapter maps for content batch 4 (hand-drawn; see LocationMapArt).
final Map<String, ChapterMapArt> batch4Maps = {
  'ice_palace': _icePalaceMap,
  'hot_springs': _hotSpringsMap,
  'space_base': _spaceBaseMap,
  'grand_hotel': _grandHotelMap,
  'royal_palace': _royalPalaceMap,
};

// Design space 360×640; buildings stand on the ground band at groundY.

Paint _grad(Rect r, Color top, Color bottom) =>
    Paint()..shader = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [top, bottom]).createShader(r);

void _mapStars(Canvas c, Rect area, int n, double ov, double t, [int seed = 0]) {
  for (var i = 0; i < n; i++) {
    final tw = 0.55 + 0.45 * sin(t * 2 + i * 1.7);
    c.drawCircle(Offset(area.left + Pk.rand(i + seed) * area.width, area.top + Pk.rand(i + seed + 31) * area.height), 0.8 + Pk.rand(i + seed + 7) * 1.2,
        Pk.fill(Colors.white.withValues(alpha: (0.2 + 0.7 * ov) * tw)));
  }
}

void _flag(Canvas c, Offset top, Color col, double t) {
  c.drawLine(top, top + const Offset(0, 22), Pk.stroke(const Color(0xFF5A4E46), 1.6));
  final wave = sin(t * 3 + top.dx) * 2;
  Pk.poly(c, [top, top + Offset(16, 4 + wave), top + const Offset(0, 9)], Pk.fill(col));
}

// ------------------------------------------------------------------ ICE PALACE

void _iceTowerShape(Canvas c, Rect body, Color wall, Color roof, Color glow, double ov) {
  Pk.box(c, body, wall, radius: 2);
  c.drawLine(Offset(body.left + body.width * 0.22, body.top + 6), Offset(body.left + body.width * 0.22, body.bottom - 6), Pk.stroke(Colors.white.withValues(alpha: 0.5), 2));
  Pk.poly(c, [Offset(body.left - 8, body.top + 2), Offset(body.center.dx, body.top - body.width * 1.1), Offset(body.right + 8, body.top + 2)], Pk.fill(roof));
  Pk.poly(c, [Offset(body.center.dx, body.top - body.width * 1.1), Offset(body.right + 8, body.top + 2), Offset(body.center.dx, body.top + 2)], Pk.fill(Pk.dark(roof, 0.1)));
}

void _icePalaceScenery(Canvas c, LocationMapArt art, double ov, double t) {
  for (final (x, h, w) in [(-60.0, 250.0, 260.0), (150.0, 300.0, 280.0)]) {
    final peak = Offset(x + w / 2, 460 - h);
    Pk.poly(c, [Offset(x, 460), peak, Offset(x + w, 460)], Pk.fill(Pk.mix(const Color(0xFFA8B0BA), const Color(0xFF8FB4E6), ov)));
    Pk.poly(c, [peak + const Offset(-34, 48), peak, peak + const Offset(34, 48)], Pk.fill(Colors.white));
  }
  // Aurora over the palace once it is restored.
  for (var i = 0; i <= 40; i++) {
    final k = i / 40;
    final x = -10 + 380 * k;
    final y = 120 + 40 * sin(k * 5 + t * 0.4);
    final ray = Rect.fromLTWH(x - 4, y, 8, 70 + 30 * sin(k * 7 + t));
    c.drawRect(ray, _grad(ray, const Color(0xFF7FFFC8).withValues(alpha: 0.4 * ov), const Color(0x007FFFC8)));
  }
  art.paintGround(c, ov);
  final ice = Pk.mix(const Color(0xFFB7C3CC), const Color(0xFFDDF3FF), ov);
  final roof = Pk.mix(const Color(0xFF8A96A8), const Color(0xFF6FB8F0), ov);
  final glow = Pk.mix(const Color(0xFF3E3A40), const Color(0xFFB8F0FF), ov);
  Pk.shadow(c, const Offset(180, 462), 330, 20);
  // Curtain wall with crenellations.
  c.drawRect(const Rect.fromLTWH(30, 340, 300, 120), Pk.fill(ice));
  for (var i = 0; i < 15; i++) {
    c.drawRect(Rect.fromLTWH(32 + i * 20.0, 330, 12, 12), Pk.fill(ice));
  }
  for (var y = 0; y < 6; y++) {
    for (var x = 0; x < 8; x++) {
      c.drawRect(Rect.fromLTWH(30 + x * 40.0 - (y.isOdd ? 20 : 0), 342 + y * 20.0, 40, 20), Pk.stroke(Pk.dark(ice, 0.1), 1));
    }
  }
  // Keep and towers.
  _iceTowerShape(c, const Rect.fromLTWH(120, 210, 120, 140), Pk.light(ice, 0.1), roof, glow, ov);
  _iceTowerShape(c, const Rect.fromLTWH(18, 250, 60, 210), ice, roof, glow, ov);
  _iceTowerShape(c, const Rect.fromLTWH(282, 250, 60, 210), ice, roof, glow, ov);
  // Gate arch with icicles.
  final arch = Path()
    ..moveTo(150, 460)
    ..lineTo(150, 424)
    ..quadraticBezierTo(180, 396, 210, 424)
    ..lineTo(210, 460)
    ..close();
  c.drawPath(arch, Pk.fill(Pk.mix(const Color(0xFF5A6070), const Color(0xFF6FD3FF), ov)));
  for (var i = 0; i < 14; i++) {
    final x = 34 + i * 21.0;
    Pk.poly(c, [Offset(x, 342), Offset(x + 8, 342), Offset(x + 4, 354 + (i % 3) * 4.0)], Pk.fill(Pk.light(ice, 0.3)));
  }
  _flag(c, const Offset(180, 116), Pk.mix(const Color(0xFF9A9AA6), const Color(0xFF4FD6E8), ov), t);
  for (var i = 0; i < 24; i++) {
    final x = (Pk.rand(i + 3) * 380 + t * (6 + Pk.rand(i) * 6)) % 380 - 10;
    final y = (Pk.rand(i + 11) * 640 + t * (16 + Pk.rand(i + 5) * 10)) % 640;
    c.drawCircle(Offset(x, y), 1.2 + Pk.rand(i + 2) * 1.4, Pk.fill(Colors.white.withValues(alpha: 0.8)));
  }
}

final _icePalaceMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _icePalaceScenery,
  groundN: const Color(0xFFB9B6AE),
  groundR: const Color(0xFFF4FAFF),
  groundY: 460,
  skyTopR: const Color(0xFF3E6AB8),
  skyBottomR: const Color(0xFFCFEAFF),
  spots: const [
    MapSpot('ice_palace_gate', Offset(180, 538), Rect.fromLTWH(95, 498, 170, 84), SpotKind.yard, Color(0xFFBFEFFF)),
    MapSpot('ice_palace_throne', Offset(98, 396), Rect.fromLTWH(66, 374, 64, 44), SpotKind.window, Color(0xFF8FB8FF)),
    MapSpot('ice_palace_ballroom', Offset(262, 396), Rect.fromLTWH(230, 374, 64, 44), SpotKind.window, Color(0xFFC59BFF)),
    MapSpot('ice_palace_garden', Offset(48, 300), Rect.fromLTWH(30, 278, 36, 44), SpotKind.window, Color(0xFF7FE0C8)),
    MapSpot('ice_palace_balcony', Offset(180, 262), Rect.fromLTWH(150, 238, 60, 48), SpotKind.window, Color(0xFF7CFFC8)),
  ],
);

// ------------------------------------------------------------------ HOT SPRINGS

void _pagodaRoof(Canvas c, double left, double right, double y, double rise, Color col) {
  final p = Path()
    ..moveTo(left - 18, y + 6)
    ..quadraticBezierTo(left + 10, y, left + 26, y - rise)
    ..lineTo(right - 26, y - rise)
    ..quadraticBezierTo(right - 10, y, right + 18, y + 6)
    ..close();
  c.drawPath(p, Pk.fill(col));
  c.drawRect(Rect.fromLTWH(left - 14, y + 2, right - left + 28, 5), Pk.fill(Pk.dark(col, 0.25)));
}

void _hotSpringsScenery(Canvas c, LocationMapArt art, double ov, double t) {
  for (final (x, h, w) in [(-80.0, 260.0, 280.0), (120.0, 320.0, 320.0)]) {
    final peak = Offset(x + w / 2, 460 - h);
    Pk.poly(c, [Offset(x, 460), peak, Offset(x + w, 460)], Pk.fill(Pk.mix(const Color(0xFFA8AAA0), const Color(0xFF8FA8D0), ov)));
    Pk.poly(c, [peak + const Offset(-30, 40), peak, peak + const Offset(30, 40)], Pk.fill(Colors.white));
  }
  final hill = Path()
    ..moveTo(-20, 470)
    ..quadraticBezierTo(90, 420, 180, 440)
    ..quadraticBezierTo(280, 410, 380, 450)
    ..lineTo(380, 480)
    ..lineTo(-20, 480)
    ..close();
  c.drawPath(hill, Pk.fill(Pk.mix(const Color(0xFFA7AE8C), const Color(0xFF6FB85A), ov)));
  art.paintGround(c, ov);
  final wall = Pk.mix(const Color(0xFFC9BFAE), const Color(0xFFFFF4E0), ov);
  final wood = Pk.mix(const Color(0xFF8C7E6C), const Color(0xFF8A4A2E), ov);
  final roof = Pk.mix(const Color(0xFF6E6A70), const Color(0xFF3E4A5E), ov);
  Pk.shadow(c, const Offset(180, 462), 320, 18);
  // Ground floor (baths + steam room).
  Pk.box(c, const Rect.fromLTWH(36, 350, 288, 110), wall, radius: 2);
  for (var i = 0; i <= 8; i++) {
    c.drawRect(Rect.fromLTWH(36 + i * 35.0, 350, 5, 110), Pk.fill(wood));
  }
  _pagodaRoof(c, 36, 324, 350, 26, roof);
  // Upper floor (tea room + terrace).
  Pk.box(c, const Rect.fromLTWH(80, 250, 200, 76), wall, radius: 2);
  for (var i = 0; i <= 5; i++) {
    c.drawRect(Rect.fromLTWH(80 + i * 39.0, 250, 5, 76), Pk.fill(wood));
  }
  _pagodaRoof(c, 80, 280, 250, 30, roof);
  // Top pavilion.
  Pk.box(c, const Rect.fromLTWH(140, 180, 80, 44), wall, radius: 2);
  _pagodaRoof(c, 140, 220, 180, 26, roof);
  c.drawLine(const Offset(180, 154), const Offset(180, 132), Pk.stroke(Pk.mix(const Color(0xFF9A8C7A), const Color(0xFFFFC93C), ov), 3));
  // Steaming pools by the path.
  for (final (x, w) in [(18.0, 70.0), (272.0, 70.0)]) {
    c.drawOval(Rect.fromLTWH(x, 470, w, 26), Pk.fill(const Color(0xFF8A847A)));
    c.drawOval(Rect.fromLTWH(x + 6, 474, w - 12, 18), Pk.fill(Pk.mix(const Color(0xFF7FA3AE), const Color(0xFF4FD6E8), ov)));
  }
  for (var i = 0; i < 8; i++) {
    final k = (t * 0.2 + i / 8) % 1;
    final x = (i.isEven ? 50.0 : 306.0) + sin(t + i) * 8;
    c.drawCircle(Offset(x, 478 - k * 90), 6 + k * 12, Pk.fill(Colors.white.withValues(alpha: 0.45 * (1 - k))));
  }
  // Lanterns along the eaves.
  for (var i = 0; i < 7; i++) {
    final p = Offset(60 + i * 40.0, 366);
    Pk.glow(c, p, 12, const Color(0xFFFFB347), 0.6 * ov);
    c.drawOval(Rect.fromCenter(center: p, width: 9, height: 12), Pk.fill(Pk.mix(const Color(0xFF9A8C7A), const Color(0xFFE0533F), ov)));
  }
}

final _hotSpringsMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _hotSpringsScenery,
  groundN: const Color(0xFFA89A80),
  groundR: const Color(0xFFC9B48A),
  groundY: 460,
  skyTopR: const Color(0xFF7FB8E8),
  skyBottomR: const Color(0xFFFFE0D0),
  spots: const [
    MapSpot('hot_springs_path', Offset(180, 545), Rect.fromLTWH(100, 510, 160, 76), SpotKind.yard, Color(0xFFC9B48A)),
    MapSpot('hot_springs_baths', Offset(98, 410), Rect.fromLTWH(64, 386, 68, 48), SpotKind.window, Color(0xFF6FE0D0)),
    MapSpot('hot_springs_steam', Offset(262, 410), Rect.fromLTWH(228, 386, 68, 48), SpotKind.window, Color(0xFFFF9A5C)),
    MapSpot('hot_springs_tea', Offset(112, 292), Rect.fromLTWH(88, 270, 48, 42), SpotKind.window, Color(0xFFFF8AB0)),
    MapSpot('hot_springs_terrace', Offset(248, 292), Rect.fromLTWH(224, 270, 48, 42), SpotKind.window, Color(0xFFFFC46B)),
  ],
);

// ------------------------------------------------------------------ SPACE BASE

void _spaceBaseScenery(Canvas c, LocationMapArt art, double ov, double t) {
  final sky = const Rect.fromLTWH(-200, -100, 760, 560);
  c.drawRect(sky, _grad(sky, Pk.mix(const Color(0xFF4A4E5A), const Color(0xFF0A0E2A), ov), Pk.mix(const Color(0xFF8A8E96), const Color(0xFF3A2A6E), ov)));
  _mapStars(c, const Rect.fromLTWH(0, 0, 360, 420), 70, ov, t);
  // Earth.
  const ep = Offset(80, 120);
  Pk.glow(c, ep, 60, const Color(0xFF7FD0FF), 0.15 + 0.35 * ov);
  c.drawCircle(ep, 38, Pk.fill(Pk.mix(const Color(0xFF7890A0), const Color(0xFF2E8FE0), ov)));
  c.drawOval(Rect.fromCenter(center: ep + const Offset(-10, -6), width: 30, height: 20), Pk.fill(Pk.mix(const Color(0xFF8A9A80), const Color(0xFF4FC94A), ov)));
  c.drawOval(Rect.fromCenter(center: ep + const Offset(14, 16), width: 22, height: 14), Pk.fill(Pk.mix(const Color(0xFF8A9A80), const Color(0xFF4FC94A), ov)));
  c.drawCircle(ep + const Offset(16, 4), 40, Pk.fill(Colors.black.withValues(alpha: 0.25)));
  // Grey regolith with craters.
  art.paintGround(c, ov);
  for (final (x, y, s) in [(50.0, 600.0, 60.0), (300.0, 590.0, 70.0), (250.0, 500.0, 30.0), (40.0, 490.0, 26.0)]) {
    c.drawOval(Rect.fromCenter(center: Offset(x, y), width: s, height: s * 0.3), Pk.fill(Colors.black.withValues(alpha: 0.15)));
  }
  final hull = Pk.mix(const Color(0xFF9A9EA8), const Color(0xFFE6EEF8), ov);
  final trim = Pk.mix(const Color(0xFF6E7285), const Color(0xFFFF7A5C), ov);
  Pk.shadow(c, const Offset(180, 462), 330, 18);
  // Rocket on its pad.
  Pk.box(c, const Rect.fromLTWH(296, 300, 36, 160), hull, radius: 14);
  Pk.poly(c, const [Offset(296, 312), Offset(314, 240), Offset(332, 312)], Pk.fill(trim));
  Pk.poly(c, const [Offset(296, 420), Offset(282, 460), Offset(296, 452)], Pk.fill(trim));
  Pk.poly(c, const [Offset(332, 420), Offset(346, 460), Offset(332, 452)], Pk.fill(trim));
  c.drawCircle(const Offset(314, 330), 7, Pk.fill(Pk.mix(const Color(0xFF5A6070), const Color(0xFF4FE3FF), ov)));
  // Side modules.
  Pk.box(c, const Rect.fromLTWH(16, 368, 112, 92), hull, radius: 10);
  Pk.box(c, const Rect.fromLTWH(206, 368, 86, 92), hull, radius: 10);
  for (final x in [16.0, 206.0]) {
    c.drawRect(Rect.fromLTWH(x, 440, x == 16 ? 112 : 86, 4), Pk.fill(trim));
  }
  // Central dome (greenhouse) and observation tower.
  c.drawRect(const Rect.fromLTWH(170, 220, 20, 120), Pk.fill(Pk.dark(hull, 0.1)));
  Pk.box(c, const Rect.fromLTWH(146, 206, 68, 52), hull, radius: 14);
  c.drawArc(const Rect.fromLTWH(92, 320, 176, 280), pi, pi, true, Pk.fill(Pk.mix(const Color(0xFF8A9A9E), const Color(0xFFBFEFFF), ov).withValues(alpha: 0.9)));
  for (var i = 1; i < 6; i++) {
    c.drawLine(Offset(92 + i * 29.3, 460), Offset(180 + (i - 3) * 22.0, 324), Pk.stroke(Colors.white.withValues(alpha: 0.6), 1.5));
  }
  c.drawArc(const Rect.fromLTWH(92, 320, 176, 280), pi, pi, false, Pk.stroke(Pk.dark(hull, 0.2), 3));
  Pk.glow(c, const Offset(214, 210), 10, const Color(0xFFFF4A4A), sin(t * 4) > 0 ? 0.8 * ov + 0.1 : 0.1);
  // Radar dish on the left module.
  c.drawArc(const Rect.fromLTWH(30, 330, 44, 30), 0.2, pi - 0.4, true, Pk.fill(hull));
  c.drawLine(const Offset(52, 352), const Offset(52, 368), Pk.stroke(trim, 3));
}

final _spaceBaseMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _spaceBaseScenery,
  groundN: const Color(0xFF8A8A8E),
  groundR: const Color(0xFFB8B4C8),
  groundY: 460,
  spots: const [
    MapSpot('space_base_pad', Offset(180, 545), Rect.fromLTWH(100, 508, 160, 78), SpotKind.yard, Color(0xFFFF7A5C)),
    MapSpot('space_base_control', Offset(72, 408), Rect.fromLTWH(40, 388, 64, 40), SpotKind.window, Color(0xFF4FD6E8)),
    MapSpot('space_base_greenhouse', Offset(180, 360), Rect.fromLTWH(150, 342, 60, 36), SpotKind.window, Color(0xFF7ACB52)),
    MapSpot('space_base_quarters', Offset(258, 408), Rect.fromLTWH(232, 388, 52, 40), SpotKind.window, Color(0xFFFFB35C)),
    MapSpot('space_base_deck', Offset(180, 232), Rect.fromLTWH(156, 216, 48, 32), SpotKind.window, Color(0xFF9CF0FF)),
  ],
);

// ------------------------------------------------------------------ GRAND HOTEL

void _grandHotelScenery(Canvas c, LocationMapArt art, double ov, double t) {
  // City skyline behind the hotel.
  for (var i = 0; i < 9; i++) {
    final bw = 34 + Pk.rand(i) * 20;
    final bh = 120 + Pk.rand(i + 9) * 140;
    c.drawRect(Rect.fromLTWH(i * 42.0 - 10, 460 - bh, bw, bh), Pk.fill(Pk.mix(const Color(0xFFA0A4AC), const Color(0xFF9FB4D8), ov)));
  }
  art.paintGround(c, ov);
  final wall = Pk.mix(const Color(0xFFC9BFAE), const Color(0xFFFFF0DC), ov);
  final trim = Pk.mix(const Color(0xFF8C7E6C), const Color(0xFFC98A52), ov);
  final glass = Pk.mix(const Color(0xFF6E7A80), const Color(0xFFFFE3A0), ov);
  Pk.shadow(c, const Offset(180, 462), 320, 18);
  Pk.box(c, const Rect.fromLTWH(56, 170, 248, 290), wall, radius: 2);
  for (final y in [222.0, 274.0, 348.0]) {
    c.drawRect(Rect.fromLTWH(52, y, 256, 4), Pk.fill(trim));
  }
  for (var row = 0; row < 5; row++) {
    for (var col = 0; col < 6; col++) {
      final win = Rect.fromLTWH(70 + col * 38.0, 184 + row * 34.0, 18, 22);
      c.drawRRect(RRect.fromRectAndCorners(win, topLeft: const Radius.circular(9), topRight: const Radius.circular(9)), Pk.fill(glass));
    }
  }
  // Rooftop: pool deck with a railing and a neon crown.
  c.drawRect(const Rect.fromLTWH(48, 160, 264, 12), Pk.fill(trim));
  for (var i = 0; i < 17; i++) {
    c.drawRect(Rect.fromLTWH(52 + i * 16.0, 140, 3, 20), Pk.fill(trim));
  }
  c.drawRect(const Rect.fromLTWH(52, 140, 256, 3), Pk.fill(trim));
  final sign = const Rect.fromLTWH(130, 104, 100, 26);
  c.drawRRect(RRect.fromRectAndRadius(sign, const Radius.circular(6)), Pk.fill(Pk.mix(const Color(0xFF6E6478), const Color(0xFF7A2E4A), ov)));
  for (var i = 0; i < 5; i++) {
    final s = Offset(146 + i * 17.0, 117);
    Pk.glow(c, s, 9, const Color(0xFFFFE066), 0.5 * ov);
    Pk.sparkle(c, s, 4, Pk.mix(const Color(0xFF9A9AA6), const Color(0xFFFFE066), ov));
  }
  // Grand entrance canopy at the bottom.
  Pk.poly(c, const [Offset(132, 404), Offset(228, 404), Offset(240, 424), Offset(120, 424)], Pk.fill(Pk.mix(const Color(0xFF9A7E78), const Color(0xFFB8283E), ov)));
  c.drawRect(const Rect.fromLTWH(150, 424, 60, 36), Pk.fill(Pk.mix(const Color(0xFF5A6070), const Color(0xFFBFEFFA), ov)));
  for (final x in [124.0, 234.0]) {
    c.drawRect(Rect.fromLTWH(x, 424, 3, 36), Pk.fill(trim));
  }
}

final _grandHotelMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _grandHotelScenery,
  groundN: const Color(0xFFA8A296),
  groundR: const Color(0xFFE6DCCB),
  groundY: 460,
  skyTopR: const Color(0xFF5E8EE8),
  skyBottomR: const Color(0xFFFFD8C2),
  spots: const [
    MapSpot('grand_hotel_entrance', Offset(180, 538), Rect.fromLTWH(95, 498, 170, 84), SpotKind.yard, Color(0xFFE0533F)),
    MapSpot('grand_hotel_lobby', Offset(180, 374), Rect.fromLTWH(140, 354, 80, 40), SpotKind.window, Color(0xFFFFB347)),
    MapSpot('grand_hotel_ballroom', Offset(100, 298), Rect.fromLTWH(66, 280, 68, 38), SpotKind.window, Color(0xFFFF7AB6)),
    MapSpot('grand_hotel_suite', Offset(260, 246), Rect.fromLTWH(226, 228, 68, 38), SpotKind.window, Color(0xFFE0B8FF)),
    MapSpot('grand_hotel_pool', Offset(180, 150), Rect.fromLTWH(70, 140, 220, 22), SpotKind.window, Color(0xFF4FD6E8)),
  ],
);

// ------------------------------------------------------------------ ROYAL PALACE

void _royalPalaceScenery(Canvas c, LocationMapArt art, double ov, double t) {
  art.paintGround(c, ov);
  final wall = Pk.mix(const Color(0xFFBFB6A6), const Color(0xFFFFF4E0), ov);
  final gold = Pk.mix(const Color(0xFF9A8C7A), const Color(0xFFFFC93C), ov);
  final roof = Pk.mix(const Color(0xFF6E6A70), const Color(0xFF3E5AA8), ov);
  final glass = Pk.mix(const Color(0xFF6E7A80), const Color(0xFF8ED8FF), ov);
  Pk.shadow(c, const Offset(180, 462), 340, 20);
  // Wings.
  Pk.box(c, const Rect.fromLTWH(14, 320, 332, 140), wall, radius: 2);
  c.drawRect(const Rect.fromLTWH(10, 314, 340, 8), Pk.fill(gold));
  for (var i = 0; i < 12; i++) {
    c.drawRect(Rect.fromLTWH(14 + i * 28.0, 302, 14, 14), Pk.fill(wall));
  }
  for (var i = 0; i < 8; i++) {
    final x = 24 + i * 42.0;
    if (x > 120 && x < 230) continue;
    final win = Rect.fromLTWH(x, 336, 16, 26);
    c.drawRRect(RRect.fromRectAndCorners(win, topLeft: const Radius.circular(8), topRight: const Radius.circular(8)), Pk.fill(glass));
    c.drawRect(Rect.fromLTWH(x, 404, 16, 26), Pk.fill(glass));
  }
  // Corner towers with domes and flags.
  for (final x in [6.0, 314.0]) {
    Pk.box(c, Rect.fromLTWH(x, 260, 40, 200), Pk.dark(wall, 0.05), radius: 2);
    c.drawArc(Rect.fromLTWH(x - 4, 236, 48, 48), pi, pi, true, Pk.fill(roof));
    _flag(c, Offset(x + 20, 214), Pk.mix(const Color(0xFF9A9AA6), const Color(0xFFB8283E), ov), t);
  }
  // Central hall with the great dome (ballroom).
  Pk.box(c, const Rect.fromLTWH(118, 270, 124, 190), Pk.light(wall, 0.15), radius: 2);
  for (var i = 0; i < 5; i++) {
    c.drawRect(Rect.fromLTWH(124 + i * 26.0, 300, 8, 160), Pk.fill(Pk.light(wall, 0.35)));
  }
  c.drawRect(const Rect.fromLTWH(112, 264, 136, 8), Pk.fill(gold));
  final dome = Path()
    ..moveTo(122, 266)
    ..quadraticBezierTo(180, 150, 238, 266)
    ..close();
  c.drawPath(dome, Pk.fill(roof));
  c.drawPath(
    Path()
      ..moveTo(150, 262)
      ..quadraticBezierTo(165, 196, 180, 178),
    Pk.stroke(Colors.white.withValues(alpha: 0.3), 4),
  );
  c.drawLine(const Offset(180, 210), const Offset(180, 176), Pk.stroke(gold, 3));
  // A crown on top of the dome.
  Pk.poly(c, const [Offset(166, 178), Offset(164, 158), Offset(172, 166), Offset(180, 152), Offset(188, 166), Offset(196, 158), Offset(194, 178)], Pk.fill(gold));
  Pk.glow(c, const Offset(180, 166), 30, const Color(0xFFFFE066), 0.5 * ov);
  // Golden gate arch.
  final arch = Path()
    ..moveTo(150, 460)
    ..lineTo(150, 418)
    ..quadraticBezierTo(180, 388, 210, 418)
    ..lineTo(210, 460)
    ..close();
  c.drawPath(arch, Pk.fill(Pk.mix(const Color(0xFF5A5060), const Color(0xFF3A2A4E), ov)));
  c.drawPath(arch, Pk.stroke(gold, 4));
  // Fireworks for the grand finale once everything is restored.
  if (ov > 0.5) {
    for (var i = 0; i < 3; i++) {
      final k = (t * 0.45 + i / 3) % 1;
      final cc = Offset(60 + i * 120.0, 90 + (i % 2) * 40.0);
      final rr = 14 + 26 * k;
      final a = (1 - k) * (ov - 0.5) * 2;
      for (var s = 0; s < 12; s++) {
        final ang = s * pi / 6;
        c.drawLine(cc + Offset(cos(ang), sin(ang)) * rr * 0.4, cc + Offset(cos(ang), sin(ang)) * rr,
            Pk.stroke([const Color(0xFFFFE066), const Color(0xFFFF7AB6), const Color(0xFF7FE0FF)][i].withValues(alpha: a), 2));
      }
    }
  }
}

final _royalPalaceMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _royalPalaceScenery,
  groundN: const Color(0xFFB39460),
  groundR: const Color(0xFF5DB848),
  groundY: 460,
  skyTopR: const Color(0xFF4A6ED8),
  skyBottomR: const Color(0xFFFFE0B0),
  spots: const [
    MapSpot('royal_palace_gardens', Offset(180, 540), Rect.fromLTWH(95, 500, 170, 84), SpotKind.yard, Color(0xFF7ACB52)),
    MapSpot('royal_palace_gate', Offset(180, 432), Rect.fromLTWH(154, 414, 52, 40), SpotKind.window, Color(0xFFFFD447)),
    MapSpot('royal_palace_throne', Offset(84, 382), Rect.fromLTWH(54, 366, 60, 34), SpotKind.window, Color(0xFFB88AD8)),
    MapSpot('royal_palace_library', Offset(276, 382), Rect.fromLTWH(246, 366, 60, 34), SpotKind.window, Color(0xFFE0A050)),
    MapSpot('royal_palace_ballroom', Offset(180, 228), Rect.fromLTWH(152, 206, 56, 44), SpotKind.window, Color(0xFFFFE066)),
  ],
);
