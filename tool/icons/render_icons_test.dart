// Renders every launcher / store / web icon from AppIconPainter.
// Run: flutter test tool/icons/render_icons_test.dart
// then: python3 tool/icons/finish_icons.py   (strips alpha for iOS)
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:match_make/ui/art/app_icon_art.dart';

Future<void> _png(
  String path,
  int size, {
  bool bg = true,
  bool fg = true,
  double inset = 0,
  double round = 0,
}) async {
  final rec = ui.PictureRecorder();
  final c = Canvas(rec);
  final s = size.toDouble();
  if (round > 0) {
    c.clipRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, s, s), Radius.circular(s * round)));
  }
  AppIconPainter(
    background: bg,
    foreground: fg,
    inset: inset,
  ).paint(c, Size(s, s));
  final img = await rec.endRecording().toImage(size, size);
  final data = await img.toByteData(format: ui.ImageByteFormat.png);
  File(path)
    ..createSync(recursive: true)
    ..writeAsBytesSync(data!.buffer.asUint8List());
}

void main() {
  testWidgets('render icons', (tester) async {
    await tester.runAsync(() async {
      final root = Platform.environment['FLUTTER_ROOT']!;
      final loader = FontLoader('Roboto')
        ..addFont(
          Future.value(
            ByteData.sublistView(
              File('$root/bin/cache/artifacts/material_fonts/Roboto-Black.ttf')
                  .readAsBytesSync(),
            ),
          ),
        );
      await loader.load();

      const res = 'android/app/src/main/res';
      const dens = {
        'mdpi': 1.0,
        'hdpi': 1.5,
        'xhdpi': 2.0,
        'xxhdpi': 3.0,
        'xxxhdpi': 4.0,
      };
      for (final e in dens.entries) {
        await _png(
          '$res/mipmap-${e.key}/ic_launcher.png',
          (48 * e.value).round(),
          round: 0.2,
        );
        await _png(
          '$res/mipmap-${e.key}/ic_launcher_foreground.png',
          (108 * e.value).round(),
          bg: false,
          inset: 0.3,
        );
        await _png(
          '$res/mipmap-${e.key}/ic_launcher_background.png',
          (108 * e.value).round(),
          fg: false,
        );
      }
      // Android 12+ splash icon (shown inside a circle, 2/3 of 240dp visible).
      await _png(
        '$res/drawable-nodpi/splash_icon.png',
        768,
        bg: false,
        inset: 0.32,
      );

      const ios = 'ios/Runner/Assets.xcassets/AppIcon.appiconset';
      for (final (name, px) in [
        ('20x20@1x', 20),
        ('20x20@2x', 40),
        ('20x20@3x', 60),
        ('29x29@1x', 29),
        ('29x29@2x', 58),
        ('29x29@3x', 87),
        ('40x40@1x', 40),
        ('40x40@2x', 80),
        ('40x40@3x', 120),
        ('60x60@2x', 120),
        ('60x60@3x', 180),
        ('76x76@1x', 76),
        ('76x76@2x', 152),
        ('83.5x83.5@2x', 167),
        ('1024x1024@1x', 1024),
      ]) {
        await _png('$ios/Icon-App-$name.png', px);
      }

      await _png('web/icons/Icon-192.png', 192, round: 0.2);
      await _png('web/icons/Icon-512.png', 512, round: 0.2);
      await _png('web/icons/Icon-maskable-192.png', 192, inset: 0.2);
      await _png('web/icons/Icon-maskable-512.png', 512, inset: 0.2);
      await _png('web/favicon.png', 64, round: 0.2);

      await _png('store/play_icon_512.png', 512);
    });
  });
}
