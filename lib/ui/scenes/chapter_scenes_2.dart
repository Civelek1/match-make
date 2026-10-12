import 'dart:math';

import 'package:flutter/material.dart';

import '../art/paint_kit.dart';
import 'prop_kit.dart';
import 'prop_scene.dart';
import 'scene_art.dart';

// Scene data for chapters 6–10, same format as chapter_scenes.dart.

Rect _r(double l, double t, double w, double h) => Rect.fromLTWH(l, t, w, h);

const _wood = Color(0xFFC98A52);
const _darkWood = Color(0xFF8B5E3C);
const _red = Color(0xFFE0533F);
const _white = Color(0xFFFFFFFF);
const _cream = Color(0xFFFFF1DA);
const _gold = Color(0xFFFFC93C);
const _green = Color(0xFF4FB548);
const _leaf = Color(0xFF55C04A);
const _blue = Color(0xFF45A7F5);
const _aqua = Color(0xFF4FD6E8);
const _pink = Color(0xFFFF7AB6);
const _purple = Color(0xFF8A5CE6);
const _steel = Color(0xFFC9CCD8);
const _terracotta = Color(0xFFE07A4F);
const _straw = Color(0xFFE8C66B);
const _navy = Color(0xFF2B3A67);
const _orange = Color(0xFFFF9A3C);
const _flame = Color(0xFFFFB347);
const _lampGlow = Color(0xFFFFE9A0);
const _iceBlue = Color(0xFFBFEFFF);
const _pine = Color(0xFF2E7D4F);
const _bronze = Color(0xFFC98A52);
const _ebony = Color(0xFF2B2440);

const _stoneN = Color(0xFFA8A296), _stoneR = Color(0xFFE6DCCB);
const _snowN = Color(0xFFB9B6AE), _snowR = Color(0xFFF4FAFF);

void _castleWall(Canvas c, double ov, double t) {
  final stone = Pk.mix(const Color(0xFF9A948A), const Color(0xFFD9D2C3), ov);
  final dark = Pk.dark(stone, 0.18);
  // Curtain wall with crenellations and a gate arch.
  c.drawRect(const Rect.fromLTWH(0, 70, 400, 82), Pk.fill(stone));
  for (var i = 0; i < 20; i++) {
    c.drawRect(Rect.fromLTWH(i * 20.0 + 2, 60, 12, 12), Pk.fill(stone));
  }
  for (var y = 0; y < 4; y++) {
    for (var x = 0; x < 10; x++) {
      c.drawRect(Rect.fromLTWH(x * 40.0 + (y.isEven ? 0 : 20), 78 + y * 18.0, 40, 18), Pk.stroke(dark.withValues(alpha: 0.35), 1));
    }
  }
  final arch = Path()
    ..moveTo(146, 152)
    ..lineTo(146, 108)
    ..quadraticBezierTo(200, 70, 254, 108)
    ..lineTo(254, 152)
    ..close();
  c.drawPath(arch, Pk.fill(Pk.dark(stone, 0.45)));
  // Towers.
  for (final x in [0.0, 336.0]) {
    Pk.box(c, Rect.fromLTWH(x, 30, 64, 122), dark, radius: 2);
    for (var i = 0; i < 4; i++) {
      c.drawRect(Rect.fromLTWH(x + 2 + i * 16.0, 20, 10, 12), Pk.fill(dark));
    }
    Pk.box(c, Rect.fromLTWH(x + 24, 60, 16, 24), Pk.mix(const Color(0xFF3E3A40), const Color(0xFFFFE9A6), ov), radius: 8);
  }
}

void _lodgeFacade(Canvas c, double ov, double t) {
  final wood = Pk.mix(const Color(0xFF8C7E6C), const Color(0xFFB9763F), ov);
  Pk.box(c, const Rect.fromLTWH(140, 54, 240, 84), wood, radius: 2);
  for (var i = 0; i < 6; i++) {
    c.drawLine(Offset(140, 62 + i * 13.0), Offset(380, 62 + i * 13.0), Pk.stroke(Pk.dark(wood, 0.2), 1.5));
  }
  // Snowy roof.
  Pk.poly(c, const [
    Offset(126, 58),
    Offset(260, 8),
    Offset(394, 58),
  ], Pk.fill(Pk.mix(const Color(0xFF6E6260), const Color(0xFF7A3E2E), ov)));
  Pk.poly(c, const [
    Offset(126, 58),
    Offset(260, 8),
    Offset(394, 58),
    Offset(380, 62),
    Offset(260, 18),
    Offset(140, 62),
  ], Pk.fill(Colors.white));
  // Chimney with smoke.
  Pk.box(c, const Rect.fromLTWH(320, 16, 18, 30), Pk.mix(const Color(0xFF8A7F78), const Color(0xFFB8AEA0), ov), radius: 1);
  for (var i = 0; i < 3; i++) {
    final k = (t * 0.3 + i / 3) % 1;
    c.drawCircle(Offset(329 + sin(k * 6) * 6, 12 - k * 30), 4 + k * 6, Pk.fill(Colors.white.withValues(alpha: (0.5 - k * 0.5) * ov)));
  }
  // Distant peaks.
  Pk.poly(c, const [
    Offset(-20, 136),
    Offset(40, 60),
    Offset(100, 136),
  ], Pk.fill(Pk.mix(const Color(0xFFA8B0BA), const Color(0xFF9EC3E6), ov)));
  Pk.poly(c, const [Offset(22, 82), Offset(40, 60), Offset(58, 82)], Pk.fill(Colors.white));
}

void _marketHall(Canvas c, double ov, double t) {
  final wall = Pk.mix(const Color(0xFFB5A99A), const Color(0xFFF2E4C8), ov);
  Pk.box(c, const Rect.fromLTWH(40, 40, 320, 112), wall, radius: 2);
  Pk.poly(c, const [
    Offset(30, 44),
    Offset(200, 6),
    Offset(370, 44),
  ], Pk.fill(Pk.mix(const Color(0xFF7D6B5E), const Color(0xFF2E6E8A), ov)));
  for (var i = 0; i < 3; i++) {
    final x = 70 + i * 100.0;
    final arch = Path()
      ..moveTo(x, 152)
      ..lineTo(x, 70)
      ..quadraticBezierTo(x + 30, 50, x + 60, 70)
      ..lineTo(x + 60, 152)
      ..close();
    c.drawPath(arch, Pk.fill(Pk.dark(wall, 0.35)));
  }
}

void _lighthouse(Canvas c, double ov, double t) {
  // Rocky outcrop and a striped tower.
  Pk.poly(c, const [
    Offset(120, 140),
    Offset(150, 112),
    Offset(250, 108),
    Offset(290, 140),
  ], Pk.fill(Pk.mix(const Color(0xFF8A847A), const Color(0xFFB8AE9A), ov)));
  final red = Pk.mix(const Color(0xFF9A7E78), const Color(0xFFE0533F), ov);
  final tower = Path()
    ..moveTo(178, 120)
    ..lineTo(186, 40)
    ..lineTo(214, 40)
    ..lineTo(222, 120)
    ..close();
  c.drawPath(tower, Pk.fill(Colors.white));
  c.save();
  c.clipPath(tower);
  for (var i = 0; i < 4; i++) {
    c.drawRect(Rect.fromLTWH(170, 48 + i * 20.0, 60, 10), Pk.fill(red));
  }
  c.restore();
  Pk.box(c, const Rect.fromLTWH(182, 30, 36, 12), const Color(0xFF3B3452), radius: 2);
  Pk.poly(c, const [Offset(184, 30), Offset(200, 14), Offset(216, 30)], Pk.fill(red));
  // Sweeping beam once restored.
  if (ov > 0.05) {
    final a = sin(t * 0.8) * 0.6;
    final beam = Path()
      ..moveTo(200, 26)
      ..lineTo(200 + cos(a) * 220, 26 + sin(a) * 40 - 18)
      ..lineTo(200 + cos(a) * 220, 26 + sin(a) * 40 + 18)
      ..close();
    c.drawPath(beam, Pk.fill(const Color(0xFFFFF1A8).withValues(alpha: 0.25 * ov)));
  }
}

void _museumFacade(Canvas c, double ov, double t) {
  final stone = Pk.mix(const Color(0xFFB0AA9E), const Color(0xFFF4EFE6), ov);
  Pk.box(c, const Rect.fromLTWH(90, 44, 220, 108), Pk.dark(stone, 0.06), radius: 1);
  Pk.poly(c, const [Offset(80, 46), Offset(200, 6), Offset(320, 46)], Pk.fill(stone));
  Pk.poly(c, const [Offset(104, 42), Offset(200, 14), Offset(296, 42)], Pk.fill(Pk.dark(stone, 0.12)));
  c.drawRect(const Rect.fromLTWH(84, 42, 232, 8), Pk.fill(Pk.light(stone, 0.2)));
  // Steps.
  for (var i = 0; i < 3; i++) {
    c.drawRect(Rect.fromLTWH(96.0 - i * 10, 150 + i * 6.0, 208.0 + i * 20, 6), Pk.fill(Pk.dark(stone, 0.05 * i)));
  }
}

void _theaterFacade(Canvas c, double ov, double t) {
  final wall = Pk.mix(const Color(0xFF6E6478), const Color(0xFF8A2E4A), ov);
  Pk.box(c, const Rect.fromLTWH(70, 30, 260, 122), wall, radius: 2);
  c.drawRect(const Rect.fromLTWH(64, 24, 272, 10), Pk.fill(Pk.dark(wall, 0.3)));
  // Marquee bulbs around the roof line.
  for (var i = 0; i < 26; i++) {
    final on = (i + (t * 6).floor()) % 3 != 0;
    c.drawCircle(
      Offset(74 + i * 10.0, 30),
      2.5,
      Pk.fill((on ? const Color(0xFFFFE066) : const Color(0xFF8A7F78)).withValues(alpha: 0.4 + 0.6 * ov)),
    );
  }
  for (final x in [92.0, 286.0]) {
    Pk.box(c, Rect.fromLTWH(x, 50, 22, 100), Pk.light(wall, 0.15), radius: 2);
  }
}

final Map<String, SceneArt Function()> chapterScenes2 = {
  // ------------------------------------------------------------- CASTLE
  'castle_gate': () => PropScene(
    backdrop: const Backdrop.outdoor(groundN: _stoneN, groundR: _stoneR, horizon: 150, floor: FloorStyle.stone),
    scenery: _castleWall,
    objectives: [
      ObjectiveProps('gates', [Prop(PK.gate, _r(150, 92, 100, 60), _darkWood, _gold)]),
      ObjectiveProps('banners', [Prop(PK.banner, _r(92, 48, 36, 52), _red, _gold), Prop(PK.banner, _r(272, 48, 36, 52), _blue, _gold)]),
      ObjectiveProps('torches', [
        Prop(PK.torch, _r(134, 76, 14, 30), _darkWood, _flame),
        Prop(PK.torch, _r(252, 76, 14, 30), _darkWood, _flame),
      ]),
      ObjectiveProps('hedges', [Prop(PK.hedge, _r(8, 160, 92, 34), _leaf, _pink), Prop(PK.hedge, _r(300, 160, 92, 34), _leaf, _pink)]),
      ObjectiveProps('fountain', [Prop(PK.fountain, _r(160, 172, 80, 52), _white, _aqua)]),
      ObjectiveProps('lights', [
        Prop(PK.lamppost, _r(112, 136, 18, 90), _navy, _lampGlow),
        Prop(PK.lamppost, _r(270, 136, 18, 90), _navy, _lampGlow),
      ]),
    ],
  ),
  'banquet_hall': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFFA59C8F),
      topR: Color(0xFFEBD7B5),
      groundN: Color(0xFF8D7F6E),
      groundR: Color(0xFFC98A52),
      floorAltN: Color(0xFF7E7060),
      floorAltR: Color(0xFFB9763F),
      floor: FloorStyle.planks,
    ),
    objectives: [
      ObjectiveProps('tables', [Prop(PK.table, _r(108, 150, 184, 42), _darkWood, _cream)]),
      ObjectiveProps('seats', [
        Prop(PK.chair, _r(80, 138, 26, 48), _red, _darkWood),
        Prop(PK.chair, _r(294, 138, 26, 48), _red, _darkWood),
      ]),
      ObjectiveProps('wine_rack', [Prop(PK.wineRack, _r(16, 96, 62, 76), _darkWood, _red)]),
      ObjectiveProps('glassware', [Prop(PK.champagneTower, _r(180, 116, 40, 34), _aqua, _gold)]),
      ObjectiveProps('curtains', [
        Prop(PK.window, _r(160, 26, 80, 62), _gold, _gold),
        Prop(PK.curtains, _r(150, 20, 100, 74), _red, _gold),
      ]),
      ObjectiveProps('chests', [Prop(PK.crates, _r(322, 134, 60, 42), _wood, _gold)]),
      ObjectiveProps('ice', [
        Prop(PK.chandelier, _r(170, 0, 60, 40), _white, _gold),
        Prop(PK.painting, _r(300, 34, 40, 32), _gold, _green),
      ]),
    ],
  ),
  'castle_library': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFF9E958A),
      topR: Color(0xFFDCC6A2),
      groundN: Color(0xFF8D7F6E),
      groundR: Color(0xFF8E3B3B),
      floorAltN: Color(0xFF7E7060),
      floorAltR: Color(0xFF6E2B2B),
      floor: FloorStyle.carpet,
    ),
    objectives: [
      ObjectiveProps('decor', [Prop(PK.vase, _r(130, 140, 22, 32), _blue, _gold), Prop(PK.vase, _r(250, 140, 22, 32), _purple, _gold)]),
      ObjectiveProps('staircase', [Prop(PK.stairs, _r(296, 72, 96, 100), _darkWood, _red)]),
      ObjectiveProps('trophies', [Prop(PK.trophyCase, _r(158, 112, 84, 60), _darkWood, _gold)]),
      ObjectiveProps('books', [
        Prop(PK.bookshelf, _r(8, 30, 80, 142), _darkWood, _red),
        Prop(PK.bookshelf, _r(94, 44, 56, 90), _darkWood, _green),
      ]),
      ObjectiveProps('scrolls', [Prop(PK.table, _r(150, 184, 100, 32), _wood, _cream)]),
      ObjectiveProps('clocks', [Prop(PK.clock, _r(262, 90, 26, 82), _darkWood, _gold)]),
      ObjectiveProps('chains', [
        Prop(PK.chandelier, _r(172, 0, 56, 40), _gold, _white),
        Prop(PK.floorLamp, _r(110, 120, 18, 52), _gold, _cream),
      ]),
    ],
  ),
  'armory': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFF8E8A84),
      topR: Color(0xFFC9CED8),
      groundN: Color(0xFF7D7064),
      groundR: Color(0xFFA8A296),
      floorAltN: Color(0xFF6E6254),
      floorAltR: Color(0xFF8E887C),
      floor: FloorStyle.tiles,
    ),
    objectives: [
      ObjectiveProps('banners', [Prop(PK.banner, _r(36, 20, 40, 60), _red, _gold), Prop(PK.banner, _r(324, 20, 40, 60), _red, _gold)]),
      ObjectiveProps('shields', [Prop(PK.pegboard, _r(120, 28, 160, 62), _steel, _red)]),
      ObjectiveProps('torches', [
        Prop(PK.torch, _r(98, 58, 14, 30), _darkWood, _flame),
        Prop(PK.torch, _r(288, 58, 14, 30), _darkWood, _flame),
      ]),
      ObjectiveProps('medals', [Prop(PK.trophyCase, _r(150, 110, 100, 62), _darkWood, _gold)]),
      ObjectiveProps('lights', [Prop(PK.chandelier, _r(178, 0, 44, 30), _steel, _gold)]),
      ObjectiveProps('chests', [
        Prop(PK.crates, _r(18, 134, 58, 42), _wood, _gold),
        Prop(PK.barrel, _r(330, 138, 26, 36), _darkWood, _steel),
      ]),
      ObjectiveProps('crates', [Prop(PK.table, _r(90, 186, 100, 30), _wood, _steel), Prop(PK.toolbox, _r(236, 196, 40, 28), _red, _steel)]),
    ],
  ),
  'throne_room': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFFA59CA8),
      topR: Color(0xFFF0E2F8),
      groundN: Color(0xFF8D877D),
      groundR: Color(0xFF6B3FA0),
      floorAltN: Color(0xFF7E7868),
      floorAltR: Color(0xFF55307F),
      floor: FloorStyle.carpet,
    ),
    objectives: [
      ObjectiveProps('decor', [Prop(PK.sofa, _r(160, 120, 80, 52), _red, _gold)]),
      ObjectiveProps('shields', [
        Prop(PK.banner, _r(18, 22, 40, 66), _purple, _gold),
        Prop(PK.banner, _r(342, 22, 40, 66), _purple, _gold),
      ]),
      ObjectiveProps('statues', [
        Prop(PK.statue, _r(98, 102, 34, 70), _white, _gold),
        Prop(PK.statue, _r(268, 102, 34, 70), _white, _gold),
      ]),
      ObjectiveProps('floor', [
        Prop(PK.rug, _r(128, 190, 144, 40), _red, _gold),
        Prop(PK.vase, _r(64, 132, 24, 40), _purple, _gold),
        Prop(PK.vase, _r(312, 132, 24, 40), _purple, _gold),
      ]),
      ObjectiveProps('windows', [Prop(PK.window, _r(160, 18, 80, 60), _gold, _gold)]),
      ObjectiveProps('curtains', [Prop(PK.curtains, _r(150, 12, 100, 74), _purple, _gold)]),
      ObjectiveProps('chests', [Prop(PK.crates, _r(330, 176, 52, 42), _gold, _red), Prop(PK.crates, _r(18, 176, 52, 42), _gold, _red)]),
    ],
  ),
  // ------------------------------------------------------------- MOUNTAIN LODGE
  'lodge_front': () => PropScene(
    backdrop: const Backdrop.outdoor(groundN: _snowN, groundR: _snowR, horizon: 136, topR: Color(0xFF8FD0FF)),
    scenery: _lodgeFacade,
    objectives: [
      ObjectiveProps('snowmen', [Prop(PK.snowman, _r(34, 124, 34, 70), _white, _red)]),
      ObjectiveProps('skis', [
        Prop(PK.surfboard, _r(330, 128, 12, 58), _red, _white),
        Prop(PK.surfboard, _r(346, 130, 12, 58), _blue, _white),
      ]),
      ObjectiveProps('sleds', [Prop(PK.cart, _r(70, 196, 62, 34), _red, _gold)]),
      ObjectiveProps('chalet', [Prop(PK.door, _r(238, 84, 44, 52), _darkWood, _gold), Prop(PK.window, _r(164, 66, 52, 40), _gold, _gold)]),
      ObjectiveProps('ice_rink', [Prop(PK.pond, _r(150, 186, 130, 42), _iceBlue, _white)]),
      ObjectiveProps('gates', [Prop(PK.gate, _r(6, 160, 64, 30), _darkWood, _gold)]),
      ObjectiveProps('ice', [Prop(PK.tree, _r(360, 60, 40, 84), _pine, _white), Prop(PK.tree, _r(96, 72, 46, 70), _pine, _white)]),
    ],
  ),
  'lodge_lounge': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFFA59C8F),
      topR: Color(0xFFE6BF8E),
      groundN: Color(0xFF8D7F6E),
      groundR: Color(0xFFB9763F),
      floorAltN: Color(0xFF7E7060),
      floorAltR: Color(0xFF9A5E33),
      floor: FloorStyle.planks,
    ),
    objectives: [
      ObjectiveProps('sofas', [Prop(PK.sofa, _r(18, 138, 110, 50), _red, _cream)]),
      ObjectiveProps('fireplace', [Prop(PK.fireplace, _r(158, 84, 92, 88), _stoneR, _gold)]),
      ObjectiveProps('lamps', [
        Prop(PK.floorLamp, _r(138, 110, 18, 62), _darkWood, _gold),
        Prop(PK.pendant, _r(300, 0, 28, 40), _darkWood, _gold),
      ]),
      ObjectiveProps('floor', [Prop(PK.rug, _r(118, 190, 172, 36), _red, _cream)]),
      ObjectiveProps('windows', [Prop(PK.window, _r(290, 30, 80, 62), _white, _white)]),
      ObjectiveProps('cocoa', [Prop(PK.table, _r(282, 172, 82, 32), _wood, _cream)]),
      ObjectiveProps('ice', [Prop(PK.painting, _r(36, 38, 54, 40), _gold, _blue), Prop(PK.clock, _r(262, 94, 22, 78), _darkWood, _gold)]),
    ],
  ),
  'ski_room': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFF9EA4AA),
      topR: Color(0xFFD3E6F3),
      groundN: Color(0xFF7D7064),
      groundR: Color(0xFFB9824A),
      floorAltN: Color(0xFF6E6254),
      floorAltR: Color(0xFFA06A3A),
      floor: FloorStyle.planks,
    ),
    objectives: [
      ObjectiveProps('skis', [
        Prop(PK.surfboard, _r(18, 70, 12, 100), _red, _white),
        Prop(PK.surfboard, _r(34, 74, 12, 96), _blue, _white),
        Prop(PK.surfboard, _r(50, 70, 12, 100), _gold, _white),
      ]),
      ObjectiveProps('sleds', [Prop(PK.cart, _r(80, 190, 64, 36), _red, _gold)]),
      ObjectiveProps('boards', [
        Prop(PK.surfboard, _r(330, 80, 16, 92), _purple, _gold),
        Prop(PK.surfboard, _r(350, 84, 16, 88), _aqua, _white),
      ]),
      ObjectiveProps('skates', [
        Prop(PK.shelf, _r(120, 50, 120, 22), _darkWood, _white),
        Prop(PK.shelf, _r(120, 90, 120, 22), _darkWood, _red),
      ]),
      ObjectiveProps('lights', [Prop(PK.pendant, _r(160, 0, 28, 40), _navy, _gold), Prop(PK.pendant, _r(240, 0, 28, 40), _navy, _gold)]),
      ObjectiveProps('lockers', [Prop(PK.cabinet, _r(252, 110, 62, 62), _blue, _steel)]),
      ObjectiveProps('crates', [Prop(PK.crates, _r(170, 172, 60, 46), _wood, _cream)]),
    ],
  ),
  'lodge_spa': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFFA8A69A),
      topR: Color(0xFFE6F3EE),
      groundN: Color(0xFF8D8A80),
      groundR: Color(0xFFFFFFFF),
      floorAltN: Color(0xFF6E6B62),
      floorAltR: Color(0xFFA8DCD0),
      floor: FloorStyle.tiles,
    ),
    objectives: [
      ObjectiveProps('flowers', [
        Prop(PK.plant, _r(18, 130, 26, 42), _terracotta, _terracotta),
        Prop(PK.vase, _r(356, 136, 22, 36), _white, _pink),
      ]),
      ObjectiveProps('towels', [Prop(PK.towels, _r(58, 140, 56, 34), _white, _aqua)]),
      ObjectiveProps('juice_bar', [Prop(PK.barCounter, _r(250, 120, 110, 52), _wood, _aqua)]),
      ObjectiveProps('herbs', [Prop(PK.shelf, _r(130, 40, 120, 22), _wood, _green)]),
      ObjectiveProps('hot_tub', [Prop(PK.hotTub, _r(118, 150, 164, 62), _aqua, _wood)]),
      ObjectiveProps('toiletries', [Prop(PK.mirror, _r(290, 28, 52, 62), _white, _gold)]),
      ObjectiveProps('ice', [Prop(PK.window, _r(28, 28, 72, 62), _white, _white), Prop(PK.pendant, _r(188, 0, 24, 36), _steel, _gold)]),
    ],
  ),
  'lodge_suite': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFFA59C8F),
      topR: Color(0xFFF1DECB),
      groundN: Color(0xFF8D877D),
      groundR: Color(0xFFC98A52),
      floorAltN: Color(0xFF7E7868),
      floorAltR: Color(0xFFB9763F),
      floor: FloorStyle.planks,
    ),
    objectives: [
      ObjectiveProps('bed', [Prop(PK.bed, _r(110, 120, 170, 60), _darkWood, _red)]),
      ObjectiveProps('wardrobe', [Prop(PK.wardrobe, _r(18, 70, 66, 102), _darkWood, _gold)]),
      ObjectiveProps('lamps', [
        Prop(PK.floorLamp, _r(292, 110, 18, 62), _darkWood, _gold),
        Prop(PK.pendant, _r(186, 0, 26, 36), _darkWood, _gold),
      ]),
      ObjectiveProps('balcony', [Prop(PK.window, _r(130, 24, 130, 72), _white, _white)]),
      ObjectiveProps('windows', [Prop(PK.window, _r(312, 40, 60, 50), _white, _white)]),
      ObjectiveProps('curtains', [Prop(PK.curtains, _r(122, 18, 146, 82), _red, _gold)]),
      ObjectiveProps('chests', [Prop(PK.luggage, _r(330, 138, 40, 44), _red, _gold)]),
    ],
  ),
  // ------------------------------------------------------------- HARBOR
  'harbor_dock': () => PropScene(
    backdrop: const Backdrop.outdoor(groundN: Color(0xFF9A8C7A), groundR: Color(0xFFC98A52), horizon: 122, sea: true),
    objectives: [
      ObjectiveProps('anchors', [Prop(PK.anchor, _r(18, 140, 30, 42), _navy, _red)]),
      ObjectiveProps('boats', [Prop(PK.sailboat, _r(250, 60, 84, 62), _white, _red), Prop(PK.sailboat, _r(60, 70, 62, 48), _red, _white)]),
      ObjectiveProps('fish', [Prop(PK.stall, _r(150, 128, 92, 60), _wood, _blue)]),
      ObjectiveProps('fishing', [
        Prop(PK.barrel, _r(90, 150, 26, 36), _darkWood, _steel),
        Prop(PK.barrel, _r(118, 156, 24, 32), _darkWood, _steel),
      ]),
      ObjectiveProps('shoreline', [Prop(PK.shoreline, _r(0, 122, 400, 16), _white, _white)]),
      ObjectiveProps('cargo', [Prop(PK.crates, _r(310, 170, 72, 56), _wood, _cream)]),
      ObjectiveProps('crates', [Prop(PK.railing, _r(0, 206, 150, 22), _white, _white)]),
    ],
  ),
  'fish_market': () => PropScene(
    backdrop: const Backdrop.outdoor(groundN: _stoneN, groundR: _stoneR, horizon: 150, floor: FloorStyle.stone),
    scenery: _marketHall,
    objectives: [
      ObjectiveProps('menu_board', [Prop(PK.menuBoard, _r(18, 120, 40, 50), _wood, _gold)]),
      ObjectiveProps('stools', [
        Prop(PK.chair, _r(262, 170, 22, 40), _red, _darkWood),
        Prop(PK.chair, _r(292, 172, 22, 40), _blue, _darkWood),
      ]),
      ObjectiveProps('fish', [Prop(PK.stall, _r(78, 108, 104, 72), _wood, _aqua)]),
      ObjectiveProps('fishing', [Prop(PK.barrel, _r(192, 150, 26, 36), _darkWood, _steel)]),
      ObjectiveProps('awning', [Prop(PK.awning, _r(60, 80, 260, 26), _blue, _white)]),
      ObjectiveProps('lockers', [Prop(PK.crates, _r(322, 150, 70, 56), _wood, _cream)]),
      ObjectiveProps('ice', [
        Prop(PK.stringLights, _r(40, 66, 320, 16), _gold, _pink),
        Prop(PK.lamppost, _r(372, 100, 18, 90), _navy, _lampGlow),
      ]),
    ],
  ),
  'boathouse': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFF8E8A84),
      topR: Color(0xFFBFD0E0),
      groundN: Color(0xFF7D7064),
      groundR: Color(0xFFB9824A),
      floorAltN: Color(0xFF6E6254),
      floorAltR: Color(0xFFA06A3A),
      floor: FloorStyle.planks,
    ),
    objectives: [
      ObjectiveProps('anchors', [Prop(PK.anchor, _r(28, 36, 34, 48), _steel, _red)]),
      ObjectiveProps('boats', [Prop(PK.sailboat, _r(120, 70, 160, 104), _white, _blue)]),
      ObjectiveProps('repairs', [Prop(PK.workbench, _r(292, 120, 90, 52), _wood, _red)]),
      ObjectiveProps('tools', [Prop(PK.pegboard, _r(282, 36, 100, 56), _cream, _red)]),
      ObjectiveProps('waterway', [Prop(PK.poolWater, _r(100, 186, 200, 46), _aqua, _white)]),
      ObjectiveProps('kayaks', [Prop(PK.kayak, _r(8, 186, 80, 16), _orange, _navy), Prop(PK.kayak, _r(8, 206, 70, 14), _red, _navy)]),
      ObjectiveProps('lockers', [Prop(PK.cabinet, _r(68, 100, 46, 72), _blue, _steel)]),
    ],
  ),
  'lighthouse_base': () => PropScene(
    backdrop: const Backdrop.outdoor(groundN: Color(0xFFA8A296), groundR: Color(0xFFD9CDB0), horizon: 132, sea: true),
    scenery: _lighthouse,
    objectives: [
      ObjectiveProps('anchors', [Prop(PK.anchor, _r(28, 150, 30, 42), _navy, _red)]),
      ObjectiveProps('staircase', [Prop(PK.stairs, _r(250, 100, 80, 62), _white, _red)]),
      ObjectiveProps('beacon', [Prop(PK.lantern, _r(186, 6, 28, 40), _navy, _gold)]),
      ObjectiveProps('fishing', [
        Prop(PK.bench, _r(304, 172, 70, 30), _wood, _wood),
        Prop(PK.barrel, _r(80, 182, 24, 32), _darkWood, _steel),
      ]),
      ObjectiveProps('shoreline', [Prop(PK.shoreline, _r(0, 132, 400, 16), _white, _white)]),
      ObjectiveProps('lights', [
        Prop(PK.lamppost, _r(112, 122, 18, 90), _navy, _lampGlow),
        Prop(PK.lamppost, _r(334, 118, 18, 90), _navy, _lampGlow),
      ]),
      ObjectiveProps('gates', [Prop(PK.door, _r(182, 108, 36, 46), _red, _gold)]),
    ],
  ),
  'keeper_cottage': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFFA0A4A8),
      topR: Color(0xFFDCE8F0),
      groundN: Color(0xFF8D877D),
      groundR: Color(0xFFC98A52),
      floorAltN: Color(0xFF7E7060),
      floorAltR: Color(0xFFB9763F),
      floor: FloorStyle.planks,
    ),
    objectives: [
      ObjectiveProps('furniture', [Prop(PK.sofa, _r(18, 138, 100, 50), _blue, _cream)]),
      ObjectiveProps('fireplace', [Prop(PK.fireplace, _r(150, 88, 86, 84), _stoneR, _gold)]),
      ObjectiveProps('lamps', [
        Prop(PK.lantern, _r(258, 8, 20, 44), _navy, _gold),
        Prop(PK.floorLamp, _r(124, 114, 16, 58), _darkWood, _gold),
      ]),
      ObjectiveProps('baking', [Prop(PK.table, _r(252, 172, 100, 34), _wood, _orange)]),
      ObjectiveProps('maps', [Prop(PK.painting, _r(36, 34, 62, 46), _gold, _blue), Prop(PK.clock, _r(334, 96, 22, 76), _darkWood, _gold)]),
      ObjectiveProps('plants', [
        Prop(PK.plant, _r(362, 150, 24, 36), _terracotta, _terracotta),
        Prop(PK.plant, _r(240, 136, 20, 30), _terracotta, _terracotta),
      ]),
      ObjectiveProps('chains', [
        Prop(PK.window, _r(262, 40, 60, 50), _white, _white),
        Prop(PK.curtains, _r(254, 34, 76, 62), _blue, _white),
      ]),
    ],
  ),
  // ------------------------------------------------------------- MUSEUM
  'museum_steps': () => PropScene(
    backdrop: const Backdrop.outdoor(groundN: _stoneN, groundR: _stoneR, horizon: 150, floor: FloorStyle.stone),
    scenery: _museumFacade,
    objectives: [
      ObjectiveProps('flowers', [
        Prop(PK.flowerbed, _r(18, 204, 110, 26), _pink, _gold),
        Prop(PK.flowerbed, _r(272, 204, 110, 26), _pink, _gold),
      ]),
      ObjectiveProps('columns', [
        Prop(PK.column, _r(112, 50, 24, 100), _white, _gold),
        Prop(PK.column, _r(158, 50, 24, 100), _white, _gold),
        Prop(PK.column, _r(218, 50, 24, 100), _white, _gold),
        Prop(PK.column, _r(264, 50, 24, 100), _white, _gold),
      ]),
      ObjectiveProps('statues', [
        Prop(PK.statue, _r(30, 118, 40, 82), _white, _gold),
        Prop(PK.statue, _r(330, 118, 40, 82), _white, _gold),
      ]),
      ObjectiveProps('hedges', [Prop(PK.hedge, _r(74, 168, 80, 30), _leaf, _pink), Prop(PK.hedge, _r(246, 168, 80, 30), _leaf, _pink)]),
      ObjectiveProps('fountain', [Prop(PK.fountain, _r(160, 172, 80, 50), _white, _aqua)]),
      ObjectiveProps('lights', [
        Prop(PK.lamppost, _r(8, 110, 18, 100), _navy, _lampGlow),
        Prop(PK.lamppost, _r(374, 110, 18, 100), _navy, _lampGlow),
      ]),
      ObjectiveProps('gates', [Prop(PK.door, _r(180, 92, 40, 58), _darkWood, _gold)]),
    ],
  ),
  'sculpture_hall': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFFA8A296),
      topR: Color(0xFFEFE9DE),
      groundN: Color(0xFF8D877D),
      groundR: Color(0xFFFFFFFF),
      floorAltN: Color(0xFF6E6B62),
      floorAltR: Color(0xFFBFB6A6),
    ),
    objectives: [
      ObjectiveProps('decor', [Prop(PK.vase, _r(68, 140, 24, 34), _blue, _gold), Prop(PK.vase, _r(308, 140, 24, 34), _blue, _gold)]),
      ObjectiveProps('columns', [
        Prop(PK.column, _r(18, 20, 30, 152), _white, _gold),
        Prop(PK.column, _r(352, 20, 30, 152), _white, _gold),
      ]),
      ObjectiveProps('statues', [
        Prop(PK.statue, _r(108, 96, 40, 76), _white, _gold),
        Prop(PK.statue, _r(252, 96, 40, 76), _white, _gold),
        Prop(PK.statue, _r(180, 110, 40, 62), _bronze, _gold),
      ]),
      ObjectiveProps('floor', [Prop(PK.rug, _r(100, 196, 200, 32), _red, _gold)]),
      ObjectiveProps('windows', [Prop(PK.window, _r(160, 20, 80, 60), _white, _white)]),
      ObjectiveProps('curtains', [Prop(PK.curtains, _r(150, 14, 100, 74), _red, _gold)]),
      ObjectiveProps('chains', [
        Prop(PK.chandelier, _r(78, 0, 50, 34), _white, _gold),
        Prop(PK.chandelier, _r(272, 0, 50, 34), _white, _gold),
      ]),
    ],
  ),
  'art_gallery': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFFA8A296),
      topR: Color(0xFFF8F3EA),
      groundN: Color(0xFF8D7F6E),
      groundR: Color(0xFFC98A52),
      floorAltN: Color(0xFF7E7060),
      floorAltR: Color(0xFFB9763F),
      floor: FloorStyle.planks,
    ),
    objectives: [
      ObjectiveProps('paintings', [
        Prop(PK.painting, _r(28, 40, 70, 52), _gold, _blue),
        Prop(PK.painting, _r(165, 34, 70, 58), _gold, _red),
        Prop(PK.painting, _r(302, 40, 70, 52), _gold, _green),
      ]),
      ObjectiveProps('seats', [Prop(PK.bench, _r(150, 172, 100, 30), _darkWood, _darkWood)]),
      ObjectiveProps('lamps', [
        Prop(PK.pendant, _r(52, 0, 24, 30), _navy, _gold),
        Prop(PK.pendant, _r(188, 0, 24, 30), _navy, _gold),
        Prop(PK.pendant, _r(324, 0, 24, 30), _navy, _gold),
      ]),
      ObjectiveProps('brushes', [Prop(PK.menuBoard, _r(28, 118, 42, 54), _wood, _white)]),
      ObjectiveProps('frames', [
        Prop(PK.painting, _r(108, 100, 40, 34), _gold, _pink),
        Prop(PK.painting, _r(252, 100, 40, 34), _gold, _aqua),
      ]),
      ObjectiveProps('curtains', [Prop(PK.rug, _r(80, 204, 240, 26), _purple, _gold)]),
      ObjectiveProps('ice', [
        Prop(PK.plant, _r(360, 140, 24, 34), _terracotta, _terracotta),
        Prop(PK.vase, _r(8, 140, 22, 32), _white, _pink),
      ]),
    ],
  ),
  'history_hall': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFF9E958A),
      topR: Color(0xFFEADFC8),
      groundN: Color(0xFF8D7F6E),
      groundR: Color(0xFF2E5E86),
      floorAltN: Color(0xFF7E7060),
      floorAltR: Color(0xFF244A6B),
      floor: FloorStyle.carpet,
    ),
    objectives: [
      ObjectiveProps('decor', [Prop(PK.vase, _r(18, 130, 24, 42), _terracotta, _gold)]),
      ObjectiveProps('shields', [Prop(PK.banner, _r(58, 20, 38, 58), _red, _gold), Prop(PK.banner, _r(304, 20, 38, 58), _blue, _gold)]),
      ObjectiveProps('exhibits', [Prop(PK.trophyCase, _r(140, 110, 120, 62), _darkWood, _gold)]),
      ObjectiveProps('globes', [Prop(PK.podium, _r(280, 128, 52, 44), _gold, _blue)]),
      ObjectiveProps('maps', [Prop(PK.painting, _r(140, 28, 120, 62), _gold, _straw)]),
      ObjectiveProps('clocks', [Prop(PK.clock, _r(92, 96, 24, 76), _darkWood, _gold)]),
      ObjectiveProps('display_cases', [Prop(PK.cabinet, _r(334, 100, 56, 72), _white, _aqua)]),
    ],
  ),
  'museum_cafe': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFFA59C8F),
      topR: Color(0xFFF7E5CF),
      groundN: Color(0xFF8D8A80),
      groundR: Color(0xFFFFFFFF),
      floorAltN: Color(0xFF6E6B62),
      floorAltR: Color(0xFFE0533F),
      floor: FloorStyle.tiles,
    ),
    objectives: [
      ObjectiveProps('menu_board', [Prop(PK.menuBoard, _r(18, 40, 60, 60), _darkWood, _gold)]),
      ObjectiveProps('seats', [
        Prop(PK.chair, _r(118, 150, 24, 42), _red, _darkWood),
        Prop(PK.chair, _r(182, 150, 24, 42), _red, _darkWood),
      ]),
      ObjectiveProps('cutlery', [Prop(PK.roundTable, _r(126, 164, 72, 38), _white, _red)]),
      ObjectiveProps('baking', [Prop(PK.counter, _r(250, 118, 122, 54), _cream, _wood)]),
      ObjectiveProps('glassware', [Prop(PK.shelf, _r(250, 50, 122, 22), _darkWood, _aqua)]),
      ObjectiveProps('cocoa', [Prop(PK.pendant, _r(140, 0, 24, 34), _navy, _gold), Prop(PK.pendant, _r(300, 0, 24, 34), _navy, _gold)]),
      ObjectiveProps('crates', [
        Prop(PK.plant, _r(222, 136, 22, 36), _terracotta, _terracotta),
        Prop(PK.plant, _r(8, 140, 22, 34), _terracotta, _terracotta),
      ]),
    ],
  ),
  // ------------------------------------------------------------- THEATER
  'theater_front': () => PropScene(
    backdrop: const Backdrop.outdoor(
      groundN: _stoneN,
      groundR: Color(0xFF6B6480),
      horizon: 150,
      night: true,
      skyline: true,
      floor: FloorStyle.stone,
      topR: Color(0xFF241C4D),
      bottomR: Color(0xFF5E3A8A),
    ),
    scenery: _theaterFacade,
    objectives: [
      ObjectiveProps('posters', [
        Prop(PK.painting, _r(38, 92, 40, 54), _gold, _purple),
        Prop(PK.painting, _r(322, 92, 40, 54), _gold, _red),
      ]),
      ObjectiveProps('tickets', [Prop(PK.stall, _r(88, 108, 70, 64), _red, _gold)]),
      ObjectiveProps('sign', [Prop(PK.neonSign, _r(130, 38, 140, 34), _pink, _gold)]),
      ObjectiveProps('hedges', [Prop(PK.planter, _r(18, 182, 62, 34), _wood, _leaf), Prop(PK.planter, _r(320, 182, 62, 34), _wood, _leaf)]),
      ObjectiveProps('awning', [Prop(PK.awning, _r(110, 80, 180, 24), _red, _gold)]),
      ObjectiveProps('spotlights', [
        Prop(PK.spotlight, _r(8, 0, 62, 150), _navy, _gold),
        Prop(PK.spotlight, _r(330, 0, 62, 150), _navy, _gold),
      ]),
      ObjectiveProps('gates', [Prop(PK.door, _r(176, 104, 48, 66), _red, _gold)]),
    ],
  ),
  'theater_lobby': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFFA59C8F),
      topR: Color(0xFFF4E0C8),
      groundN: Color(0xFF8D877D),
      groundR: Color(0xFFFFFFFF),
      floorAltN: Color(0xFF6E6B62),
      floorAltR: Color(0xFF7A2E3A),
    ),
    objectives: [
      ObjectiveProps('decor', [
        Prop(PK.vase, _r(40, 138, 24, 34), _red, _gold),
        Prop(PK.plant, _r(340, 136, 24, 36), _terracotta, _terracotta),
      ]),
      ObjectiveProps('staircase', [Prop(PK.stairs, _r(140, 70, 120, 102), _white, _red)]),
      ObjectiveProps('champagne', [
        Prop(PK.barCounter, _r(282, 124, 100, 48), _darkWood, _gold),
        Prop(PK.champagneTower, _r(310, 94, 40, 30), _gold, _white),
      ]),
      ObjectiveProps('floor', [Prop(PK.rug, _r(110, 196, 180, 30), _red, _gold)]),
      ObjectiveProps('windows', [Prop(PK.window, _r(20, 30, 60, 70), _gold, _gold)]),
      ObjectiveProps('curtains', [Prop(PK.curtains, _r(12, 24, 76, 84), _red, _gold)]),
      ObjectiveProps('ice', [Prop(PK.chandelier, _r(170, 0, 60, 42), _white, _gold)]),
    ],
  ),
  'dressing_room': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFFA59CA0),
      topR: Color(0xFFF5DCE8),
      groundN: Color(0xFF8D877D),
      groundR: Color(0xFF8A3B6A),
      floorAltN: Color(0xFF7E7868),
      floorAltR: Color(0xFF6E2B55),
      floor: FloorStyle.carpet,
    ),
    objectives: [
      ObjectiveProps('masks', [Prop(PK.painting, _r(170, 34, 60, 42), _gold, _purple)]),
      ObjectiveProps('wardrobe', [Prop(PK.wardrobe, _r(18, 70, 66, 102), _purple, _gold)]),
      ObjectiveProps('lamps', [Prop(PK.floorLamp, _r(100, 110, 18, 62), _gold, _cream)]),
      ObjectiveProps('mics', [Prop(PK.speaker, _r(340, 118, 40, 54), _navy, _gold)]),
      ObjectiveProps('frames', [Prop(PK.mirror, _r(240, 28, 80, 72), _white, _gold)]),
      ObjectiveProps('spotlights', [Prop(PK.spotlight, _r(150, 0, 100, 122), _navy, _pink)]),
      ObjectiveProps('lockers', [Prop(PK.cabinet, _r(252, 110, 80, 62), _white, _pink)]),
    ],
  ),
  'concert_hall': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFF5E5868),
      topR: Color(0xFF3B2A5A),
      groundN: Color(0xFF6E6878),
      groundR: Color(0xFF7A2E3A),
      floorAltN: Color(0xFF5E5868),
      floorAltR: Color(0xFF5E1F2A),
      floor: FloorStyle.carpet,
      night: true,
    ),
    objectives: [
      ObjectiveProps('masks', [Prop(PK.painting, _r(28, 36, 52, 40), _gold, _red), Prop(PK.painting, _r(320, 36, 52, 40), _gold, _blue)]),
      ObjectiveProps('seats', [Prop(PK.cinemaSeats, _r(18, 194, 364, 40), _red, _gold)]),
      ObjectiveProps('trophies', [Prop(PK.trophyCase, _r(28, 110, 70, 62), _darkWood, _gold)]),
      ObjectiveProps('piano', [Prop(PK.piano, _r(150, 110, 100, 62), _ebony, _white)]),
      ObjectiveProps('sheet_music', [Prop(PK.speaker, _r(302, 110, 44, 62), _navy, _gold)]),
      ObjectiveProps('spotlights', [
        Prop(PK.spotlight, _r(118, 0, 62, 120), _navy, _gold),
        Prop(PK.spotlight, _r(220, 0, 62, 120), _navy, _gold),
      ]),
      ObjectiveProps('chains', [Prop(PK.chandelier, _r(170, 0, 60, 40), _gold, _white)]),
    ],
  ),
  'grand_stage': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFF5E5868),
      topR: Color(0xFF2B1B3A),
      groundN: Color(0xFF6E6878),
      groundR: Color(0xFF7A2E3A),
      floorAltN: Color(0xFF5E5868),
      floorAltR: Color(0xFF5E1F2A),
      floor: FloorStyle.carpet,
      night: true,
    ),
    objectives: [
      ObjectiveProps('decor', [Prop(PK.vase, _r(18, 130, 24, 40), _gold, _red), Prop(PK.vase, _r(358, 130, 24, 40), _gold, _red)]),
      ObjectiveProps('seats', [Prop(PK.cinemaSeats, _r(8, 202, 384, 34), _red, _gold)]),
      ObjectiveProps('champagne', [Prop(PK.champagneTower, _r(332, 150, 44, 36), _gold, _white)]),
      ObjectiveProps('mics', [Prop(PK.speaker, _r(50, 110, 40, 62), _navy, _gold), Prop(PK.speaker, _r(310, 110, 40, 62), _navy, _gold)]),
      ObjectiveProps('sheet_music', [Prop(PK.piano, _r(244, 124, 90, 50), _ebony, _white)]),
      ObjectiveProps('curtains', [
        Prop(PK.stage, _r(100, 100, 200, 90), _darkWood, _gold),
        Prop(PK.curtains, _r(100, 8, 200, 112), _red, _gold),
      ]),
      ObjectiveProps('chests', [Prop(PK.crates, _r(140, 150, 60, 40), _gold, _red)]),
    ],
  ),
};
