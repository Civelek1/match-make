import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'paint_kit.dart';

/// Code-drawn obstacle visuals. Damage states are clearly different:
/// crates crack and lose planks, ice thins and cracks, chains lose links.
class ObstacleArt {
  /// Wooden crate; [hp] 1..3 (3 = iron-banded, 2 = bolted, 1 = plain).
  /// [damaged] adds cracks and a broken corner once it has taken a hit.
  static void crate(Canvas c, Rect cell, int hp, {bool damaged = false}) {
    final r = cell.deflate(cell.width * 0.05);
    final rr = RRect.fromRectAndRadius(r, Radius.circular(r.width * 0.14));
    c.drawRRect(rr.shift(Offset(0, r.height * 0.05)), Pk.fill(Colors.black.withValues(alpha: 0.3)));
    final wood = hp >= 3 ? const Color(0xFFB9824A) : (hp == 2 ? const Color(0xFFD29A5A) : const Color(0xFFE2B274));
    c.drawRRect(rr, Paint()..shader = ui.Gradient.linear(r.topCenter, r.bottomCenter, [Pk.light(wood, 0.15), Pk.dark(wood, 0.12)]));
    final edge = Pk.dark(wood, 0.45);
    final w = r.width;
    // Planks + frame.
    for (var i = 1; i < 3; i++) {
      final y = r.top + r.height * i / 3;
      c.drawLine(Offset(r.left + w * 0.08, y), Offset(r.right - w * 0.08, y), Pk.stroke(Pk.dark(wood, 0.3), w * 0.03));
    }
    c.drawRRect(rr.deflate(w * 0.04), Pk.stroke(edge, w * 0.07));
    // Diagonal brace.
    c.drawLine(r.topLeft + Offset(w * 0.12, w * 0.12), r.bottomRight - Offset(w * 0.12, w * 0.12), Pk.stroke(edge, w * 0.08));
    if (hp >= 3) {
      // Iron bands + rivets.
      final band = Pk.fill(const Color(0xFF6E7285));
      c.drawRect(Rect.fromLTWH(r.left, r.top + r.height * 0.18, r.width, r.height * 0.1), band);
      c.drawRect(Rect.fromLTWH(r.left, r.bottom - r.height * 0.28, r.width, r.height * 0.1), band);
      for (final p in [r.topLeft, r.topRight, r.bottomLeft, r.bottomRight]) {
        c.drawCircle(Offset.lerp(p, r.center, 0.18)!, w * 0.05, Pk.fill(const Color(0xFFC9CCD8)));
      }
    }
    if (hp == 2) {
      c.drawCircle(r.center, w * 0.07, Pk.fill(const Color(0xFF8A839B)));
    }
    if (damaged) {
      // Cracks + missing corner: clearly damaged.
      final p = Pk.stroke(const Color(0xFF4A2E18), w * 0.035);
      c.drawPath(
        Path()
          ..moveTo(r.left + w * 0.3, r.top + w * 0.05)
          ..lineTo(r.left + w * 0.42, r.top + w * 0.3)
          ..lineTo(r.left + w * 0.34, r.top + w * 0.48)
          ..lineTo(r.left + w * 0.5, r.top + w * 0.7),
        p,
      );
      c.drawPath(
        Path()
          ..moveTo(r.right - w * 0.08, r.top + w * 0.55)
          ..lineTo(r.right - w * 0.3, r.top + w * 0.62)
          ..lineTo(r.right - w * 0.36, r.top + w * 0.8),
        p,
      );
      Pk.poly(c, [r.topRight, r.topRight + Offset(-w * 0.22, 0), r.topRight + Offset(0, w * 0.22)], Pk.fill(const Color(0xFF5C3B22)));
    }
  }

  /// Translucent ice over a cell; [layers] 1..2 (2 = thick frost).
  /// [damaged] draws cracks once a layer has broken.
  static void ice(Canvas c, Rect cell, int layers, double t, {bool damaged = false}) {
    final r = cell.deflate(cell.width * 0.04);
    final rr = RRect.fromRectAndRadius(r, Radius.circular(r.width * 0.2));
    final thick = layers >= 2;
    c.drawRRect(
      rr,
      Paint()
        ..shader = ui.Gradient.linear(r.topLeft, r.bottomRight, [
          Colors.white.withValues(alpha: thick ? 0.72 : 0.5),
          const Color(0xFFA8E6FF).withValues(alpha: thick ? 0.6 : 0.35),
        ]),
    );
    c.drawRRect(rr, Pk.stroke(Colors.white.withValues(alpha: 0.9), r.width * (thick ? 0.08 : 0.05)));
    final w = r.width;
    // Glints.
    c.drawLine(r.topLeft + Offset(w * 0.18, w * 0.4), r.topLeft + Offset(w * 0.4, w * 0.18), Pk.stroke(Colors.white.withValues(alpha: 0.9), w * 0.06));
    if (thick) {
      c.drawLine(r.topLeft + Offset(w * 0.2, w * 0.62), r.topLeft + Offset(w * 0.62, w * 0.2), Pk.stroke(Colors.white.withValues(alpha: 0.6), w * 0.04));
      Pk.sparkle(c, r.topRight + Offset(-w * 0.2, w * 0.2), w * 0.08 * (0.7 + 0.3 * sin(t * 3 + r.left)), Colors.white);
    }
    if (damaged) {
      // Cracked ice.
      final p = Pk.stroke(Colors.white, w * 0.03);
      c.drawPath(
        Path()
          ..moveTo(r.center.dx, r.center.dy)
          ..lineTo(r.center.dx + w * 0.25, r.center.dy - w * 0.1)
          ..moveTo(r.center.dx, r.center.dy)
          ..lineTo(r.center.dx - w * 0.15, r.center.dy + w * 0.28)
          ..moveTo(r.center.dx, r.center.dy)
          ..lineTo(r.center.dx + w * 0.1, r.center.dy + w * 0.3),
        p,
      );
    }
  }

  /// Chains across a locked piece; [stage] 1..2 (2 = double chain + padlock).
  static void chain(Canvas c, Rect cell, int stage) {
    final r = cell.deflate(cell.width * 0.02);
    void strand(Offset a, Offset b) {
      final n = 5;
      for (var i = 0; i < n; i++) {
        final p = Offset.lerp(a, b, (i + 0.5) / n)!;
        final horizontal = i.isEven;
        final link = Rect.fromCenter(center: p, width: r.width * (horizontal ? 0.26 : 0.16), height: r.width * (horizontal ? 0.16 : 0.26));
        final ang = atan2(b.dy - a.dy, b.dx - a.dx);
        c.save();
        c.translate(p.dx, p.dy);
        c.rotate(ang);
        c.translate(-p.dx, -p.dy);
        c.drawRRect(RRect.fromRectAndRadius(link, Radius.circular(r.width * 0.08)), Pk.stroke(const Color(0xFF3B3452), r.width * 0.075));
        c.drawRRect(RRect.fromRectAndRadius(link, Radius.circular(r.width * 0.08)), Pk.stroke(const Color(0xFFC9CCD8), r.width * 0.045));
        c.restore();
      }
    }

    strand(r.topLeft, r.bottomRight);
    if (stage >= 2) {
      strand(r.topRight, r.bottomLeft);
      // Padlock marks the stronger lock.
      final lock = Rect.fromCenter(center: r.center + Offset(0, r.height * 0.08), width: r.width * 0.3, height: r.width * 0.24);
      c.drawArc(Rect.fromCenter(center: lock.topCenter, width: r.width * 0.2, height: r.width * 0.22), pi, pi, false,
          Pk.stroke(const Color(0xFF3B3452), r.width * 0.06));
      c.drawRRect(RRect.fromRectAndRadius(lock, Radius.circular(r.width * 0.05)), Pk.fill(const Color(0xFFFFC93C)));
      c.drawRRect(RRect.fromRectAndRadius(lock, Radius.circular(r.width * 0.05)), Pk.stroke(const Color(0xFF8A5A10), r.width * 0.03));
    }
  }

  /// Objective / HUD icon for an obstacle type id (crate / ice / chain).
  static void icon(Canvas c, Rect r, String id) {
    switch (id) {
      case 'crate':
        crate(c, r, 2);
      case 'ice':
        c.drawRRect(RRect.fromRectAndRadius(r.deflate(r.width * 0.06), Radius.circular(r.width * 0.2)), Pk.fill(const Color(0xFF6FC3E8)));
        ice(c, r, 2, 0);
      default:
        c.drawRRect(RRect.fromRectAndRadius(r.deflate(r.width * 0.06), Radius.circular(r.width * 0.24)), Pk.fill(const Color(0xFF8A839B)));
        chain(c, r.deflate(r.width * 0.06), 2);
    }
  }
}
