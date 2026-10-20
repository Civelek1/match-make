import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'app/app_services.dart';
import 'app/game_root.dart';
import 'monetization/ads_service.dart';
import 'monetization/store_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Portrait-first game.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  // Ads and real-money purchases exist only in the mobile apps. TEST builds
  // fall back to a fake store until the products exist in Play Console.
  final mobile = !kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS);
  final services = AppServices.create(
    ads: mobile ? AdMobAdsService() : null,
    shop: !mobile ? null : (kDebugTools ? DebugFallbackStoreService() : PlatformStoreService()),
  );
  runApp(MatchMakeApp(services: services));
}
