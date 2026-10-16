import 'dart:math';

import 'package:flutter/material.dart';

import '../art/paint_kit.dart';
import 'house_map_art.dart';
import 'location_map_art.dart';

/// Chapter maps for content batch 2 (hand-drawn; see LocationMapArt).
final Map<String, ChapterMapArt> batch2Maps = {
  'zoo': _zooMap,
  'aquarium': _aquariumMap,
  'funfair': _funfairMap,
  'bookshop': _bookshopMap,
  'observatory': _observatoryMap,
};

Color _m(int n, int r, double ov) => Pk.mix(Color(n), Color(r), ov);

void _tree(Canvas c, Offset base, double s, Color leaf) {
  c.drawRect(Rect.fromLTWH(base.dx - 3 * s, base.dy - 18 * s, 6 * s, 18 * s), Pk.fill(const Color(0xFF8B5E3C)));
  c.drawCircle(base + Offset(0, -30 * s), 16 * s, Pk.fill(Pk.dark(leaf, 0.12)));
  c.drawCircle(base + Offset(-5 * s, -34 * s), 11 * s, Pk.fill(leaf));
}

void _mapStar(Canvas c, Offset o, double s, Color col) {
  final p = Path();
  for (var i = 0; i < 10; i++) {
    final ang = -pi / 2 + i * pi / 5;
    final q = o + Offset(cos(ang), sin(ang)) * (i.isEven ? s : s * 0.45);
    if (i == 0) {
      p.moveTo(q.dx, q.dy);
    } else {
      p.lineTo(q.dx, q.dy);
    }
  }
  c.drawPath(p..close(), Pk.fill(col));
}

// ---------------------------------------------------------------------- ZOO
void _zooScenery(Canvas c, LocationMapArt art, double ov, double t) {
  final hills = Path()
    ..moveTo(-100, 340)
    ..quadraticBezierTo(60, 280, 190, 326)
    ..quadraticBezierTo(300, 286, 460, 320)
    ..lineTo(460, 360)
    ..lineTo(-100, 360)
    ..close();
  c.drawPath(hills, Pk.fill(_m(0xFFA7AE8C, 0xFF8ED46A, ov)));
  art.paintGround(c, ov);
  final path = _m(0xFFB8AE96, 0xFFF2DFB4, ov);
  c.drawPath(
    Path()
      ..moveTo(180, 640)
      ..lineTo(180, 470)
      ..moveTo(180, 470)
      ..quadraticBezierTo(180, 440, 90, 430)
      ..moveTo(180, 470)
      ..quadraticBezierTo(180, 440, 270, 430)
      ..moveTo(90, 400)
      ..lineTo(90, 330)
      ..moveTo(270, 400)
      ..lineTo(270, 330),
    Pk.stroke(path, 16),
  );
  // Reptile house (left) and barn (right).
  final glass = _m(0xFFB0B8A8, 0xFF9FE0B8, ov);
  Pk.shadow(c, const Offset(90, 332), 140, 12);
  Pk.box(c, const Rect.fromLTWH(26, 236, 128, 96), _m(0xFFB5AA90, 0xFFE8D8A8, ov), radius: 3);
  c.drawArc(const Rect.fromLTWH(30, 196, 120, 80), pi, pi, true, Pk.fill(glass));
  for (var i = 1; i < 5; i++) {
    c.drawLine(Offset(30 + i * 24.0, 236), Offset(90 + (i - 2.5) * 14, 198), Pk.stroke(Colors.white.withValues(alpha: 0.6), 1.5));
  }
  final red = _m(0xFF9A6A5E, 0xFFC8412F, ov);
  Pk.shadow(c, const Offset(270, 332), 140, 12);
  Pk.box(c, const Rect.fromLTWH(206, 238, 128, 94), red, radius: 2);
  Pk.poly(c, const [Offset(198, 242), Offset(270, 196), Offset(342, 242)], Pk.fill(Pk.dark(red, 0.25)));
  Pk.poly(c, const [Offset(196, 244), Offset(270, 196), Offset(344, 244), Offset(336, 248), Offset(270, 206), Offset(204, 248)], Pk.fill(Colors.white));
  // Giraffe yard: acacias and a giraffe.
  final leaf = _m(0xFF8C9A7A, 0xFF5DB848, ov);
  c.drawLine(const Offset(36, 400), const Offset(36, 360), Pk.stroke(const Color(0xFF8B5E3C), 5));
  c.drawOval(const Rect.fromLTWH(6, 346, 62, 20), Pk.fill(leaf));
  final gy = _m(0xFFC8B690, 0xFFF2B648, ov);
  c.drawLine(const Offset(150, 388), const Offset(164, 344), Pk.stroke(gy, 6));
  c.drawOval(const Rect.fromLTWH(128, 380, 34, 16), Pk.fill(gy));
  c.drawOval(const Rect.fromLTWH(158, 338, 16, 9), Pk.fill(gy));
  for (final x in [132.0, 142.0, 150.0, 158.0]) {
    c.drawLine(Offset(x, 392), Offset(x, 408), Pk.stroke(gy, 3));
  }
  // Penguin pool with rocks.
  c.drawOval(const Rect.fromLTWH(196, 380, 148, 72), Pk.fill(_m(0xFFB8B4AA, 0xFFF2FBFF, ov)));
  Pk.poly(c, const [Offset(300, 392), Offset(318, 352), Offset(346, 392)], Pk.fill(_m(0xFFA9AFB4, 0xFFE6F6FF, ov)));
  // Entrance arch over the yard.
  final wood = _m(0xFF8C7E6C, 0xFF8B5E3C, ov);
  Pk.box(c, const Rect.fromLTWH(96, 452, 16, 56), wood, radius: 2);
  Pk.box(c, const Rect.fromLTWH(248, 452, 16, 56), wood, radius: 2);
  c.drawArc(const Rect.fromLTWH(100, 438, 160, 50), pi, pi, false, Pk.stroke(Pk.dark(wood, 0.2), 16));
  c.drawArc(const Rect.fromLTWH(100, 438, 160, 50), pi, pi, false, Pk.stroke(_m(0xFF9AA08A, 0xFF55C04A, ov), 11));
  for (final p in [const Offset(60, 520), const Offset(310, 520), const Offset(330, 590), const Offset(30, 600)]) {
    _tree(c, p, 1.1, leaf);
  }
}

final _zooMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _zooScenery,
  groundN: const Color(0xFFB39460),
  groundR: const Color(0xFF6CC04E),
  groundY: 330,
  spots: const [
    MapSpot('zoo_gate', Offset(180, 540), Rect.fromLTWH(95, 500, 170, 80), SpotKind.yard, Color(0xFF7ACB52)),
    MapSpot('zoo_giraffes', Offset(90, 420), Rect.fromLTWH(24, 390, 132, 60), SpotKind.yard, Color(0xFFE8C66B)),
    MapSpot('zoo_penguins', Offset(270, 420), Rect.fromLTWH(204, 388, 132, 58), SpotKind.yard, Color(0xFF6FE0F0)),
    MapSpot('zoo_reptiles', Offset(90, 288), Rect.fromLTWH(60, 266, 60, 44), SpotKind.window, Color(0xFF9CE38A)),
    MapSpot('zoo_petting', Offset(270, 288), Rect.fromLTWH(240, 266, 60, 44), SpotKind.window, Color(0xFFFFD08A)),
  ],
);

// ---------------------------------------------------------------------- AQUARIUM
void _aquariumScenery(Canvas c, LocationMapArt art, double ov, double t) {
  // Sea behind the building.
  Pk.gradientRect(c, const Rect.fromLTWH(-200, 380, 760, 80), _m(0xFF7FA3AE, 0xFF2EB6E0, ov), _m(0xFF6E8E98, 0xFF1E8FC0, ov));
  for (var i = 0; i < 4; i++) {
    final y = 392 + i * 16.0;
    c.drawLine(Offset((t * 12 + i * 70) % 440 - 40, y), Offset((t * 12 + i * 70) % 440 + 10, y), Pk.stroke(Colors.white.withValues(alpha: 0.5), 2));
  }
  art.paintGround(c, ov);
  final wall = _m(0xFFC0BCB4, 0xFFF4FBFF, ov);
  final blue = _m(0xFF7E8C96, 0xFF2E8FCF, ov);
  Pk.shadow(c, const Offset(180, 462), 320, 20);
  Pk.box(c, const Rect.fromLTWH(28, 250, 304, 210), wall, radius: 4);
  // Wave roof.
  final roof = Path()..moveTo(18, 258);
  for (var i = 0; i < 4; i++) {
    roof.quadraticBezierTo(18 + i * 81 + 40, 222, 18 + (i + 1) * 81.0, 258);
  }
  roof
    ..lineTo(342, 268)
    ..lineTo(18, 268)
    ..close();
  c.drawPath(roof, Pk.fill(blue));
  // Glass dome.
  c.drawArc(const Rect.fromLTWH(110, 150, 140, 150), pi, pi, true, Pk.fill(_m(0xFFA8B8C0, 0xFF8ED8FF, ov)));
  for (var i = 1; i < 5; i++) {
    c.drawLine(Offset(110 + i * 28.0, 225), Offset(180 + (i - 2.5) * 10, 152), Pk.stroke(Colors.white.withValues(alpha: 0.6), 1.5));
  }
  c.drawLine(const Offset(110, 225), const Offset(250, 225), Pk.stroke(Colors.white.withValues(alpha: 0.7), 2));
  // Fish sign.
  Pk.box(c, const Rect.fromLTWH(130, 330, 100, 30), blue, radius: 8);
  c.drawOval(const Rect.fromLTWH(160, 337, 32, 16), Pk.fill(_m(0xFFC0B8A8, 0xFFFF9A3C, ov)));
  Pk.poly(c, const [Offset(192, 345), Offset(204, 337), Offset(204, 353)], Pk.fill(_m(0xFFC0B8A8, 0xFFFF9A3C, ov)));
  // Doors.
  Pk.box(c, const Rect.fromLTWH(150, 398, 60, 62), _m(0xFF8E9AA0, 0xFFBFEFFA, ov), radius: 3);
  c.drawLine(const Offset(180, 398), const Offset(180, 460), Pk.stroke(blue, 2));
  for (final x in [24.0, 336.0]) {
    c.drawRect(Rect.fromLTWH(x - 3, 470, 6, 60), Pk.fill(const Color(0xFFB9824A)));
    for (var i = 0; i < 5; i++) {
      final ang = -pi + i * pi / 4;
      c.drawLine(Offset(x, 470), Offset(x, 470) + Offset(cos(ang), sin(ang) * 0.5 + 0.3) * 30, Pk.stroke(_m(0xFF8C9A7A, 0xFF3FA84A, ov), 7));
    }
  }
}

final _aquariumMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _aquariumScenery,
  groundN: const Color(0xFFCFC2A2),
  groundR: const Color(0xFFF6DC9C),
  groundY: 460,
  spots: const [
    MapSpot('aquarium_hall', Offset(180, 538), Rect.fromLTWH(95, 498, 170, 82), SpotKind.yard, Color(0xFF6FE0F0)),
    MapSpot('aquarium_coral', Offset(85, 415), Rect.fromLTWH(52, 392, 66, 46), SpotKind.window, Color(0xFFFF9A8A)),
    MapSpot('aquarium_tunnel', Offset(275, 415), Rect.fromLTWH(242, 392, 66, 46), SpotKind.window, Color(0xFF45A7F5)),
    MapSpot('aquarium_jelly', Offset(85, 305), Rect.fromLTWH(52, 284, 66, 44), SpotKind.window, Color(0xFFC9A8FF)),
    MapSpot('aquarium_touch', Offset(275, 305), Rect.fromLTWH(242, 284, 66, 44), SpotKind.window, Color(0xFF8FE3C0)),
  ],
);

// ---------------------------------------------------------------------- FUNFAIR
void _funfairScenery(Canvas c, LocationMapArt art, double ov, double t) {
  art.paintGround(c, ov);
  // Ferris wheel (left, behind).
  final steel = _m(0xFF9A9AA4, 0xFFE6E8F0, ov);
  const hub = Offset(100, 250);
  for (final s in [-1.0, 1.0]) {
    c.drawLine(hub, Offset(hub.dx + s * 50, 452), Pk.stroke(Pk.dark(steel, 0.2), 5));
  }
  c.drawCircle(hub, 82, Pk.stroke(steel, 4));
  final rot = t * 0.2;
  for (var i = 0; i < 8; i++) {
    final ang = rot + i * pi / 4;
    final p = hub + Offset(cos(ang), sin(ang)) * 82;
    c.drawLine(hub, p, Pk.stroke(steel, 1.5));
    Pk.box(c, Rect.fromCenter(center: p + const Offset(0, 10), width: 18, height: 14),
        _m(0xFFA8A098, [0xFFE0533F, 0xFF45A7F5, 0xFFFFC93C, 0xFFFF7AB6][i % 4], ov), radius: 4);
  }
  // Roller coaster (right, behind).
  final track = _m(0xFF9A8C82, 0xFFE0533F, ov);
  Offset at(double k) => Offset(190 + 170 * k, 420 - (190 - 90 * k) * (0.5 - 0.5 * cos(k * 3 * pi)));
  for (var i = 0; i <= 12; i++) {
    final p = at(i / 12);
    c.drawLine(p, Offset(p.dx, 452), Pk.stroke(Pk.dark(steel, 0.25), 2));
  }
  final tp = Path();
  for (var i = 0; i <= 60; i++) {
    final p = at(i / 60);
    i == 0 ? tp.moveTo(p.dx, p.dy) : tp.lineTo(p.dx, p.dy);
  }
  c.drawPath(tp, Pk.stroke(track, 6));
  // Coaster station.
  Pk.box(c, const Rect.fromLTWH(228, 250, 90, 60), _m(0xFFB5A99A, 0xFFFFE3C2, ov), radius: 3);
  Pk.poly(c, const [Offset(220, 254), Offset(273, 226), Offset(326, 254)], Pk.fill(track));
  // Carousel (left front).
  final red = _m(0xFF9A7E78, 0xFFE0533F, ov);
  Pk.shadow(c, const Offset(92, 452), 130, 12);
  Pk.box(c, const Rect.fromLTWH(40, 372, 104, 80), _m(0xFFC9BFAE, 0xFFFFF1DA, ov), radius: 4);
  for (var i = 0; i < 8; i++) {
    final x0 = 30 + i * 15.5;
    Pk.poly(c, [Offset(92, 318), Offset(x0, 376), Offset(x0 + 15.5, 376)], Pk.fill(i.isEven ? red : Colors.white));
  }
  // Game stalls (right front).
  for (var k = 0; k < 2; k++) {
    final x = 214.0 + k * 66;
    Pk.box(c, Rect.fromLTWH(x, 380, 60, 72), _m(0xFFB5A99A, 0xFFFFF1DA, ov), radius: 2);
    for (var i = 0; i < 4; i++) {
      c.drawRect(Rect.fromLTWH(x - 2 + i * 16, 372, 16, 14), Pk.fill(i.isEven ? (k == 0 ? red : _m(0xFF8A9AA8, 0xFF45A7F5, ov)) : Colors.white));
    }
  }
  // Entrance arch with bulbs.
  final arch = _m(0xFF9A8C82, 0xFFE0533F, ov);
  Pk.box(c, const Rect.fromLTWH(96, 452, 16, 58), Colors.white, radius: 2);
  Pk.box(c, const Rect.fromLTWH(248, 452, 16, 58), Colors.white, radius: 2);
  const ar = Rect.fromLTWH(100, 436, 160, 54);
  c.drawArc(ar, pi, pi, false, Pk.stroke(arch, 13));
  for (var i = 0; i <= 10; i++) {
    final ang = pi + pi * i / 10;
    final on = (i + (t * 4).floor()) % 3 != 0;
    c.drawCircle(ar.center + Offset(cos(ang) * 80, sin(ang) * 27), 2.5,
        Pk.fill((on ? const Color(0xFFFFE066) : const Color(0xFF8A7F78)).withValues(alpha: 0.4 + 0.6 * ov)));
  }
}

final _funfairMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _funfairScenery,
  groundN: const Color(0xFFA8A296),
  groundR: const Color(0xFFE6D3C0),
  groundY: 452,
  spots: const [
    MapSpot('funfair_arch', Offset(180, 540), Rect.fromLTWH(95, 500, 170, 80), SpotKind.yard, Color(0xFFFF7AB6)),
    MapSpot('funfair_carousel', Offset(92, 418), Rect.fromLTWH(62, 396, 60, 40), SpotKind.window, Color(0xFFFFD08A)),
    MapSpot('funfair_wheel', Offset(100, 250), Rect.fromLTWH(78, 232, 44, 36), SpotKind.window, Color(0xFF8FD0FF)),
    MapSpot('funfair_stalls', Offset(277, 420), Rect.fromLTWH(222, 400, 110, 36), SpotKind.window, Color(0xFFFFC93C)),
    MapSpot('funfair_coaster', Offset(273, 285), Rect.fromLTWH(240, 266, 66, 36), SpotKind.window, Color(0xFFFF6B6B)),
  ],
);

// ---------------------------------------------------------------------- BOOKSHOP
void _bookshopScenery(Canvas c, LocationMapArt art, double ov, double t) {
  art.paintGround(c, ov, top: 460);
  // Neighbouring houses.
  for (final (x, w, h, col) in [(-20.0, 64.0, 170.0, 0xFF8ED0B0), (316.0, 70.0, 190.0, 0xFFFFB38A)]) {
    Pk.box(c, Rect.fromLTWH(x, 460 - h, w, h), _m(0xFFAAA49A, col, ov), radius: 2);
    for (var i = 0; i < 3; i++) {
      c.drawRect(Rect.fromLTWH(x + 18, 460 - h + 24 + i * 50.0, 24, 28), Pk.fill(_m(0xFF6E6A70, 0xFFFFE9A6, ov)));
    }
  }
  final brick = _m(0xFF9A8C82, 0xFFC9644A, ov);
  final trim = _m(0xFF6E6A70, 0xFF2B3A67, ov);
  Pk.shadow(c, const Offset(180, 462), 300, 20);
  Pk.box(c, const Rect.fromLTWH(44, 160, 272, 300), brick, radius: 2);
  c.save();
  c.clipRect(const Rect.fromLTWH(44, 160, 272, 300));
  for (var y = 0; y < 30; y++) {
    for (var x = 0; x < 13; x++) {
      c.drawRect(Rect.fromLTWH(44 + x * 22.0 - (y.isEven ? 0 : 11), 160 + y * 10.0, 22, 10), Pk.stroke(Pk.dark(brick, 0.2).withValues(alpha: 0.4), 1));
    }
  }
  c.restore();
  // Roof with gable.
  Pk.poly(c, const [Offset(30, 166), Offset(180, 92), Offset(330, 166)], Pk.fill(trim));
  c.drawRect(const Rect.fromLTWH(40, 160, 280, 8), Pk.fill(Pk.dark(trim, 0.2)));
  c.drawRect(const Rect.fromLTWH(40, 352, 280, 10), Pk.fill(trim));
  c.drawRect(const Rect.fromLTWH(40, 256, 280, 6), Pk.fill(Pk.dark(brick, 0.25)));
  // Shop sign + awning.
  Pk.box(c, const Rect.fromLTWH(110, 362, 140, 22), trim, radius: 4);
  for (var i = 0; i < 4; i++) {
    c.drawRect(Rect.fromLTWH(128 + i * 28.0, 368, 18, 10), Pk.fill(_m(0xFFB0A89C, [0xFFE0533F, 0xFF45A7F5, 0xFFFFC93C, 0xFF5BCB4B][i], ov)));
  }
  for (var i = 0; i < 10; i++) {
    c.drawRect(Rect.fromLTWH(46 + i * 26.8, 386, 26.8, 12), Pk.fill(i.isEven ? _m(0xFF9A7E78, 0xFFE0533F, ov) : Colors.white));
  }
  // Door.
  Pk.box(c, const Rect.fromLTWH(160, 402, 40, 58), trim, radius: 3);
  c.drawCircle(const Offset(193, 432), 2, Pk.fill(const Color(0xFFFFC93C)));
  // Lampposts.
  for (final x in [26.0, 334.0]) {
    c.drawRect(Rect.fromLTWH(x - 2, 470, 4, 70), Pk.fill(const Color(0xFF3B3452)));
    Pk.glow(c, Offset(x, 468), 20, const Color(0xFFFFE9A0), 0.2 + 0.4 * ov);
    c.drawCircle(Offset(x, 468), 6, Pk.fill(_m(0xFF8A7F78, 0xFFFFE9A0, ov)));
  }
}

final _bookshopMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _bookshopScenery,
  groundN: const Color(0xFFA8A296),
  groundR: const Color(0xFFD9D2C3),
  groundY: 460,
  spots: const [
    MapSpot('bookshop_front', Offset(180, 538), Rect.fromLTWH(95, 498, 170, 80), SpotKind.yard, Color(0xFFD29A5A)),
    MapSpot('bookshop_nook', Offset(85, 425), Rect.fromLTWH(58, 404, 56, 44), SpotKind.window, Color(0xFFFFD08A)),
    MapSpot('bookshop_kids', Offset(275, 425), Rect.fromLTWH(246, 404, 56, 44), SpotKind.window, Color(0xFFFF9AC8)),
    MapSpot('bookshop_cafe', Offset(118, 305), Rect.fromLTWH(76, 280, 84, 50), SpotKind.window, Color(0xFFFFB35C)),
    MapSpot('bookshop_rare', Offset(242, 305), Rect.fromLTWH(200, 280, 84, 50), SpotKind.window, Color(0xFFB38CFF)),
  ],
);

// ---------------------------------------------------------------------- OBSERVATORY
void _observatoryScenery(Canvas c, LocationMapArt art, double ov, double t) {
  // Night falls as the observatory comes back to life.
  c.drawRect(const Rect.fromLTWH(-200, -100, 760, 580), Pk.fill(const Color(0xFF141A44).withValues(alpha: 0.15 + 0.45 * ov)));
  for (var i = 0; i < 40; i++) {
    final p = Offset(Pk.rand(i) * 360, Pk.rand(i + 60) * 300);
    final tw = 0.6 + 0.4 * sin(t * 2 + i);
    c.drawCircle(p, 0.8 + Pk.rand(i + 7) * 1.4, Pk.fill(Colors.white.withValues(alpha: (0.2 + 0.7 * ov) * tw)));
  }
  Pk.glow(c, const Offset(300, 70), 60, const Color(0xFFFFF4C2), 0.3 * ov);
  c.drawCircle(const Offset(300, 70), 26, Pk.fill(_m(0xFFE8E0C8, 0xFFFFF4C2, ov)));
  c.drawCircle(const Offset(312, 62), 22, Pk.fill(_m(0xFFC8C4C0, 0xFF2A3070, ov)));
  // Hill.
  final hill = Path()
    ..moveTo(-100, 480)
    ..quadraticBezierTo(180, 300, 460, 480)
    ..close();
  c.drawPath(hill, Pk.fill(_m(0xFF7E8470, 0xFF3E6E5A, ov)));
  art.paintGround(c, ov);
  // Observatory: wings + central tower with dome.
  final wall = _m(0xFFB5B0A8, 0xFFECEEF6, ov);
  final roof = _m(0xFF6E6A70, 0xFF3A4A8A, ov);
  Pk.shadow(c, const Offset(180, 472), 300, 18);
  for (final x in [40.0, 230.0]) {
    Pk.box(c, Rect.fromLTWH(x, 330, 90, 140), wall, radius: 3);
    c.drawRect(Rect.fromLTWH(x - 4, 324, 98, 8), Pk.fill(roof));
  }
  Pk.box(c, const Rect.fromLTWH(118, 240, 124, 230), Pk.dark(wall, 0.04), radius: 3);
  c.drawRect(const Rect.fromLTWH(112, 236, 136, 8), Pk.fill(roof));
  c.drawArc(const Rect.fromLTWH(118, 150, 124, 170), pi, pi, true, Pk.fill(_m(0xFFC8C4C0, 0xFFF6F7FB, ov)));
  final slit = Path()
    ..moveTo(170, 236)
    ..lineTo(174, 156)
    ..lineTo(186, 156)
    ..lineTo(190, 236)
    ..close();
  c.drawPath(slit, Pk.fill(_m(0xFF5E5A60, 0xFF141A44, ov)));
  // Telescope peeking out.
  c.drawLine(const Offset(180, 186), const Offset(210, 150), Pk.stroke(_m(0xFF9A9AA4, 0xFFE6E8F0, ov), 7));
  Pk.box(c, const Rect.fromLTWH(160, 420, 40, 50), roof, radius: 3);
  // Winding path.
  c.drawPath(
    Path()
      ..moveTo(180, 640)
      ..quadraticBezierTo(250, 560, 180, 500)
      ..lineTo(180, 470),
    Pk.stroke(_m(0xFF9A9486, 0xFFE6D2A8, ov), 14),
  );
  for (final p in [const Offset(30, 520), const Offset(330, 530), const Offset(56, 600)]) {
    _tree(c, p, 1.1, _m(0xFF6E7A62, 0xFF2E7D4F, ov));
  }
  _mapStar(c, const Offset(60, 150), 6, Colors.white.withValues(alpha: 0.3 + 0.6 * ov));
}

final _observatoryMap = LocationMapArt(
  style: MapStyle.custom,
  scenery: _observatoryScenery,
  groundN: const Color(0xFF8A8E7A),
  groundR: const Color(0xFF4E8A5A),
  groundY: 470,
  skyTopR: const Color(0xFF2A2F7A),
  skyBottomR: const Color(0xFF8A6AC8),
  spots: const [
    MapSpot('observatory_path', Offset(180, 545), Rect.fromLTWH(95, 505, 170, 78), SpotKind.yard, Color(0xFF9CE38A)),
    MapSpot('observatory_planetarium', Offset(85, 395), Rect.fromLTWH(58, 372, 54, 44), SpotKind.window, Color(0xFFB38CFF)),
    MapSpot('observatory_library', Offset(275, 395), Rect.fromLTWH(248, 372, 54, 44), SpotKind.window, Color(0xFF8FD0FF)),
    MapSpot('observatory_dome', Offset(180, 302), Rect.fromLTWH(150, 278, 60, 46), SpotKind.window, Color(0xFFFFE066)),
    MapSpot('observatory_roof', Offset(180, 200), Rect.fromLTWH(160, 184, 40, 30), SpotKind.window, Color(0xFFFF9ADA)),
  ],
);
