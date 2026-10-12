import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../data/models/level_data.dart';
import '../../match3/board.dart';
import 'obstacle_art.dart';

/// Visual identity of a tile type. [slot] fixes shape + colour so pieces stay
/// distinguishable without relying on colour alone (accessibility). Icons can
/// later be swapped for image assets without touching gameplay code.
class TileVisual {
  final IconData icon;
  final int slot;
  const TileVisual(this.icon, this.slot);
}

const Map<String, TileVisual> tileVisuals = {
  // Garden
  'flower': TileVisual(Icons.local_florist, 0),
  'fence': TileVisual(Icons.fence, 1),
  'bench': TileVisual(Icons.chair, 2),
  'grass': TileVisual(Icons.grass, 3),
  'tree': TileVisual(Icons.park, 5),
  // Kitchen
  'table': TileVisual(Icons.table_restaurant, 0),
  'cabinets': TileVisual(Icons.door_sliding, 1),
  'counter': TileVisual(Icons.countertops, 2),
  'herbs': TileVisual(Icons.spa, 3),
  'fridge': TileVisual(Icons.kitchen, 4),
  'decor_cup': TileVisual(Icons.coffee, 5),
  // Bathroom
  'sink': TileVisual(Icons.wash, 0),
  'cabinet_bath': TileVisual(Icons.shelves, 1),
  'mirror': TileVisual(Icons.face_retouching_natural, 2),
  'plants': TileVisual(Icons.yard, 3),
  'bathtub': TileVisual(Icons.bathtub, 4),
  'soap': TileVisual(Icons.soap, 5),
  // Gaming room
  'chair': TileVisual(Icons.chair_alt, 0),
  'desk': TileVisual(Icons.desk, 1),
  'pc': TileVisual(Icons.memory, 2),
  'gaming_decor': TileVisual(Icons.sports_esports, 3),
  'monitor': TileVisual(Icons.desktop_windows, 4),
  'rgb': TileVisual(Icons.lightbulb, 5),
  // Attic
  'furniture': TileVisual(Icons.weekend, 0),
  'boxes': TileVisual(Icons.inventory_2, 1),
  'attic_decor': TileVisual(Icons.auto_awesome, 2),
  'floor': TileVisual(Icons.grid_view, 3),
  'window': TileVisual(Icons.window, 4),
  'shelves': TileVisual(Icons.shelves, 5),
  // Farm
  'tractor': TileVisual(Icons.agriculture, 0),
  'grain': TileVisual(Icons.grain, 2),
  'water': TileVisual(Icons.water_drop, 4),
  'animals': TileVisual(Icons.pets, 0),
  'barn_door': TileVisual(Icons.garage, 1),
  'hay': TileVisual(Icons.grass, 2),
  'tools': TileVisual(Icons.handyman, 3),
  'lantern': TileVisual(Icons.light, 5),
  'hen': TileVisual(Icons.emoji_nature, 0),
  'nest': TileVisual(Icons.cabin, 1),
  'egg': TileVisual(Icons.egg, 2),
  'feed': TileVisual(Icons.grain, 3),
  'blossom': TileVisual(Icons.local_florist, 5),
  'saw': TileVisual(Icons.carpenter, 0),
  'hammer': TileVisual(Icons.hardware, 1),
  'construction': TileVisual(Icons.construction, 2),
  'wrench': TileVisual(Icons.build, 3),
  'toolbox': TileVisual(Icons.handyman, 4),
  'bulb': TileVisual(Icons.lightbulb, 5),
  'cottage': TileVisual(Icons.cottage, 0),
  'hearth': TileVisual(Icons.fireplace, 1),
  'bed': TileVisual(Icons.bed, 2),
  'pie': TileVisual(Icons.cake, 3),
  'houseplant': TileVisual(Icons.spa, 5),
  // Restaurant
  'menu': TileVisual(Icons.restaurant_menu, 0),
  'rest_door': TileVisual(Icons.meeting_room, 1),
  'sign': TileVisual(Icons.flag, 2),
  'awning': TileVisual(Icons.umbrella, 4),
  'pot': TileVisual(Icons.soup_kitchen, 0),
  'grill': TileVisual(Icons.outdoor_grill, 1),
  'cutlery': TileVisual(Icons.flatware, 2),
  'plate': TileVisual(Icons.dinner_dining, 5),
  'seat': TileVisual(Icons.event_seat, 1),
  'wine': TileVisual(Icons.wine_bar, 2),
  'glass': TileVisual(Icons.local_drink, 4),
  'deck': TileVisual(Icons.deck, 1),
  'cocktail': TileVisual(Icons.local_bar, 2),
  'parasol': TileVisual(Icons.beach_access, 4),
  'jewel': TileVisual(Icons.diamond, 0),
  'lounge': TileVisual(Icons.weekend, 1),
  'champagne': TileVisual(Icons.liquor, 2),
  'piano': TileVisual(Icons.piano, 3),
  'music': TileVisual(Icons.music_note, 4),
  'curtain': TileVisual(Icons.curtains, 5),
  // Beach resort
  'umbrella': TileVisual(Icons.beach_access, 0),
  'surf': TileVisual(Icons.surfing, 1),
  'sun': TileVisual(Icons.wb_sunny, 2),
  'palm': TileVisual(Icons.forest, 3),
  'wave': TileVisual(Icons.waves, 4),
  'kayak': TileVisual(Icons.kayaking, 5),
  'lounger': TileVisual(Icons.airline_seat_recline_extra, 0),
  'towel': TileVisual(Icons.dry, 1),
  'juice': TileVisual(Icons.local_drink, 2),
  'pool': TileVisual(Icons.pool, 4),
  'sunshade': TileVisual(Icons.sunny, 5),
  'tap': TileVisual(Icons.sports_bar, 0),
  'icecream': TileVisual(Icons.icecream, 4),
  'speaker': TileVisual(Icons.speaker, 5),
  'king_bed': TileVisual(Icons.king_bed, 0),
  'luggage': TileVisual(Icons.luggage, 1),
  'room_service': TileVisual(Icons.room_service, 2),
  'shower': TileVisual(Icons.shower, 4),
  'party': TileVisual(Icons.celebration, 0),
  // Mansion
  'statue': TileVisual(Icons.castle, 2),
  'hedge': TileVisual(Icons.nature, 3),
  'fountain': TileVisual(Icons.water, 4),
  'stairs': TileVisual(Icons.stairs, 1),
  'trophy': TileVisual(Icons.workspace_premium, 2),
  'wardrobe': TileVisual(Icons.checkroom, 1),
  'gold_lamp': TileVisual(Icons.light_mode, 2),
  'movie': TileVisual(Icons.movie, 0),
  'reel': TileVisual(Icons.local_movies, 2),
  'console': TileVisual(Icons.videogame_asset, 3),
  'projector': TileVisual(Icons.tv, 4),
};

TileVisual visualOf(String tileTypeId) => tileVisuals[tileTypeId] ?? const TileVisual(Icons.help_outline, 0);

const slotColors = <Color>[
  Color(0xFFFF5A6E), // red circle
  Color(0xFFFF9B2F), // orange square
  Color(0xFFFFCF33), // yellow pentagon
  Color(0xFF4FC94A), // green hexagon
  Color(0xFF3FA4FF), // blue drop
  Color(0xFFAE6BFF), // purple diamond
];

Path slotPath(int slot, Rect r) {
  final c = r.center;
  final w = r.width, h = r.height;
  switch (slot % 6) {
    case 0:
      return Path()..addOval(r.deflate(w * 0.02));
    case 1:
      return Path()..addRRect(RRect.fromRectAndRadius(r.deflate(w * 0.05), Radius.circular(w * 0.24)));
    case 2:
      return _roundedPolygon(c, w * 0.53, 5, -pi / 2, w * 0.1);
    case 3:
      return _roundedPolygon(c, w * 0.52, 6, 0, w * 0.1);
    case 4:
      // Teardrop pointing up.
      final p = Path();
      final cy = r.top + h * 0.62;
      final rad = w * 0.4;
      p.moveTo(c.dx, r.top + h * 0.02);
      p.cubicTo(c.dx + w * 0.12, r.top + h * 0.2, c.dx + rad, cy - rad * 0.55, c.dx + rad, cy);
      p.arcToPoint(Offset(c.dx - rad, cy), radius: Radius.circular(rad), clockwise: true);
      p.cubicTo(c.dx - rad, cy - rad * 0.55, c.dx - w * 0.12, r.top + h * 0.2, c.dx, r.top + h * 0.02);
      p.close();
      return p;
    default:
      return _roundedPolygon(c, w * 0.54, 4, -pi / 2, w * 0.12);
  }
}

Path _roundedPolygon(Offset c, double radius, int sides, double rot, double corner) {
  final pts = [for (var i = 0; i < sides; i++) c + Offset(cos(rot + i * 2 * pi / sides), sin(rot + i * 2 * pi / sides)) * radius];
  final p = Path();
  for (var i = 0; i < sides; i++) {
    final prev = pts[(i - 1 + sides) % sides], cur = pts[i], next = pts[(i + 1) % sides];
    final a = cur + (prev - cur) / (prev - cur).distance * corner;
    final b = cur + (next - cur) / (next - cur).distance * corner;
    if (i == 0) {
      p.moveTo(a.dx, a.dy);
    } else {
      p.lineTo(a.dx, a.dy);
    }
    p.quadraticBezierTo(cur.dx, cur.dy, b.dx, b.dy);
  }
  p.close();
  return p;
}

Color _lighten(Color c, double t) => Color.lerp(c, Colors.white, t)!;
Color _darken(Color c, double t) => Color.lerp(c, Colors.black, t)!;

void _drawIcon(Canvas canvas, IconData icon, Offset center, double size, Color color, {Color? shadow}) {
  final tp = TextPainter(
    text: TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontFamily: icon.fontFamily,
        package: icon.fontPackage,
        fontSize: size,
        color: color,
        shadows: shadow == null ? null : [Shadow(color: shadow, offset: Offset(0, size * 0.06), blurRadius: size * 0.04)],
      ),
    ),
    textDirection: TextDirection.ltr,
  )..layout();
  tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
}

/// Draws a piece or, for obstacle ids (crate / ice / chain), its icon.
void paintPiece(Canvas canvas, Rect r, String id, SpecialKind special) {
  if (ObjectiveData.obstacleIds.contains(id)) {
    ObstacleArt.icon(canvas, r, id);
  } else {
    paintTile(canvas, r, visualOf(id), special);
  }
}

/// Draws a complete game piece into [r].
void paintTile(Canvas canvas, Rect r, TileVisual v, SpecialKind special) {
  final color = slotColors[v.slot % 6];
  if (special == SpecialKind.colorBomb) {
    _paintColorBomb(canvas, r);
    return;
  }
  if (special == SpecialKind.bomb) {
    _paintBomb(canvas, r, v, color);
    return;
  }
  final shape = slotPath(v.slot, r.deflate(r.width * 0.06));

  // Drop shadow.
  canvas.drawPath(
    shape.shift(Offset(0, r.height * 0.05)),
    Paint()
      ..color = Colors.black.withValues(alpha: 0.28)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, r.width * 0.025),
  );
  // Body gradient.
  canvas.drawPath(
    shape,
    Paint()
      ..shader = ui.Gradient.radial(
        r.topLeft + Offset(r.width * 0.35, r.height * 0.3),
        r.width * 0.75,
        [_lighten(color, 0.35), color, _darken(color, 0.25)],
        [0, 0.55, 1],
      ),
  );
  // Rim.
  canvas.drawPath(
    shape,
    Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = r.width * 0.045
      ..color = _darken(color, 0.35),
  );
  // Gloss.
  canvas.save();
  canvas.clipPath(shape);
  canvas.drawOval(
    Rect.fromLTWH(r.left + r.width * 0.2, r.top + r.height * 0.1, r.width * 0.6, r.height * 0.3),
    Paint()..color = Colors.white.withValues(alpha: 0.38),
  );
  canvas.restore();

  if (special.isRocket) {
    _paintRocketStripes(canvas, r, shape, special == SpecialKind.rocketH);
  }

  final iconCenter = r.center + Offset(0, v.slot == 4 ? r.height * 0.1 : r.height * 0.02);
  _drawIcon(canvas, v.icon, iconCenter, r.width * (v.slot == 4 ? 0.4 : 0.46), Colors.white, shadow: _darken(color, 0.5));
}

void _paintRocketStripes(Canvas canvas, Rect r, Path shape, bool horizontal) {
  canvas.save();
  canvas.clipPath(shape);
  final stripe = Paint()..color = Colors.white.withValues(alpha: 0.55);
  for (var i = -1; i <= 1; i += 2) {
    final off = r.width * 0.3 * i;
    final rect = horizontal
        ? Rect.fromCenter(center: r.center + Offset(0, off), width: r.width, height: r.height * 0.1)
        : Rect.fromCenter(center: r.center + Offset(off, 0), width: r.width * 0.1, height: r.height);
    canvas.drawRect(rect, stripe);
  }
  canvas.restore();
  // Direction arrows.
  final arrow = Paint()..color = Colors.white;
  final outline = Paint()
    ..color = const Color(0xFF3B2A5A)
    ..style = PaintingStyle.stroke
    ..strokeWidth = r.width * 0.025
    ..strokeJoin = StrokeJoin.round;
  for (final dir in [-1.0, 1.0]) {
    final p = Path();
    final s = r.width * 0.13;
    if (horizontal) {
      final tip = r.center + Offset(r.width * 0.47 * dir, 0);
      p
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(tip.dx - s * dir, tip.dy - s)
        ..lineTo(tip.dx - s * dir, tip.dy + s)
        ..close();
    } else {
      final tip = r.center + Offset(0, r.height * 0.47 * dir);
      p
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(tip.dx - s, tip.dy - s * dir)
        ..lineTo(tip.dx + s, tip.dy - s * dir)
        ..close();
    }
    canvas.drawPath(p, arrow);
    canvas.drawPath(p, outline);
  }
}

void _paintBomb(Canvas canvas, Rect r, TileVisual v, Color color) {
  final c = r.center + Offset(0, r.height * 0.06);
  final rad = r.width * 0.36;
  canvas.drawCircle(
    c + Offset(0, r.height * 0.05),
    rad,
    Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, r.width * 0.03),
  );
  // Glow ring in the type colour.
  canvas.drawCircle(c, rad * 1.12, Paint()..color = color);
  canvas.drawCircle(
    c,
    rad,
    Paint()
      ..shader = ui.Gradient.radial(
        c - Offset(rad * 0.4, rad * 0.4),
        rad * 1.4,
        [const Color(0xFF6A6480), const Color(0xFF2A2440), const Color(0xFF15111F)],
        [0, 0.6, 1],
      ),
  );
  canvas.drawOval(
    Rect.fromCenter(center: c - Offset(rad * 0.3, rad * 0.45), width: rad * 0.8, height: rad * 0.45),
    Paint()..color = Colors.white.withValues(alpha: 0.35),
  );
  // Fuse cap + fuse + spark.
  final cap = Rect.fromCenter(center: c + Offset(rad * 0.55, -rad * 0.78), width: rad * 0.5, height: rad * 0.35);
  canvas.save();
  canvas.translate(cap.center.dx, cap.center.dy);
  canvas.rotate(0.6);
  canvas.drawRRect(
    RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: cap.width, height: cap.height),
      Radius.circular(rad * 0.08),
    ),
    Paint()..color = const Color(0xFF8A839B),
  );
  canvas.restore();
  final fuse = Path()
    ..moveTo(cap.center.dx + rad * 0.1, cap.center.dy - rad * 0.1)
    ..quadraticBezierTo(
      cap.center.dx + rad * 0.5,
      cap.center.dy - rad * 0.6,
      cap.center.dx + rad * 0.3,
      cap.center.dy - rad * 0.8,
    );
  canvas.drawPath(
    fuse,
    Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = r.width * 0.04
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFC9A36B),
  );
  final spark = cap.center + Offset(rad * 0.3, -rad * 0.85);
  canvas.drawCircle(spark, rad * 0.22, Paint()..color = const Color(0xFFFFE066).withValues(alpha: 0.7));
  canvas.drawCircle(spark, rad * 0.11, Paint()..color = Colors.white);
  _drawIcon(canvas, v.icon, c, rad * 0.95, Colors.white.withValues(alpha: 0.9));
}

void _paintColorBomb(Canvas canvas, Rect r) {
  final c = r.center;
  final rad = r.width * 0.4;
  canvas.drawCircle(
    c + Offset(0, r.height * 0.05),
    rad,
    Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, r.width * 0.03),
  );
  // More than two colours require explicit stops, otherwise the engine throws.
  final rainbow = [...slotColors, slotColors.first];
  canvas.drawCircle(
    c,
    rad,
    Paint()..shader = ui.Gradient.sweep(c, rainbow, [for (var i = 0; i < rainbow.length; i++) i / (rainbow.length - 1)]),
  );
  canvas.drawCircle(
    c,
    rad,
    Paint()
      ..shader = ui.Gradient.radial(
        c - Offset(rad * 0.3, rad * 0.3),
        rad * 1.1,
        [Colors.white.withValues(alpha: 0.85), Colors.white.withValues(alpha: 0.0)],
        [0, 0.7],
      ),
  );
  canvas.drawCircle(
    c,
    rad,
    Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = r.width * 0.04
      ..color = const Color(0xFF3B2A5A),
  );
  final sp = Paint()..color = Colors.white;
  for (final (dx, dy, s) in const [(-0.15, -0.1, 0.16), (0.2, 0.15, 0.11), (0.05, 0.28, 0.08)]) {
    paintSparkle(canvas, c + Offset(dx * r.width, dy * r.height), r.width * s, sp);
  }
}

/// Four-point star used for sparkles everywhere.
void paintSparkle(Canvas canvas, Offset c, double s, Paint paint) {
  final p = Path()
    ..moveTo(c.dx, c.dy - s)
    ..quadraticBezierTo(c.dx, c.dy, c.dx + s, c.dy)
    ..quadraticBezierTo(c.dx, c.dy, c.dx, c.dy + s)
    ..quadraticBezierTo(c.dx, c.dy, c.dx - s, c.dy)
    ..quadraticBezierTo(c.dx, c.dy, c.dx, c.dy - s)
    ..close();
  canvas.drawPath(p, paint);
}

/// Renders tiles once per size into GPU images; the board then just blits
/// them each frame (cheap, allocation-free).
class TileArtCache {
  final Map<String, ui.Image> _images = {};
  double _size = 0;

  ui.Image get(String tileTypeId, SpecialKind special, double size) {
    if ((size - _size).abs() > 0.5) {
      clear();
      _size = size;
    }
    final key = '$tileTypeId|${special.index}';
    return _images[key] ??= _render(tileTypeId, special, size);
  }

  ui.Image _render(String id, SpecialKind special, double size) {
    final px = max(8, size.ceil());
    final rec = ui.PictureRecorder();
    final canvas = Canvas(rec);
    paintPiece(canvas, Rect.fromLTWH(0, 0, px.toDouble(), px.toDouble()), id, special);
    final pic = rec.endRecording();
    final img = pic.toImageSync(px, px);
    pic.dispose();
    return img;
  }

  void clear() {
    for (final i in _images.values) {
      i.dispose();
    }
    _images.clear();
  }
}

/// Simple widget for showing a tile icon in HUD / menus.
class TileIcon extends StatelessWidget {
  final String tileTypeId;
  final double size;
  final SpecialKind special;
  const TileIcon(this.tileTypeId, {super.key, this.size = 36, this.special = SpecialKind.none});

  @override
  Widget build(BuildContext context) => CustomPaint(size: Size.square(size), painter: _TileIconPainter(tileTypeId, special));
}

class _TileIconPainter extends CustomPainter {
  final String id;
  final SpecialKind special;
  _TileIconPainter(this.id, this.special);

  @override
  void paint(Canvas canvas, Size size) => paintPiece(canvas, Offset.zero & size, id, special);

  @override
  bool shouldRepaint(_TileIconPainter old) => old.id != id || old.special != special;
}
