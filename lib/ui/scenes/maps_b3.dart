import 'dart:math';

import 'package:flutter/material.dart';

import '../art/paint_kit.dart';
import 'house_map_art.dart';
import 'location_map_art.dart';

/// Chapter maps for content batch 3 (hand-drawn; see LocationMapArt).
final Map<String, ChapterMapArt> batch3Maps = {
  'zen_garden': _zenMap,
  'forest_camp': _campMap,
  'circus': _circusMap,
  'oasis': _oasisMap,
  'pirate_ship': _pirateMap,
};

Color _m(int n, int r, double ov) => Pk.mix(Color(n), Color(r), ov);

void _pine(Canvas c, Offset base, double s, Color leaf) {
  c.drawRect(Rect.fromLTWH(base.dx - 3 * s, base.dy - 10 * s, 6 * s, 12 * s), Pk.fill(const Color(0xFF6E4A2E)));
  for (var i = 0; i < 3; i++) {
    final y = base.dy - 10 * s - i * 22 * s;
    final w = (26 - i * 6) * s;
    Pk.poly(c, [Offset(base.dx - w, y), Offset(base.dx, y - 36 * s), Offset(base.dx + w, y)], Pk.fill(Pk.dark(leaf, i * 0.06)));
  }
}

void _palm(Canvas c, Offset base, double s, Color leaf) {
  final trunk = Path()
    ..moveTo(base.dx, base.dy)
    ..quadraticBezierTo(base.dx + 10 * s, base.dy - 40 * s, base.dx + 4 * s, base.dy - 78 * s);
  c.drawPath(trunk, Pk.stroke(const Color(0xFF9C6B3C), 6 * s));
  final top = base + Offset(4 * s, -78 * s);
  for (var i = 0; i < 6; i++) {
    final ang = -pi + i * pi / 5;
    final tip = top + Offset(cos(ang) * 34 * s, sin(ang) * 14 * s + 14 * s);
    c.drawPath(
      Path()
        ..moveTo(top.dx, top.dy)
        ..quadraticBezierTo((top.dx + tip.dx) / 2, top.dy - 14 * s, tip.dx, tip.dy),
      Pk.stroke(leaf, 6 * s),
    );
  }
}

void _cherry(Canvas c, Offset base, double s, Color bloom) {
  c.drawRect(Rect.fromLTWH(base.dx - 3 * s, base.dy - 30 * s, 6 * s, 30 * s), Pk.fill(const Color(0xFF6E4A3A)));
  for (final (dx, dy, r) in [(-12.0, -44.0, 16.0), (10.0, -48.0, 18.0), (0.0, -58.0, 15.0)]) {
    c.drawCircle(base + Offset(dx * s, dy * s), r * s, Pk.fill(bloom));
  }
}

// ---------------------------------------------------------------------- ZEN GARDEN
void _zenScenery(Canvas c, LocationMapArt art, double ov, double t) {
  // Distant mountain with a snowy cap.
  final mtn = Path()
    ..moveTo(-40, 340)
    ..lineTo(150, 170)
    ..lineTo(360, 340)
    ..close();
  c.drawPath(mtn, Pk.fill(_m(0xFF9AA0A8, 0xFF8FA4C8, ov)));
  Pk.poly(c, const [Offset(120, 198), Offset(150, 170), Offset(180, 198), Offset(160, 190), Offset(148, 204), Offset(136, 190)], Pk.fill(Colors.white));
  art.paintGround(c, ov);
  // Raked gravel.
  for (var i = 0; i < 4; i++) {
    c.drawLine(Offset(8, 524 + i * 22.0), Offset(352, 524 + i * 22.0), Pk.stroke(Colors.white.withValues(alpha: 0.3 + 0.2 * ov), 1.5));
  }
  // Bamboo grove (left).
  final bam = _m(0xFF8C9A78, 0xFF58B84A, ov);
  for (var i = 0; i < 6; i++) {
    final x = 30.0 + i * 15;
    final top = 190.0 + (i % 3) * 18;
    c.drawLine(Offset(x, 342), Offset(x, top), Pk.stroke(Pk.dark(bam, i.isEven ? 0 : 0.1), 6));
    for (var y = 342.0; y > top; y -= 28) {
      c.drawLine(Offset(x - 4, y), Offset(x + 4, y), Pk.stroke(Pk.dark(bam, 0.3), 1.5));
    }
    c.drawOval(Rect.fromLTWH(x - 14, top - 6, 28, 8), Pk.fill(Pk.dark(bam, 0.05)));
  }
  // Tea house (right).
  final wood = _m(0xFF8C7E6C, 0xFFB98A55, ov);
  final roof = _m(0xFF6E6A70, 0xFF4A5E78, ov);
  Pk.shadow(c, const Offset(262, 342), 150, 12);
  Pk.box(c, const Rect.fromLTWH(196, 250, 132, 92), _m(0xFFC8C0B0, 0xFFF6EBD2, ov), radius: 2);
  for (final x in [196.0, 258.0, 322.0]) {
    c.drawRect(Rect.fromLTWH(x, 250, 6, 92), Pk.fill(wood));
  }
  Pk.poly(c, const [Offset(176, 258), Offset(262, 206), Offset(348, 258), Offset(330, 262), Offset(262, 224), Offset(194, 262)], Pk.fill(roof));
  Pk.poly(c, const [Offset(190, 258), Offset(262, 218), Offset(334, 258)], Pk.fill(Pk.dark(roof, 0.12)));
  // Pond with koi and lotus.
  c.drawOval(const Rect.fromLTWH(14, 378, 332, 76), Pk.fill(_m(0xFF8AA0A8, 0xFF3FA8C8, ov)));
  c.drawOval(const Rect.fromLTWH(26, 384, 308, 62), Pk.fill(_m(0xFF9AB0B4, 0xFF58C0DC, ov)));
  final koi = _m(0xFFB8A898, 0xFFFF7A3C, ov);
  for (final (x, y) in [(70.0, 414.0), (112.0, 428.0)]) {
    final k = Offset(x + 6 * sin(t * 0.8 + x), y);
    c.drawOval(Rect.fromCenter(center: k, width: 22, height: 9), Pk.fill(koi));
    Pk.poly(c, [k + const Offset(10, 0), k + const Offset(18, -4), k + const Offset(18, 4)], Pk.fill(koi));
  }
  for (final x in [140.0, 170.0]) {
    c.drawOval(Rect.fromCenter(center: Offset(x, 420), width: 18, height: 8), Pk.fill(_m(0xFF7E9A7A, 0xFF4CB85A, ov)));
  }
  c.drawCircle(const Offset(170, 417), 3, Pk.fill(_m(0xFFD8C8CC, 0xFFFF8AB6, ov)));
  // Arched cherry bridge.
  final red = _m(0xFF9A7E78, 0xFFD2412F, ov);
  const br = Rect.fromLTWH(212, 372, 124, 60);
  c.drawArc(br, pi, pi, false, Pk.stroke(red, 9));
  c.drawArc(br.translate(0, -12), pi, pi, false, Pk.stroke(Pk.dark(red, 0.15), 3));
  for (var i = 0; i <= 4; i++) {
    final x = 212 + i * 31.0;
    c.drawLine(Offset(x, 402 - 30 * sin(pi * i / 4)), Offset(x, 390 - 30 * sin(pi * i / 4)), Pk.stroke(Pk.dark(red, 0.15), 2));
  }
  // Stone lanterns and cherry trees.
  final stone = _m(0xFF9A9A9A, 0xFFD4D0C8, ov);
  for (final x in [18.0, 342.0]) {
    Pk.box(c, Rect.fromLTWH(x - 6, 458, 12, 20), stone, radius: 1);
    Pk.box(c, Rect.fromLTWH(x - 10, 450, 20, 10), Pk.dark(stone, 0.1), radius: 2);
    Pk.glow(c, Offset(x, 454), 14, const Color(0xFFFFE9A0), 0.15 + 0.4 * ov);
  }
  final bloom = _m(0xFFB0A0A0, 0xFFFFB3CE, ov);
  _cherry(c, const Offset(150, 342), 1.0, bloom);
  _cherry(c, const Offset(334, 590), 1.2, bloom);
  _cherry(c, const Offset(30, 600), 1.2, bloom);
  // Torii gate over the entrance.
  final tor = _m(0xFF9A7E78, 0xFFD2412F, ov);
  Pk.box(c, const Rect.fromLTWH(104, 450, 14, 62), tor, radius: 2);
  Pk.box(c, const Rect.fromLTWH(242, 450, 14, 62), tor, radius: 2);
  c.drawLine(const Offset(92, 462), const Offset(268, 462), Pk.stroke(tor, 10));
  c.drawLine(const Offset(84, 450), const Offset(276, 450), Pk.stroke(Pk.dark(tor, 0.25), 8));
}

final _zenMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _zenScenery,
  groundN: const Color(0xFFB0AA94),
  groundR: const Color(0xFFE6DCBC),
  groundY: 342,
  spots: const [
    MapSpot('zen_garden_torii', Offset(180, 545), Rect.fromLTWH(95, 505, 170, 76), SpotKind.yard, Color(0xFFFF7A6B)),
    MapSpot('zen_garden_koi', Offset(90, 412), Rect.fromLTWH(40, 390, 110, 44), SpotKind.yard, Color(0xFFFFA05C)),
    MapSpot('zen_garden_bridge', Offset(275, 404), Rect.fromLTWH(230, 378, 90, 40), SpotKind.window, Color(0xFFFFB3CE)),
    MapSpot('zen_garden_bamboo', Offset(72, 290), Rect.fromLTWH(26, 250, 90, 70), SpotKind.yard, Color(0xFF9CE38A)),
    MapSpot('zen_garden_tea', Offset(262, 302), Rect.fromLTWH(232, 276, 60, 46), SpotKind.window, Color(0xFFFFD08A)),
  ],
);

// ---------------------------------------------------------------------- FOREST CAMP
void _campScenery(Canvas c, LocationMapArt art, double ov, double t) {
  final far = _m(0xFF7E8C78, 0xFF2E7A52, ov);
  for (var i = 0; i < 9; i++) {
    _pine(c, Offset(i * 46.0 - 6, 330), 1.1, far);
  }
  art.paintGround(c, ov);
  // Treehouse in a big oak (left).
  c.drawRect(const Rect.fromLTWH(54, 220, 26, 120), Pk.fill(const Color(0xFF7A5230)));
  final leaf = _m(0xFF8C9A7A, 0xFF4CAE48, ov);
  for (final (x, y, r) in [(40.0, 200.0, 40.0), (100.0, 190.0, 44.0), (66.0, 160.0, 40.0)]) {
    c.drawCircle(Offset(x + 10, y), r, Pk.fill(Pk.dark(leaf, 0.08)));
  }
  final plank = _m(0xFF9A8A78, 0xFFC4894F, ov);
  Pk.box(c, const Rect.fromLTWH(22, 244, 104, 54), plank, radius: 3);
  Pk.poly(c, const [Offset(14, 248), Offset(74, 212), Offset(134, 248)], Pk.fill(_m(0xFF7E5E5A, 0xFFB5442F, ov)));
  c.drawLine(const Offset(36, 298), const Offset(36, 338), Pk.stroke(const Color(0xFF7A5230), 3));
  c.drawLine(const Offset(110, 298), const Offset(110, 338), Pk.stroke(const Color(0xFF7A5230), 3));
  // Log cabin (right).
  final log = _m(0xFF8C7E6C, 0xFF9A6638, ov);
  Pk.shadow(c, const Offset(270, 342), 150, 12);
  Pk.box(c, const Rect.fromLTWH(206, 246, 128, 96), log, radius: 3);
  for (var i = 1; i < 6; i++) {
    c.drawLine(Offset(206, 246 + i * 16.0), Offset(334, 246 + i * 16.0), Pk.stroke(Pk.dark(log, 0.25), 1.5));
  }
  Pk.poly(c, const [Offset(196, 250), Offset(270, 200), Offset(344, 250)], Pk.fill(_m(0xFF6E5E5A, 0xFF5A3E2E, ov)));
  Pk.box(c, const Rect.fromLTWH(306, 206, 14, 34), _m(0xFF8A8480, 0xFFA0968A, ov), radius: 1);
  Pk.box(c, const Rect.fromLTWH(254, 296, 32, 46), _m(0xFF6E5E52, 0xFF5A3E2E, ov), radius: 2);
  // Tents (lower left) and campfire.
  final tc = [_m(0xFF8A98A8, 0xFF45A7F5, ov), _m(0xFFA89A8A, 0xFFFF9A3C, ov)];
  for (var k = 0; k < 2; k++) {
    final x = 30.0 + k * 74;
    Pk.shadow(c, Offset(x + 34, 452), 76, 8);
    Pk.poly(c, [Offset(x, 450), Offset(x + 34, 392), Offset(x + 68, 450)], Pk.fill(tc[k]));
    Pk.poly(c, [Offset(x + 24, 450), Offset(x + 34, 418), Offset(x + 44, 450)], Pk.fill(Pk.dark(tc[k], 0.35)));
  }
  final fx = const Offset(176, 440);
  Pk.glow(c, fx, 26, const Color(0xFFFFB347), 0.1 + 0.4 * ov);
  c.drawLine(fx + const Offset(-10, 4), fx + const Offset(10, -2), Pk.stroke(const Color(0xFF5A3E2E), 4));
  c.drawLine(fx + const Offset(-10, -2), fx + const Offset(10, 4), Pk.stroke(const Color(0xFF5A3E2E), 4));
  Pk.poly(c, [fx + const Offset(-6, 0), fx + Offset(0, -16 - 3 * sin(t * 6)), fx + const Offset(6, 0)],
      Pk.fill(_m(0xFF8A7A6E, 0xFFFFA43C, ov)));
  // Lake with dock (lower right).
  c.drawOval(const Rect.fromLTWH(222, 388, 150, 70), Pk.fill(_m(0xFF8AA0A8, 0xFF3FA8C8, ov)));
  final dock = _m(0xFF8C7E6C, 0xFFB98A55, ov);
  Pk.box(c, const Rect.fromLTWH(206, 410, 100, 14), dock, radius: 1);
  for (var i = 0; i < 5; i++) {
    c.drawRect(Rect.fromLTWH(212 + i * 20.0, 424, 5, 12), Pk.fill(Pk.dark(dock, 0.3)));
  }
  // Entrance sign arch.
  final wood = _m(0xFF8C7E6C, 0xFF8B5E3C, ov);
  Pk.box(c, const Rect.fromLTWH(96, 454, 16, 56), wood, radius: 2);
  Pk.box(c, const Rect.fromLTWH(248, 454, 16, 56), wood, radius: 2);
  Pk.box(c, const Rect.fromLTWH(92, 446, 176, 20), Pk.dark(wood, 0.12), radius: 3);
  _pine(c, const Offset(40, 540), 1.2, far);
  _pine(c, const Offset(322, 548), 1.2, far);
}

final _campMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _campScenery,
  groundN: const Color(0xFF9A9478),
  groundR: const Color(0xFF6CB04E),
  groundY: 340,
  spots: const [
    MapSpot('forest_camp_gate', Offset(180, 545), Rect.fromLTWH(95, 505, 170, 76), SpotKind.yard, Color(0xFF7ACB52)),
    MapSpot('forest_camp_tents', Offset(70, 420), Rect.fromLTWH(26, 392, 108, 52), SpotKind.yard, Color(0xFFFF9A3C)),
    MapSpot('forest_camp_dock', Offset(280, 418), Rect.fromLTWH(226, 394, 100, 40), SpotKind.yard, Color(0xFF6FE0F0)),
    MapSpot('forest_camp_treehouse', Offset(75, 290), Rect.fromLTWH(34, 252, 80, 40), SpotKind.window, Color(0xFFFFD08A)),
    MapSpot('forest_camp_cabin', Offset(270, 296), Rect.fromLTWH(214, 258, 112, 36), SpotKind.window, Color(0xFFFFB35C)),
  ],
);

// ---------------------------------------------------------------------- CIRCUS
void _circusScenery(Canvas c, LocationMapArt art, double ov, double t) {
  art.paintGround(c, ov);
  final red = _m(0xFF9A7E78, 0xFFE0333F, ov);
  final cream = _m(0xFFC8C0B0, 0xFFFFF4DC, ov);
  // Big top: striped dome tent.
  Pk.shadow(c, const Offset(180, 342), 220, 14);
  const body = Rect.fromLTWH(96, 236, 168, 106);
  Pk.box(c, body, cream, radius: 2);
  for (var i = 0; i < 7; i++) {
    if (i.isOdd) c.drawRect(Rect.fromLTWH(96 + i * 24.0, 236, 24, 106), Pk.fill(red));
  }
  for (var i = 0; i < 14; i++) {
    final x0 = 76 + i * 15.4;
    Pk.poly(c, [const Offset(180, 140), Offset(x0, 240), Offset(x0 + 15.4, 240)], Pk.fill(i.isEven ? red : cream));
  }
  c.drawLine(const Offset(180, 140), const Offset(180, 118), Pk.stroke(const Color(0xFF6E4A2E), 3));
  Pk.poly(c, [const Offset(180, 118), const Offset(204, 124 + 0), const Offset(180, 132)], Pk.fill(_m(0xFFA89A8A, 0xFFFFC93C, ov)));
  Pk.poly(c, const [Offset(160, 342), Offset(180, 288), Offset(200, 342)], Pk.fill(_m(0xFF5E5A60, 0xFF3B1E4A, ov)));
  // Clown wagon (left) and ticket booth (right).
  final wagon = _m(0xFF8A98A8, 0xFF45A7F5, ov);
  Pk.box(c, const Rect.fromLTWH(18, 272, 70, 70), wagon, radius: 4);
  for (var i = 0; i < 5; i++) {
    c.drawRect(Rect.fromLTWH(16 + i * 15.0, 262, 15, 14), Pk.fill(i.isEven ? Colors.white : red));
  }
  Pk.box(c, const Rect.fromLTWH(272, 282, 70, 60), _m(0xFFB5A99A, 0xFFFFC93C, ov), radius: 3);
  for (var i = 0; i < 5; i++) {
    c.drawRect(Rect.fromLTWH(270 + i * 15.0, 272, 15, 14), Pk.fill(i.isEven ? Colors.white : red));
  }
  for (final x in [30.0, 330.0]) {
    c.drawLine(Offset(x, 190), Offset(x, 262), Pk.stroke(const Color(0xFF6E4A2E), 2));
    final fl = Path()..moveTo(x, 190);
    fl.lineTo(x + (x < 100 ? 22 : -22), 198 + 2 * sin(t * 3));
    fl.lineTo(x, 206);
    c.drawPath(fl..close(), Pk.fill(_m(0xFFA89A8A, 0xFFFF6B9A, ov)));
  }
  // Ring (left front).
  final sand = _m(0xFFB8AE98, 0xFFE8C98A, ov);
  c.drawOval(const Rect.fromLTWH(20, 380, 140, 72), Pk.fill(red));
  c.drawOval(const Rect.fromLTWH(30, 386, 120, 60), Pk.fill(sand));
  // Caravans (right front).
  final cols = [_m(0xFF8AA89A, 0xFF3FB88A, ov), _m(0xFFA89A8A, 0xFFFF9A3C, ov)];
  for (var k = 0; k < 2; k++) {
    final x = 200.0 + k * 74;
    Pk.box(c, Rect.fromLTWH(x, 388, 66, 52), cols[k], radius: 8);
    c.drawRect(Rect.fromLTWH(x + 38, 398, 18, 16), Pk.fill(_m(0xFF6E6A70, 0xFFFFE9A6, ov)));
    c.drawCircle(Offset(x + 16, 442), 7, Pk.fill(const Color(0xFF3B3452)));
    c.drawCircle(Offset(x + 50, 442), 7, Pk.fill(const Color(0xFF3B3452)));
  }
  // Entrance arch with bulbs.
  final arch = _m(0xFF9A8C82, 0xFFE0333F, ov);
  Pk.box(c, const Rect.fromLTWH(96, 454, 16, 58), Colors.white, radius: 2);
  Pk.box(c, const Rect.fromLTWH(248, 454, 16, 58), Colors.white, radius: 2);
  const ar = Rect.fromLTWH(100, 438, 160, 54);
  c.drawArc(ar, pi, pi, false, Pk.stroke(arch, 13));
  for (var i = 0; i <= 10; i++) {
    final ang = pi + pi * i / 10;
    final on = (i + (t * 4).floor()) % 3 != 0;
    c.drawCircle(ar.center + Offset(cos(ang) * 80, sin(ang) * 27), 2.5,
        Pk.fill((on ? const Color(0xFFFFE066) : const Color(0xFF8A7F78)).withValues(alpha: 0.4 + 0.6 * ov)));
  }
}

final _circusMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _circusScenery,
  groundN: const Color(0xFFA8A296),
  groundR: const Color(0xFFE6CFA8),
  groundY: 342,
  spots: const [
    MapSpot('circus_entrance', Offset(180, 545), Rect.fromLTWH(95, 505, 170, 76), SpotKind.yard, Color(0xFFFF7AB6)),
    MapSpot('circus_ring', Offset(90, 412), Rect.fromLTWH(30, 388, 120, 56), SpotKind.yard, Color(0xFFFFC93C)),
    MapSpot('circus_caravans', Offset(272, 420), Rect.fromLTWH(204, 392, 130, 46), SpotKind.window, Color(0xFF6FE0B0)),
    MapSpot('circus_clowns', Offset(52, 296), Rect.fromLTWH(24, 276, 58, 40), SpotKind.window, Color(0xFF8FD0FF)),
    MapSpot('circus_trapeze', Offset(180, 232), Rect.fromLTWH(138, 196, 84, 40), SpotKind.window, Color(0xFFFF6B6B)),
  ],
);

// ---------------------------------------------------------------------- OASIS
void _oasisScenery(Canvas c, LocationMapArt art, double ov, double t) {
  // Dunes.
  final dune = Path()
    ..moveTo(-100, 400)
    ..quadraticBezierTo(40, 330, 170, 390)
    ..quadraticBezierTo(300, 340, 460, 400)
    ..close();
  c.drawPath(dune, Pk.fill(_m(0xFFC8B896, 0xFFF0CE8A, ov)));
  Pk.glow(c, const Offset(300, 80), 60, const Color(0xFFFFF0B0), 0.3 * ov);
  c.drawCircle(const Offset(300, 80), 26, Pk.fill(_m(0xFFE8E0C8, 0xFFFFE066, ov)));
  art.paintGround(c, ov);
  // Palace with domes.
  final wall = _m(0xFFC8BCA8, 0xFFFBF0D8, ov);
  final dome = _m(0xFF7E8C98, 0xFF2E9AB8, ov);
  final gold = _m(0xFFB0A488, 0xFFFFC93C, ov);
  Pk.shadow(c, const Offset(180, 402), 270, 14);
  for (final x in [70.0, 262.0]) {
    Pk.box(c, Rect.fromLTWH(x - 20, 250, 40, 150), wall, radius: 2);
    c.drawArc(Rect.fromLTWH(x - 24, 214, 48, 70), pi, pi, true, Pk.fill(dome));
    c.drawLine(Offset(x, 214), Offset(x, 198), Pk.stroke(gold, 2));
  }
  Pk.box(c, const Rect.fromLTWH(86, 284, 188, 116), wall, radius: 2);
  c.drawArc(const Rect.fromLTWH(110, 190, 140, 190), pi, pi, true, Pk.fill(dome));
  c.drawLine(const Offset(180, 190), const Offset(180, 166), Pk.stroke(gold, 3));
  c.drawCircle(const Offset(180, 164), 4, Pk.fill(gold));
  c.drawRect(const Rect.fromLTWH(110, 282, 140, 6), Pk.fill(gold));
  final arch = _m(0xFF6E6A70, 0xFF4A3A6E, ov);
  for (final x in [124.0, 236.0]) {
    c.drawArc(Rect.fromLTWH(x - 14, 318, 28, 40), pi, pi, true, Pk.fill(arch));
    c.drawRect(Rect.fromLTWH(x - 14, 338, 28, 62), Pk.fill(arch));
  }
  c.drawArc(const Rect.fromLTWH(160, 330, 40, 50), pi, pi, true, Pk.fill(arch));
  c.drawRect(const Rect.fromLTWH(160, 355, 40, 45), Pk.fill(arch));
  // Spring pool with palms (left).
  c.drawOval(const Rect.fromLTWH(22, 410, 130, 56), Pk.fill(_m(0xFF8AA0A8, 0xFF3FB8D8, ov)));
  final leaf = _m(0xFF8C9A70, 0xFF3FA84A, ov);
  _palm(c, const Offset(34, 424), 1.0, leaf);
  _palm(c, const Offset(146, 420), 0.8, leaf);
  // Bazaar stalls (right).
  for (var k = 0; k < 2; k++) {
    final x = 196.0 + k * 74;
    Pk.box(c, Rect.fromLTWH(x, 410, 66, 44), _m(0xFFB5A99A, 0xFFF6DDB0, ov), radius: 2);
    for (var i = 0; i < 4; i++) {
      c.drawRect(Rect.fromLTWH(x - 2 + i * 17.0, 398, 17, 16),
          Pk.fill(_m(0xFFA89A8A, [0xFFE0533F, 0xFF3FA8C8, 0xFFFFC93C, 0xFF8A5CD0][(i + k) % 4], ov)));
    }
  }
  // Camp tents / entrance.
  final tent = _m(0xFFA89A8A, 0xFFD87A3C, ov);
  for (final x in [96.0, 220.0]) {
    Pk.poly(c, [Offset(x, 502), Offset(x + 22, 462), Offset(x + 44, 502)], Pk.fill(tent));
    Pk.poly(c, [Offset(x + 16, 502), Offset(x + 22, 480), Offset(x + 28, 502)], Pk.fill(Pk.dark(tent, 0.35)));
  }
  _palm(c, const Offset(40, 560), 1.2, leaf);
  _palm(c, const Offset(322, 568), 1.2, leaf);
}

final _oasisMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _oasisScenery,
  groundN: const Color(0xFFC0B08C),
  groundR: const Color(0xFFF0D090),
  groundY: 402,
  spots: const [
    MapSpot('oasis_camp', Offset(180, 548), Rect.fromLTWH(95, 508, 170, 74), SpotKind.yard, Color(0xFFFFB35C)),
    MapSpot('oasis_spring', Offset(85, 436), Rect.fromLTWH(34, 412, 110, 44), SpotKind.yard, Color(0xFF6FE0F0)),
    MapSpot('oasis_bazaar', Offset(275, 440), Rect.fromLTWH(198, 412, 136, 40), SpotKind.window, Color(0xFFFF7AB6)),
    MapSpot('oasis_palace', Offset(180, 345), Rect.fromLTWH(112, 316, 136, 44), SpotKind.window, Color(0xFFB38CFF)),
    MapSpot('oasis_rooftop', Offset(180, 228), Rect.fromLTWH(140, 200, 80, 40), SpotKind.window, Color(0xFFFFE066)),
  ],
);

// ---------------------------------------------------------------------- PIRATE SHIP
void _pirateScenery(Canvas c, LocationMapArt art, double ov, double t) {
  // Sea.
  Pk.gradientRect(c, const Rect.fromLTWH(-200, 300, 760, 210), _m(0xFF7FA3AE, 0xFF3FB8E8, ov), _m(0xFF6E8E98, 0xFF1E7FB8, ov));
  for (var i = 0; i < 6; i++) {
    final y = 330 + i * 30.0;
    final x = (t * 10 + i * 90) % 440 - 40;
    c.drawLine(Offset(x, y), Offset(x + 50, y), Pk.stroke(Colors.white.withValues(alpha: 0.4), 2));
  }
  // Island (far left) with palm.
  final isl = Path()
    ..moveTo(-20, 380)
    ..quadraticBezierTo(60, 320, 140, 380)
    ..close();
  c.drawPath(isl, Pk.fill(_m(0xFFC8B896, 0xFFF0D28A, ov)));
  _palm(c, const Offset(60, 356), 0.9, _m(0xFF8C9A70, 0xFF3FA84A, ov));
  // Ship: hull, masts, sails, stern cabin.
  final hull = _m(0xFF8C7E6C, 0xFF8B5230, ov);
  final sail = _m(0xFFD8D2C4, 0xFFFFF8E8, ov);
  for (final (x, h) in [(130.0, 200.0), (214.0, 170.0)]) {
    c.drawLine(Offset(x, 420), Offset(x, h - 10), Pk.stroke(const Color(0xFF6E4A2E), 5));
    final s = Path()
      ..moveTo(x - 46, h + 10)
      ..quadraticBezierTo(x, h + 24, x + 46, h + 10)
      ..lineTo(x + 40, h + 110)
      ..quadraticBezierTo(x, h + 124, x - 40, h + 110)
      ..close();
    c.drawPath(s, Pk.fill(sail));
    c.drawLine(Offset(x - 46, h + 10), Offset(x + 46, h + 10), Pk.stroke(const Color(0xFF6E4A2E), 3));
  }
  Pk.poly(c, [const Offset(214, 160), const Offset(244, 168), const Offset(214, 178)], Pk.fill(const Color(0xFF2A2630)));
  Pk.box(c, const Rect.fromLTWH(244, 330, 86, 90), _m(0xFF9A8A78, 0xFFA8693C, ov), radius: 3);
  Pk.box(c, const Rect.fromLTWH(238, 322, 98, 12), Pk.dark(hull, 0.2), radius: 2);
  final hp = Path()
    ..moveTo(52, 410)
    ..lineTo(346, 410)
    ..quadraticBezierTo(330, 496, 270, 502)
    ..lineTo(110, 502)
    ..quadraticBezierTo(60, 480, 52, 410)
    ..close();
  Pk.shadow(c, const Offset(190, 504), 300, 12);
  c.drawPath(hp, Pk.fill(hull));
  c.drawRect(const Rect.fromLTWH(52, 410, 294, 8), Pk.fill(Pk.dark(hull, 0.25)));
  for (var i = 0; i < 4; i++) {
    c.drawCircle(Offset(120 + i * 44.0, 462), 7, Pk.fill(_m(0xFF5E5A60, 0xFFFFE9A6, ov)));
    c.drawCircle(Offset(120 + i * 44.0, 462), 7, Pk.stroke(Pk.dark(hull, 0.4), 2));
  }
  // Dock (ground).
  art.paintGround(c, ov);
  for (var i = 0; i < 6; i++) {
    c.drawLine(Offset(0, 528 + i * 22.0), Offset(360, 528 + i * 22.0), Pk.stroke(Colors.black.withValues(alpha: 0.12), 1.5));
  }
  for (final x in [24.0, 336.0]) {
    c.drawRect(Rect.fromLTWH(x - 5, 496, 10, 24), Pk.fill(Pk.dark(hull, 0.3)));
  }
  // Crates and barrels on the dock.
  Pk.box(c, const Rect.fromLTWH(40, 520, 34, 30), _m(0xFF9A8A78, 0xFFC4894F, ov), radius: 2);
  Pk.box(c, const Rect.fromLTWH(292, 524, 30, 28), _m(0xFF9A8A78, 0xFFC4894F, ov), radius: 2);
  c.drawOval(const Rect.fromLTWH(268, 536, 24, 26), Pk.fill(Pk.dark(hull, 0.1)));
  // Gangway to the ship.
  c.drawLine(const Offset(150, 504), const Offset(180, 418), Pk.stroke(Pk.dark(hull, 0.1), 12));
}

final _pirateMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _pirateScenery,
  groundN: const Color(0xFFA09680),
  groundR: const Color(0xFFC9A06A),
  groundY: 506,
  spots: const [
    MapSpot('pirate_ship_dock', Offset(180, 545), Rect.fromLTWH(95, 510, 170, 70), SpotKind.yard, Color(0xFFFFB35C)),
    MapSpot('pirate_ship_hold', Offset(262, 462), Rect.fromLTWH(222, 446, 80, 32), SpotKind.window, Color(0xFFFFD08A)),
    MapSpot('pirate_ship_deck', Offset(110, 394), Rect.fromLTWH(70, 372, 90, 34), SpotKind.window, Color(0xFF8FD0FF)),
    MapSpot('pirate_ship_cabin', Offset(288, 330), Rect.fromLTWH(252, 322, 68, 36), SpotKind.window, Color(0xFFFF7A6B)),
    MapSpot('pirate_ship_island', Offset(70, 316), Rect.fromLTWH(40, 296, 60, 30), SpotKind.yard, Color(0xFF9CE38A)),
  ],
);
