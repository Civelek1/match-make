import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ui/gameplay/gameplay_screen.dart';
import '../ui/screens/chapter_complete_screen.dart';
import '../ui/screens/chapter_map_screen.dart';
import '../ui/screens/gallery_screen.dart';
import '../ui/screens/leaderboard_screen.dart';
import '../ui/screens/main_menu_screen.dart';
import '../ui/screens/profile_screen.dart';
import '../ui/screens/settings_screen.dart';
import '../ui/screens/splash_screen.dart';
import 'app_services.dart';
import 'game_navigator.dart';

class MatchMakeApp extends StatelessWidget {
  final AppServices services;
  const MatchMakeApp({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return AppScope(
      services: services,
      child: MaterialApp(
        title: 'Match Make',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF9A3C)),
          splashFactory: NoSplash.splashFactory,
        ),
        // Very large system text breaks the game's fixed-size HUD pieces.
        builder: (context, child) => MediaQuery.withClampedTextScaling(maxScaleFactor: 1.15, child: child!),
        home: const GameRoot(),
      ),
    );
  }
}

/// Hosts the current screen and animates between screens. All navigation
/// goes through [GameNavigator], so there is only ever one active screen.
class GameRoot extends StatefulWidget {
  const GameRoot({super.key});

  @override
  State<GameRoot> createState() => _GameRootState();
}

class _GameRootState extends State<GameRoot> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final GameNavigator _nav;
  late final AnimationController _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 520));
  NavEntry? _previous;
  late NavEntry _current;
  TransitionStyle _style = TransitionStyle.fade;
  Alignment _focus = Alignment.center;

  @override
  void initState() {
    super.initState();
    _nav = context.services.navigator;
    _current = _nav.current;
    _anim.value = 1;
    _nav.addListener(_onNav);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _nav.removeListener(_onNav);
    _anim.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final s = context.services;
    if (state == AppLifecycleState.paused || state == AppLifecycleState.hidden) {
      s.audio.pauseAll();
      s.store.commit();
    } else if (state == AppLifecycleState.resumed) {
      s.audio.resumeAll();
    }
  }

  void _onNav() {
    setState(() {
      _previous = _current;
      _current = _nav.current;
      _style = _nav.style;
      _focus = _nav.focus;
    });
    _anim.forward(from: 0).whenComplete(() {
      if (mounted) setState(() => _previous = null);
    });
  }

  Widget _build(NavEntry e) {
    final s = context.services;
    switch (e.screen) {
      case AppScreen.boot:
        return const SplashScreen();
      case AppScreen.mainMenu:
        return const MainMenuScreen();
      case AppScreen.chapterMap:
        return ChapterMapScreen(chapterId: e.arg as String?);
      case AppScreen.playing:
        final level = s.content.level(e.arg as String? ?? '');
        if (level == null || !s.progress.isUnlocked(level.id)) return const ChapterMapScreen();
        return GameplayScreen(level: level);
      case AppScreen.gallery:
        return const GalleryScreen();
      case AppScreen.galleryDetail:
        return GalleryDetailScreen(levelId: e.arg as String? ?? '');
      case AppScreen.leaderboard:
        return const LeaderboardScreen();
      case AppScreen.settings:
        return const SettingsScreen();
      case AppScreen.profile:
        return const ProfileScreen();
      case AppScreen.chapterComplete:
        return ChapterCompleteScreen(chapterId: e.arg as String? ?? s.content.chapters.first.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (!_nav.back()) SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF3B2A5A),
        resizeToAvoidBottomInset: false,
        body: AnimatedBuilder(
          animation: _anim,
          builder: (context, _) {
            final t = Curves.easeInOutCubic.transform(_anim.value);
            return Stack(
              fit: StackFit.expand,
              children: [
                // Keys on the direct children keep each screen's state alive
                // when the outgoing one is removed from the stack.
                if (_previous != null)
                  KeyedSubtree(
                    key: ValueKey(_previous!.serial),
                    child: IgnorePointer(child: _transform(_build(_previous!), t, outgoing: true)),
                  ),
                KeyedSubtree(
                  key: ValueKey(_current.serial),
                  child: IgnorePointer(ignoring: _anim.isAnimating, child: _transform(_build(_current), t, outgoing: false)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Camera-like transitions: zoom toward a focus point, slide up, or fade.
  Widget _transform(Widget child, double t, {required bool outgoing}) {
    double opacity = outgoing ? 1 - t : t;
    var scale = 1.0;
    var dy = 0.0;
    switch (_style) {
      case TransitionStyle.zoomIn:
        scale = outgoing ? 1 + 0.35 * t : 0.9 + 0.1 * t;
      case TransitionStyle.zoomOut:
        scale = outgoing ? 1 - 0.12 * t : 1.25 - 0.25 * t;
      case TransitionStyle.slideUp:
        if (!outgoing) dy = 60 * (1 - t);
        scale = outgoing ? 1 - 0.05 * t : 1;
      case TransitionStyle.fade:
        break;
    }
    if (outgoing && _style != TransitionStyle.fade) opacity = (1 - t * 1.4).clamp(0.0, 1.0);
    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Transform.translate(
        offset: Offset(0, dy),
        child: Transform.scale(scale: scale, alignment: _focus, child: child),
      ),
    );
  }
}
