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

enum MapStyle { farm, restaurant, beach, mansion }

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
