import 'package:flutter/widgets.dart';

/// Top-level game states. Gameplay sub-states (paused, win, lose) live in the
/// gameplay controller so they can't conflict with screen navigation.
enum AppScreen { boot, mainMenu, chapterMap, playing, gallery, galleryDetail, leaderboard, settings, profile, chapterComplete }

enum TransitionStyle { fade, zoomIn, zoomOut, slideUp }

class NavEntry {
  final AppScreen screen;
  final Object? arg;

  /// Changes on every navigation so re-entering the same screen (e.g. replay)
  /// rebuilds it from scratch.
  final int serial;
  const NavEntry(this.screen, this.arg, this.serial);
}

/// Single source of truth for which screen is showing. Re-requesting the current
/// screen is ignored, and GameRoot blocks input while a transition runs, so
/// double taps cannot stack screens.
class GameNavigator extends ChangeNotifier {
  NavEntry _current = const NavEntry(AppScreen.boot, null, 0);
  TransitionStyle style = TransitionStyle.fade;

  /// Point the zoom transition moves toward (e.g. the tapped level node).
  Alignment focus = Alignment.center;
  int _serial = 0;

  /// Screens may intercept system back (e.g. gameplay opens the pause menu).
  /// Return true when handled.
  bool Function()? backOverride;

  NavEntry get current => _current;
  AppScreen get screen => _current.screen;

  /// Where "back" returns to from each screen.
  static const _parents = {
    AppScreen.chapterMap: AppScreen.mainMenu,
    AppScreen.gallery: AppScreen.mainMenu,
    AppScreen.leaderboard: AppScreen.mainMenu,
    AppScreen.settings: AppScreen.mainMenu,
    AppScreen.profile: AppScreen.mainMenu,
    AppScreen.galleryDetail: AppScreen.gallery,
    AppScreen.chapterComplete: AppScreen.chapterMap,
    AppScreen.playing: AppScreen.chapterMap,
  };

  bool go(AppScreen screen, {Object? arg, TransitionStyle? style, bool force = false, Alignment focus = Alignment.center}) {
    if (!force && screen == _current.screen && arg == _current.arg) return false;
    this.style = style ?? TransitionStyle.fade;
    this.focus = focus;
    _current = NavEntry(screen, arg, ++_serial);
    notifyListeners();
    return true;
  }

  /// Returns false if there is nowhere to go back to (main menu).
  bool back() {
    if (backOverride?.call() == true) return true;
    final parent = _parents[_current.screen];
    if (parent == null) return false;
    return go(parent, style: TransitionStyle.zoomOut);
  }
}
