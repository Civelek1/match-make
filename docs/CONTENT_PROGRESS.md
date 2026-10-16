# Levels 51–150: work in progress

Chapters 11–30 are built in four independent batches (25 levels each). Each batch
lives on its own backup branch until it is merged into `claude/projeyi-incele-12280x`:

| Batch | Levels | Chapters | Backup branch |
|---|---|---|---|
| 1 | 51–75 | bakery, greenhouse, vineyard, train_station, school | `claude/projeyi-incele-12280x-b1` |
| 2 | 76–100 | zoo, aquarium, funfair, bookshop, observatory | `claude/projeyi-incele-12280x-b2` |
| 3 | 101–125 | zen_garden, forest_camp, circus, oasis, pirate_ship | `claude/projeyi-incele-12280x-b3` |
| 4 | 126–150 | ice_palace, hot_springs, space_base, grand_hotel, royal_palace | `claude/projeyi-incele-12280x-b4` |

## Resuming

- The full brief for each batch is in `tool/content/prompts/batch_prompt_<N>.md`.
- A batch is finished when `python3 tool/content/gen_batch.py <N>`, `flutter analyze` and
  the tests listed in its brief pass, and its scenes/maps were reviewed with
  `tool/content/render_batch_test.dart` + `contact_sheet.py`.
- Merge finished batches in order (chapter 16 requires chapter 15, and so on). Each batch
  only touches its own files, so merges don't conflict.
- After merging: run the whole test suite (sequential numbering check included), then
  build the APK.
