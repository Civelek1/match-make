import 'dart:math';

import 'package:flutter/material.dart';

import '../art/paint_kit.dart';
import 'house_map_art.dart';

enum SpotKind { window, yard }

/// A location on a chapter map: where its level node sits and the area that
/// visibly changes from neglected to restored when the level is completed.
class MapSpot {
  final String levelId;
  final Offset node;
  final Rect area;
  final SpotKind kind;
  final Color accent;
  const MapSpot(this.levelId, this.node, this.area, this.kind, this.accent);
}

enum MapStyle { farm, restaurant, beach, mansion, castle, lodge, harbor, museum, theater }

/// Data-driven chapter map (360×640 design space). Each chapter supplies a
/// style (landmark building) and five spots.
class LocationMapArt extends ChapterMapArt {
  final MapStyle style;
  final List<MapSpot> spots;
  final Color groundN, groundR;
  final double groundY;

  LocationMapArt({required this.style, required this.spots, required this.groundN, required this.groundR, this.groundY = 450});

  @override
  late final Map<String, Offset> nodes = {for (final s in spots) s.levelId: s.node};

  @override
  void paint(Canvas c, Size canvasSize, Set<String> done, double t, {bool celebrate = false}) {
    final ov = done.length / spots.length;
    final skyTop = Pk.mix(const Color(0xFF9DB8C9), style == MapStyle.beach ? const Color(0xFF3FB8FF) : const Color(0xFF5EC2FF), ov);
    final skyBottom = Pk.mix(const Color(0xFFE6DCC8), const Color(0xFFFFE9C2), ov);
    final layout = MapLayout(canvasSize);
    final gy = layout.toLocal(Offset(0, groundY)).dy;
    Pk.gradientRect(c, Rect.fromLTWH(0, 0, canvasSize.width, gy), skyTop, skyBottom);
    final ground = Pk.mix(groundN, groundR, ov);
    c.drawRect(Rect.fromLTWH(0, gy, canvasSize.width, canvasSize.height - gy), Pk.fill(style == MapStyle.beach ? Pk.mix(const Color(0xFF7FA3AE), const Color(0xFF2EB6E0), ov) : ground));

    c.save();
    c.translate(layout.origin.dx, layout.origin.dy);
    c.scale(layout.scale);

    Pk.glow(c, const Offset(300, 70), 70, const Color(0xFFFFF1A8), 0.35 + 0.4 * ov);
    c.drawCircle(const Offset(300, 70), 24, Pk.fill(Pk.mix(const Color(0xFFF3E4B0), const Color(0xFFFFE066), ov)));
    for (var i = 0; i < 4; i++) {
      final x = (i * 120 + t * (4 + i * 1.5)) % 480 - 80;
      Pk.cloud(c, Offset(x, 40.0 + i * 30), 0.9 + (i % 2) * 0.3, Colors.white.withValues(alpha: 0.85));
    }
    switch (style) {
      case MapStyle.farm:
        _farm(c, ov, t);
      case MapStyle.restaurant:
        _restaurant(c, ov);
      case MapStyle.beach:
        _beach(c, ov, t);
      case MapStyle.mansion:
        _mansion(c, ov);
      case MapStyle.castle:
        _castle(c, ov);
      case MapStyle.lodge:
        _lodge(c, ov, t);
      case MapStyle.harbor:
        _harbor(c, ov, t);
      case MapStyle.museum:
        _museum(c, ov);
      case MapStyle.theater:
        _theater(c, ov, t);
    }
    for (final s in spots) {
      _spot(c, s, done.contains(s.levelId), t);
    }
    if (celebrate || ov >= 1) {
      for (var i = 0; i < 10; i++) {
        final p = Offset(40 + Pk.rand(i) * 280, 120 + Pk.rand(i + 5) * 380);
        final tw = (sin(t * 3 + i * 1.3) + 1) / 2;
        Pk.sparkle(c, p, 4 + 5 * tw, Colors.white.withValues(alpha: 0.4 + 0.5 * tw));
      }
    }
    c.restore();
  }

  void _ground(Canvas c, double ov, {double top = 450}) {
    Pk.gradientRect(c, Rect.fromLTWH(-200, top, 760, 260), Pk.mix(groundN, groundR, ov), Pk.dark(Pk.mix(groundN, groundR, ov), 0.15));
  }

  void _farm(Canvas c, double ov, double t) {
    final hills = Path()
      ..moveTo(-100, 440)
      ..quadraticBezierTo(60, 380, 180, 430)
      ..quadraticBezierTo(300, 380, 460, 420)
      ..lineTo(460, 470)
      ..lineTo(-100, 470)
      ..close();
    c.drawPath(hills, Pk.fill(Pk.mix(const Color(0xFFA7AE8C), const Color(0xFF8ED46A), ov)));
    _ground(c, ov);
    // Barn.
    final red = Pk.mix(const Color(0xFF9A6A5E), const Color(0xFFC8412F), ov);
    Pk.shadow(c, const Offset(105, 452), 170, 16);
    Pk.poly(c, const [Offset(30, 450), Offset(30, 300), Offset(105, 240), Offset(180, 300), Offset(180, 450)], Pk.fill(red));
    Pk.poly(c, const [Offset(22, 304), Offset(105, 232), Offset(188, 304), Offset(180, 310), Offset(105, 246), Offset(30, 310)], Pk.fill(Colors.white));
    // Silo.
    Pk.box(c, const Rect.fromLTWH(186, 290, 34, 160), Pk.mix(const Color(0xFF9A9A9A), const Color(0xFFD9D9E6), ov), radius: 3);
    c.drawOval(const Rect.fromLTWH(186, 276, 34, 28), Pk.fill(Pk.mix(const Color(0xFF7A7A7A), const Color(0xFF6E7285), ov)));
    // Farmhouse + workshop shed.
    final wall = Pk.mix(const Color(0xFFC9BFAE), const Color(0xFFFFF1DA), ov);
    Pk.box(c, const Rect.fromLTWH(206, 250, 124, 110), wall, radius: 2);
    Pk.poly(c, const [Offset(196, 254), Offset(268, 200), Offset(340, 254)], Pk.fill(Pk.mix(const Color(0xFF8C6A60), const Color(0xFF6E4B3A), ov)));
    Pk.box(c, const Rect.fromLTWH(220, 340, 110, 110), Pk.mix(const Color(0xFF9A8D7C), const Color(0xFFD29A5A), ov), radius: 2);
    Pk.poly(c, const [Offset(214, 344), Offset(275, 318), Offset(336, 344)], Pk.fill(Pk.mix(const Color(0xFF7D6B5E), const Color(0xFF8B5E3C), ov)));
  }

  void _restaurant(Canvas c, double ov) {
    _ground(c, ov);
    final wall = Pk.mix(const Color(0xFFB5A99A), const Color(0xFFFFE3C2), ov);
    Pk.shadow(c, const Offset(180, 452), 300, 18);
    Pk.box(c, const Rect.fromLTWH(40, 220, 280, 230), wall, radius: 2);
    c.drawRect(const Rect.fromLTWH(34, 210, 292, 14), Pk.fill(Pk.dark(wall, 0.3)));
    c.drawRect(const Rect.fromLTWH(40, 340, 280, 8), Pk.fill(Pk.dark(wall, 0.2)));
    // Awning.
    for (var i = 0; i < 10; i++) {
      final x = 44 + i * 27.2;
      Pk.poly(c, [Offset(x, 350), Offset(x + 27.2, 350), Offset(x + 27.2, 368), Offset(x + 13.6, 376), Offset(x, 368)],
          Pk.fill(i.isEven ? Pk.mix(const Color(0xFF9A7E78), const Color(0xFFE0533F), ov) : Colors.white));
    }
    Pk.box(c, const Rect.fromLTWH(120, 190, 120, 26), Pk.mix(const Color(0xFF8C7E6C), const Color(0xFF8B5E3C), ov), radius: 6);
  }

  void _beach(Canvas c, double ov, double t) {
    // Sand, then sea at the bottom.
    Pk.gradientRect(c, const Rect.fromLTWH(-200, 430, 760, 110), Pk.mix(groundN, groundR, ov), Pk.dark(Pk.mix(groundN, groundR, ov), 0.1));
    Pk.gradientRect(c, const Rect.fromLTWH(-200, 540, 760, 200), Pk.mix(const Color(0xFF7FA3AE), const Color(0xFF2EB6E0), ov), Pk.mix(const Color(0xFF6E8E98), const Color(0xFF1E8FC0), ov));
    for (var i = 0; i < 6; i++) {
      final y = 548 + i * 14.0;
      c.drawLine(Offset((t * 14 + i * 60) % 440 - 40, y), Offset((t * 14 + i * 60) % 440 + 20, y), Pk.stroke(Colors.white.withValues(alpha: 0.6), 2));
    }
    // Hotel tower.
    final wall = Pk.mix(const Color(0xFFC9C3B8), const Color(0xFFFFFFFF), ov);
    Pk.shadow(c, const Offset(180, 432), 170, 14);
    Pk.box(c, const Rect.fromLTWH(110, 120, 140, 312), wall, radius: 4);
    for (var y = 0; y < 7; y++) {
      for (var x = 0; x < 3; x++) {
        c.drawRect(Rect.fromLTWH(122 + x * 42.0, 190 + y * 32.0, 30, 18), Pk.fill(Pk.mix(const Color(0xFF8E9AA0), const Color(0xFF8ED8FF), ov)));
      }
    }
    for (final (x, s) in [(40.0, 1.0), (320.0, 0.9)]) {
      c.drawRect(Rect.fromLTWH(x - 4, 350 * 1.0, 8, 90 * s), Pk.fill(const Color(0xFFB9824A)));
      for (var i = 0; i < 5; i++) {
        final ang = -pi + i * pi / 4;
        c.drawLine(Offset(x, 350), Offset(x, 350) + Offset(cos(ang), sin(ang) * 0.5 + 0.3) * 40 * s, Pk.stroke(Pk.mix(const Color(0xFF8C9A7A), const Color(0xFF3FA84A), ov), 8));
      }
    }
  }

  void _mansion(Canvas c, double ov) {
    _ground(c, ov, top: 460);
    final wall = Pk.mix(const Color(0xFFBFB6A6), const Color(0xFFFFF4E0), ov);
    final roof = Pk.mix(const Color(0xFF6E6A70), const Color(0xFF3B3452), ov);
    Pk.shadow(c, const Offset(180, 462), 320, 20);
    Pk.box(c, const Rect.fromLTWH(30, 250, 300, 212), wall, radius: 2);
    Pk.poly(c, const [Offset(20, 254), Offset(60, 214), Offset(300, 214), Offset(340, 254)], Pk.fill(roof));
    // Central tower.
    Pk.box(c, const Rect.fromLTWH(125, 130, 110, 130), wall, radius: 2);
    Pk.poly(c, const [Offset(115, 134), Offset(180, 80), Offset(245, 134)], Pk.fill(roof));
    for (var i = 0; i < 6; i++) {
      c.drawRect(Rect.fromLTWH(44 + i * 52.0, 350, 10, 112), Pk.fill(Pk.light(wall, 0.3)));
    }
  }

  void _castle(Canvas c, double ov) {
    _ground(c, ov, top: 460);
    final stone = Pk.mix(const Color(0xFF9A948A), const Color(0xFFD9D2C3), ov);
    final dark = Pk.dark(stone, 0.18);
    final roof = Pk.mix(const Color(0xFF6E6A70), const Color(0xFF3E4A8A), ov);
    Pk.shadow(c, const Offset(180, 462), 320, 20);
    // Curtain wall with crenellations.
    c.drawRect(const Rect.fromLTWH(40, 330, 280, 130), Pk.fill(stone));
    for (var i = 0; i < 14; i++) {
      c.drawRect(Rect.fromLTWH(42 + i * 20.0, 318, 12, 14), Pk.fill(stone));
    }
    // Keep with a pointed roof.
    Pk.box(c, const Rect.fromLTWH(125, 200, 110, 132), dark, radius: 2);
    Pk.poly(c, const [Offset(115, 204), Offset(180, 130), Offset(245, 204)], Pk.fill(roof));
    // Corner towers.
    for (final x in [20.0, 280.0]) {
      Pk.box(c, Rect.fromLTWH(x, 240, 60, 220), dark, radius: 2);
      Pk.poly(c, [Offset(x - 8, 244), Offset(x + 30, 186), Offset(x + 68, 244)], Pk.fill(roof));
    }
    // Gate arch.
    final arch = Path()
      ..moveTo(150, 460)
      ..lineTo(150, 420)
      ..quadraticBezierTo(180, 396, 210, 420)
      ..lineTo(210, 460)
      ..close();
    c.drawPath(arch, Pk.fill(Pk.dark(stone, 0.45)));
  }

  void _lodge(Canvas c, double ov, double t) {
    // Mountains behind the chalet.
    for (final (x, h, w) in [(-40.0, 230.0, 240.0), (150.0, 270.0, 260.0)]) {
      final peak = Offset(x + w / 2, 450 - h);
      Pk.poly(c, [Offset(x, 450), peak, Offset(x + w, 450)], Pk.fill(Pk.mix(const Color(0xFFA8B0BA), const Color(0xFF8FB4D9), ov)));
      Pk.poly(c, [peak - const Offset(28, -40), peak, peak + const Offset(28, 40)], Pk.fill(Colors.white));
    }
    _ground(c, ov, top: 455);
    final wood = Pk.mix(const Color(0xFF8C7E6C), const Color(0xFFB9763F), ov);
    Pk.shadow(c, const Offset(180, 457), 300, 18);
    Pk.box(c, const Rect.fromLTWH(40, 290, 280, 167), wood, radius: 2);
    for (var i = 0; i < 9; i++) {
      c.drawLine(Offset(40, 300 + i * 17.0), Offset(320, 300 + i * 17.0), Pk.stroke(Pk.dark(wood, 0.2), 1.5));
    }
    Pk.poly(c, const [
      Offset(20, 296),
      Offset(180, 170),
      Offset(340, 296),
    ], Pk.fill(Pk.mix(const Color(0xFF6E6260), const Color(0xFF7A3E2E), ov)));
    Pk.poly(c, const [
      Offset(20, 296),
      Offset(180, 170),
      Offset(340, 296),
      Offset(320, 300),
      Offset(180, 186),
      Offset(40, 300),
    ], Pk.fill(Colors.white));
  }

  void _harbor(Canvas c, double ov, double t) {
    Pk.gradientRect(c, const Rect.fromLTWH(-200, 430, 760, 90), Pk.mix(groundN, groundR, ov), Pk.dark(Pk.mix(groundN, groundR, ov), 0.1));
    Pk.gradientRect(
      c,
      const Rect.fromLTWH(-200, 520, 760, 200),
      Pk.mix(const Color(0xFF7FA3AE), const Color(0xFF2E8FCF), ov),
      Pk.mix(const Color(0xFF6E8E98), const Color(0xFF1E6FA8), ov),
    );
    for (var i = 0; i < 6; i++) {
      final y = 528 + i * 14.0;
      c.drawLine(
        Offset((t * 14 + i * 60) % 440 - 40, y),
        Offset((t * 14 + i * 60) % 440 + 20, y),
        Pk.stroke(Colors.white.withValues(alpha: 0.6), 2),
      );
    }
    // Pier.
    c.drawRect(const Rect.fromLTWH(150, 500, 60, 90), Pk.fill(Pk.mix(const Color(0xFF8C7E6C), const Color(0xFFC98A52), ov)));
    // Two-storey market with the keeper's rooms above.
    final wall = Pk.mix(const Color(0xFFB5A99A), const Color(0xFFF2E4C8), ov);
    Pk.shadow(c, const Offset(80, 432), 120, 12);
    Pk.box(c, const Rect.fromLTWH(30, 250, 100, 182), wall, radius: 2);
    Pk.poly(c, const [
      Offset(22, 254),
      Offset(80, 214),
      Offset(138, 254),
    ], Pk.fill(Pk.mix(const Color(0xFF7D6B5E), const Color(0xFF2E6E8A), ov)));
    // Boathouse.
    final wood = Pk.mix(const Color(0xFF8C7E6C), const Color(0xFFB9763F), ov);
    Pk.box(c, const Rect.fromLTWH(148, 350, 94, 82), wood, radius: 2);
    Pk.poly(c, const [Offset(140, 354), Offset(195, 318), Offset(250, 354)], Pk.fill(Pk.dark(wood, 0.3)));
    // Lighthouse.
    final red = Pk.mix(const Color(0xFF9A7E78), const Color(0xFFE0533F), ov);
    final tower = Path()
      ..moveTo(270, 432)
      ..lineTo(278, 170)
      ..lineTo(302, 170)
      ..lineTo(310, 432)
      ..close();
    c.drawPath(tower, Pk.fill(Colors.white));
    c.save();
    c.clipPath(tower);
    for (var i = 0; i < 6; i++) {
      c.drawRect(Rect.fromLTWH(260, 190 + i * 40.0, 60, 20), Pk.fill(red));
    }
    c.restore();
    Pk.box(c, const Rect.fromLTWH(272, 146, 36, 26), const Color(0xFF3B3452), radius: 3);
    Pk.glow(c, const Offset(290, 159), 50, const Color(0xFFFFF1A8), 0.2 + 0.5 * ov);
    Pk.poly(c, const [Offset(270, 148), Offset(290, 124), Offset(310, 148)], Pk.fill(red));
  }

  void _museum(Canvas c, double ov) {
    _ground(c, ov, top: 460);
    final stone = Pk.mix(const Color(0xFFB0AA9E), const Color(0xFFF4EFE6), ov);
    Pk.shadow(c, const Offset(180, 462), 320, 20);
    Pk.box(c, const Rect.fromLTWH(30, 262, 300, 198), Pk.dark(stone, 0.06), radius: 1);
    Pk.poly(c, const [Offset(20, 266), Offset(180, 196), Offset(340, 266)], Pk.fill(stone));
    Pk.poly(c, const [Offset(56, 260), Offset(180, 210), Offset(304, 260)], Pk.fill(Pk.dark(stone, 0.12)));
    for (var i = 0; i < 6; i++) {
      final x = 44 + i * 52.0;
      c.drawRect(Rect.fromLTWH(x, 268, 16, 186), Pk.fill(Pk.light(stone, 0.25)));
      c.drawRect(Rect.fromLTWH(x - 3, 266, 22, 6), Pk.fill(stone));
    }
    for (var i = 0; i < 3; i++) {
      c.drawRect(Rect.fromLTWH(30.0 - i * 8, 454 + i * 5.0, 300.0 + i * 16, 5), Pk.fill(Pk.dark(stone, 0.04 * i)));
    }
  }

  void _theater(Canvas c, double ov, double t) {
    _ground(c, ov, top: 460);
    final wall = Pk.mix(const Color(0xFF6E6478), const Color(0xFF8A2E4A), ov);
    Pk.shadow(c, const Offset(180, 462), 300, 20);
    Pk.box(c, const Rect.fromLTWH(50, 220, 260, 240), wall, radius: 2);
    Pk.poly(c, const [Offset(40, 224), Offset(180, 170), Offset(320, 224)], Pk.fill(Pk.dark(wall, 0.25)));
    // Marquee with chasing bulbs.
    Pk.box(c, const Rect.fromLTWH(90, 352, 180, 22), Pk.mix(const Color(0xFF8A7F78), const Color(0xFFFFC93C), ov), radius: 4);
    for (var i = 0; i < 18; i++) {
      final on = (i + (t * 6).floor()) % 3 != 0;
      c.drawCircle(
        Offset(96 + i * 10.0, 350),
        2.5,
        Pk.fill((on ? const Color(0xFFFFE066) : const Color(0xFF8A7F78)).withValues(alpha: 0.4 + 0.6 * ov)),
      );
    }
  }

  void _spot(Canvas c, MapSpot s, bool restored, double t) {
    final r = s.area;
    if (s.kind == SpotKind.window) {
      Pk.box(c, r.inflate(5), Colors.white, radius: 6);
      if (!restored) {
        Pk.box(c, r, const Color(0xFF3E3A40), radius: 4);
        for (final (dy, rot) in [(0.3, -0.12), (0.7, 0.1)]) {
          c.save();
          c.translate(r.center.dx, r.top + r.height * dy);
          c.rotate(rot);
          Pk.box(c, Rect.fromCenter(center: Offset.zero, width: r.width + 8, height: 12), const Color(0xFF9A8672), radius: 2);
          c.restore();
        }
        return;
      }
      c.save();
      c.clipRRect(RRect.fromRectAndRadius(r, const Radius.circular(4)));
      Pk.gradientRect(c, r, Pk.light(s.accent, 0.35), s.accent);
      Pk.glow(c, r.center, r.width * 0.7, Colors.white, 0.35 + 0.1 * sin(t * 2 + r.left));
      c.restore();
      c.drawLine(r.topCenter, r.bottomCenter, Pk.stroke(Colors.white, 3));
      c.drawLine(r.centerLeft, r.centerRight, Pk.stroke(Colors.white, 3));
    } else {
      if (!restored) {
        c.drawOval(r, Pk.fill(const Color(0xFF9C8458)));
        for (var i = 0; i < 5; i++) {
          final p = Offset(r.left + Pk.rand(i + r.left.toInt()) * r.width, r.top + Pk.rand(i + 9) * r.height);
          c.drawLine(p, p + const Offset(-4, -9), Pk.stroke(const Color(0xFF7D6B3A), 1.6));
          c.drawLine(p, p + const Offset(3, -10), Pk.stroke(const Color(0xFF7D6B3A), 1.6));
        }
        return;
      }
      c.drawOval(r, Pk.fill(Pk.light(s.accent, 0.1)));
      c.drawOval(r.deflate(8), Pk.stroke(Colors.white.withValues(alpha: 0.6), 2));
      for (var i = 0; i < 6; i++) {
        final p = Offset(r.left + r.width * (0.15 + i * 0.14), r.center.dy + (i.isEven ? -8 : 8));
        Pk.flower(c, p, 1.2, i.isEven ? const Color(0xFFFF6B8B) : const Color(0xFFFFC93C));
      }
    }
  }
}

final farmMap = LocationMapArt(
  style: MapStyle.farm,
  groundN: const Color(0xFFB39460),
  groundR: const Color(0xFF5DB848),
  spots: const [
    MapSpot('farmyard', Offset(180, 536), Rect.fromLTWH(95, 490, 170, 90), SpotKind.yard, Color(0xFF7ACB52)),
    MapSpot('barn', Offset(105, 380), Rect.fromLTWH(62, 345, 86, 70), SpotKind.window, Color(0xFFFFD08A)),
    MapSpot('chicken_coop', Offset(90, 490), Rect.fromLTWH(20, 468, 90, 44), SpotKind.yard, Color(0xFF9CD86B)),
    MapSpot('workshop', Offset(275, 395), Rect.fromLTWH(238, 370, 74, 50), SpotKind.window, Color(0xFFB8D4FF)),
    MapSpot('farmhouse', Offset(268, 290), Rect.fromLTWH(226, 268, 84, 52), SpotKind.window, Color(0xFFFFC46B)),
  ],
);

final restaurantMap = LocationMapArt(
  style: MapStyle.restaurant,
  groundN: const Color(0xFFA8A296),
  groundR: const Color(0xFFE6DCCB),
  spots: const [
    MapSpot('entrance', Offset(180, 420), Rect.fromLTWH(152, 385, 56, 62), SpotKind.window, Color(0xFFFFD08A)),
    MapSpot('rest_kitchen', Offset(90, 405), Rect.fromLTWH(56, 384, 72, 52), SpotKind.window, Color(0xFFDFF6EE)),
    MapSpot('dining_hall', Offset(270, 405), Rect.fromLTWH(232, 384, 72, 52), SpotKind.window, Color(0xFFE88A8A)),
    MapSpot('terrace', Offset(180, 530), Rect.fromLTWH(95, 488, 170, 84), SpotKind.yard, Color(0xFFD29A5A)),
    MapSpot('vip_room', Offset(180, 275), Rect.fromLTWH(115, 244, 130, 66), SpotKind.window, Color(0xFF9B6BFF)),
  ],
);

final beachMap = LocationMapArt(
  style: MapStyle.beach,
  groundN: const Color(0xFFCFC2A2),
  groundR: const Color(0xFFF6DC9C),
  groundY: 540,
  spots: const [
    MapSpot('beach', Offset(80, 485), Rect.fromLTWH(20, 455, 120, 58), SpotKind.yard, Color(0xFFFFE08A)),
    MapSpot('pool', Offset(282, 485), Rect.fromLTWH(220, 455, 124, 58), SpotKind.yard, Color(0xFF6FE0F0)),
    MapSpot('beach_bar', Offset(300, 380), Rect.fromLTWH(262, 352, 76, 56), SpotKind.window, Color(0xFFFFB35C)),
    MapSpot('hotel_room', Offset(180, 290), Rect.fromLTWH(128, 262, 104, 56), SpotKind.window, Color(0xFFB8F1FF)),
    MapSpot('rooftop', Offset(180, 150), Rect.fromLTWH(125, 126, 110, 40), SpotKind.window, Color(0xFFFF7AD9)),
  ],
);

final mansionMap = LocationMapArt(
  style: MapStyle.mansion,
  groundN: const Color(0xFFB39460),
  groundR: const Color(0xFF5DB848),
  groundY: 460,
  spots: const [
    MapSpot('front_yard', Offset(180, 530), Rect.fromLTWH(95, 495, 170, 92), SpotKind.yard, Color(0xFF7ACB52)),
    MapSpot('grand_hall', Offset(180, 400), Rect.fromLTWH(140, 368, 80, 80), SpotKind.window, Color(0xFFFFE08A)),
    MapSpot('luxury_bedroom', Offset(92, 310), Rect.fromLTWH(50, 284, 84, 56), SpotKind.window, Color(0xFFE8A0B8)),
    MapSpot('cinema_room', Offset(268, 310), Rect.fromLTWH(226, 284, 84, 56), SpotKind.window, Color(0xFF6B4BD6)),
    MapSpot('penthouse', Offset(180, 185), Rect.fromLTWH(142, 158, 76, 56), SpotKind.window, Color(0xFFFF9ADA)),
  ],
);

final castleMap = LocationMapArt(
  style: MapStyle.castle,
  groundN: const Color(0xFFB39460),
  groundR: const Color(0xFF5DB848),
  groundY: 460,
  spots: const [
    MapSpot('castle_gate', Offset(180, 535), Rect.fromLTWH(95, 495, 170, 88), SpotKind.yard, Color(0xFF7ACB52)),
    MapSpot('banquet_hall', Offset(100, 395), Rect.fromLTWH(68, 372, 62, 46), SpotKind.window, Color(0xFFFFB35C)),
    MapSpot('castle_library', Offset(260, 395), Rect.fromLTWH(228, 372, 62, 46), SpotKind.window, Color(0xFFB38CFF)),
    MapSpot('armory', Offset(50, 290), Rect.fromLTWH(32, 270, 36, 40), SpotKind.window, Color(0xFFFF9A3C)),
    MapSpot('throne_room', Offset(180, 245), Rect.fromLTWH(150, 222, 60, 48), SpotKind.window, Color(0xFFFFC93C)),
  ],
);

final lodgeMap = LocationMapArt(
  style: MapStyle.lodge,
  groundN: const Color(0xFFB9B6AE),
  groundR: const Color(0xFFF4FAFF),
  groundY: 455,
  spots: const [
    MapSpot('lodge_front', Offset(180, 535), Rect.fromLTWH(95, 495, 170, 88), SpotKind.yard, Color(0xFFBFEFFF)),
    MapSpot('lodge_lounge', Offset(100, 400), Rect.fromLTWH(64, 378, 72, 48), SpotKind.window, Color(0xFFFFB35C)),
    MapSpot('ski_room', Offset(260, 400), Rect.fromLTWH(224, 378, 72, 48), SpotKind.window, Color(0xFF8FD0FF)),
    MapSpot('lodge_spa', Offset(110, 320), Rect.fromLTWH(80, 300, 62, 40), SpotKind.window, Color(0xFF6FE0D0)),
    MapSpot('lodge_suite', Offset(180, 250), Rect.fromLTWH(152, 228, 56, 44), SpotKind.window, Color(0xFFE8A0B8)),
  ],
);

final harborMap = LocationMapArt(
  style: MapStyle.harbor,
  groundN: const Color(0xFFCFC2A2),
  groundR: const Color(0xFFF0DCA8),
  groundY: 520,
  spots: const [
    MapSpot('harbor_dock', Offset(180, 478), Rect.fromLTWH(100, 450, 160, 58), SpotKind.yard, Color(0xFFD29A5A)),
    MapSpot('fish_market', Offset(80, 390), Rect.fromLTWH(50, 370, 60, 42), SpotKind.window, Color(0xFF8FD0FF)),
    MapSpot('boathouse', Offset(195, 395), Rect.fromLTWH(166, 376, 58, 40), SpotKind.window, Color(0xFFFFD08A)),
    MapSpot('lighthouse_base', Offset(290, 395), Rect.fromLTWH(278, 378, 24, 36), SpotKind.window, Color(0xFFFFE066)),
    MapSpot('keeper_cottage', Offset(80, 295), Rect.fromLTWH(52, 276, 56, 40), SpotKind.window, Color(0xFFFF9A3C)),
  ],
);

final museumMap = LocationMapArt(
  style: MapStyle.museum,
  groundN: const Color(0xFFA8A296),
  groundR: const Color(0xFFE6DCCB),
  groundY: 460,
  spots: const [
    MapSpot('museum_steps', Offset(180, 535), Rect.fromLTWH(95, 495, 170, 88), SpotKind.yard, Color(0xFF7ACB52)),
    MapSpot('sculpture_hall', Offset(90, 380), Rect.fromLTWH(62, 356, 56, 48), SpotKind.window, Color(0xFFFFF4E0)),
    MapSpot('art_gallery', Offset(270, 380), Rect.fromLTWH(242, 356, 56, 48), SpotKind.window, Color(0xFFFF7AB6)),
    MapSpot('history_hall', Offset(180, 245), Rect.fromLTWH(154, 228, 52, 32), SpotKind.window, Color(0xFF45A7F5)),
    MapSpot('museum_cafe', Offset(180, 410), Rect.fromLTWH(154, 390, 52, 44), SpotKind.window, Color(0xFFE0533F)),
  ],
);

final theaterMap = LocationMapArt(
  style: MapStyle.theater,
  groundN: const Color(0xFFA8A296),
  groundR: const Color(0xFF6B6480),
  groundY: 460,
  spots: const [
    MapSpot('theater_front', Offset(180, 535), Rect.fromLTWH(95, 495, 170, 88), SpotKind.yard, Color(0xFFFF7AD9)),
    MapSpot('theater_lobby', Offset(180, 412), Rect.fromLTWH(146, 388, 68, 50), SpotKind.window, Color(0xFFFFC93C)),
    MapSpot('dressing_room', Offset(95, 300), Rect.fromLTWH(70, 280, 50, 42), SpotKind.window, Color(0xFFFF7AD9)),
    MapSpot('concert_hall', Offset(265, 300), Rect.fromLTWH(240, 280, 50, 42), SpotKind.window, Color(0xFFB38CFF)),
    MapSpot('grand_stage', Offset(180, 240), Rect.fromLTWH(146, 222, 68, 36), SpotKind.window, Color(0xFFFF4F7A)),
  ],
);
