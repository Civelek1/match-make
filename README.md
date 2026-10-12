# MATCH MAKE

A match-3 restoration puzzle built with Flutter (Android · iOS · web). Match pieces to
collect objectives, and watch each location restore itself live above the board.

**10 chapters, 50 levels:** House, Farm, Restaurant, Beach Resort, Mansion, Castle,
Mountain Lodge, Harbor, Museum and Theater (five locations each).

* **Mechanics:** rockets, bombs, colour bombs and their combos; crates, ice and chains;
  falling **keys** from level 26 (they sink one row per move and are collected at the
  bottom).
* **Boosters** (never cost a move): hammer, broom (sweeps a row), shuffle; start boosters
  pick a rocket, bomb or colour bomb before the first move. Each unlocks at a set level
  with a free gift.
* **Economy:** coins from wins and a 7-day daily-reward calendar; spend them in the shop
  or on +5 moves when a level runs out (300 / 600 / 900 per attempt). All numbers live in
  `lib/economy/economy_config.dart`. Nothing is sold for real money yet.
* **Languages:** English and Turkish; a new install starts in the device language.

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
  economy/        EconomyConfig (prices, rewards), EconomyService (coins, boosters),
                  DailyRewardService (7-day streak calendar)
  match3/         pure-Dart engine: board, matching, specials, gravity, cascades, keys, shuffle
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

## Adding a chapter

No engine, save, gallery or navigation changes are needed:

1. **ChapterData + LevelData** — create `lib/data/content/<id>_chapter.dart` (copy
   `theater_chapter.dart`). Set `requiresChapterId` to the previous chapter and chain
   `unlockRequirement`s. A key objective is `ObjectiveData(tileTypeId: 'key', ...)`; its
   target is also how many keys the level spawns.
2. **Register** — add the chapter and levels in `GameContent.standard()`, and lower
   `comingSoonChapters` if you like.
3. **Tile types** — add any new tile ids to `tileVisuals` in `ui/art/tile_art.dart`
   (icon + shape slot; the six pieces of a level must use six different slots).
4. **Restoration scenes** — add a `PropScene` per location (props per objective id) to
   `ui/scenes/chapter_scenes_2.dart`; add a `LocationMapArt` (landmark style + five
   spots) in `ui/scenes/location_map_art.dart` and map it in `chapterMapArtFor`.
5. **Theme** — add an `EnvironmentTheme` entry per environment id in `game_colors.dart`,
   and a chapter icon in `chapter_icons.dart`.
6. **Strings** — add `chapter.<id>`, `level.<id>`, `level.<id>.desc`, `obj.<id>` to both
   string files (a test fails if a key is missing).
7. Run `flutter test` — the balance test bot-plays every level 100 times; add a win-rate
   floor for each new level in `test/level_balance_test.dart`.

## Replacing placeholder assets

* Sounds / music: drop files with the same names into `assets/audio/` (or edit `AudioAssets`).
* Tiles: swap the icon in `tileVisuals`, or change `paintTile` to draw an image.
* Scenes: each `SceneArt.paint` can draw sprites instead of vectors; gameplay only
  provides stage/appear values.

## Online services

Leaderboard runs on `MockLeaderboardService` (offline, realistic data, debug-toggleable
offline mode). Implement `LeaderboardService` for Firebase / Supabase / PlayFab and swap it
in `AppServices.create`. Cloud saves: implement `SaveRepository`.
