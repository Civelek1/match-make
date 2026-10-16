import 'dart:math';

import 'package:flutter/material.dart';

import '../art/paint_kit.dart';
import 'house_map_art.dart';
import 'location_map_art.dart';

/// Chapter maps for content batch 1 (chapters 11–15), hand-drawn on the
/// 360×640 map design space. Buildings sit on the ground band; each level's
/// [MapSpot] is a window or a yard that lights up once its level is done.
final Map<String, ChapterMapArt> batch1Maps = {
  'bakery': _bakeryMap,
  'greenhouse': _greenhouseMap,
  'vineyard': _vineyardMap,
  'train_station': _stationMap,
  'school': _schoolMap,
};

Color _m(int n, int r, double ov) => Pk.mix(Color(n), Color(r), ov);

void _brickLines(Canvas c, Rect area, Color mortar, {double bw = 22, double bh = 9}) {
  final p = Pk.stroke(mortar, 0.8);
  var row = 0;
  for (var y = area.top; y < area.bottom; y += bh) {
    c.drawLine(Offset(area.left, y), Offset(area.right, y), p);
    for (var x = area.left + (row.isEven ? 0 : bw / 2); x < area.right; x += bw) {
      c.drawLine(Offset(x, y), Offset(x, min(y + bh, area.bottom)), p);
    }
    row++;
  }
}

void _tree(Canvas c, Offset base, double s, Color leaf) {
  c.drawRect(Rect.fromCenter(center: base + Offset(0, -10 * s), width: 6 * s, height: 20 * s), Pk.fill(const Color(0xFF8B5E3C)));
  c.drawCircle(base + Offset(-8 * s, -26 * s), 13 * s, Pk.fill(Pk.dark(leaf, 0.12)));
  c.drawCircle(base + Offset(9 * s, -24 * s), 12 * s, Pk.fill(Pk.dark(leaf, 0.12)));
  c.drawCircle(base + Offset(0, -34 * s), 15 * s, Pk.fill(leaf));
}

void _smoke(Canvas c, Offset o, double t, double ov) {
  for (var i = 0; i < 3; i++) {
    final k = (t * 0.3 + i / 3) % 1;
    c.drawCircle(Offset(o.dx + sin(k * 6) * 6, o.dy - k * 40), 5 + k * 8, Pk.fill(Colors.white.withValues(alpha: (0.55 - k * 0.5) * ov)));
  }
}

// ------------------------------------------------------------------ BAKERY
void _bakeryScenery(Canvas c, LocationMapArt art, double ov, double t) {
  art.paintGround(c, ov);
  // Cobbled pavement in front of the shop.
  c.drawRect(const Rect.fromLTWH(-200, 452, 760, 26), Pk.fill(_m(0xFF9A948A, 0xFFD9CDB8, ov)));
  for (var x = -20.0; x < 380; x += 18) {
    c.drawLine(Offset(x, 452), Offset(x - 6, 478), Pk.stroke(Colors.black.withValues(alpha: 0.08), 1.2));
  }
  final wall = _m(0xFFB8AFA4, 0xFFFFE3D2, ov);
  final roof = _m(0xFF6E6260, 0xFF7A3E2E, ov);
  Pk.shadow(c, const Offset(180, 454), 310, 18);
  Pk.box(c, const Rect.fromLTWH(40, 240, 280, 212), wall, radius: 2);
  // Mansard roof with dormers.
  Pk.poly(c, const [Offset(28, 244), Offset(70, 180), Offset(290, 180), Offset(332, 244)], Pk.fill(roof));
  for (var x = 80.0; x < 290; x += 20) {
    c.drawLine(Offset(x, 182), Offset(x - 6, 242), Pk.stroke(Pk.dark(roof, 0.2), 1));
  }
  Pk.box(c, const Rect.fromLTWH(250, 140, 26, 50), _m(0xFF8A7F78, 0xFFB5523B, ov), radius: 1);
  _smoke(c, const Offset(263, 134), t, ov);
  // Shop sign and striped awning over the ground floor.
  Pk.box(c, const Rect.fromLTWH(100, 336, 160, 24), _m(0xFF8C7E6C, 0xFF5E3A2A, ov), radius: 4);
  c.drawLine(const Offset(120, 348), const Offset(240, 348), Pk.stroke(_m(0xFFB8AFA4, 0xFFFFC93C, ov), 3));
  for (var i = 0; i < 10; i++) {
    final x = 44 + i * 27.2;
    Pk.poly(c, [Offset(x, 364), Offset(x + 27.2, 364), Offset(x + 27.2, 380), Offset(x + 13.6, 388), Offset(x, 380)],
        Pk.fill(i.isEven ? _m(0xFF9A7E78, 0xFFE0533F, ov) : Colors.white));
  }
  // Front door between the shop windows.
  final door = const Rect.fromLTWH(160, 396, 40, 56);
  c.drawRRect(RRect.fromRectAndCorners(door, topLeft: const Radius.circular(20), topRight: const Radius.circular(20)), Pk.fill(_m(0xFF6E6A70, 0xFF2EA59A, ov)));
  c.drawCircle(const Offset(193, 428), 2, Pk.fill(const Color(0xFFFFC93C)));
  // Flower boxes under the upper windows.
  for (final x in [62.0, 230.0]) {
    Pk.box(c, Rect.fromLTWH(x, 318, 70, 8), _m(0xFF8A7F78, 0xFF8B5E3C, ov), radius: 2);
    for (var i = 0; i < 5; i++) {
      Pk.flower(c, Offset(x + 8 + i * 13.0, 314), 1.0, i.isEven ? _m(0xFFAAA49A, 0xFFFF7AB6, ov) : _m(0xFFAAA49A, 0xFFFFC93C, ov));
    }
  }
  // A lamppost and a bench on the pavement.
  c.drawRect(const Rect.fromLTWH(18, 380, 4, 74), Pk.fill(const Color(0xFF3B3452)));
  Pk.glow(c, const Offset(20, 378), 20, const Color(0xFFFFE9A0), 0.6 * ov);
  Pk.box(c, const Rect.fromLTWH(13, 370, 14, 12), _m(0xFFBDB6A4, 0xFFFFE9A0, ov), radius: 3);
  _tree(c, const Offset(340, 452), 1.0, _m(0xFF9A9E80, 0xFF5DB848, ov));
}

final _bakeryMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _bakeryScenery,
  groundN: const Color(0xFFA8A296),
  groundR: const Color(0xFF8CCB6A),
  groundY: 452,
  spots: const [
    MapSpot('bakery_front', Offset(180, 536), Rect.fromLTWH(95, 494, 170, 84), SpotKind.yard, Color(0xFFD29A5A)),
    MapSpot('bakery_kitchen', Offset(96, 418), Rect.fromLTWH(58, 396, 76, 44), SpotKind.window, Color(0xFFFFB35C)),
    MapSpot('bakery_cakes', Offset(264, 418), Rect.fromLTWH(226, 396, 76, 44), SpotKind.window, Color(0xFFFF9EC4)),
    MapSpot('bakery_store', Offset(96, 290), Rect.fromLTWH(64, 266, 64, 46), SpotKind.window, Color(0xFFFFE08A)),
    MapSpot('bakery_cafe', Offset(264, 290), Rect.fromLTWH(232, 266, 64, 46), SpotKind.window, Color(0xFF9FE3C9)),
  ],
);

// ------------------------------------------------------------------ GREENHOUSE
void _glassBlock(Canvas c, Path shape, Rect bounds, double ov, double t) {
  final frame = _m(0xFF9A9A92, 0xFFFFFFFF, ov);
  c.drawPath(shape, Pk.fill(_m(0xFF9AA8A6, 0xFFCFF3FF, ov).withValues(alpha: 0.9)));
  c.save();
  c.clipPath(shape);
  for (var i = 0; i < 8; i++) {
    c.drawCircle(Offset(bounds.left + Pk.rand(i + bounds.left.toInt()) * bounds.width, bounds.bottom - 6), 16 + Pk.rand(i + 7) * 14,
        Pk.fill(_m(0xFF8A9478, 0xFF5DB848, ov).withValues(alpha: 0.75)));
  }
  for (var i = 0; i < 3; i++) {
    final x = bounds.left + bounds.width * (0.2 + i * 0.3) + sin(t * 0.3 + i) * 4;
    c.drawLine(Offset(x, bounds.bottom), Offset(x + 40, bounds.top), Pk.stroke(Colors.white.withValues(alpha: 0.3), 6));
  }
  for (var x = bounds.left + 16; x < bounds.right; x += 16) {
    c.drawLine(Offset(x, bounds.top), Offset(x, bounds.bottom), Pk.stroke(frame, 1.2));
  }
  c.restore();
  c.drawPath(shape, Pk.stroke(frame, 3));
}

void _greenhouseScenery(Canvas c, LocationMapArt art, double ov, double t) {
  final hedge = _m(0xFF7E8A6A, 0xFF3F9A48, ov);
  for (var i = 0; i < 14; i++) {
    c.drawCircle(Offset(i * 28.0, 440 - Pk.rand(i) * 8), 20, Pk.fill(i.isEven ? hedge : Pk.dark(hedge, 0.08)));
  }
  art.paintGround(c, ov);
  Pk.shadow(c, const Offset(180, 457), 320, 18);
  // Side wings.
  for (final x in [24.0, 236.0]) {
    final r = Rect.fromLTWH(x, 322, 100, 133);
    final wing = Path()
      ..moveTo(r.left, r.bottom)
      ..lineTo(r.left, r.top + 24)
      ..lineTo(r.center.dx, r.top)
      ..lineTo(r.right, r.top + 24)
      ..lineTo(r.right, r.bottom)
      ..close();
    _glassBlock(c, wing, r, ov, t);
  }
  // Central palm dome.
  final dome = Path()
    ..moveTo(104, 455)
    ..lineTo(104, 300)
    ..quadraticBezierTo(180, 170, 256, 300)
    ..lineTo(256, 455)
    ..close();
  _glassBlock(c, dome, const Rect.fromLTWH(104, 210, 152, 245), ov, t);
  final frame = _m(0xFF9A9A92, 0xFFFFFFFF, ov);
  c.drawLine(const Offset(104, 300), const Offset(256, 300), Pk.stroke(frame, 2));
  c.drawLine(const Offset(104, 372), const Offset(256, 372), Pk.stroke(frame, 2));
  c.drawCircle(const Offset(180, 222), 6, Pk.fill(_m(0xFF9A9A92, 0xFFFFC93C, ov)));
  // Glass doors.
  Pk.box(c, const Rect.fromLTWH(160, 410, 40, 45), _m(0xFF8E9A98, 0xFFFFFFFF, ov), radius: 4);
  c.drawRect(const Rect.fromLTWH(165, 415, 30, 40), Pk.fill(_m(0xFF7A8A8A, 0xFF8ED8FF, ov)));
  c.drawLine(const Offset(180, 415), const Offset(180, 455), Pk.stroke(frame, 2));
  // Flower beds along the path.
  for (final x in [20.0, 250.0]) {
    c.drawOval(Rect.fromLTWH(x, 470, 90, 18), Pk.fill(_m(0xFF8A7A5E, 0xFF8A5E3A, ov)));
    for (var i = 0; i < 6; i++) {
      Pk.flower(c, Offset(x + 10 + i * 14.0, 474), 1.2, i.isEven ? _m(0xFFAAA49A, 0xFFFF7AB6, ov) : _m(0xFFAAA49A, 0xFFFFC93C, ov));
    }
  }
}

final _greenhouseMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _greenhouseScenery,
  groundN: const Color(0xFFB39460),
  groundR: const Color(0xFF6CC453),
  groundY: 455,
  spots: const [
    MapSpot('greenhouse_glass', Offset(130, 546), Rect.fromLTWH(48, 506, 164, 82), SpotKind.yard, Color(0xFF9CD86B)),
    MapSpot('greenhouse_orchids', Offset(74, 400), Rect.fromLTWH(44, 378, 60, 44), SpotKind.window, Color(0xFFC9A0FF)),
    MapSpot('greenhouse_seedlings', Offset(286, 400), Rect.fromLTWH(256, 378, 60, 44), SpotKind.window, Color(0xFFB8E07A)),
    MapSpot('greenhouse_palms', Offset(180, 318), Rect.fromLTWH(146, 294, 68, 50), SpotKind.window, Color(0xFF6FE0B0)),
    MapSpot('greenhouse_pond', Offset(290, 512), Rect.fromLTWH(236, 492, 110, 44), SpotKind.yard, Color(0xFF6FD0F0)),
  ],
);

// ------------------------------------------------------------------ VINEYARD
void _vineyardScenery(Canvas c, LocationMapArt art, double ov, double t) {
  final far = _m(0xFFA8A88E, 0xFF8CC86A, ov);
  final hills = Path()
    ..moveTo(-100, 430)
    ..quadraticBezierTo(60, 330, 200, 400)
    ..quadraticBezierTo(320, 360, 460, 390)
    ..lineTo(460, 470)
    ..lineTo(-100, 470)
    ..close();
  c.drawPath(hills, Pk.fill(far));
  for (final x in [24.0, 40.0, 320.0, 336.0]) {
    Pk.poly(c, [Offset(x - 7, 420), Offset(x, 360), Offset(x + 7, 420)], Pk.fill(_m(0xFF6E7A60, 0xFF2F6B3F, ov)));
  }
  art.paintGround(c, ov);
  // Vine rows on the slope in front of the house.
  for (var row = 0; row < 4; row++) {
    final y = 470 + row * 34.0;
    c.drawLine(Offset(-10, y + 6), Offset(370, y - 6), Pk.stroke(_m(0xFF8A7A5E, 0xFF8B5E3C, ov), 2));
    for (var i = 0; i < 12; i++) {
      final x = i * 32.0 + (row.isEven ? 0 : 16);
      final yy = y + 6 - x / 380 * 12;
      c.drawCircle(Offset(x, yy - 8), 9, Pk.fill(_m(0xFF8A9478, 0xFF4FA33A, ov)));
      if ((i + row) % 3 == 0) {
        c.drawCircle(Offset(x + 3, yy - 2), 3, Pk.fill(_m(0xFF8A8090, 0xFF6A3D8F, ov)));
      }
    }
  }
  final wall = _m(0xFFB8AFA4, 0xFFF4E2C4, ov);
  final roof = _m(0xFF8C7A70, 0xFFC8552F, ov);
  Pk.shadow(c, const Offset(175, 452), 300, 18);
  // Main house.
  Pk.box(c, const Rect.fromLTWH(36, 296, 196, 156), wall, radius: 2);
  Pk.poly(c, const [Offset(24, 300), Offset(134, 240), Offset(244, 300)], Pk.fill(roof));
  // Tower with a terrace on top.
  Pk.box(c, const Rect.fromLTWH(228, 228, 84, 224), Pk.dark(wall, 0.05), radius: 2);
  Pk.poly(c, const [Offset(220, 232), Offset(270, 196), Offset(320, 232)], Pk.fill(roof));
  // Pergola with vines over the barn door.
  c.drawRect(const Rect.fromLTWH(40, 362, 110, 6), Pk.fill(_m(0xFF7D6B5E, 0xFF6B4226, ov)));
  for (var i = 0; i < 9; i++) {
    c.drawCircle(Offset(46 + i * 13.0, 366), 7, Pk.fill(_m(0xFF8A9478, 0xFF4FA33A, ov)));
  }
  // Barrels by the cellar door.
  for (final x in [204.0, 318.0]) {
    Pk.box(c, Rect.fromLTWH(x, 428, 20, 24), _m(0xFF8A7A6A, 0xFF8B5E3C, ov), radius: 5);
    c.drawRect(Rect.fromLTWH(x, 433, 20, 2), Pk.fill(const Color(0xFF3B3452)));
    c.drawRect(Rect.fromLTWH(x, 445, 20, 2), Pk.fill(const Color(0xFF3B3452)));
  }
  _tree(c, const Offset(10, 452), 0.9, _m(0xFF9A9E80, 0xFF7C8B3A, ov));
}

final _vineyardMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _vineyardScenery,
  groundN: const Color(0xFFB39460),
  groundR: const Color(0xFFC9A46A),
  groundY: 452,
  skyBottomR: const Color(0xFFFFD9A8),
  spots: const [
    MapSpot('vineyard_rows', Offset(180, 548), Rect.fromLTWH(95, 506, 170, 84), SpotKind.yard, Color(0xFF9CD86B)),
    MapSpot('vineyard_press', Offset(92, 414), Rect.fromLTWH(58, 384, 68, 58), SpotKind.window, Color(0xFFC890E0)),
    MapSpot('vineyard_cellar', Offset(270, 418), Rect.fromLTWH(248, 392, 44, 50), SpotKind.window, Color(0xFFFFB35C)),
    MapSpot('vineyard_kitchen', Offset(150, 330), Rect.fromLTWH(118, 312, 64, 40), SpotKind.window, Color(0xFFFFD08A)),
    MapSpot('vineyard_terrace', Offset(270, 270), Rect.fromLTWH(246, 248, 48, 40), SpotKind.window, Color(0xFFFF9A6B)),
  ],
);

// ------------------------------------------------------------------ TRAIN STATION
void _stationScenery(Canvas c, LocationMapArt art, double ov, double t) {
  art.paintGround(c, ov, top: 460);
  // Tracks across the foreground.
  c.drawRect(const Rect.fromLTWH(-200, 486, 760, 34), Pk.fill(_m(0xFF8A8478, 0xFF9A8E7E, ov)));
  for (var x = -10.0; x < 380; x += 16) {
    c.drawRect(Rect.fromLTWH(x, 492, 9, 24), Pk.fill(_m(0xFF6E6258, 0xFF6B4A2E, ov)));
  }
  c.drawLine(const Offset(-10, 497), const Offset(370, 497), Pk.stroke(const Color(0xFFB8B4C0), 3));
  c.drawLine(const Offset(-10, 511), const Offset(370, 511), Pk.stroke(const Color(0xFFB8B4C0), 3));
  final brick = _m(0xFF9A8E84, 0xFFC9765A, ov);
  final roof = _m(0xFF6E6A70, 0xFF2E4A5A, ov);
  Pk.shadow(c, const Offset(180, 462), 330, 18);
  // Engine shed (left) with an arched door.
  Pk.box(c, const Rect.fromLTWH(8, 352, 86, 108), Pk.dark(brick, 0.06), radius: 2);
  Pk.poly(c, const [Offset(0, 356), Offset(51, 322), Offset(102, 356)], Pk.fill(roof));
  // Café wing (right).
  Pk.box(c, const Rect.fromLTWH(266, 362, 88, 98), Pk.dark(brick, 0.06), radius: 2);
  Pk.poly(c, const [Offset(260, 366), Offset(310, 336), Offset(360, 366)], Pk.fill(roof));
  for (var i = 0; i < 5; i++) {
    final x = 268 + i * 17.0;
    Pk.poly(c, [Offset(x, 372), Offset(x + 17, 372), Offset(x + 17, 380), Offset(x + 8.5, 385), Offset(x, 380)],
        Pk.fill(i.isEven ? _m(0xFF9A7E78, 0xFF2EA59A, ov) : Colors.white));
  }
  // Main hall and clock tower.
  Pk.box(c, const Rect.fromLTWH(92, 280, 176, 180), brick, radius: 2);
  _brickLines(c, const Rect.fromLTWH(92, 280, 176, 180), Pk.light(brick, 0.2));
  c.drawRect(const Rect.fromLTWH(86, 274, 188, 10), Pk.fill(_m(0xFFB0AA9E, 0xFFF4EFE6, ov)));
  Pk.box(c, const Rect.fromLTWH(150, 186, 60, 92), brick, radius: 2);
  Pk.poly(c, const [Offset(144, 190), Offset(180, 150), Offset(216, 190)], Pk.fill(roof));
  c.drawCircle(const Offset(180, 222), 18, Pk.fill(Colors.white));
  c.drawCircle(const Offset(180, 222), 18, Pk.stroke(_m(0xFF6E6A70, 0xFFC9A04A, ov), 3));
  c.drawLine(const Offset(180, 222), Offset(180 + sin(t * 0.3) * 12, 222 - cos(t * 0.3) * 12), Pk.stroke(const Color(0xFF3B3452), 1.5));
  c.drawLine(const Offset(180, 222), const Offset(188, 226), Pk.stroke(const Color(0xFF3B3452), 2));
  // Platform canopy along the track.
  c.drawRect(const Rect.fromLTWH(0, 462, 360, 8), Pk.fill(_m(0xFFB8B0A0, 0xFFFFD447, ov)));
}

final _stationMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _stationScenery,
  groundN: const Color(0xFFA8A296),
  groundR: const Color(0xFFD9D2C3),
  groundY: 460,
  spots: const [
    MapSpot('station_platform', Offset(180, 560), Rect.fromLTWH(95, 524, 170, 74), SpotKind.yard, Color(0xFFFFD447)),
    MapSpot('station_tickets', Offset(180, 410), Rect.fromLTWH(144, 380, 72, 60), SpotKind.window, Color(0xFFFFE08A)),
    MapSpot('station_waiting', Offset(180, 318), Rect.fromLTWH(140, 296, 80, 42), SpotKind.window, Color(0xFF8FD0FF)),
    MapSpot('station_cafe', Offset(310, 420), Rect.fromLTWH(286, 396, 48, 40), SpotKind.window, Color(0xFFFF9A6B)),
    MapSpot('station_shed', Offset(51, 420), Rect.fromLTWH(26, 392, 50, 50), SpotKind.window, Color(0xFFFFB35C)),
  ],
);

// ------------------------------------------------------------------ SCHOOL
void _schoolScenery(Canvas c, LocationMapArt art, double ov, double t) {
  art.paintGround(c, ov);
  // Playground court markings.
  c.drawRect(const Rect.fromLTWH(-200, 452, 760, 30), Pk.fill(_m(0xFF9A948A, 0xFFD9C9A8, ov)));
  final brick = _m(0xFF9A8E84, 0xFFD0704E, ov);
  final roof = _m(0xFF7D6B5E, 0xFF3E4A6A, ov);
  Pk.shadow(c, const Offset(180, 454), 320, 18);
  Pk.box(c, const Rect.fromLTWH(26, 272, 308, 180), brick, radius: 2);
  _brickLines(c, const Rect.fromLTWH(26, 272, 308, 180), Pk.light(brick, 0.22));
  c.drawRect(const Rect.fromLTWH(20, 266, 320, 10), Pk.fill(_m(0xFFB0AA9E, 0xFFF4EFE6, ov)));
  c.drawRect(const Rect.fromLTWH(26, 360, 308, 6), Pk.fill(_m(0xFFB0AA9E, 0xFFF4EFE6, ov)));
  // Bell tower.
  Pk.box(c, const Rect.fromLTWH(138, 196, 84, 74), brick, radius: 2);
  Pk.poly(c, const [Offset(130, 200), Offset(180, 150), Offset(230, 200)], Pk.fill(roof));
  c.drawLine(const Offset(180, 150), const Offset(180, 128), Pk.stroke(const Color(0xFF3B3452), 2));
  final wave = sin(t * 3) * 3;
  Pk.poly(c, [const Offset(181, 128), Offset(204, 132 + wave), const Offset(181, 140)], Pk.fill(_m(0xFF9A9A9A, 0xFFE0533F, ov)));
  // Entrance with steps.
  c.drawRRect(RRect.fromRectAndCorners(const Rect.fromLTWH(160, 398, 40, 54), topLeft: const Radius.circular(20), topRight: const Radius.circular(20)),
      Pk.fill(_m(0xFF6E6258, 0xFF2E5E86, ov)));
  for (var i = 0; i < 2; i++) {
    c.drawRect(Rect.fromLTWH(150.0 - i * 6, 446 + i * 4.0, 60.0 + i * 12, 4), Pk.fill(_m(0xFFB0AA9E, 0xFFF4EFE6, ov)));
  }
  // Swing set and a tree in the yard.
  final frame = Pk.stroke(_m(0xFF8A847A, 0xFFE0533F, ov), 3);
  c.drawLine(const Offset(298, 520), const Offset(310, 470), frame);
  c.drawLine(const Offset(322, 520), const Offset(310, 470), frame);
  c.drawLine(const Offset(338, 520), const Offset(350, 470), frame);
  c.drawLine(const Offset(362, 520), const Offset(350, 470), frame);
  c.drawLine(const Offset(310, 470), const Offset(350, 470), frame);
  final sw = sin(t * 1.6) * 5;
  c.drawLine(const Offset(330, 470), Offset(330 + sw, 504), Pk.stroke(const Color(0xFF8A839B), 1));
  Pk.box(c, Rect.fromCenter(center: Offset(330 + sw, 506), width: 14, height: 4), _m(0xFF9A9A9A, 0xFFFFD447, ov), radius: 1);
  _tree(c, const Offset(14, 452), 1.0, _m(0xFF9A9E80, 0xFF5DB848, ov));
}

final _schoolMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _schoolScenery,
  groundN: const Color(0xFFB39460),
  groundR: const Color(0xFF6CC453),
  groundY: 452,
  spots: const [
    MapSpot('school_yard', Offset(170, 546), Rect.fromLTWH(85, 504, 170, 84), SpotKind.yard, Color(0xFFFFD447)),
    MapSpot('school_class', Offset(90, 410), Rect.fromLTWH(54, 384, 72, 50), SpotKind.window, Color(0xFFFFD08A)),
    MapSpot('school_lab', Offset(270, 410), Rect.fromLTWH(234, 384, 72, 50), SpotKind.window, Color(0xFF6FE0D0)),
    MapSpot('school_gym', Offset(180, 316), Rect.fromLTWH(130, 292, 100, 50), SpotKind.window, Color(0xFF8FB8FF)),
    MapSpot('school_music', Offset(180, 232), Rect.fromLTWH(154, 212, 52, 40), SpotKind.window, Color(0xFFFF9ADA)),
  ],
);
