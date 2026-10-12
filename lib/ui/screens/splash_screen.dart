import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../../app/game_navigator.dart';
import '../widgets/game_text.dart';
import '../widgets/game_widgets.dart';
import '../widgets/logo.dart';

/// Animated splash + loading screen (logo entrance, particles, shine,
/// progress bar and a random gameplay tip). Loads the save, then continues.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0;
  late final int _tip = Random().nextInt(7) + 1;
  Timer? _timer;
  bool _loaded = false;
  double _elapsed = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 40), (_) => _tick());
    _load();
  }

  Future<void> _load() async {
    final s = context.services;
    try {
      await s.load();
    } catch (_) {
      // Never block the game: continue with defaults.
    }
    _loaded = true;
    if (mounted && s.store.recoveredOnLoad) {
      showGameToast(context, s.loc.t('error.save_recovered'), icon: Icons.warning_rounded);
    }
  }

  void _tick() {
    if (!mounted) return;
    _elapsed += 0.04;
    final elapsed = _elapsed;
    // Minimum ~2.4 s so the entrance animation plays out.
    final target = _loaded ? min(1.0, elapsed / 2.4) : min(0.85, elapsed / 2.4);
    setState(() => _progress = target);
    if (_progress >= 1) {
      _timer?.cancel();
      context.services.navigator.go(AppScreen.mainMenu, style: TransitionStyle.zoomIn, force: true);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.services.loc;
    return AnimatedBackdrop(
      colors: const [Color(0xFF4FB8FF), Color(0xFF8EDCFF), Color(0xFFFFE3B3), Color(0xFF9EE07A)],
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) {
            final w = min(c.maxWidth * 0.86, 420.0);
            return Column(
              children: [
                const Spacer(flex: 3),
                MatchMakeLogo(width: w),
                const Spacer(flex: 3),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 360),
                    child: Column(
                      children: [
                        GameProgressBar(value: _progress, height: 22, fill: const Color(0xFFFFC93C)),
                        const SizedBox(height: 14),
                        AnimatedOpacity(
                          opacity: _elapsed > 0.6 ? 1 : 0,
                          duration: const Duration(milliseconds: 400),
                          child: GameText(loc.t('tip.$_tip'), size: 15, strokeWidth: 3, maxLines: 2),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            );
          },
        ),
      ),
    );
  }
}
