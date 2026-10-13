import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../art/lighting.dart';
import '../art/paint_kit.dart';
import 'location_map_art.dart';

/// Chapter-map artwork contract so future chapters (Farm, Barn...) can plug in
/// their own illustrated map without touching screens.
abstract class ChapterMapArt {
  static const Size designSize = Size(360, 640);

  /// Level node positions in design space.
  Map<String, Offset> get nodes;

  void paint(Canvas c, Size canvasSize, Set<String> completed, double time, {bool celebrate = false});
}

ChapterMapArt? chapterMapArtFor(String id) => switch (id) {
  'house' => HouseMapArt(),
  'farm' => farmMap,
  'restaurant' => restaurantMap,
  'beach' => beachMap,
  'mansion' => mansionMap,
  'castle' => castleMap,
  'lodge' => lodgeMap,
  'harbor' => harborMap,
  'museum' => museumMap,
  'theater' => theaterMap,
  _ => null,
};

/// Maps design coordinates onto a box (contain or cover).
class MapLayout {
  final double scale;
  final Offset origin;
  const MapLayout._(this.scale, this.origin);

  factory MapLayout(Size box) {
    const d = ChapterMapArt.designSize;
    final scale = min(box.width / d.width, box.height / d.height);
    return MapLayout._(scale, Offset((box.width - d.width * scale) / 2, (box.height - d.height * scale) / 2));
  }

  Offset toLocal(Offset design) => origin + design * scale;
}

/// Illustrated dollhouse: each room visibly restores when its level is done.
class HouseMapArt extends ChapterMapArt {
  @override
  final Map<String, Offset> nodes = const {
    'garden': Offset(180, 536),
    'kitchen': Offset(124, 416),
    'bathroom': Offset(116, 306),
    'gaming_room': Offset(244, 306),
    'attic': Offset(180, 196),
  };

  @override
  void paint(Canvas c, Size canvasSize, Set<String> done, double t, {bool celebrate = false}) {
    final ov = done.length / 5;
    final garden = done.contains('garden');

    // Background fills the whole canvas (beyond the design box).
    final sky = [
      Pk.mix(const Color(0xFF9DB8C9), const Color(0xFF5EC2FF), ov),
      Pk.mix(const Color(0xFFE6DCC8), const Color(0xFFFFE9C2), ov),
    ];
    c.drawRect(Offset.zero & canvasSize, Pk.fill(sky[0]));
    final layout = MapLayout(canvasSize);
    final groundTop = layout.toLocal(const Offset(0, 470)).dy;
    Pk.gradientRect(c, Rect.fromLTWH(0, 0, canvasSize.width, groundTop), sky[0], sky[1]);
    c.drawRect(
      Rect.fromLTWH(0, groundTop, canvasSize.width, canvasSize.height - groundTop),
      Pk.fill(garden ? const Color(0xFF5DB848) : const Color(0xFFB39460)),
    );

    c.save();
    c.translate(layout.origin.dx, layout.origin.dy);
    c.scale(layout.scale);

    // Sun & clouds.
    Pk.glow(c, const Offset(300, 70), 70, const Color(0xFFFFF1A8), 0.35 + 0.4 * ov);
    c.drawCircle(const Offset(300, 70), 24, Pk.fill(Pk.mix(const Color(0xFFF3E4B0), const Color(0xFFFFE066), ov)));
    for (var i = 0; i < 4; i++) {
      final x = (i * 120 + t * (4 + i * 1.5)) % 480 - 80;
      Pk.cloud(c, Offset(x, 40.0 + i * 34), 0.9 + (i % 2) * 0.3, Colors.white.withValues(alpha: 0.85));
    }
    // Hills.
    final hills = Path()
      ..moveTo(-100, 440)
      ..quadraticBezierTo(40, 380, 160, 430)
      ..quadraticBezierTo(280, 370, 460, 420)
      ..lineTo(460, 480)
      ..lineTo(-100, 480)
      ..close();
    c.drawPath(hills, Pk.fill(Pk.mix(const Color(0xFFA7AE8C), const Color(0xFF8ED46A), ov)));

    _lawn(c, garden, t);
    _house(c, done, ov, t);
    _garden(c, garden, t);

    if (celebrate || ov >= 1) {
      for (var i = 0; i < 10; i++) {
        final p = Offset(40 + Pk.rand(i) * 280, 120 + Pk.rand(i + 5) * 380);
        final tw = (sin(t * 3 + i * 1.3) + 1) / 2;
        Pk.sparkle(c, p, 4 + 5 * tw, Colors.white.withValues(alpha: 0.4 + 0.5 * tw));
      }
    }
    c.restore();
  }

  void _lawn(Canvas c, bool garden, double t) {
    Pk.gradientRect(
      c,
      const Rect.fromLTWH(-200, 470, 760, 260),
      garden ? const Color(0xFF8EDB5E) : const Color(0xFFD2B77E),
      garden ? const Color(0xFF4FA83C) : const Color(0xFFA88A58),
    );
    // Path to door.
    final path = Path()
      ..moveTo(236, 470)
      ..lineTo(270, 470)
      ..lineTo(300, 640)
      ..lineTo(220, 640)
      ..close();
    c.drawPath(path, Pk.fill(garden ? const Color(0xFFF1E3C6) : const Color(0xFFBFA982)));
  }

  void _house(Canvas c, Set<String> done, double ov, double t) {
    final wall = Pk.mix(const Color(0xFFC9BFAE), const Color(0xFFFFF1DA), ov);
    final wallShade = Pk.dark(wall, 0.14);
    Pk.shadow(c, const Offset(180, 472), 300, 20, 0.25);
    // Side wall (isometric depth).
    Pk.poly(c, const [Offset(310, 250), Offset(330, 240), Offset(330, 462), Offset(310, 470)], Pk.fill(wallShade));
    Pk.box(c, const Rect.fromLTWH(50, 250, 260, 220), wall, radius: 2);
    // Floor divider.
    c.drawRect(const Rect.fromLTWH(46, 356, 268, 8), Pk.fill(Pk.mix(const Color(0xFF8C7E6C), const Color(0xFFE0A86C), ov)));
    // Roof.
    final roof = Pk.mix(const Color(0xFF8C6A60), const Color(0xFFD9573F), ov);
    Pk.poly(c, const [Offset(28, 256), Offset(180, 108), Offset(332, 256)], Pk.fill(roof));
    Pk.poly(c, const [Offset(180, 108), Offset(332, 256), Offset(352, 244), Offset(200, 100)], Pk.fill(Pk.dark(roof, 0.2)));
    for (var i = 1; i < 6; i++) {
      final y = 108 + i * 25.0;
      final half = (y - 108) * 152 / 148;
      c.drawLine(Offset(180 - half, y), Offset(180 + half, y), Pk.stroke(Pk.dark(roof, 0.15), 1.5));
    }
    // Chimney with smoke once everything is done.
    Pk.box(c, const Rect.fromLTWH(262, 150, 22, 50), Pk.mix(const Color(0xFF8C7E6C), const Color(0xFFB9642C), ov), radius: 2);
    if (ov >= 1) {
      for (var i = 0; i < 4; i++) {
        final k = (t * 0.4 + i / 4) % 1;
        c.drawCircle(
          Offset(273 + sin(k * 6 + i) * 6, 146 - k * 60),
          6 + k * 10,
          Pk.fill(Colors.white.withValues(alpha: 0.55 * (1 - k))),
        );
      }
    }

    _roomWindow(c, const Rect.fromLTWH(70, 378, 118, 70), done.contains('kitchen'), const Color(0xFFFFD08A), t, 'kitchen');
    _roomWindow(c, const Rect.fromLTWH(66, 268, 100, 72), done.contains('bathroom'), const Color(0xFFB8F1FF), t, 'bathroom');
    _roomWindow(c, const Rect.fromLTWH(194, 268, 100, 72), done.contains('gaming_room'), const Color(0xFF6B4BD6), t, 'gaming');
    _atticWindow(c, done.contains('attic'), t);

    // Door.
    final doorOk = ov > 0;
    Pk.box(
      c,
      const Rect.fromLTWH(228, 392, 48, 78),
      Pk.mix(const Color(0xFF7E6A5A), const Color(0xFF3FA3E0), doorOk ? 1 : 0),
      radius: 8,
      outline: Pk.dark(wall, 0.35),
      ow: 2,
    );
    c.drawCircle(const Offset(268, 432), 3, Pk.fill(const Color(0xFFFFD447)));
    Pk.box(c, const Rect.fromLTWH(220, 382, 64, 10), Pk.mix(const Color(0xFF8C7E6C), const Color(0xFFE08A45), ov), radius: 3);

    // Cracks & grime on neglected walls.
    final grime = 1 - ov;
    if (grime > 0.02) {
      final p = Pk.stroke(Colors.black.withValues(alpha: 0.3 * grime), 1.4);
      c.drawPath(
        Path()
          ..moveTo(200, 262)
          ..lineTo(206, 276)
          ..lineTo(200, 288)
          ..lineTo(208, 300),
        p,
      );
      c.drawPath(
        Path()
          ..moveTo(296, 380)
          ..lineTo(290, 396)
          ..lineTo(298, 410),
        p,
      );
      Pk.cobweb(c, const Offset(50, 250), 1.2, grime);
    }
  }

  void _roomWindow(Canvas c, Rect r, bool restored, Color light, double t, String kind) {
    Pk.box(c, r.inflate(5), Colors.white, radius: 6);
    if (!restored) {
      Pk.box(c, r, const Color(0xFF3E3A40), radius: 4);
      // Boards.
      for (final (dy, rot) in [(0.3, -0.12), (0.7, 0.1)]) {
        c.save();
        c.translate(r.center.dx, r.top + r.height * dy);
        c.rotate(rot);
        Pk.box(c, Rect.fromCenter(center: Offset.zero, width: r.width + 8, height: 12), const Color(0xFF9A8672), radius: 2);
        c.drawCircle(Offset(-r.width / 2 + 4, 0), 1.5, Pk.fill(const Color(0xFF5A4A3A)));
        c.drawCircle(Offset(r.width / 2 - 4, 0), 1.5, Pk.fill(const Color(0xFF5A4A3A)));
        c.restore();
      }
      return;
    }
    c.save();
    c.clipRRect(RRect.fromRectAndRadius(r, const Radius.circular(4)));
    Pk.gradientRect(c, r, Pk.light(light, 0.25), light);
    // Tiny interior hints.
    switch (kind) {
      case 'kitchen':
        Pk.box(c, Rect.fromLTWH(r.left + 6, r.top + 8, 44, 18), const Color(0xFF8FC79A), radius: 2);
        Pk.box(c, Rect.fromLTWH(r.left + 6, r.bottom - 26, 50, 26), const Color(0xFF8FC79A), radius: 2);
        Pk.box(c, Rect.fromLTWH(r.right - 26, r.top + 10, 20, r.height - 10), const Color(0xFF9EE3D1), radius: 5);
        Pk.box(c, Rect.fromLTWH(r.left + 60, r.bottom - 20, 30, 6), const Color(0xFFC98A52), radius: 2);
        Pk.glow(c, Offset(r.center.dx, r.top + 6), 30, const Color(0xFFFFE3A0), 0.6);
      case 'bathroom':
        for (var y = r.top; y < r.bottom; y += 10) {
          c.drawLine(Offset(r.left, y), Offset(r.right, y), Pk.stroke(Colors.white.withValues(alpha: 0.5), 1));
        }
        Pk.box(c, Rect.fromLTWH(r.left + 6, r.bottom - 24, 52, 20), Colors.white, radius: 8);
        c.drawOval(Rect.fromLTWH(r.right - 34, r.top + 8, 24, 30), Pk.fill(const Color(0xFFE5B85C)));
        c.drawOval(Rect.fromLTWH(r.right - 31, r.top + 11, 18, 24), Pk.fill(const Color(0xFFDFF8FF)));
      case 'gaming':
        Pk.glow(c, r.center, 60, Pk.hue(t * 50), 0.5);
        c.drawLine(Offset(r.left, r.top + 4), Offset(r.right, r.top + 4), Pk.stroke(Pk.hue(t * 90), 3));
        Pk.box(c, Rect.fromLTWH(r.center.dx - 24, r.top + 18, 48, 28), const Color(0xFF14111F), radius: 3);
        Pk.box(c, Rect.fromLTWH(r.center.dx - 21, r.top + 21, 42, 22), Pk.hue(t * 40 + 200, 0.6), radius: 2);
        c.drawRect(Rect.fromLTWH(r.left + 14, r.bottom - 18, r.width - 28, 5), Pk.fill(const Color(0xFF3A3450)));
    }
    c.restore();
    c.drawLine(r.topCenter, r.bottomCenter, Pk.stroke(Colors.white, 3));
    c.drawLine(r.centerLeft, r.centerRight, Pk.stroke(Colors.white, 3));
  }

  void _atticWindow(Canvas c, bool restored, double t) {
    const center = Offset(180, 200);
    c.drawCircle(center, 30, Pk.fill(Colors.white));
    if (restored) {
      c.drawCircle(
        center,
        25,
        Paint()
          ..shader = const RadialGradient(colors: [Color(0xFFFFE08A), Color(0xFFFF9A5C)])
              .createShader(Rect.fromCircle(center: center, radius: 25)),
      );
      Pk.glow(c, center, 50, const Color(0xFFFFC46B), 0.4 + 0.1 * sin(t * 2));
    } else {
      c.drawCircle(center, 25, Pk.fill(const Color(0xFF3E3A40)));
      c.save();
      c.translate(center.dx, center.dy);
      c.rotate(-0.4);
      Pk.box(c, const Rect.fromLTWH(-30, -6, 60, 11), const Color(0xFF9A8672), radius: 2);
      c.restore();
    }
    c.drawLine(center - const Offset(0, 25), center + const Offset(0, 25), Pk.stroke(Colors.white, 3));
    c.drawLine(center - const Offset(25, 0), center + const Offset(25, 0), Pk.stroke(Colors.white, 3));
  }

  void _garden(Canvas c, bool garden, double t) {
    // Fence along the front.
    for (var i = 0; i < 16; i++) {
      final x = -10 + i * 25.0;
      if (x > 205 && x < 300) continue; // gap for the path
      if (garden) {
        Pk.poly(c, [
          Offset(x, 520),
          Offset(x, 494),
          Offset(x + 5, 488),
          Offset(x + 10, 494),
          Offset(x + 10, 520),
        ], Pk.fill(Colors.white));
      } else if (i % 3 != 1) {
        c.save();
        c.translate(x + 5, 520);
        c.rotate(i.isEven ? 0.25 : -0.15);
        c.drawRect(const Rect.fromLTWH(-4, -24, 8, 24), Pk.fill(const Color(0xFFA89C8A)));
        c.restore();
      }
    }
    if (garden) {
      c.drawRect(const Rect.fromLTWH(-10, 500, 215, 4), Pk.fill(const Color(0xFFE6E0EE)));
      c.drawRect(const Rect.fromLTWH(300, 500, 80, 4), Pk.fill(const Color(0xFFE6E0EE)));
    }
    // Trees.
    for (final (x, s) in [(20.0, 1.0), (340.0, 0.85)]) {
      if (garden) {
        final base = Offset(x, 480);
        c.drawRect(Rect.fromLTWH(x - 5 * s, 420 * 1.0 + (1 - s) * 40, 10 * s, 60 * s), Pk.fill(const Color(0xFF8B5E3C)));
        final cc = base - Offset(sin(t * 0.8) * 2, 72 * s);
        c.drawCircle(cc + Offset(-18 * s, 10 * s), 24 * s, Pk.fill(const Color(0xFF3FA84A)));
        c.drawCircle(cc + Offset(18 * s, 12 * s), 22 * s, Pk.fill(const Color(0xFF3FA84A)));
        c.drawCircle(cc, 30 * s, Pk.fill(const Color(0xFF55C04A)));
        c.drawCircle(cc + Offset(-8 * s, -10 * s), 14 * s, Pk.fill(const Color(0xFF7ED65E)));
      } else {
        Pk.box(c, Rect.fromCenter(center: Offset(x, 474), width: 18, height: 12), const Color(0xFF8B6A48), radius: 2);
      }
    }
    // Flower beds.
    const colors = [Color(0xFFFF6B8B), Color(0xFFFFC93C), Color(0xFFB57BFF), Color(0xFFFFFFFF)];
    for (var i = 0; i < 2; i++) {
      final bed = Offset(70.0 + i * 70, 540);
      c.drawOval(Rect.fromCenter(center: bed, width: 60, height: 16), Pk.fill(const Color(0xFF8A5E3A)));
      if (garden) {
        for (var k = 0; k < 5; k++) {
          Pk.flower(c, bed + Offset(-20 + k * 10.0, -6), 1.3, colors[(i + k) % 4]);
        }
      }
    }
    if (!garden) {
      for (var i = 0; i < 8; i++) {
        final base = Offset(10 + Pk.rand(i + 90) * 340, 500 + Pk.rand(i + 91) * 130);
        final p = Pk.stroke(const Color(0xFF7D6B3A), 1.6);
        c.drawLine(base, base + const Offset(-4, -9), p);
        c.drawLine(base, base + const Offset(3, -10), p);
      }
    }
  }
}

/// Animated map painter widget.
class ChapterMapView extends StatefulWidget {
  final ChapterMapArt art;
  final Set<String> completed;
  final bool celebrate;
  const ChapterMapView({super.key, required this.art, required this.completed, this.celebrate = false});

  @override
  State<ChapterMapView> createState() => _ChapterMapViewState();
}

class _ChapterMapViewState extends State<ChapterMapView> with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final _t = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((e) => _t.value = e.inMicroseconds / 1e6)..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _t.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => RepaintBoundary(
    child: CustomPaint(size: Size.infinite, painter: _MapPainter(widget.art, widget.completed, _t, widget.celebrate)),
  );
}

class _MapPainter extends CustomPainter {
  final ChapterMapArt art;
  final Set<String> completed;
  final ValueNotifier<double> t;
  final bool celebrate;
  _MapPainter(this.art, this.completed, this.t, this.celebrate) : super(repaint: t);

  @override
  void paint(Canvas canvas, Size size) {
    // Maps use a 360×640 design space: buildings recede toward its middle.
    final vp = Pk.vanish;
    Pk.vanish = const Offset(180, 260);
    art.paint(canvas, size, completed, t.value, celebrate: celebrate);
    Pk.vanish = vp;
    final total = art.nodes.length;
    Lighting.gradeRect(canvas, Offset.zero & size, total == 0 ? 0 : completed.length / total);
  }

  @override
  bool shouldRepaint(_MapPainter old) => old.completed.length != completed.length || old.art != art || old.celebrate != celebrate;
}
