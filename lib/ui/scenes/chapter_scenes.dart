import 'package:flutter/material.dart';

import '../art/paint_kit.dart';
import 'prop_kit.dart';
import 'prop_scene.dart';
import 'scene_art.dart';

// Scene data for chapters 2–5. Each objective lists the props it restores
// (see ObjectiveProps.stageFor). Coordinates are in the 400×240 design space.

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

const _grassN = Color(0xFFC9AE77), _grassR = Color(0xFF7ACB52);
const _sandN = Color(0xFFCFC2A2), _sandR = Color(0xFFF6DC9C);
const _stoneN = Color(0xFFA8A296), _stoneR = Color(0xFFE6DCCB);

void _barnFacade(Canvas c, double ov, double t) {
  final red = Pk.mix(const Color(0xFF9A6A5E), const Color(0xFFC8412F), ov);
  Pk.poly(c, const [Offset(250, 132), Offset(250, 70), Offset(300, 40), Offset(350, 70), Offset(350, 132)], Pk.fill(red));
  c.drawRect(const Rect.fromLTWH(285, 95, 30, 37), Pk.fill(Pk.dark(red, 0.3)));
  c.drawLine(const Offset(285, 95), const Offset(315, 132), Pk.stroke(_white, 2));
  c.drawLine(const Offset(315, 95), const Offset(285, 132), Pk.stroke(_white, 2));
}

void _coopShed(Canvas c, double ov, double t) {
  final wood = Pk.mix(const Color(0xFF9A8D7C), const Color(0xFFD9A066), ov);
  Pk.box(c, const Rect.fromLTWH(20, 70, 220, 60), wood, radius: 2);
  Pk.poly(c, const [Offset(10, 72), Offset(130, 40), Offset(250, 72)], Pk.fill(Pk.mix(const Color(0xFF7D6B5E), const Color(0xFFB24330), ov)));
}

void _restaurantFacade(Canvas c, double ov, double t) {
  final wall = Pk.mix(const Color(0xFFB5A99A), const Color(0xFFFFE3C2), ov);
  Pk.box(c, const Rect.fromLTWH(40, 30, 320, 145), wall, radius: 2);
  c.drawRect(const Rect.fromLTWH(34, 24, 332, 8), Pk.fill(Pk.dark(wall, 0.25)));
  for (final x in [70.0, 290.0]) {
    Pk.box(c, Rect.fromLTWH(x, 105, 44, 50), Pk.mix(const Color(0xFF6E7076), const Color(0xFFFFE9A6), ov), radius: 3, outline: _white, ow: 2.5);
  }
}

void _mansionFacade(Canvas c, double ov, double t) {
  final wall = Pk.mix(const Color(0xFFBFB6A6), const Color(0xFFFFF4E0), ov);
  Pk.box(c, const Rect.fromLTWH(30, 30, 340, 105), wall, radius: 2);
  Pk.poly(c, const [Offset(140, 32), Offset(200, 6), Offset(260, 32)], Pk.fill(Pk.dark(wall, 0.12)));
  for (var i = 0; i < 6; i++) {
    c.drawRect(Rect.fromLTWH(60 + i * 56.0, 40, 8, 95), Pk.fill(Pk.light(wall, 0.3)));
  }
  for (var i = 0; i < 5; i++) {
    Pk.box(c, Rect.fromLTWH(74 + i * 56.0, 50, 26, 34), Pk.mix(const Color(0xFF5E6168), const Color(0xFFFFE9A6), ov), radius: 8);
  }
}

void _barHut(Canvas c, double ov, double t) {
  final wood = Pk.mix(const Color(0xFF9A8D7C), const Color(0xFFD29A5A), ov);
  Pk.box(c, const Rect.fromLTWH(100, 30, 200, 112), wood, radius: 2);
  Pk.poly(c, const [Offset(84, 36), Offset(200, 4), Offset(316, 36)], Pk.fill(Pk.mix(const Color(0xFFA89C7E), _straw, ov)));
}

void _skylineWindow(Canvas c, double ov, double t) {
  const win = Rect.fromLTWH(30, 18, 340, 118);
  Pk.gradientRect(c, win, Pk.mix(const Color(0xFF4A4658), const Color(0xFF241C4D), ov), Pk.mix(const Color(0xFF5E5868), const Color(0xFF8A4FB0), ov));
  for (var i = 0; i < 11; i++) {
    final bw = 20 + Pk.rand(i) * 14;
    final bh = 30 + Pk.rand(i + 9) * 60;
    final x = 30 + i * 31.0;
    c.drawRect(Rect.fromLTWH(x, win.bottom - bh, bw, bh), Pk.fill(Pk.mix(const Color(0xFF3A3744), const Color(0xFF1B163A), ov)));
    for (var k = 0; k < 4; k++) {
      if (Pk.rand(i * 5 + k) > 0.45) {
        c.drawRect(Rect.fromLTWH(x + 4 + (k % 2) * 8, win.bottom - bh + 6 + (k ~/ 2) * 12, 4, 6), Pk.fill(_gold.withValues(alpha: 0.7 * ov)));
      }
    }
  }
  for (var i = 1; i < 4; i++) {
    c.drawLine(Offset(win.left + win.width * i / 4, win.top), Offset(win.left + win.width * i / 4, win.bottom), Pk.stroke(Colors.white.withValues(alpha: 0.3), 2));
  }
  c.drawRect(win, Pk.stroke(Colors.white.withValues(alpha: 0.6), 3));
}

final Map<String, SceneArt Function()> chapterScenes = {
  // ------------------------------------------------------------- FARM
  'farmyard': () => PropScene(
    backdrop: const Backdrop.outdoor(groundN: _grassN, groundR: _grassR, horizon: 132),
    scenery: _barnFacade,
    objectives: [
      ObjectiveProps('tree', [Prop(PK.tree, _r(10, 50, 70, 95), _green, _red), Prop(PK.tree, _r(345, 60, 55, 80), _leaf, _gold)]),
      ObjectiveProps('fence', [Prop(PK.fence, _r(80, 112, 90, 30), _white), Prop(PK.fence, _r(170, 112, 75, 30), _white)]),
      ObjectiveProps('crops', [Prop(PK.crops, _r(120, 150, 110, 42), _green, _gold), Prop(PK.crops, _r(235, 150, 80, 40), _green, _gold)]),
      ObjectiveProps('pond', [Prop(PK.pond, _r(20, 172, 90, 40), _blue, _green)]),
      ObjectiveProps('cart', [Prop(PK.cart, _r(245, 192, 62, 38), _wood, const Color(0xFFFF9A3C)), Prop(PK.tractor, _r(318, 172, 76, 58), _red, _gold)]),
      ObjectiveProps('crates', [Prop(PK.crates, _r(120, 196, 42, 38), _wood, _cream), Prop(PK.haybale, _r(170, 206, 48, 28), _straw, _red)]),
    ],
  ),
  'barn': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFF8C7A68), topR: Color(0xFFC8743F),
      groundN: Color(0xFF8D7F6E), groundR: Color(0xFFD9A35E), floorAltN: Color(0xFF7E7060), floorAltR: Color(0xFFC98A52),
      floor: FloorStyle.planks,
    ),
    objectives: [
      ObjectiveProps('barn_doors', [Prop(PK.door, _r(165, 62, 70, 110), _red, _gold), Prop(PK.window, _r(40, 36, 50, 40), _white)]),
      ObjectiveProps('lights', [Prop(PK.lantern, _r(115, 8, 20, 42), _darkWood, _gold), Prop(PK.lantern, _r(275, 8, 20, 42), _darkWood, _gold)]),
      ObjectiveProps('hay', [Prop(PK.haybale, _r(15, 140, 62, 34), _straw, _red), Prop(PK.stall, _r(300, 108, 85, 64), _wood, _straw)]),
      ObjectiveProps('animals', [Prop(PK.cow, _r(245, 150, 72, 50), _white, const Color(0xFF3B3452)), Prop(PK.chicken, _r(95, 200, 26, 22), _white, const Color(0xFFFF9A3C)), Prop(PK.chicken, _r(128, 206, 22, 18), const Color(0xFFC98A52), const Color(0xFFFF9A3C))]),
      ObjectiveProps('tools', [Prop(PK.pegboard, _r(95, 50, 55, 48), _cream, _red), Prop(PK.cart, _r(18, 190, 62, 38), _wood, _green)]),
      ObjectiveProps('trough', [Prop(PK.trough, _r(165, 196, 72, 30), _wood, _blue)]),
      ObjectiveProps('crates', [Prop(PK.crates, _r(335, 188, 55, 44), _wood, _cream), Prop(PK.barrel, _r(305, 196, 26, 36), _darkWood, const Color(0xFF6E7285))]),
    ],
  ),
  'chicken_coop': () => PropScene(
    backdrop: const Backdrop.outdoor(groundN: _grassN, groundR: _grassR, horizon: 130),
    scenery: _coopShed,
    objectives: [
      ObjectiveProps('coop', [Prop(PK.nestbox, _r(30, 82, 95, 48), _wood, _cream), Prop(PK.fence, _r(250, 118, 145, 28), _white)]),
      ObjectiveProps('eggs', [Prop(PK.nestbox, _r(135, 86, 75, 44), _darkWood, _cream)]),
      ObjectiveProps('hens', [Prop(PK.chicken, _r(85, 180, 32, 28), _white, const Color(0xFFFF9A3C)), Prop(PK.chicken, _r(150, 196, 28, 24), const Color(0xFFC98A52), const Color(0xFFFF9A3C)), Prop(PK.chicken, _r(225, 184, 32, 28), _white, const Color(0xFFFF9A3C))]),
      ObjectiveProps('feed', [Prop(PK.crops, _r(250, 148, 100, 34), _green, _gold), Prop(PK.haybale, _r(330, 196, 52, 30), _straw, _red)]),
      ObjectiveProps('trough', [Prop(PK.trough, _r(30, 202, 62, 26), _wood, _blue)]),
      ObjectiveProps('flowers', [Prop(PK.flowerbed, _r(165, 214, 75, 22), _pink, _gold), Prop(PK.bush, _r(350, 132, 46, 30), _leaf, _pink)]),
      ObjectiveProps('crates', [Prop(PK.crates, _r(275, 188, 44, 40), _wood, _cream)]),
    ],
  ),
  'workshop': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFF8E8A84), topR: Color(0xFF9FB3C8),
      groundN: Color(0xFF7D7064), groundR: Color(0xFFB9824A), floorAltN: Color(0xFF6E6254), floorAltR: Color(0xFFA06A3A),
      floor: FloorStyle.planks,
    ),
    objectives: [
      ObjectiveProps('tool_wall', [Prop(PK.pegboard, _r(35, 38, 125, 62), const Color(0xFFE3C28E), _red)]),
      ObjectiveProps('workbench', [Prop(PK.workbench, _r(35, 125, 125, 50), _wood, _red)]),
      ObjectiveProps('machines', [Prop(PK.machine, _r(195, 110, 72, 62), const Color(0xFF6E7285), const Color(0xFFFF9A3C))]),
      ObjectiveProps('repairs', [Prop(PK.toolbox, _r(170, 200, 38, 28), _red, _steel), Prop(PK.cart, _r(270, 188, 72, 42), _wood, _blue)]),
      ObjectiveProps('shelves', [Prop(PK.shelf, _r(290, 40, 95, 34), _darkWood, _green), Prop(PK.shelf, _r(290, 84, 95, 30), _darkWood, _blue)]),
      ObjectiveProps('lights', [Prop(PK.pendant, _r(85, 0, 30, 42), const Color(0xFF3B3452)), Prop(PK.pendant, _r(235, 0, 30, 42), const Color(0xFF3B3452))]),
      ObjectiveProps('crates', [Prop(PK.crates, _r(335, 132, 55, 42), _wood, _cream), Prop(PK.barrel, _r(15, 192, 26, 36), _darkWood, _steel)]),
    ],
  ),
  'farmhouse': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFFA59C8F), topR: Color(0xFFF6D8B0),
      groundN: Color(0xFF8D877D), groundR: Color(0xFFC98A52), floorAltN: Color(0xFF7E7060), floorAltR: Color(0xFFB9763F),
      floor: FloorStyle.planks,
    ),
    objectives: [
      ObjectiveProps('windows', [Prop(PK.window, _r(40, 38, 60, 50), _white), Prop(PK.window, _r(300, 38, 60, 50), _white), Prop(PK.curtains, _r(292, 32, 76, 62), _red, _darkWood)]),
      ObjectiveProps('fireplace', [Prop(PK.fireplace, _r(150, 88, 92, 84), const Color(0xFFB8AEA0), _gold)]),
      ObjectiveProps('baking', [Prop(PK.counter, _r(15, 120, 100, 52), _cream, _wood), Prop(PK.table, _r(140, 186, 80, 36), _wood, const Color(0xFFFF9A3C))]),
      ObjectiveProps('bedroom', [Prop(PK.bed, _r(270, 132, 115, 50), _darkWood, _red)]),
      ObjectiveProps('porch', [Prop(PK.rug, _r(120, 205, 150, 28), _red, _gold), Prop(PK.sofa, _r(15, 180, 95, 45), const Color(0xFF6CB08A), _cream)]),
      ObjectiveProps('plants', [Prop(PK.plant, _r(248, 136, 24, 36), _terracotta), Prop(PK.plant, _r(372, 188, 24, 36), _terracotta)]),
      ObjectiveProps('crates', [Prop(PK.crates, _r(228, 192, 44, 40), _wood, _cream)]),
    ],
  ),
  // ------------------------------------------------------------- RESTAURANT
  'entrance': () => PropScene(
    backdrop: const Backdrop.outdoor(groundN: _stoneN, groundR: _stoneR, horizon: 172, floor: FloorStyle.stone),
    scenery: _restaurantFacade,
    objectives: [
      ObjectiveProps('sign', [Prop(PK.sign, _r(140, 36, 120, 24), _darkWood, _gold)]),
      ObjectiveProps('awning', [Prop(PK.awning, _r(60, 68, 280, 28), _red, _white)]),
      ObjectiveProps('doors', [Prop(PK.door, _r(172, 100, 56, 72), _darkWood, _gold)]),
      ObjectiveProps('menu_board', [Prop(PK.menuBoard, _r(238, 118, 40, 50), _wood, _gold)]),
      ObjectiveProps('planters', [Prop(PK.planter, _r(110, 138, 50, 34), _wood, _leaf), Prop(PK.planter, _r(300, 164, 50, 34), _wood, _leaf)]),
      ObjectiveProps('lights', [Prop(PK.lamppost, _r(12, 92, 20, 110), const Color(0xFF3B3452), const Color(0xFFFFE9A0)), Prop(PK.lamppost, _r(368, 92, 20, 110), const Color(0xFF3B3452), const Color(0xFFFFE9A0)), Prop(PK.stringLights, _r(60, 100, 280, 18), _gold, _pink)]),
      ObjectiveProps('ice', [Prop(PK.bench, _r(40, 196, 62, 30), _wood), Prop(PK.flowerbed, _r(150, 208, 100, 26), _pink, _gold)]),
    ],
  ),
  'rest_kitchen': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFFA8A69A), topR: Color(0xFFEAF6F2),
      groundN: Color(0xFF8D8A80), groundR: Color(0xFFFFFFFF), floorAltN: Color(0xFF6E6B62), floorAltR: Color(0xFF3B3452),
    ),
    objectives: [
      ObjectiveProps('ice', [Prop(PK.window, _r(160, 22, 70, 40), _white), Prop(PK.pendant, _r(185, 0, 24, 40), _steel)]),
      ObjectiveProps('cutlery', [Prop(PK.pegboard, _r(18, 48, 92, 50), _steel, const Color(0xFF6E7285)), Prop(PK.table, _r(150, 190, 100, 34), _steel, _white)]),
      ObjectiveProps('pots', [Prop(PK.shelf, _r(128, 70, 130, 22), _darkWood, const Color(0xFF8A839B)), Prop(PK.counter, _r(18, 122, 100, 50), _steel, _darkWood)]),
      ObjectiveProps('stoves', [Prop(PK.stove, _r(128, 120, 62, 52), _steel, _red), Prop(PK.stove, _r(194, 120, 62, 52), _steel, _red)]),
      ObjectiveProps('herbs', [Prop(PK.shelf, _r(268, 60, 62, 22), _darkWood, _green), Prop(PK.plant, _r(262, 140, 20, 30), _terracotta)]),
      ObjectiveProps('fridge', [Prop(PK.fridge, _r(338, 68, 54, 104), _steel, const Color(0xFF6E7285))]),
      ObjectiveProps('dishes', [Prop(PK.cabinet, _r(282, 122, 54, 50), _white, _steel), Prop(PK.trolley, _r(36, 190, 62, 42), _steel, _steel)]),
    ],
  ),
  'dining_hall': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFF9E8F86), topR: Color(0xFFB84A4A),
      groundN: Color(0xFF7E716A), groundR: Color(0xFF7A2E3A), floorAltN: Color(0xFF6E625C), floorAltR: Color(0xFF5E1F2B),
      floor: FloorStyle.carpet,
    ),
    objectives: [
      ObjectiveProps('chandeliers', [Prop(PK.chandelier, _r(60, 4, 64, 42), _white, _gold), Prop(PK.chandelier, _r(276, 4, 64, 42), _white, _gold)]),
      ObjectiveProps('glassware', [Prop(PK.bottleShelf, _r(36, 52, 92, 42), _darkWood, _pink), Prop(PK.champagneTower, _r(186, 192, 30, 40), const Color(0xFFFFE9B0), _white)]),
      ObjectiveProps('ice', [Prop(PK.painting, _r(284, 50, 64, 42), _gold, _blue), Prop(PK.rug, _r(110, 208, 180, 26), _gold, _red)]),
      ObjectiveProps('wine_rack', [Prop(PK.wineRack, _r(170, 92, 60, 80), _darkWood, _red)]),
      ObjectiveProps('tables', [Prop(PK.roundTable, _r(55, 160, 82, 40), _white, _red), Prop(PK.roundTable, _r(262, 160, 82, 40), _white, _red)]),
      ObjectiveProps('chairs', [Prop(PK.chair, _r(24, 162, 26, 40), _red, _gold), Prop(PK.chair, _r(142, 162, 26, 40), _red, _gold), Prop(PK.chair, _r(232, 162, 26, 40), _red, _gold), Prop(PK.chair, _r(350, 162, 26, 40), _red, _gold)]),
      ObjectiveProps('plants', [Prop(PK.plant, _r(4, 145, 24, 40), _gold), Prop(PK.plant, _r(374, 145, 24, 40), _gold)]),
    ],
  ),
  'terrace': () => PropScene(
    backdrop: const Backdrop.outdoor(groundN: Color(0xFF9E9384), groundR: Color(0xFFD29A5A), horizon: 128, sea: true),
    objectives: [
      ObjectiveProps('lights', [Prop(PK.stringLights, _r(0, 18, 400, 40), _gold, _pink)]),
      ObjectiveProps('decking', [Prop(PK.railing, _r(0, 118, 400, 30), _darkWood, _aqua), Prop(PK.bench, _r(20, 192, 62, 30), _wood)]),
      ObjectiveProps('parasols', [Prop(PK.umbrella, _r(55, 108, 80, 70), _red, _white), Prop(PK.umbrella, _r(265, 108, 80, 70), _red, _white)]),
      ObjectiveProps('bar', [Prop(PK.tikiBar, _r(150, 118, 100, 60), _wood, _straw)]),
      ObjectiveProps('ice', [Prop(PK.roundTable, _r(85, 176, 62, 36), _white, _pink), Prop(PK.roundTable, _r(255, 176, 62, 36), _white, _pink)]),
      ObjectiveProps('planters', [Prop(PK.planter, _r(4, 150, 40, 38), _terracotta, _leaf), Prop(PK.planter, _r(356, 150, 40, 38), _terracotta, _leaf)]),
      ObjectiveProps('flowers', [Prop(PK.flowerbed, _r(120, 214, 80, 22), _pink, _gold), Prop(PK.flowerbed, _r(300, 214, 80, 22), _gold, _white)]),
    ],
  ),
  'vip_room': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFF6E6474), topR: Color(0xFF3A1F5E),
      groundN: Color(0xFF5E5868), groundR: Color(0xFF2A1640), floorAltN: Color(0xFF4E4858), floorAltR: Color(0xFF1E0E30),
      floor: FloorStyle.carpet, night: true,
    ),
    objectives: [
      ObjectiveProps('curtains', [Prop(PK.curtains, _r(10, 18, 380, 150), _purple, _gold)]),
      ObjectiveProps('decor', [Prop(PK.chandelier, _r(170, 0, 60, 42), _white, _gold), Prop(PK.discoBall, _r(92, 26, 20, 20), _pink)]),
      ObjectiveProps('champagne', [Prop(PK.bottleShelf, _r(290, 50, 82, 40), _gold, _pink), Prop(PK.champagneTower, _r(182, 192, 32, 40), const Color(0xFFFFE9B0), _gold)]),
      ObjectiveProps('stage', [Prop(PK.stage, _r(150, 110, 100, 62), _darkWood, _pink)]),
      ObjectiveProps('piano', [Prop(PK.piano, _r(35, 140, 92, 50), const Color(0xFF14111F), _gold)]),
      ObjectiveProps('sofas', [Prop(PK.sofa, _r(250, 150, 115, 46), _purple, _gold)]),
      ObjectiveProps('ice', [Prop(PK.rug, _r(90, 204, 220, 28), _gold, _purple), Prop(PK.vase, _r(18, 188, 22, 42), _gold, _pink)]),
    ],
  ),
  // ------------------------------------------------------------- BEACH RESORT
  'beach': () => PropScene(
    backdrop: const Backdrop.outdoor(groundN: _sandN, groundR: _sandR, horizon: 124, sea: true),
    objectives: [
      ObjectiveProps('palms', [Prop(PK.palm, _r(0, 40, 70, 140), _green), Prop(PK.palm, _r(335, 50, 60, 120), _leaf)]),
      ObjectiveProps('kayaks', [Prop(PK.kayak, _r(290, 100, 70, 14), const Color(0xFFFF9A3C), _navy), Prop(PK.kayak, _r(80, 96, 60, 12), _red, _navy)]),
      ObjectiveProps('shoreline', [Prop(PK.shoreline, _r(0, 124, 400, 18), _white)]),
      ObjectiveProps('umbrellas', [Prop(PK.umbrella, _r(85, 130, 70, 70), _red, _white), Prop(PK.umbrella, _r(235, 134, 70, 70), _blue, _white)]),
      ObjectiveProps('surfboards', [Prop(PK.surfboard, _r(180, 140, 18, 60), _pink, _white), Prop(PK.surfboard, _r(202, 146, 16, 54), _aqua, _gold)]),
      ObjectiveProps('sunbeds', [Prop(PK.lounger, _r(95, 186, 72, 30), _white, _blue), Prop(PK.lounger, _r(245, 190, 72, 30), _white, _red)]),
      ObjectiveProps('chains', [Prop(PK.sandcastle, _r(168, 206, 42, 30), _straw, _red), Prop(PK.beachball, _r(330, 206, 22, 22), _red, _gold)]),
    ],
  ),
  'pool': () => PropScene(
    backdrop: const Backdrop.outdoor(groundN: _stoneN, groundR: _stoneR, horizon: 118, floor: FloorStyle.stone),
    objectives: [
      ObjectiveProps('pool', [Prop(PK.poolWater, _r(90, 148, 220, 56), _aqua, _steel)]),
      ObjectiveProps('sunshades', [Prop(PK.umbrella, _r(15, 118, 72, 66), _gold, _white), Prop(PK.umbrella, _r(160, 92, 60, 52), _blue, _white)]),
      ObjectiveProps('juice_bar', [Prop(PK.tikiBar, _r(298, 88, 92, 58), _wood, _straw)]),
      ObjectiveProps('plants', [Prop(PK.palm, _r(0, 30, 60, 110), _green), Prop(PK.planter, _r(250, 106, 40, 40), _terracotta, _leaf)]),
      ObjectiveProps('loungers', [Prop(PK.lounger, _r(15, 192, 72, 30), _white, _aqua), Prop(PK.lounger, _r(312, 192, 72, 30), _white, _pink)]),
      ObjectiveProps('towels', [Prop(PK.towels, _r(100, 208, 30, 22), _pink, _white), Prop(PK.towels, _r(270, 208, 30, 22), _aqua, _white)]),
      ObjectiveProps('chains', [Prop(PK.lamppost, _r(232, 70, 16, 80), const Color(0xFF3B3452), const Color(0xFFFFE9A0)), Prop(PK.beachball, _r(200, 162, 18, 18), _red, _gold)]),
    ],
  ),
  'beach_bar': () => PropScene(
    backdrop: const Backdrop.outdoor(groundN: _sandN, groundR: _sandR, horizon: 124, sea: true),
    scenery: _barHut,
    objectives: [
      ObjectiveProps('chains', [Prop(PK.stringLights, _r(90, 14, 220, 30), _gold, _pink), Prop(PK.neonSign, _r(170, 88, 60, 20), _pink, _aqua)]),
      ObjectiveProps('cocktails', [Prop(PK.bottleShelf, _r(130, 42, 140, 40), _darkWood, _pink)]),
      ObjectiveProps('palms', [Prop(PK.palm, _r(0, 40, 70, 140), _green), Prop(PK.palm, _r(335, 40, 60, 140), _leaf)]),
      ObjectiveProps('taps', [Prop(PK.barCounter, _r(110, 122, 180, 58), _wood, _aqua)]),
      ObjectiveProps('speakers', [Prop(PK.speaker, _r(78, 140, 26, 38), const Color(0xFF3B3452), _pink), Prop(PK.speaker, _r(308, 140, 30, 44), const Color(0xFF3B3452), _pink)]),
      ObjectiveProps('stools', [Prop(PK.chair, _r(130, 188, 24, 40), _aqua, _white), Prop(PK.chair, _r(188, 192, 24, 40), _aqua, _white), Prop(PK.chair, _r(246, 188, 24, 40), _aqua, _white)]),
      ObjectiveProps('ice_cream', [Prop(PK.trolley, _r(28, 186, 62, 42), _pink, _white)]),
    ],
  ),
  'hotel_room': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFFA59C8F), topR: Color(0xFFD8F1F0),
      groundN: Color(0xFF8D877D), groundR: Color(0xFF6FB8C8), floorAltN: Color(0xFF7E7868), floorAltR: Color(0xFF4F98AA),
      floor: FloorStyle.carpet,
    ),
    objectives: [
      ObjectiveProps('chains', [Prop(PK.window, _r(170, 28, 80, 50), _white), Prop(PK.curtains, _r(160, 22, 100, 64), _aqua, _gold)]),
      ObjectiveProps('lamps', [Prop(PK.pendant, _r(95, 0, 26, 44), _gold), Prop(PK.floorLamp, _r(300, 88, 24, 84), _cream)]),
      ObjectiveProps('bathroom', [Prop(PK.shower, _r(15, 40, 62, 132), _steel, _aqua)]),
      ObjectiveProps('bed', [Prop(PK.bed, _r(120, 118, 170, 62), _darkWood, _aqua)]),
      ObjectiveProps('room_service', [Prop(PK.trolley, _r(318, 162, 62, 44), _gold, _steel)]),
      ObjectiveProps('luggage', [Prop(PK.luggage, _r(88, 176, 52, 42), _red, _navy)]),
      ObjectiveProps('plants', [Prop(PK.plant, _r(372, 150, 24, 40), _terracotta), Prop(PK.plant, _r(292, 196, 22, 34), _white)]),
    ],
  ),
  'rooftop': () => PropScene(
    backdrop: const Backdrop.outdoor(groundN: _stoneN, groundR: Color(0xFFBFA8D8), horizon: 130, skyline: true, night: true,
        topN: Color(0xFF5E5A6E), topR: Color(0xFF1B1446), bottomN: Color(0xFF8A8494), bottomR: Color(0xFF8A4FB0), floor: FloorStyle.stone),
    objectives: [
      ObjectiveProps('chains', [Prop(PK.railing, _r(0, 126, 400, 22), _steel, _aqua)]),
      ObjectiveProps('party_lights', [Prop(PK.stringLights, _r(0, 18, 400, 50), _gold, _pink), Prop(PK.discoBall, _r(190, 40, 20, 20), _pink)]),
      ObjectiveProps('cocktails', [Prop(PK.barCounter, _r(150, 104, 100, 44), _white, _pink)]),
      ObjectiveProps('lamps', [Prop(PK.lamppost, _r(122, 80, 16, 90), const Color(0xFF3B3452), const Color(0xFFFFE9A0)), Prop(PK.lamppost, _r(262, 80, 16, 90), const Color(0xFF3B3452), const Color(0xFFFFE9A0))]),
      ObjectiveProps('planters', [Prop(PK.planter, _r(0, 118, 40, 40), _terracotta, _leaf), Prop(PK.planter, _r(360, 118, 40, 40), _terracotta, _leaf)]),
      ObjectiveProps('hot_tub', [Prop(PK.hotTub, _r(140, 150, 120, 46), _aqua, _purple)]),
      ObjectiveProps('sofas', [Prop(PK.sofa, _r(15, 162, 105, 46), _white, _pink), Prop(PK.sofa, _r(280, 162, 105, 46), _white, _pink)]),
    ],
  ),
  // ------------------------------------------------------------- MANSION
  'front_yard': () => PropScene(
    backdrop: const Backdrop.outdoor(groundN: _grassN, groundR: _grassR, horizon: 134),
    scenery: _mansionFacade,
    objectives: [
      ObjectiveProps('hedges', [Prop(PK.hedge, _r(0, 134, 140, 26), _green, _pink), Prop(PK.hedge, _r(260, 134, 140, 26), _green, _pink)]),
      ObjectiveProps('gates', [Prop(PK.gate, _r(150, 94, 100, 62), const Color(0xFF2E2A3A), _gold)]),
      ObjectiveProps('statues', [Prop(PK.statue, _r(62, 116, 32, 52), const Color(0xFFE6E0D4)), Prop(PK.statue, _r(306, 116, 32, 52), const Color(0xFFE6E0D4))]),
      ObjectiveProps('lamps', [Prop(PK.lamppost, _r(118, 100, 16, 100), const Color(0xFF3B3452), const Color(0xFFFFE9A0)), Prop(PK.lamppost, _r(266, 100, 16, 100), const Color(0xFF3B3452), const Color(0xFFFFE9A0))]),
      ObjectiveProps('fountain', [Prop(PK.fountain, _r(158, 160, 84, 56), _aqua)]),
      ObjectiveProps('crates', [Prop(PK.path, _r(150, 206, 100, 34), const Color(0xFFD9D2C3)), Prop(PK.bench, _r(330, 176, 56, 28), _white)]),
      ObjectiveProps('flowers', [Prop(PK.flowerbed, _r(15, 210, 105, 24), _pink, _gold), Prop(PK.flowerbed, _r(280, 210, 105, 24), _purple, _white)]),
    ],
  ),
  'grand_hall': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFFA8A296), topR: Color(0xFFF4E9D6),
      groundN: Color(0xFF8D877D), groundR: Color(0xFFFFFFFF), floorAltN: Color(0xFF6E6B62), floorAltR: Color(0xFF2B2440),
    ),
    objectives: [
      ObjectiveProps('windows', [Prop(PK.window, _r(28, 38, 56, 72), _gold), Prop(PK.window, _r(316, 38, 56, 72), _gold)]),
      ObjectiveProps('ice', [Prop(PK.painting, _r(100, 42, 40, 32), _gold, _blue), Prop(PK.painting, _r(260, 42, 40, 32), _gold, _green)]),
      ObjectiveProps('chandeliers', [Prop(PK.chandelier, _r(168, 0, 64, 46), _white, _gold)]),
      ObjectiveProps('staircase', [Prop(PK.stairs, _r(140, 78, 120, 94), _white, _red)]),
      ObjectiveProps('trophies', [Prop(PK.trophyCase, _r(36, 118, 62, 54), _darkWood, _gold), Prop(PK.clock, _r(302, 98, 26, 74), _darkWood, _gold)]),
      ObjectiveProps('decor', [Prop(PK.vase, _r(108, 136, 24, 36), _blue, _pink), Prop(PK.vase, _r(268, 136, 24, 36), _blue, _pink)]),
      ObjectiveProps('floor', [Prop(PK.rug, _r(95, 196, 210, 36), _red, _gold)]),
    ],
  ),
  'luxury_bedroom': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFFA59C8F), topR: Color(0xFFF3DCC8),
      groundN: Color(0xFF8D877D), groundR: Color(0xFFD9B98C), floorAltN: Color(0xFF7E7868), floorAltR: Color(0xFFC49A62),
      floor: FloorStyle.carpet,
    ),
    objectives: [
      ObjectiveProps('curtains', [Prop(PK.curtains, _r(150, 18, 120, 86), const Color(0xFF8C2F4A), _gold), Prop(PK.mirror, _r(92, 48, 30, 40), _gold, const Color(0xFFDFF8FF))]),
      ObjectiveProps('lamps', [Prop(PK.chandelier, _r(182, 0, 52, 40), _white, _gold), Prop(PK.floorLamp, _r(302, 92, 22, 80), _gold)]),
      ObjectiveProps('wardrobe', [Prop(PK.wardrobe, _r(18, 78, 62, 94), _white, _gold)]),
      ObjectiveProps('bed', [Prop(PK.bed, _r(128, 112, 164, 62), _gold, const Color(0xFF8C2F4A))]),
      ObjectiveProps('plants', [Prop(PK.plant, _r(92, 138, 22, 34), _gold), Prop(PK.plant, _r(372, 144, 24, 40), _gold)]),
      ObjectiveProps('bath', [Prop(PK.bathtub, _r(300, 180, 92, 40), _white, _gold)]),
      ObjectiveProps('chains', [Prop(PK.rug, _r(115, 198, 175, 32), _cream, _gold), Prop(PK.vase, _r(22, 190, 22, 38), _gold, _pink)]),
    ],
  ),
  'cinema_room': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFF55505E), topR: Color(0xFF1A1433),
      groundN: Color(0xFF4A4750), groundR: Color(0xFF3A1428), floorAltN: Color(0xFF3E3B44), floorAltR: Color(0xFF2A0C1C),
      floor: FloorStyle.carpet, night: true,
    ),
    objectives: [
      ObjectiveProps('screen', [Prop(PK.screen, _r(90, 18, 220, 94), _purple, _pink)]),
      ObjectiveProps('reels', [Prop(PK.shelf, _r(14, 60, 62, 24), const Color(0xFF3A3450), _gold), Prop(PK.neonSign, _r(324, 40, 62, 20), _pink, _aqua)]),
      ObjectiveProps('speakers', [Prop(PK.speaker, _r(40, 96, 30, 62), const Color(0xFF26213A), _pink), Prop(PK.speaker, _r(330, 96, 30, 62), const Color(0xFF26213A), _pink)]),
      ObjectiveProps('consoles', [Prop(PK.console, _r(170, 120, 60, 40), const Color(0xFF3A3450), _aqua)]),
      ObjectiveProps('projector', [Prop(PK.projector, _r(356, 120, 32, 20), const Color(0xFF6E6A78), const Color(0xFFFFF4C2))]),
      ObjectiveProps('seats', [Prop(PK.cinemaSeats, _r(36, 160, 160, 42), _red, _gold), Prop(PK.cinemaSeats, _r(206, 160, 160, 42), _red, _gold)]),
      ObjectiveProps('ice', [Prop(PK.rug, _r(90, 204, 220, 28), _gold, _red), Prop(PK.planter, _r(4, 192, 34, 40), _gold, _leaf)]),
    ],
  ),
  'penthouse': () => PropScene(
    backdrop: const Backdrop.indoor(
      topN: Color(0xFF8E8A84), topR: Color(0xFF3B2F5A),
      groundN: Color(0xFF7E7868), groundR: Color(0xFFEDE6F6), floorAltN: Color(0xFF6E6B62), floorAltR: Color(0xFF3B2F5A),
    ),
    scenery: _skylineWindow,
    objectives: [
      ObjectiveProps('curtains', [Prop(PK.curtains, _r(20, 12, 360, 124), _purple, _gold)]),
      ObjectiveProps('party_lights', [Prop(PK.stringLights, _r(40, 10, 320, 30), _gold, _pink), Prop(PK.discoBall, _r(190, 22, 20, 20), _pink)]),
      ObjectiveProps('champagne', [Prop(PK.barCounter, _r(292, 110, 100, 54), _white, _gold), Prop(PK.champagneTower, _r(250, 124, 30, 40), const Color(0xFFFFE9B0), _gold)]),
      ObjectiveProps('piano', [Prop(PK.piano, _r(140, 128, 92, 50), _white, _gold)]),
      ObjectiveProps('sofas', [Prop(PK.sofa, _r(15, 148, 112, 46), _purple, _gold)]),
      ObjectiveProps('pool', [Prop(PK.poolWater, _r(232, 176, 160, 46), _aqua, _steel)]),
      ObjectiveProps('chains', [Prop(PK.rug, _r(30, 200, 180, 30), _gold, _purple), Prop(PK.vase, _r(206, 188, 22, 38), _gold, _pink)]),
    ],
  ),
};
