import 'dart:math';

import 'package:flutter/material.dart';

import '../art/paint_kit.dart';

/// Reusable code-drawn props for data-driven restoration scenes.
/// Every painter draws inside its rect [r] using colours [a] (main) and [b]
/// (accent), so the same prop reads differently in each location.
enum PK {
  // Outdoor
  tree, palm, bush, hedge, flowerbed, fence, gate, path, pond, fountain, statue, lamppost, bench,
  haybale, crops, cart, tractor, trough, chicken, cow, nestbox, umbrella, lounger, surfboard, kayak,
  shoreline, sandcastle, beachball, poolWater, hotTub, towels, stringLights, railing, planter, tikiBar,
  // Indoor
  window, curtains, painting, shelf, bookshelf, cabinet, counter, stove, fridge, table, roundTable, chair,
  sofa, bed, wardrobe, rug, floorLamp, pendant, chandelier, plant, screen, fireplace, piano, barCounter,
  bottleShelf, wineRack, menuBoard, door, awning, podium, workbench, pegboard, barrel, crates, machine,
  toolbox, stall, lantern, cinemaSeats, projector, speaker, console, mirror, bathtub, shower, luggage,
  trolley, stairs, trophyCase, vase, clock, neonSign, stage, champagneTower, discoBall, sign,
  // Chapters 6–10
  banner, torch, snowman, sailboat, anchor, column, spotlight,
}

/// Props hung on walls pop from their centre; everything else grows from the floor.
const wallProps = {
  PK.window, PK.curtains, PK.painting, PK.shelf, PK.pendant, PK.chandelier, PK.screen, PK.bottleShelf,
  PK.menuBoard, PK.awning, PK.pegboard, PK.lantern, PK.mirror, PK.clock, PK.neonSign, PK.stringLights,
  PK.discoBall, PK.sign, PK.banner, PK.torch, PK.spotlight,
};

class PropKit {
  static void paint(Canvas c, PK k, Rect r, Color a, Color b, double t) {
    final w = r.width, h = r.height;
    switch (k) {
      // ---------------------------------------------------------------- outdoor
      case PK.tree:
        Pk.shadow(c, r.bottomCenter, w * 0.8, h * 0.08);
        c.drawRect(Rect.fromLTWH(r.center.dx - w * 0.07, r.top + h * 0.5, w * 0.14, h * 0.5), Pk.fill(const Color(0xFF8B5E3C)));
        final cc = Offset(r.center.dx + sin(t * 0.8) * w * 0.02, r.top + h * 0.35);
        c.drawCircle(cc + Offset(-w * 0.22, h * 0.08), w * 0.28, Pk.fill(Pk.dark(a, 0.15)));
        c.drawCircle(cc + Offset(w * 0.22, h * 0.1), w * 0.26, Pk.fill(Pk.dark(a, 0.15)));
        c.drawCircle(cc, w * 0.34, Pk.fill(a));
        c.drawCircle(cc + Offset(-w * 0.1, -h * 0.1), w * 0.14, Pk.fill(Pk.light(a, 0.25)));
        for (var i = 0; i < 4; i++) {
          c.drawCircle(cc + Offset((Pk.rand(i) - 0.5) * w * 0.5, (Pk.rand(i + 3) - 0.4) * h * 0.3), w * 0.04, Pk.fill(b));
        }
      case PK.palm:
        Pk.shadow(c, r.bottomCenter, w * 0.7, h * 0.06);
        final trunk = Path()
          ..moveTo(r.center.dx - w * 0.05, r.bottom)
          ..quadraticBezierTo(r.center.dx + w * 0.2, r.top + h * 0.5, r.center.dx + w * 0.05, r.top + h * 0.2)
          ..lineTo(r.center.dx + w * 0.13, r.top + h * 0.2)
          ..quadraticBezierTo(r.center.dx + w * 0.3, r.top + h * 0.5, r.center.dx + w * 0.06, r.bottom)
          ..close();
        c.drawPath(trunk, Pk.fill(const Color(0xFFB9824A)));
        final top = Offset(r.center.dx + w * 0.09, r.top + h * 0.2);
        final sway = sin(t) * 0.05;
        for (var i = 0; i < 6; i++) {
          final ang = -pi + i * pi / 5 + sway;
          final tip = top + Offset(cos(ang), sin(ang) * 0.6 + 0.35) * w * 0.55;
          c.drawPath(
            Path()
              ..moveTo(top.dx, top.dy)
              ..quadraticBezierTo((top.dx + tip.dx) / 2, min(top.dy, tip.dy) - h * 0.12, tip.dx, tip.dy),
            Pk.stroke(i.isEven ? a : Pk.dark(a, 0.15), w * 0.12),
          );
        }
        c.drawCircle(top + Offset(0, h * 0.05), w * 0.06, Pk.fill(const Color(0xFF7A4A2A)));
      case PK.bush:
        c.drawCircle(Offset(r.left + w * 0.3, r.bottom - h * 0.35), h * 0.35, Pk.fill(Pk.dark(a, 0.1)));
        c.drawCircle(Offset(r.right - w * 0.3, r.bottom - h * 0.35), h * 0.35, Pk.fill(Pk.dark(a, 0.1)));
        c.drawCircle(Offset(r.center.dx, r.bottom - h * 0.5), h * 0.45, Pk.fill(a));
        c.drawCircle(Offset(r.center.dx + w * 0.1, r.bottom - h * 0.6), h * 0.12, Pk.fill(b));
      case PK.hedge:
        Pk.box(c, r, a, bottom: Pk.dark(a, 0.2), radius: h * 0.35);
        for (var i = 0; i < 5; i++) {
          c.drawCircle(Offset(r.left + w * (0.12 + i * 0.19), r.top + h * 0.3), h * 0.12, Pk.fill(Pk.light(a, 0.15)));
        }
      case PK.flowerbed:
        c.drawOval(Rect.fromLTWH(r.left, r.bottom - h * 0.4, w, h * 0.4), Pk.fill(const Color(0xFF8A5E3A)));
        final n = max(3, (w / 9).round());
        for (var i = 0; i < n; i++) {
          Pk.flower(c, Offset(r.left + w * (i + 0.5) / n, r.bottom - h * 0.35 - (i.isEven ? h * 0.12 : 0)), h / 16, i.isEven ? a : b);
        }
      case PK.fence:
        c.drawRect(Rect.fromLTWH(r.left, r.top + h * 0.3, w, h * 0.12), Pk.fill(Pk.dark(a, 0.12)));
        c.drawRect(Rect.fromLTWH(r.left, r.top + h * 0.65, w, h * 0.12), Pk.fill(Pk.dark(a, 0.12)));
        final n = max(3, (w / 10).round());
        for (var i = 0; i < n; i++) {
          final x = r.left + w * i / n + w / n * 0.15;
          final pw = w / n * 0.7;
          Pk.poly(c, [Offset(x, r.bottom), Offset(x, r.top + h * 0.15), Offset(x + pw / 2, r.top), Offset(x + pw, r.top + h * 0.15), Offset(x + pw, r.bottom)], Pk.fill(a));
        }
      case PK.gate:
        Pk.box(c, Rect.fromLTWH(r.left, r.top, w * 0.14, h), const Color(0xFFD9D2C3), radius: 2);
        Pk.box(c, Rect.fromLTWH(r.right - w * 0.14, r.top, w * 0.14, h), const Color(0xFFD9D2C3), radius: 2);
        final p = Pk.stroke(a, w * 0.02);
        for (var i = 1; i < 8; i++) {
          final x = r.left + w * 0.14 + (w * 0.72) * i / 8;
          c.drawLine(Offset(x, r.bottom), Offset(x, r.top + h * 0.2 + (i - 4).abs() * h * 0.03), p);
        }
        c.drawArc(Rect.fromLTWH(r.left + w * 0.14, r.top + h * 0.05, w * 0.72, h * 0.4), pi, pi, false, Pk.stroke(a, w * 0.03));
        c.drawCircle(Offset(r.left + w * 0.07, r.top), w * 0.07, Pk.fill(b));
        c.drawCircle(Offset(r.right - w * 0.07, r.top), w * 0.07, Pk.fill(b));
      case PK.path:
        for (var i = 0; i < 4; i++) {
          final p = Offset.lerp(r.topLeft + Offset(w * 0.3, h * 0.2), r.bottomRight - Offset(w * 0.2, h * 0.2), i / 3)!;
          c.drawOval(Rect.fromCenter(center: p, width: w * 0.28, height: h * 0.2), Pk.fill(a));
        }
      case PK.pond:
        c.drawOval(r, Pk.fill(Pk.dark(a, 0.2)));
        c.drawOval(r.deflate(w * 0.04), Pk.fill(a));
        c.drawOval(Rect.fromCenter(center: r.center + Offset(-w * 0.15, 0), width: w * 0.2, height: h * 0.25), Pk.fill(b));
        c.drawLine(r.center + Offset(w * 0.05, -h * 0.1), r.center + Offset(w * 0.25, -h * 0.1), Pk.stroke(Colors.white.withValues(alpha: 0.6), 1.5));
      case PK.fountain:
        c.drawOval(Rect.fromLTWH(r.left, r.bottom - h * 0.35, w, h * 0.35), Pk.fill(const Color(0xFFD9D2C3)));
        c.drawOval(Rect.fromLTWH(r.left + w * 0.06, r.bottom - h * 0.32, w * 0.88, h * 0.24), Pk.fill(a));
        c.drawRect(Rect.fromLTWH(r.center.dx - w * 0.06, r.top + h * 0.35, w * 0.12, h * 0.45), Pk.fill(const Color(0xFFC9C2B3)));
        c.drawOval(Rect.fromCenter(center: Offset(r.center.dx, r.top + h * 0.38), width: w * 0.5, height: h * 0.12), Pk.fill(const Color(0xFFD9D2C3)));
        for (final d in [-1.0, 1.0]) {
          final ph = (t * 2) % 1;
          c.drawPath(
            Path()
              ..moveTo(r.center.dx, r.top + h * 0.3)
              ..quadraticBezierTo(r.center.dx + d * w * 0.25, r.top - h * 0.05, r.center.dx + d * w * (0.3 + ph * 0.05), r.bottom - h * 0.25),
            Pk.stroke(Colors.white.withValues(alpha: 0.8), 2),
          );
        }
      case PK.statue:
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.15, r.bottom - h * 0.25, w * 0.7, h * 0.25), const Color(0xFFD9D2C3), radius: 2);
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.3, r.top + h * 0.3, w * 0.4, h * 0.46), a, radius: w * 0.15);
        c.drawCircle(Offset(r.center.dx, r.top + h * 0.2), w * 0.16, Pk.fill(a));
        c.drawCircle(Offset(r.center.dx - w * 0.05, r.top + h * 0.16), w * 0.05, Pk.fill(Pk.light(a, 0.4)));
      case PK.lamppost:
        c.drawRect(Rect.fromLTWH(r.center.dx - w * 0.08, r.top + h * 0.15, w * 0.16, h * 0.85), Pk.fill(const Color(0xFF3B3452)));
        Pk.glow(c, Offset(r.center.dx, r.top + h * 0.1), w * 1.4, b, 0.6);
        Pk.box(c, Rect.fromCenter(center: Offset(r.center.dx, r.top + h * 0.1), width: w * 0.6, height: h * 0.16), b, radius: 3, outline: const Color(0xFF3B3452), ow: 1.5);
      case PK.bench:
        Pk.shadow(c, r.bottomCenter, w * 1.1, h * 0.12);
        final leg = Pk.fill(const Color(0xFF4A3A33));
        c.drawRect(Rect.fromLTWH(r.left + w * 0.06, r.top + h * 0.5, w * 0.06, h * 0.5), leg);
        c.drawRect(Rect.fromLTWH(r.right - w * 0.12, r.top + h * 0.5, w * 0.06, h * 0.5), leg);
        Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.45, w, h * 0.14), a, radius: 2);
        Pk.box(c, Rect.fromLTWH(r.left, r.top, w, h * 0.14), a, radius: 2);
        Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.2, w, h * 0.12), a, radius: 2);
      case PK.haybale:
        Pk.shadow(c, r.bottomCenter, w, h * 0.1);
        Pk.box(c, r, a, bottom: Pk.dark(a, 0.2), radius: h * 0.25, outline: Pk.dark(a, 0.35));
        for (var i = 1; i < 4; i++) {
          c.drawLine(Offset(r.left + w * i / 4, r.top + 2), Offset(r.left + w * i / 4, r.bottom - 2), Pk.stroke(Pk.dark(a, 0.25), 1.2));
        }
        c.drawLine(Offset(r.left, r.center.dy), Offset(r.right, r.center.dy), Pk.stroke(b, 2));
      case PK.crops:
        for (var row = 0; row < 3; row++) {
          final y = r.top + h * (0.35 + row * 0.3);
          c.drawLine(Offset(r.left, y), Offset(r.right, y), Pk.stroke(const Color(0xFF8A5E3A), h * 0.12));
          for (var i = 0; i < 7; i++) {
            final x = r.left + w * (i + 0.5) / 7 + sin(t * 1.5 + i) * 1.2;
            c.drawLine(Offset(x, y), Offset(x, y - h * 0.28), Pk.stroke(a, 1.6));
            c.drawOval(Rect.fromCenter(center: Offset(x, y - h * 0.3), width: w * 0.04, height: h * 0.12), Pk.fill(b));
          }
        }
      case PK.cart:
        Pk.shadow(c, r.bottomCenter, w, h * 0.1);
        Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.2, w * 0.8, h * 0.45), a, radius: 2, outline: Pk.dark(a, 0.35));
        c.drawLine(Offset(r.left + w * 0.8, r.top + h * 0.45), Offset(r.right, r.top + h * 0.3), Pk.stroke(Pk.dark(a, 0.35), 3));
        for (final x in [0.2, 0.62]) {
          c.drawCircle(Offset(r.left + w * x, r.bottom - h * 0.2), h * 0.2, Pk.fill(const Color(0xFF4A3A33)));
          c.drawCircle(Offset(r.left + w * x, r.bottom - h * 0.2), h * 0.08, Pk.fill(b));
        }
        for (var i = 0; i < 3; i++) {
          c.drawCircle(Offset(r.left + w * (0.2 + i * 0.22), r.top + h * 0.18), h * 0.12, Pk.fill(b));
        }
      case PK.tractor:
        Pk.shadow(c, r.bottomCenter, w, h * 0.1);
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.3, r.top + h * 0.35, w * 0.6, h * 0.35), a, radius: 4);
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.05, r.top + h * 0.1, w * 0.42, h * 0.55), a, radius: 4);
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.1, r.top + h * 0.16, w * 0.3, h * 0.24), const Color(0xFFBFEFFA), radius: 2);
        c.drawRect(Rect.fromLTWH(r.left + w * 0.72, r.top + h * 0.12, w * 0.06, h * 0.25), Pk.fill(const Color(0xFF3B3452)));
        c.drawCircle(Offset(r.left + w * 0.26, r.bottom - h * 0.28), h * 0.28, Pk.fill(const Color(0xFF2A2440)));
        c.drawCircle(Offset(r.left + w * 0.26, r.bottom - h * 0.28), h * 0.12, Pk.fill(b));
        c.drawCircle(Offset(r.right - w * 0.15, r.bottom - h * 0.16), h * 0.16, Pk.fill(const Color(0xFF2A2440)));
        c.drawCircle(Offset(r.right - w * 0.15, r.bottom - h * 0.16), h * 0.07, Pk.fill(b));
      case PK.trough:
        Pk.poly(c, [Offset(r.left, r.top + h * 0.3), Offset(r.right, r.top + h * 0.3), Offset(r.right - w * 0.1, r.bottom), Offset(r.left + w * 0.1, r.bottom)], Pk.fill(a));
        c.drawRect(Rect.fromLTWH(r.left + w * 0.04, r.top + h * 0.3, w * 0.92, h * 0.15), Pk.fill(b));
      case PK.chicken:
        final bob = sin(t * 4 + r.left) * h * 0.04;
        c.drawOval(Rect.fromLTWH(r.left, r.top + h * 0.35 + bob, w * 0.8, h * 0.5), Pk.fill(a));
        c.drawCircle(Offset(r.left + w * 0.72, r.top + h * 0.3 + bob), w * 0.2, Pk.fill(a));
        c.drawCircle(Offset(r.left + w * 0.72, r.top + h * 0.12 + bob), w * 0.08, Pk.fill(const Color(0xFFFF4A4A)));
        Pk.poly(c, [Offset(r.left + w * 0.88, r.top + h * 0.28 + bob), Offset(r.right + w * 0.05, r.top + h * 0.34 + bob), Offset(r.left + w * 0.88, r.top + h * 0.38 + bob)], Pk.fill(b));
        c.drawCircle(Offset(r.left + w * 0.76, r.top + h * 0.27 + bob), 1.2, Pk.fill(const Color(0xFF3B2A5A)));
      case PK.cow:
        Pk.shadow(c, r.bottomCenter, w, h * 0.1);
        for (final x in [0.15, 0.3, 0.65, 0.8]) {
          c.drawRect(Rect.fromLTWH(r.left + w * x, r.top + h * 0.6, w * 0.06, h * 0.4), Pk.fill(const Color(0xFF4A3A33)));
        }
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.1, r.top + h * 0.25, w * 0.75, h * 0.42), a, radius: h * 0.2);
        c.drawOval(Rect.fromLTWH(r.left + w * 0.3, r.top + h * 0.3, w * 0.2, h * 0.18), Pk.fill(b));
        c.drawOval(Rect.fromLTWH(r.left + w * 0.55, r.top + h * 0.42, w * 0.15, h * 0.14), Pk.fill(b));
        c.drawOval(Rect.fromLTWH(r.left + w * 0.78, r.top + h * 0.12, w * 0.22, h * 0.3), Pk.fill(a));
        c.drawOval(Rect.fromLTWH(r.left + w * 0.84, r.top + h * 0.3, w * 0.14, h * 0.1), Pk.fill(const Color(0xFFFFB3C7)));
      case PK.nestbox:
        Pk.box(c, r, a, radius: 2, outline: Pk.dark(a, 0.35));
        for (var i = 0; i < 2; i++) {
          final cell = Rect.fromLTWH(r.left + w * (0.06 + i * 0.48), r.top + h * 0.2, w * 0.42, h * 0.65);
          c.drawRect(cell, Pk.fill(Pk.dark(a, 0.35)));
          c.drawOval(Rect.fromLTWH(cell.left, cell.bottom - h * 0.25, cell.width, h * 0.25), Pk.fill(const Color(0xFFE8C66B)));
          c.drawOval(Rect.fromCenter(center: Offset(cell.center.dx, cell.bottom - h * 0.18), width: w * 0.12, height: h * 0.2), Pk.fill(b));
        }
      case PK.umbrella:
        c.drawLine(Offset(r.center.dx, r.top + h * 0.2), Offset(r.center.dx, r.bottom), Pk.stroke(const Color(0xFF8A839B), 2));
        final canopy = Path()
          ..moveTo(r.left, r.top + h * 0.35)
          ..quadraticBezierTo(r.center.dx, r.top - h * 0.1, r.right, r.top + h * 0.35)
          ..close();
        c.drawPath(canopy, Pk.fill(a));
        for (var i = 1; i < 4; i += 2) {
          final x0 = r.left + w * i / 4;
          c.drawPath(
            Path()
              ..moveTo(r.center.dx, r.top + h * 0.05)
              ..lineTo(x0 - w * 0.12, r.top + h * 0.35)
              ..lineTo(x0 + w * 0.12, r.top + h * 0.35)
              ..close(),
            Pk.fill(b),
          );
        }
      case PK.lounger:
        Pk.shadow(c, r.bottomCenter, w, h * 0.12);
        c.drawRect(Rect.fromLTWH(r.left + w * 0.08, r.top + h * 0.6, w * 0.05, h * 0.4), Pk.fill(const Color(0xFF8A839B)));
        c.drawRect(Rect.fromLTWH(r.right - w * 0.13, r.top + h * 0.6, w * 0.05, h * 0.4), Pk.fill(const Color(0xFF8A839B)));
        Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.5, w * 0.72, h * 0.16), a, radius: 3);
        Pk.poly(c, [Offset(r.left + w * 0.7, r.top + h * 0.6), Offset(r.right, r.top), Offset(r.right, r.top + h * 0.18), Offset(r.left + w * 0.76, r.top + h * 0.66)], Pk.fill(a));
        c.drawRect(Rect.fromLTWH(r.left + w * 0.05, r.top + h * 0.5, w * 0.2, h * 0.16), Pk.fill(b));
      case PK.surfboard:
        final board = RRect.fromRectAndRadius(r, Radius.circular(w * 0.5));
        c.drawRRect(board, Pk.fill(a));
        c.drawRect(Rect.fromLTWH(r.center.dx - w * 0.08, r.top + h * 0.1, w * 0.16, h * 0.8), Pk.fill(b));
      case PK.kayak:
        c.drawOval(r, Pk.fill(a));
        c.drawOval(Rect.fromCenter(center: r.center, width: w * 0.3, height: h * 0.5), Pk.fill(Pk.dark(a, 0.4)));
        c.drawLine(r.centerLeft + Offset(w * 0.1, -h * 0.4), r.centerRight + Offset(-w * 0.1, h * 0.6), Pk.stroke(b, 2.5));
      case PK.shoreline:
        for (var i = 0; i < 3; i++) {
          final y = r.top + h * i / 3 + sin(t + i) * 2;
          final p = Path()..moveTo(r.left, y);
          for (var x = 0.0; x <= w; x += w / 8) {
            p.quadraticBezierTo(r.left + x + w / 16, y - 4, r.left + x + w / 8, y);
          }
          c.drawPath(p, Pk.stroke(Colors.white.withValues(alpha: 0.85 - i * 0.2), 2.5));
        }
      case PK.sandcastle:
        Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.45, w, h * 0.55), a, radius: 2);
        for (var i = 0; i < 3; i++) {
          final x = r.left + w * (0.1 + i * 0.32);
          Pk.box(c, Rect.fromLTWH(x, r.top + h * 0.15, w * 0.2, h * 0.4), Pk.light(a, 0.08), radius: 1);
        }
        c.drawLine(Offset(r.center.dx, r.top + h * 0.15), Offset(r.center.dx, r.top - h * 0.1), Pk.stroke(const Color(0xFF3B3452), 1));
        Pk.poly(c, [Offset(r.center.dx, r.top - h * 0.1), Offset(r.center.dx + w * 0.2, r.top - h * 0.02), Offset(r.center.dx, r.top + h * 0.05)], Pk.fill(b));
      case PK.beachball:
        final cc = r.center;
        final rad = min(w, h) / 2;
        c.drawCircle(cc, rad, Pk.fill(Colors.white));
        for (var i = 0; i < 3; i++) {
          c.drawArc(Rect.fromCircle(center: cc, radius: rad), i * 2 * pi / 3, pi / 3, true, Pk.fill(i == 0 ? a : (i == 1 ? b : const Color(0xFF45A7F5))));
        }
      case PK.poolWater:
        final rr = RRect.fromRectAndRadius(r, Radius.circular(h * 0.25));
        c.drawRRect(rr, Pk.fill(Colors.white));
        c.drawRRect(rr.deflate(3), Pk.fill(a));
        for (var i = 0; i < 4; i++) {
          final y = r.top + h * (0.25 + i * 0.18);
          c.drawLine(Offset(r.left + w * 0.1 + sin(t + i) * 4, y), Offset(r.left + w * 0.4 + sin(t + i) * 4, y), Pk.stroke(Colors.white.withValues(alpha: 0.6), 1.5));
        }
        c.drawLine(Offset(r.right - w * 0.1, r.top - h * 0.1), Offset(r.right - w * 0.1, r.top + h * 0.3), Pk.stroke(b, 2));
        c.drawLine(Offset(r.right - w * 0.05, r.top - h * 0.1), Offset(r.right - w * 0.05, r.top + h * 0.3), Pk.stroke(b, 2));
      case PK.hotTub:
        c.drawOval(r, Pk.fill(const Color(0xFFD9D2C3)));
        c.drawOval(r.deflate(4), Pk.fill(a));
        for (var i = 0; i < 6; i++) {
          c.drawCircle(Offset(r.left + w * (0.2 + Pk.rand(i) * 0.6), r.center.dy + sin(t * 3 + i) * 3), 2.5, Pk.fill(Colors.white.withValues(alpha: 0.8)));
        }
        Pk.glow(c, r.center, w * 0.6, b, 0.25);
      case PK.towels:
        for (var i = 0; i < 4; i++) {
          Pk.box(c, Rect.fromLTWH(r.left, r.bottom - h * (i + 1) / 4, w, h / 4 - 1), i.isEven ? a : b, radius: 3);
        }
      case PK.stringLights:
        final p = Path()..moveTo(r.left, r.top);
        p.quadraticBezierTo(r.center.dx, r.bottom, r.right, r.top);
        c.drawPath(p, Pk.stroke(const Color(0xFF3B3452), 1));
        for (var i = 1; i < 10; i++) {
          final k = i / 10;
          final x = r.left + w * k;
          final y = r.top + (r.height) * 4 * k * (1 - k) * 0.5;
          final tw = 0.6 + 0.4 * sin(t * 3 + i);
          final col = [a, b, const Color(0xFF9CF0FF)][i % 3];
          Pk.glow(c, Offset(x, y + 2), 6, col, 0.6 * tw);
          c.drawCircle(Offset(x, y + 2), 1.8, Pk.fill(col));
        }
      case PK.railing:
        c.drawRect(Rect.fromLTWH(r.left, r.top, w, h * 0.12), Pk.fill(a));
        c.drawRect(Rect.fromLTWH(r.left, r.top + h * 0.12, w, h * 0.88), Pk.fill(b.withValues(alpha: 0.35)));
        for (var i = 0; i <= 6; i++) {
          c.drawRect(Rect.fromLTWH(r.left + w * i / 6 - 1, r.top, 2, h), Pk.fill(a));
        }
      case PK.planter:
        Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.55, w, h * 0.45), a, radius: 2);
        Pk.bushy(c, Rect.fromLTWH(r.left, r.top, w, h * 0.65), b);
      case PK.tikiBar:
        Pk.shadow(c, r.bottomCenter, w, h * 0.1);
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.05, r.top + h * 0.5, w * 0.9, h * 0.5), a, radius: 2);
        for (var i = 0; i < 6; i++) {
          c.drawLine(Offset(r.left + w * (0.1 + i * 0.16), r.top + h * 0.52), Offset(r.left + w * (0.1 + i * 0.16), r.bottom), Pk.stroke(Pk.dark(a, 0.25), 1.2));
        }
        c.drawRect(Rect.fromLTWH(r.left + w * 0.08, r.top + h * 0.12, w * 0.04, h * 0.4), Pk.fill(Pk.dark(a, 0.3)));
        c.drawRect(Rect.fromLTWH(r.right - w * 0.12, r.top + h * 0.12, w * 0.04, h * 0.4), Pk.fill(Pk.dark(a, 0.3)));
        Pk.poly(c, [Offset(r.left - w * 0.05, r.top + h * 0.25), Offset(r.center.dx, r.top), Offset(r.right + w * 0.05, r.top + h * 0.25)], Pk.fill(b));
      // ---------------------------------------------------------------- indoor
      case PK.window:
        Pk.box(c, r.inflate(3), a, radius: 3);
        Pk.gradientRect(c, r, const Color(0xFF8ED8FF), Pk.light(b, 0.4));
        c.drawOval(Rect.fromLTWH(r.left - 4, r.bottom - h * 0.3, w * 0.7, h * 0.4), Pk.fill(const Color(0xFF7CCB5A)));
        c.drawLine(r.topCenter, r.bottomCenter, Pk.stroke(a, 2.5));
        c.drawLine(r.centerLeft, r.centerRight, Pk.stroke(a, 2.5));
        c.drawLine(r.topLeft + Offset(w * 0.15, h * 0.4), r.topLeft + Offset(w * 0.35, h * 0.12), Pk.stroke(Colors.white.withValues(alpha: 0.6), 2));
      case PK.curtains:
        for (final d in [0, 1]) {
          final x = d == 0 ? r.left : r.right - w * 0.28;
          final path = Path()
            ..moveTo(x, r.top)
            ..lineTo(x + w * 0.28, r.top)
            ..quadraticBezierTo(x + w * (d == 0 ? 0.12 : 0.16), r.center.dy, x + w * (d == 0 ? 0.24 : 0.04), r.bottom)
            ..lineTo(x + (d == 0 ? 0 : w * 0.28), r.bottom)
            ..close();
          c.drawPath(path, Pk.fill(a));
          c.drawPath(path, Pk.stroke(Pk.dark(a, 0.25), 1));
        }
        c.drawRect(Rect.fromLTWH(r.left - 3, r.top - 3, w + 6, 3), Pk.fill(b));
      case PK.painting:
        Pk.box(c, r, b, radius: 1, outline: a, ow: 3);
        c.drawCircle(Offset(r.left + w * 0.7, r.top + h * 0.3), h * 0.12, Pk.fill(const Color(0xFFFFD447)));
        Pk.poly(c, [Offset(r.left + 3, r.bottom - 3), Offset(r.left + w * 0.4, r.top + h * 0.4), Offset(r.right - 3, r.bottom - 3)], Pk.fill(Pk.dark(b, 0.35)));
      case PK.shelf:
        c.drawRect(Rect.fromLTWH(r.left, r.bottom - h * 0.12, w, h * 0.12), Pk.fill(a));
        final n = max(3, (w / 8).round());
        for (var i = 0; i < n; i++) {
          final bh = h * (0.5 + Pk.rand(i + r.left.toInt()) * 0.35);
          final col = [b, const Color(0xFF45A7F5), const Color(0xFFFFC93C), const Color(0xFF5BCB4B)][i % 4];
          if (i % 3 == 2) {
            c.drawCircle(Offset(r.left + w * (i + 0.5) / n, r.bottom - h * 0.12 - bh * 0.35), bh * 0.32, Pk.fill(col));
          } else {
            c.drawRect(Rect.fromLTWH(r.left + w * i / n + 1, r.bottom - h * 0.12 - bh, w / n - 2, bh), Pk.fill(col));
          }
        }
      case PK.bookshelf:
        Pk.box(c, r, a, radius: 2, outline: Pk.dark(a, 0.35));
        for (var s = 0; s < 3; s++) {
          final y = r.top + h * (s + 1) / 3.2;
          c.drawRect(Rect.fromLTWH(r.left + 3, y, w - 6, 2.5), Pk.fill(Pk.dark(a, 0.3)));
          for (var i = 0; i < 6; i++) {
            final bh = h * 0.2 * (0.7 + Pk.rand(s * 9 + i) * 0.3);
            c.drawRect(Rect.fromLTWH(r.left + 4 + i * (w - 8) / 6, y - bh, (w - 8) / 6 - 1, bh), Pk.fill([b, const Color(0xFF45A7F5), const Color(0xFFFFC93C)][(i + s) % 3]));
          }
        }
      case PK.cabinet:
        Pk.box(c, r, a, radius: 3, outline: Pk.dark(a, 0.3));
        Pk.box(c, Rect.fromLTWH(r.left + 3, r.top + 3, w / 2 - 4.5, h - 6), Pk.light(a, 0.12), radius: 2);
        Pk.box(c, Rect.fromLTWH(r.center.dx + 1.5, r.top + 3, w / 2 - 4.5, h - 6), Pk.light(a, 0.12), radius: 2);
        c.drawCircle(Offset(r.center.dx - 4, r.center.dy), 1.8, Pk.fill(b));
        c.drawCircle(Offset(r.center.dx + 4, r.center.dy), 1.8, Pk.fill(b));
      case PK.counter:
        Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.15, w, h * 0.85), a, radius: 2, outline: Pk.dark(a, 0.3));
        Pk.box(c, Rect.fromLTWH(r.left - 3, r.top, w + 6, h * 0.16), b, radius: 2);
        for (var i = 0; i < 3; i++) {
          c.drawRect(Rect.fromLTWH(r.left + w * (0.05 + i * 0.32), r.top + h * 0.3, w * 0.27, h * 0.6), Pk.fill(Pk.light(a, 0.1)));
        }
      case PK.stove:
        Pk.box(c, r, a, radius: 3);
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.12, r.top + h * 0.35, w * 0.76, h * 0.45), const Color(0xFF3B3452), radius: 3);
        Pk.glow(c, Offset(r.center.dx, r.top + h * 0.58), w * 0.4, const Color(0xFFFF9A3C), 0.4);
        for (final x in [0.3, 0.7]) {
          c.drawOval(Rect.fromCenter(center: Offset(r.left + w * x, r.top + h * 0.08), width: w * 0.3, height: h * 0.08), Pk.stroke(b, 1.5));
        }
        c.drawOval(Rect.fromLTWH(r.left + w * 0.15, r.top - h * 0.22, w * 0.32, h * 0.26), Pk.fill(const Color(0xFF8A839B)));
      case PK.fridge:
        Pk.box(c, r, a, radius: w * 0.18, outline: Pk.dark(a, 0.25), ow: 1.5);
        c.drawLine(Offset(r.left + 2, r.top + h * 0.38), Offset(r.right - 2, r.top + h * 0.38), Pk.stroke(Pk.dark(a, 0.25), 1.5));
        c.drawRect(Rect.fromLTWH(r.left + w * 0.12, r.top + h * 0.12, w * 0.08, h * 0.18), Pk.fill(b));
        c.drawRect(Rect.fromLTWH(r.left + w * 0.12, r.top + h * 0.46, w * 0.08, h * 0.25), Pk.fill(b));
      case PK.table:
        Pk.shadow(c, r.bottomCenter, w, h * 0.12);
        c.drawRect(Rect.fromLTWH(r.left + w * 0.08, r.top + h * 0.2, w * 0.06, h * 0.8), Pk.fill(Pk.dark(a, 0.3)));
        c.drawRect(Rect.fromLTWH(r.right - w * 0.14, r.top + h * 0.2, w * 0.06, h * 0.8), Pk.fill(Pk.dark(a, 0.3)));
        Pk.box(c, Rect.fromLTWH(r.left, r.top, w, h * 0.22), a, radius: 3);
        c.drawCircle(Offset(r.center.dx, r.top - h * 0.12), h * 0.12, Pk.fill(b));
      case PK.roundTable:
        Pk.shadow(c, r.bottomCenter, w, h * 0.14);
        c.drawRect(Rect.fromLTWH(r.center.dx - w * 0.05, r.top + h * 0.2, w * 0.1, h * 0.8), Pk.fill(const Color(0xFF6E6A78)));
        final cloth = Path()
          ..moveTo(r.left, r.top + h * 0.15)
          ..quadraticBezierTo(r.center.dx, r.top - h * 0.1, r.right, r.top + h * 0.15)
          ..lineTo(r.right - w * 0.05, r.top + h * 0.55)
          ..lineTo(r.left + w * 0.05, r.top + h * 0.55)
          ..close();
        c.drawPath(cloth, Pk.fill(a));
        Pk.flower(c, Offset(r.center.dx, r.top - h * 0.05), h / 18, b);
      case PK.chair:
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.15, r.top, w * 0.7, h * 0.55), a, radius: 3);
        Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.5, w, h * 0.16), a, radius: 2);
        c.drawRect(Rect.fromLTWH(r.left + w * 0.08, r.top + h * 0.66, w * 0.1, h * 0.34), Pk.fill(Pk.dark(a, 0.3)));
        c.drawRect(Rect.fromLTWH(r.right - w * 0.18, r.top + h * 0.66, w * 0.1, h * 0.34), Pk.fill(Pk.dark(a, 0.3)));
        c.drawRect(Rect.fromLTWH(r.left + w * 0.3, r.top + h * 0.12, w * 0.4, h * 0.08), Pk.fill(b));
      case PK.sofa:
        Pk.shadow(c, r.bottomCenter, w, h * 0.12);
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.06, r.top, w * 0.88, h * 0.55), a, radius: h * 0.2);
        Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.35, w * 0.14, h * 0.5), Pk.dark(a, 0.08), radius: h * 0.15);
        Pk.box(c, Rect.fromLTWH(r.right - w * 0.14, r.top + h * 0.35, w * 0.14, h * 0.5), Pk.dark(a, 0.08), radius: h * 0.15);
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.12, r.top + h * 0.48, w * 0.76, h * 0.3), Pk.light(a, 0.1), radius: 4);
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.18, r.top + h * 0.22, w * 0.2, h * 0.26), b, radius: 4);
        Pk.box(c, Rect.fromLTWH(r.right - w * 0.38, r.top + h * 0.22, w * 0.2, h * 0.26), b, radius: 4);
      case PK.bed:
        Pk.shadow(c, r.bottomCenter, w, h * 0.12);
        Pk.box(c, Rect.fromLTWH(r.left, r.top, w * 0.12, h), Pk.dark(a, 0.2), radius: 3);
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.08, r.top + h * 0.4, w * 0.92, h * 0.45), Colors.white, radius: 4);
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.35, r.top + h * 0.36, w * 0.65, h * 0.5), b, radius: 4);
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.13, r.top + h * 0.28, w * 0.2, h * 0.2), Colors.white, radius: 4);
        c.drawRect(Rect.fromLTWH(r.left + w * 0.08, r.bottom - h * 0.15, w * 0.92, h * 0.15), Pk.fill(a));
      case PK.wardrobe:
        Pk.box(c, r, a, radius: 3, outline: Pk.dark(a, 0.35));
        c.drawLine(r.topCenter + const Offset(0, 3), r.bottomCenter - const Offset(0, 3), Pk.stroke(Pk.dark(a, 0.35), 1.5));
        c.drawCircle(Offset(r.center.dx - 3, r.center.dy), 1.8, Pk.fill(b));
        c.drawCircle(Offset(r.center.dx + 3, r.center.dy), 1.8, Pk.fill(b));
        Pk.box(c, Rect.fromLTWH(r.left - 2, r.top - 4, w + 4, 5), Pk.dark(a, 0.2), radius: 2);
      case PK.rug:
        c.drawOval(r, Pk.fill(a));
        c.drawOval(r.deflate(min(w, h) * 0.18), Pk.stroke(b, 2.5));
      case PK.floorLamp:
        Pk.glow(c, Offset(r.center.dx, r.top + h * 0.12), w * 2, const Color(0xFFFFD68A), 0.5);
        c.drawRect(Rect.fromLTWH(r.center.dx - 1.2, r.top + h * 0.2, 2.4, h * 0.8), Pk.fill(const Color(0xFF3B3452)));
        c.drawOval(Rect.fromCenter(center: r.bottomCenter, width: w * 0.7, height: h * 0.05), Pk.fill(const Color(0xFF3B3452)));
        Pk.poly(c, [Offset(r.left + w * 0.2, r.top), Offset(r.right - w * 0.2, r.top), Offset(r.right, r.top + h * 0.22), Offset(r.left, r.top + h * 0.22)], Pk.fill(a));
      case PK.pendant:
        c.drawLine(r.topCenter, Offset(r.center.dx, r.top + h * 0.6), Pk.stroke(const Color(0xFF3B3452), 1));
        Pk.glow(c, Offset(r.center.dx, r.bottom), w * 1.6, const Color(0xFFFFE3A0), 0.55);
        Pk.poly(c, [Offset(r.center.dx - w * 0.2, r.top + h * 0.6), Offset(r.center.dx + w * 0.2, r.top + h * 0.6), Offset(r.right, r.bottom), Offset(r.left, r.bottom)], Pk.fill(a));
      case PK.chandelier:
        c.drawLine(r.topCenter, Offset(r.center.dx, r.top + h * 0.3), Pk.stroke(b, 1.2));
        Pk.glow(c, r.center + Offset(0, h * 0.2), w * 0.9, const Color(0xFFFFE9A0), 0.6);
        c.drawArc(Rect.fromLTWH(r.left, r.top + h * 0.2, w, h * 0.6), 0, pi, false, Pk.stroke(b, 2));
        for (var i = 0; i < 5; i++) {
          final x = r.left + w * (0.1 + i * 0.2);
          c.drawLine(Offset(x, r.top + h * 0.45), Offset(x, r.top + h * 0.3), Pk.stroke(b, 1.5));
          c.drawCircle(Offset(x, r.top + h * 0.26), 2.2, Pk.fill(const Color(0xFFFFF4C2)));
          final tw = 0.6 + 0.4 * sin(t * 2 + i);
          Pk.sparkle(c, Offset(x, r.top + h * 0.7), 2.5 * tw, a);
        }
      case PK.plant:
        Pk.plant(c, r.bottomCenter, h / 32, pot: a);
      case PK.screen:
        Pk.box(c, r.inflate(3), const Color(0xFF14111F), radius: 3);
        Pk.gradientRect(c, r, a, b);
        c.drawCircle(Offset(r.left + w * 0.7, r.top + h * 0.35), h * 0.14, Pk.fill(const Color(0xFFFFE066)));
        Pk.glow(c, r.center, w * 0.8, a, 0.25);
      case PK.fireplace:
        Pk.box(c, r, a, radius: 3, outline: Pk.dark(a, 0.3));
        Pk.box(c, Rect.fromLTWH(r.left - 4, r.top, w + 8, h * 0.12), Pk.dark(a, 0.15), radius: 2);
        final hole = Rect.fromLTWH(r.left + w * 0.2, r.top + h * 0.35, w * 0.6, h * 0.65);
        c.drawRRect(RRect.fromRectAndCorners(hole, topLeft: Radius.circular(w * 0.3), topRight: Radius.circular(w * 0.3)), Pk.fill(const Color(0xFF2A221D)));
        for (var i = 0; i < 3; i++) {
          final fh = h * (0.25 + 0.08 * sin(t * 6 + i * 2));
          Pk.poly(c, [Offset(hole.left + hole.width * (0.2 + i * 0.3), hole.bottom), Offset(hole.left + hole.width * (0.35 + i * 0.3) - hole.width * 0.15, hole.bottom - fh), Offset(hole.left + hole.width * (0.5 + i * 0.3) - hole.width * 0.3, hole.bottom)], Pk.fill(i == 1 ? b : const Color(0xFFFF7A3C)));
        }
        Pk.glow(c, hole.center, w * 0.6, const Color(0xFFFF9A3C), 0.35);
      case PK.piano:
        Pk.shadow(c, r.bottomCenter, w, h * 0.12);
        final body = Path()
          ..moveTo(r.left, r.top + h * 0.2)
          ..lineTo(r.left + w * 0.5, r.top + h * 0.2)
          ..quadraticBezierTo(r.right, r.top + h * 0.1, r.right, r.top + h * 0.45)
          ..lineTo(r.left, r.top + h * 0.55)
          ..close();
        c.drawPath(body, Pk.fill(a));
        c.drawRect(Rect.fromLTWH(r.left, r.top + h * 0.45, w * 0.55, h * 0.1), Pk.fill(Colors.white));
        for (var i = 1; i < 8; i++) {
          c.drawLine(Offset(r.left + w * 0.55 * i / 8, r.top + h * 0.45), Offset(r.left + w * 0.55 * i / 8, r.top + h * 0.55), Pk.stroke(const Color(0xFF3B3452), 0.8));
        }
        for (final x in [0.08, 0.5, 0.9]) {
          c.drawRect(Rect.fromLTWH(r.left + w * x - 1.5, r.top + h * 0.5, 3, h * 0.5), Pk.fill(a));
        }
        c.drawLine(Offset(r.left + w * 0.5, r.top + h * 0.2), Offset(r.left + w * 0.7, r.top - h * 0.1), Pk.stroke(b, 1.5));
      case PK.barCounter:
        Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.2, w, h * 0.8), a, radius: 3, outline: Pk.dark(a, 0.35));
        Pk.box(c, Rect.fromLTWH(r.left - 3, r.top + h * 0.12, w + 6, h * 0.12), b, radius: 2);
        for (var i = 0; i < 4; i++) {
          final x = r.left + w * (0.12 + i * 0.25);
          c.drawCircle(Offset(x, r.bottom + h * 0.05), w * 0.05, Pk.fill(const Color(0xFF3B3452)));
        }
      case PK.bottleShelf:
        c.drawRect(Rect.fromLTWH(r.left, r.bottom - 3, w, 3), Pk.fill(a));
        c.drawRect(Rect.fromLTWH(r.left, r.top + h * 0.45, w, 3), Pk.fill(a));
        for (var row = 0; row < 2; row++) {
          final base = row == 0 ? r.top + h * 0.45 : r.bottom - 3;
          for (var i = 0; i < 6; i++) {
            final x = r.left + 3 + i * (w - 6) / 6;
            final col = [b, const Color(0xFF5BCB4B), const Color(0xFFFFC93C), const Color(0xFF45A7F5)][(i + row) % 4];
            c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(x, base - h * 0.35, (w - 6) / 6 - 2, h * 0.35), const Radius.circular(2)), Pk.fill(col));
          }
        }
      case PK.wineRack:
        Pk.box(c, r, a, radius: 2, outline: Pk.dark(a, 0.35));
        for (var y = 0; y < 4; y++) {
          for (var x = 0; x < 4; x++) {
            c.drawCircle(Offset(r.left + w * (x + 0.5) / 4, r.top + h * (y + 0.5) / 4), min(w, h) * 0.08, Pk.fill(y.isEven ? b : const Color(0xFF3B2A5A)));
          }
        }
      case PK.menuBoard:
        Pk.box(c, r, const Color(0xFF2E3A33), radius: 2, outline: a, ow: 3);
        for (var i = 0; i < 4; i++) {
          c.drawLine(Offset(r.left + w * 0.15, r.top + h * (0.25 + i * 0.18)), Offset(r.left + w * (0.6 + Pk.rand(i) * 0.25), r.top + h * (0.25 + i * 0.18)), Pk.stroke(i == 0 ? b : Colors.white.withValues(alpha: 0.8), 1.4));
        }
      case PK.door:
        Pk.box(c, r.inflate(3), Pk.dark(a, 0.25), radius: w * 0.5);
        c.drawRRect(RRect.fromRectAndCorners(r, topLeft: Radius.circular(w * 0.5), topRight: Radius.circular(w * 0.5)), Pk.fill(a));
        c.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(r.left + w * 0.2, r.top + h * 0.12, w * 0.6, h * 0.3), topLeft: Radius.circular(w * 0.3), topRight: Radius.circular(w * 0.3)), Pk.fill(const Color(0xFFBFEFFA)));
        c.drawCircle(Offset(r.right - w * 0.18, r.center.dy + h * 0.1), 2, Pk.fill(b));
      case PK.awning:
        final n = 6;
        for (var i = 0; i < n; i++) {
          final x = r.left + w * i / n;
          Pk.poly(c, [Offset(x, r.top), Offset(x + w / n, r.top), Offset(x + w / n, r.bottom - h * 0.2), Offset(x + w / n / 2, r.bottom), Offset(x, r.bottom - h * 0.2)], Pk.fill(i.isEven ? a : b));
        }
      case PK.podium:
        Pk.poly(c, [Offset(r.left + w * 0.15, r.top + h * 0.2), Offset(r.right - w * 0.15, r.top + h * 0.2), Offset(r.right, r.bottom), Offset(r.left, r.bottom)], Pk.fill(a));
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.05, r.top, w * 0.9, h * 0.22), Pk.dark(a, 0.15), radius: 2);
        c.drawRect(Rect.fromLTWH(r.left + w * 0.3, r.top + h * 0.03, w * 0.4, h * 0.14), Pk.fill(b));
      case PK.workbench:
        Pk.shadow(c, r.bottomCenter, w, h * 0.1);
        c.drawRect(Rect.fromLTWH(r.left + w * 0.05, r.top + h * 0.2, w * 0.06, h * 0.8), Pk.fill(Pk.dark(a, 0.3)));
        c.drawRect(Rect.fromLTWH(r.right - w * 0.11, r.top + h * 0.2, w * 0.06, h * 0.8), Pk.fill(Pk.dark(a, 0.3)));
        c.drawRect(Rect.fromLTWH(r.left + w * 0.05, r.top + h * 0.7, w * 0.9, h * 0.06), Pk.fill(Pk.dark(a, 0.3)));
        Pk.box(c, Rect.fromLTWH(r.left, r.top, w, h * 0.22), a, radius: 2);
        Pk.box(c, Rect.fromLTWH(r.right - w * 0.25, r.top - h * 0.18, w * 0.16, h * 0.2), b, radius: 2);
        c.drawLine(Offset(r.left + w * 0.2, r.top - 2), Offset(r.left + w * 0.45, r.top - 2), Pk.stroke(const Color(0xFF8A839B), 3));
      case PK.pegboard:
        Pk.box(c, r, a, radius: 2);
        for (var y = 0; y < 5; y++) {
          for (var x = 0; x < 8; x++) {
            c.drawCircle(Offset(r.left + w * (x + 0.5) / 8, r.top + h * (y + 0.5) / 5), 0.8, Pk.fill(Pk.dark(a, 0.3)));
          }
        }
        final tool = Pk.stroke(b, 2.5);
        c.drawLine(Offset(r.left + w * 0.15, r.top + h * 0.2), Offset(r.left + w * 0.15, r.top + h * 0.8), tool);
        c.drawRect(Rect.fromLTWH(r.left + w * 0.1, r.top + h * 0.15, w * 0.1, h * 0.12), Pk.fill(const Color(0xFF8A839B)));
        c.drawLine(Offset(r.left + w * 0.35, r.top + h * 0.2), Offset(r.left + w * 0.45, r.top + h * 0.8), tool);
        c.drawCircle(Offset(r.left + w * 0.65, r.top + h * 0.35), h * 0.14, Pk.stroke(const Color(0xFF8A839B), 2));
        c.drawLine(Offset(r.left + w * 0.85, r.top + h * 0.15), Offset(r.left + w * 0.85, r.top + h * 0.85), Pk.stroke(const Color(0xFF8A839B), 2));
      case PK.barrel:
        Pk.shadow(c, r.bottomCenter, w, h * 0.1);
        c.drawRRect(RRect.fromRectAndRadius(r, Radius.circular(w * 0.3)), Pk.fill(a));
        for (final y in [0.2, 0.8]) {
          c.drawRect(Rect.fromLTWH(r.left, r.top + h * y - 1.5, w, 3), Pk.fill(b));
        }
      case PK.crates:
        for (final (x, y, s) in [(0.0, 0.5, 0.5), (0.5, 0.5, 0.5), (0.25, 0.0, 0.5)]) {
          final cr = Rect.fromLTWH(r.left + w * x, r.top + h * y, w * s, h * 0.5);
          Pk.box(c, cr, a, radius: 1.5, outline: Pk.dark(a, 0.35));
          c.drawLine(cr.topLeft + const Offset(2, 2), cr.bottomRight - const Offset(2, 2), Pk.stroke(Pk.dark(a, 0.35), 1.5));
          Pk.box(c, Rect.fromCenter(center: cr.center, width: cr.width * 0.4, height: cr.height * 0.2), b, radius: 1);
        }
      case PK.machine:
        Pk.shadow(c, r.bottomCenter, w, h * 0.1);
        Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.3, w, h * 0.7), a, radius: 3, outline: Pk.dark(a, 0.35));
        c.save();
        c.translate(r.left + w * 0.3, r.top + h * 0.3);
        c.rotate(t);
        for (var i = 0; i < 8; i++) {
          c.rotate(pi / 4);
          c.drawRect(Rect.fromLTWH(-w * 0.04, -h * 0.28, w * 0.08, h * 0.08), Pk.fill(b));
        }
        c.restore();
        c.drawCircle(Offset(r.left + w * 0.3, r.top + h * 0.3), h * 0.2, Pk.fill(b));
        c.drawCircle(Offset(r.left + w * 0.3, r.top + h * 0.3), h * 0.07, Pk.fill(Pk.dark(a, 0.3)));
        c.drawCircle(Offset(r.right - w * 0.2, r.top + h * 0.55), 2.5, Pk.fill(const Color(0xFF5BCB4B)));
      case PK.toolbox:
        Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.3, w, h * 0.7), a, radius: 3, outline: Pk.dark(a, 0.35));
        c.drawArc(Rect.fromLTWH(r.left + w * 0.3, r.top, w * 0.4, h * 0.6), pi, pi, false, Pk.stroke(b, 3));
        c.drawRect(Rect.fromLTWH(r.left, r.top + h * 0.55, w, 2), Pk.fill(Pk.dark(a, 0.35)));
      case PK.stall:
        Pk.box(c, r, a, radius: 2, outline: Pk.dark(a, 0.35));
        c.drawLine(r.topLeft + const Offset(3, 3), r.bottomRight - const Offset(3, 3), Pk.stroke(Pk.dark(a, 0.3), 3));
        c.drawLine(r.topRight + const Offset(-3, 3), r.bottomLeft + const Offset(3, -3), Pk.stroke(Pk.dark(a, 0.3), 3));
        c.drawOval(Rect.fromLTWH(r.left, r.bottom - h * 0.2, w, h * 0.25), Pk.fill(b));
      case PK.lantern:
        c.drawLine(r.topCenter, Offset(r.center.dx, r.top + h * 0.3), Pk.stroke(const Color(0xFF3B3452), 1));
        Pk.glow(c, Offset(r.center.dx, r.top + h * 0.65), w * 1.8, b, 0.55);
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.2, r.top + h * 0.35, w * 0.6, h * 0.6), b, radius: 3, outline: a, ow: 2);
      case PK.cinemaSeats:
        final n = max(3, (w / 18).round());
        for (var i = 0; i < n; i++) {
          final sr = Rect.fromLTWH(r.left + w * i / n + 1, r.top, w / n - 2, h);
          Pk.box(c, Rect.fromLTWH(sr.left, sr.top, sr.width, sr.height * 0.7), a, radius: 4);
          Pk.box(c, Rect.fromLTWH(sr.left, sr.top + sr.height * 0.55, sr.width, sr.height * 0.3), Pk.dark(a, 0.15), radius: 3);
          c.drawRect(Rect.fromLTWH(sr.left + sr.width * 0.4, sr.top + sr.height * 0.85, sr.width * 0.2, sr.height * 0.15), Pk.fill(b));
        }
      case PK.projector:
        final beam = Path()
          ..moveTo(r.left + w * 0.2, r.center.dy)
          ..lineTo(r.left - w * 2.5, r.top - h * 1.5)
          ..lineTo(r.left - w * 2.5, r.bottom + h * 0.5)
          ..close();
        c.drawPath(beam, Pk.fill(b.withValues(alpha: 0.12 + 0.03 * sin(t * 5))));
        Pk.box(c, r, a, radius: 3);
        c.drawCircle(Offset(r.left + w * 0.2, r.center.dy), h * 0.25, Pk.fill(b));
      case PK.speaker:
        Pk.box(c, r, a, radius: 3);
        final pulse = 1 + 0.06 * sin(t * 8);
        c.drawCircle(Offset(r.center.dx, r.top + h * 0.28), w * 0.26, Pk.fill(Pk.dark(a, 0.4)));
        c.drawCircle(Offset(r.center.dx, r.top + h * 0.68), w * 0.34 * pulse, Pk.fill(Pk.dark(a, 0.4)));
        c.drawCircle(Offset(r.center.dx, r.top + h * 0.68), w * 0.12, Pk.fill(b));
      case PK.console:
        Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.45, w, h * 0.55), a, radius: 3);
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.15, r.top + h * 0.2, w * 0.35, h * 0.25), const Color(0xFF14111F), radius: 2);
        c.drawCircle(Offset(r.left + w * 0.45, r.top + h * 0.26), 1.5, Pk.fill(b));
        c.drawOval(Rect.fromLTWH(r.left + w * 0.58, r.top + h * 0.25, w * 0.28, h * 0.18), Pk.fill(b));
      case PK.mirror:
        c.drawOval(r.inflate(3), Pk.fill(a));
        c.drawOval(r, Pk.fill(b));
        c.drawLine(r.topLeft + Offset(w * 0.3, h * 0.35), r.topLeft + Offset(w * 0.55, h * 0.15), Pk.stroke(Colors.white.withValues(alpha: 0.8), 3));
      case PK.bathtub:
        Pk.shadow(c, r.bottomCenter, w, h * 0.12);
        c.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(r.left, r.top + h * 0.2, w, h * 0.7), bottomLeft: Radius.circular(h * 0.4), bottomRight: Radius.circular(h * 0.4)), Pk.fill(a));
        c.drawRect(Rect.fromLTWH(r.left - 2, r.top + h * 0.15, w + 4, h * 0.1), Pk.fill(Pk.light(a, 0.3)));
        for (var i = 0; i < 5; i++) {
          c.drawCircle(Offset(r.left + w * (0.15 + i * 0.18), r.top + h * 0.12 + sin(t * 2 + i)), h * 0.12, Pk.fill(Colors.white));
        }
        for (final x in [0.12, 0.88]) {
          c.drawCircle(Offset(r.left + w * x, r.bottom), h * 0.08, Pk.fill(b));
        }
      case PK.shower:
        Pk.box(c, r, b.withValues(alpha: 0.35), radius: 3, outline: Colors.white, ow: 2);
        c.drawLine(Offset(r.left + w * 0.3, r.top + h * 0.08), Offset(r.left + w * 0.6, r.top + h * 0.08), Pk.stroke(a, 2));
        for (var i = 0; i < 5; i++) {
          final y = r.top + h * (0.15 + ((t * 0.8 + i * 0.2) % 1) * 0.7);
          c.drawLine(Offset(r.left + w * (0.4 + i * 0.05), y), Offset(r.left + w * (0.4 + i * 0.05), y + 4), Pk.stroke(Colors.white.withValues(alpha: 0.7), 1));
        }
      case PK.luggage:
        Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.25, w * 0.55, h * 0.75), a, radius: 4);
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.5, r.top + h * 0.45, w * 0.5, h * 0.55), b, radius: 4);
        c.drawLine(Offset(r.left + w * 0.2, r.top + h * 0.25), Offset(r.left + w * 0.2, r.top), Pk.stroke(const Color(0xFF3B3452), 2));
        c.drawLine(Offset(r.left + w * 0.35, r.top + h * 0.25), Offset(r.left + w * 0.35, r.top), Pk.stroke(const Color(0xFF3B3452), 2));
        c.drawLine(Offset(r.left + w * 0.2, r.top), Offset(r.left + w * 0.35, r.top), Pk.stroke(const Color(0xFF3B3452), 2));
      case PK.trolley:
        Pk.shadow(c, r.bottomCenter, w, h * 0.12);
        Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.35, w, h * 0.12), Colors.white, radius: 2);
        c.drawRect(Rect.fromLTWH(r.left + w * 0.1, r.top + h * 0.45, 2, h * 0.5), Pk.fill(const Color(0xFF8A839B)));
        c.drawRect(Rect.fromLTWH(r.right - w * 0.12, r.top + h * 0.45, 2, h * 0.5), Pk.fill(const Color(0xFF8A839B)));
        c.drawArc(Rect.fromLTWH(r.left + w * 0.25, r.top, w * 0.5, h * 0.7), pi, pi, true, Pk.fill(b));
        c.drawCircle(Offset(r.center.dx, r.top + 1), 2, Pk.fill(b));
        c.drawRect(Rect.fromLTWH(r.left, r.top + h * 0.35, w, h * 0.04), Pk.fill(a));
      case PK.stairs:
        for (var i = 0; i < 6; i++) {
          final sw = w * (1 - i * 0.1);
          Pk.box(c, Rect.fromCenter(center: Offset(r.center.dx, r.bottom - h * (i + 0.5) / 6), width: sw, height: h / 6), i.isEven ? a : Pk.dark(a, 0.08), radius: 1);
        }
        c.drawRect(Rect.fromLTWH(r.center.dx - w * 0.2, r.top, w * 0.4, h), Pk.fill(b.withValues(alpha: 0.85)));
      case PK.trophyCase:
        Pk.box(c, r, a, radius: 3, outline: Pk.dark(a, 0.3));
        Pk.box(c, r.deflate(4), const Color(0xFFBFEFFA).withValues(alpha: 0.5), radius: 2);
        for (var i = 0; i < 3; i++) {
          final cx = r.left + w * (0.22 + i * 0.28);
          final cy = r.top + h * (i == 1 ? 0.35 : 0.45);
          c.drawArc(Rect.fromCenter(center: Offset(cx, cy), width: w * 0.2, height: h * 0.2), 0, pi, true, Pk.fill(b));
          c.drawRect(Rect.fromLTWH(cx - 1.5, cy + h * 0.08, 3, h * 0.12), Pk.fill(b));
        }
      case PK.vase:
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.2, r.top + h * 0.55, w * 0.6, h * 0.45), Pk.dark(a, 0.2), radius: 1);
        c.drawOval(Rect.fromLTWH(r.left + w * 0.25, r.top + h * 0.25, w * 0.5, h * 0.34), Pk.fill(a));
        Pk.flower(c, Offset(r.center.dx, r.top + h * 0.15), h / 25, b);
        Pk.flower(c, Offset(r.center.dx - w * 0.2, r.top + h * 0.22), h / 30, b);
      case PK.clock:
        Pk.box(c, r, a, radius: w * 0.3, outline: Pk.dark(a, 0.35));
        c.drawCircle(Offset(r.center.dx, r.top + w * 0.5), w * 0.35, Pk.fill(Colors.white));
        final ang = t * 0.5;
        c.drawLine(Offset(r.center.dx, r.top + w * 0.5), Offset(r.center.dx, r.top + w * 0.5) + Offset(sin(ang), -cos(ang)) * w * 0.25, Pk.stroke(const Color(0xFF3B2A5A), 1.5));
        final swing = sin(t * 2) * w * 0.15;
        c.drawLine(Offset(r.center.dx, r.top + h * 0.5), Offset(r.center.dx + swing, r.top + h * 0.85), Pk.stroke(b, 1.5));
        c.drawCircle(Offset(r.center.dx + swing, r.top + h * 0.85), w * 0.1, Pk.fill(b));
      case PK.neonSign:
        final flick = sin(t * 11) > -0.85 ? 1.0 : 0.5;
        Pk.glow(c, r.center, w * 0.8, a, 0.35 * flick);
        c.drawRRect(RRect.fromRectAndRadius(r, Radius.circular(h * 0.3)), Pk.stroke(a.withValues(alpha: flick), 2.5));
        c.drawLine(Offset(r.left + w * 0.2, r.center.dy), Offset(r.right - w * 0.2, r.center.dy), Pk.stroke(b.withValues(alpha: flick), 2.5));
      case PK.stage:
        Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.6, w, h * 0.4), a, radius: 2);
        c.drawLine(Offset(r.center.dx, r.top + h * 0.6), Offset(r.center.dx, r.top + h * 0.15), Pk.stroke(const Color(0xFF3B3452), 1.5));
        c.drawCircle(Offset(r.center.dx, r.top + h * 0.12), 3, Pk.fill(const Color(0xFF3B3452)));
        Pk.glow(c, Offset(r.center.dx, r.top + h * 0.5), w * 0.6, b, 0.35);
      case PK.champagneTower:
        for (var row = 0; row < 3; row++) {
          final n = 3 - row;
          for (var i = 0; i < n; i++) {
            final cx = r.center.dx + (i - (n - 1) / 2) * w * 0.3;
            final cy = r.bottom - h * (row + 1) * 0.3;
            Pk.poly(c, [Offset(cx - w * 0.12, cy), Offset(cx + w * 0.12, cy), Offset(cx, cy + h * 0.18)], Pk.fill(a.withValues(alpha: 0.85)));
            c.drawLine(Offset(cx, cy + h * 0.18), Offset(cx, cy + h * 0.28), Pk.stroke(Colors.white, 1));
          }
        }
        Pk.sparkle(c, r.topCenter, 4 + 2 * sin(t * 3), b);
      case PK.discoBall:
        c.drawLine(Offset(r.center.dx, r.top - 30), Offset(r.center.dx, r.top), Pk.stroke(const Color(0xFF8A839B), 1));
        c.drawCircle(r.center, w / 2, Pk.fill(const Color(0xFFC9CCD8)));
        for (var i = 0; i < 6; i++) {
          final ang = t + i;
          c.drawCircle(r.center + Offset(cos(ang) * w * 0.3, sin(i * 1.3) * h * 0.3), 2, Pk.fill(Pk.hue(t * 80 + i * 60)));
        }
        Pk.glow(c, r.center, w * 2, a, 0.25);
      case PK.sign:
        Pk.box(c, r, a, radius: h * 0.3, outline: Pk.dark(a, 0.35), ow: 2);
        c.drawLine(Offset(r.left + w * 0.15, r.center.dy), Offset(r.right - w * 0.15, r.center.dy), Pk.stroke(b, h * 0.18));
      case PK.banner:
        // Hanging pennant on a rod, gently swaying, with an emblem.
        c.drawLine(Offset(r.left, r.top + 2), Offset(r.right, r.top + 2), Pk.stroke(const Color(0xFF8B5E3C), 3));
        final sway = sin(t * 1.4 + r.left) * w * 0.04;
        Pk.poly(
          c,
          [
            Offset(r.left + w * 0.1, r.top + 3),
            Offset(r.right - w * 0.1, r.top + 3),
            Offset(r.right - w * 0.1 + sway, r.bottom),
            Offset(r.center.dx + sway, r.bottom - h * 0.16),
            Offset(r.left + w * 0.1 + sway, r.bottom),
          ],
          Pk.fill(a),
        );
        c.drawCircle(Offset(r.center.dx + sway * 0.5, r.top + h * 0.42), w * 0.18, Pk.fill(b));
        c.drawLine(Offset(r.left + w * 0.14, r.top + h * 0.12), Offset(r.right - w * 0.14, r.top + h * 0.12), Pk.stroke(Pk.light(a, 0.3), 2));
      case PK.torch:
        // Wall sconce with a flickering flame.
        Pk.box(c, Rect.fromLTWH(r.center.dx - w * 0.12, r.top + h * 0.45, w * 0.24, h * 0.55), a, radius: 2);
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.2, r.top + h * 0.38, w * 0.6, h * 0.1), Pk.dark(a, 0.2), radius: 2);
        final f = 1 + 0.12 * sin(t * 9 + r.left);
        Pk.glow(c, Offset(r.center.dx, r.top + h * 0.25), w * 2.2, b, 0.55);
        Pk.poly(c, [Offset(r.center.dx, r.top), Offset(r.center.dx + w * 0.3 * f, r.top + h * 0.36), Offset(r.center.dx - w * 0.3 * f, r.top + h * 0.36)], Pk.fill(b));
        Pk.poly(c, [Offset(r.center.dx, r.top + h * 0.12), Offset(r.center.dx + w * 0.14, r.top + h * 0.36), Offset(r.center.dx - w * 0.14, r.top + h * 0.36)], Pk.fill(Colors.white.withValues(alpha: 0.8)));
      case PK.snowman:
        Pk.shadow(c, r.bottomCenter, w, h * 0.08);
        c.drawCircle(Offset(r.center.dx, r.bottom - w * 0.36), w * 0.38, Pk.fill(a));
        c.drawCircle(Offset(r.center.dx, r.bottom - w * 0.92), w * 0.28, Pk.fill(a));
        c.drawCircle(Offset(r.center.dx, r.bottom - w * 1.34), w * 0.2, Pk.fill(a));
        Pk.box(c, Rect.fromLTWH(r.center.dx - w * 0.24, r.bottom - w * 1.16, w * 0.48, w * 0.08), b, radius: 2);
        Pk.poly(c, [Offset(r.center.dx, r.bottom - w * 1.36), Offset(r.center.dx + w * 0.22, r.bottom - w * 1.32), Offset(r.center.dx, r.bottom - w * 1.28)], Pk.fill(const Color(0xFFFF9A3C)));
        for (final dx in [-0.07, 0.07]) {
          c.drawCircle(Offset(r.center.dx + w * dx, r.bottom - w * 1.4), w * 0.03, Pk.fill(const Color(0xFF3B3452)));
        }
        Pk.box(c, Rect.fromLTWH(r.center.dx - w * 0.16, r.bottom - w * 1.72, w * 0.32, w * 0.22), const Color(0xFF3B3452), radius: 2);
      case PK.sailboat:
        final bob = sin(t * 1.5 + r.left) * h * 0.03;
        final hull = Path()
          ..moveTo(r.left, r.top + h * 0.7 + bob)
          ..lineTo(r.right, r.top + h * 0.7 + bob)
          ..lineTo(r.right - w * 0.15, r.bottom + bob)
          ..lineTo(r.left + w * 0.12, r.bottom + bob)
          ..close();
        c.drawPath(hull, Pk.fill(a));
        c.drawLine(Offset(r.left + w * 0.05, r.top + h * 0.78 + bob), Offset(r.right - w * 0.05, r.top + h * 0.78 + bob), Pk.stroke(Pk.light(a, 0.4), 2));
        c.drawLine(Offset(r.center.dx, r.top + bob), Offset(r.center.dx, r.top + h * 0.7 + bob), Pk.stroke(const Color(0xFF8B5E3C), 2));
        Pk.poly(c, [Offset(r.center.dx + 2, r.top + bob), Offset(r.right - w * 0.08, r.top + h * 0.62 + bob), Offset(r.center.dx + 2, r.top + h * 0.62 + bob)], Pk.fill(b));
        Pk.poly(c, [Offset(r.center.dx - 2, r.top + h * 0.15 + bob), Offset(r.left + w * 0.12, r.top + h * 0.62 + bob), Offset(r.center.dx - 2, r.top + h * 0.62 + bob)], Pk.fill(Pk.light(b, 0.15)));
      case PK.anchor:
        final ink = Pk.stroke(a, w * 0.12)..strokeCap = StrokeCap.round;
        c.drawCircle(Offset(r.center.dx, r.top + h * 0.12), w * 0.12, Pk.stroke(a, w * 0.08));
        c.drawLine(Offset(r.center.dx, r.top + h * 0.22), Offset(r.center.dx, r.bottom - h * 0.06), ink);
        c.drawLine(Offset(r.left + w * 0.2, r.top + h * 0.34), Offset(r.right - w * 0.2, r.top + h * 0.34), ink);
        final arc = Path()
          ..moveTo(r.left + w * 0.08, r.top + h * 0.62)
          ..quadraticBezierTo(r.center.dx, r.bottom + h * 0.08, r.right - w * 0.08, r.top + h * 0.62);
        c.drawPath(arc, ink..style = PaintingStyle.stroke);
        c.drawCircle(Offset(r.center.dx, r.top + h * 0.12), w * 0.05, Pk.fill(b));
      case PK.column:
        Pk.box(c, Rect.fromLTWH(r.left, r.bottom - h * 0.08, w, h * 0.08), Pk.dark(a, 0.1), radius: 1);
        Pk.box(c, Rect.fromLTWH(r.left, r.top, w, h * 0.08), Pk.dark(a, 0.1), radius: 1);
        Pk.box(c, Rect.fromLTWH(r.left + w * 0.14, r.top + h * 0.08, w * 0.72, h * 0.84), a, radius: 1);
        for (var i = 1; i < 4; i++) {
          final x = r.left + w * 0.14 + w * 0.72 * i / 4;
          c.drawLine(Offset(x, r.top + h * 0.1), Offset(x, r.bottom - h * 0.1), Pk.stroke(Pk.dark(a, 0.15), 1));
        }
        c.drawLine(Offset(r.left, r.top + h * 0.08), Offset(r.right, r.top + h * 0.08), Pk.stroke(b, 2));
      case PK.spotlight:
        // Ceiling spotlight casting a soft cone.
        final cone = Path()
          ..moveTo(r.center.dx - w * 0.15, r.top + h * 0.2)
          ..lineTo(r.center.dx + w * 0.15, r.top + h * 0.2)
          ..lineTo(r.right, r.bottom)
          ..lineTo(r.left, r.bottom)
          ..close();
        c.drawPath(cone, Pk.fill(b.withValues(alpha: 0.18 + 0.06 * sin(t * 2 + r.left))));
        Pk.box(c, Rect.fromCenter(center: Offset(r.center.dx, r.top + h * 0.1), width: w * 0.36, height: h * 0.2), a, radius: 3);
        c.drawCircle(Offset(r.center.dx, r.top + h * 0.2), w * 0.1, Pk.fill(b));
    }
  }
}
