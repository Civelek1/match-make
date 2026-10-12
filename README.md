# MATCH MAKE

A match-3 restoration puzzle built with Flutter (Android · iOS · web). Match pieces to
collect objectives, and watch each location restore itself live above the board.

**Chapter 1 — House:** Garden → Kitchen → Bathroom → Gaming Room → Attic.

## Run

```bash
flutter pub get
flutter run                                  # device / emulator
flutter run --dart-define=MM_DEBUG=true      # release-like build with the debug panel
flutter test                                 # engine, balance, save, restoration, UI flow
```

Web play-test: `flutter build web --release` then `dart run tool/serve_web.dart` (port 8765).

> Windows note: the project uses `dependency_overrides` for `path_provider_*` to avoid
> native-asset build hooks that fail on very long paths. Remove them if your checkout
> path is short or Windows long-path support is on.

## Architecture

```
lib/
  app/            composition root (AppServices), navigator/state machine, root + transitions
  data/           LevelData / ChapterData models, ScoringConfig, content registry
    content/      house_chapter.dart  ← all level balancing lives here
  match3/         pure-Dart engine: board, matching, specials, gravity, cascades, shuffle
  game/           LevelSession (moves, score, objectives, win/lose), GameplayController
  restoration/    RestorationState: milestone stages + timing for live restoration
  progression/    ProgressService: unlocks, stars (never downgraded), gallery, chapters
  save/           SaveData (tolerant JSON), SaveRepository (local + backup), SaveStore
  settings/       SettingsService, ProfileService
  localization/   Localization + strings_en.dart / strings_tr.dart
  audio/          AudioService (asset table separate from playback)
  haptics/        HapticsService
  leaderboard/    LeaderboardService interface + MockLeaderboardService
  monetization/   RewardsService extension point (disabled — nothing is sold)
  ui/
    art/          tile renderer (cached to GPU images), painting kit
    scenes/       one procedural SceneArt per environment + chapter map art
    board/        BoardView: input, step playback, effects, pooled particles
    gameplay/     gameplay screen, HUD, flying icons, overlays (intro/tutorial/pause/win/lose)
    screens/      splash, main menu, map, gallery, leaderboard, settings, profile, chapter complete
    widgets/      GameButton, GamePanel, StarDisplay, GameToggle, confetti, logo...
    debug/        debug panel (only when kDebugMode or MM_DEBUG=true)
tool/             generate_audio.dart (all SFX/music synthesized), serve_web.dart
```

Key flow: the engine resolves a move instantly and returns a list of `BoardStep`s
(swap → clear → fall → … → shuffle). `BoardView` replays them with animations while
input is locked, so visuals can never corrupt board state. Objective deltas travel with
each `ClearStep`, fly to the HUD, and feed `RestorationState`, which advances the scene
at each milestone (25/50/75/100% by default, configurable per objective).

## Adding Chapter 2 (e.g. Farm)

No engine, save, gallery or navigation changes are needed:

1. **ChapterData + LevelData** — create `lib/data/content/farm_chapter.dart` (copy the
   House file). Set `requiresChapterId: 'house'` and chain `unlockRequirement`s.
2. **Register** — add the chapter and levels in `GameContent.standard()`, and lower
   `comingSoonChapters` if you like.
3. **Tile types** — add any new tile ids to `tileVisuals` in `ui/art/tile_art.dart`
   (icon + shape slot; keep the slots within a level distinct).
4. **Restoration scenes** — implement a `SceneArt` per location (anchors per objective)
   and register it in `ui/scenes/scene_art.dart`; add a `ChapterMapArt` for the chapter
   map in `ui/scenes/house_map_art.dart`'s `chapterMapArtFor`.
5. **Theme** — add an `EnvironmentTheme` entry per environment id in `game_colors.dart`.
6. **Strings** — add `chapter.farm`, `level.<id>`, `level.<id>.desc`, `obj.<id>` to both
   string files (a test fails if a key is missing).
7. Run `flutter test` — the balance test automatically bot-plays new levels.

## Replacing placeholder assets

* Sounds / music: drop files with the same names into `assets/audio/` (or edit `AudioAssets`).
* Tiles: swap the icon in `tileVisuals`, or change `paintTile` to draw an image.
* Scenes: each `SceneArt.paint` can draw sprites instead of vectors; gameplay only
  provides stage/appear values.

## Online services

Leaderboard runs on `MockLeaderboardService` (offline, realistic data, debug-toggleable
offline mode). Implement `LeaderboardService` for Firebase / Supabase / PlayFab and swap it
in `AppServices.create`. Cloud saves: implement `SaveRepository`.
