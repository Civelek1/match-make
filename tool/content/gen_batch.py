"""Generates one content batch (5 chapters, 25 levels) from tool/content/spec_b<N>.py.

Usage (from the repo root):
    python3 tool/content/gen_batch.py <N>            # validate + write every file of batch N
    python3 tool/content/gen_batch.py <N> --check    # validate only

Spec module contents (see spec_b1.py once written, or docs in this file):
    BATCH          batch number N (1..4)
    FIRST_NUMBER   level number of the batch's first level (51, 76, 101, 126)
    PREV_CHAPTER   chapter id the batch's first chapter requires
    NEW_TILES      {tile_id: (material_icon_name, slot 0..5)}   ids must start with 'b<N>_'
    NEW_OBJECTIVES {objective_id: (en, tr)}                     ids must start with 'b<N>_'
    DART           raw Dart pasted at the top of the scenes file (colour consts, custom
                   props `const _x = CustomProp(_paintX)`, scenery functions)
    CHAPTERS       [ {id, number, icon, name: (en, tr), doc, levels: [level, ...5]} ]
    level dict:    id, moves, diff, tiles [6 tile ids, slots 0..5 once each],
                   obstacles [8 strings of 8 chars: . # c C B i I l L j J],
                   objectives [(objective_id, tile_id | crate | ice | chain | key, target)] (5..7),
                   stars [two_star, three_star], name (en, tr), desc (en, tr),
                   theme (bgTop, bgBottom, frame, accent[, dark]) as 0xAARRGGBB ints,
                   floor  minimum bot win rate (0..1) for level_balance_test,
                   obstacle_intro (optional), scene {backdrop, scenery?, props}
    scene props:   [(objective_id, [(kind, left, top, width, height, colorA, colorB), ...])]
                   kind = a PK enum name, or '@name' for `const _name = CustomProp(...)` in DART.
"""
import importlib.util
import json
import os
import re
import sys
from collections import deque

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
N = int(sys.argv[1])
CHECK = '--check' in sys.argv

spec_path = os.path.join(ROOT, 'tool', 'content', f'spec_b{N}.py')
_s = importlib.util.spec_from_file_location(f'spec_b{N}', spec_path)
spec = importlib.util.module_from_spec(_s)
_s.loader.exec_module(spec)

EXISTING = json.load(open(os.path.join(ROOT, 'tool', 'content', 'existing.json')))
PK_NAMES = set()
_pk = open(os.path.join(ROOT, 'lib', 'ui', 'scenes', 'prop_kit.dart')).read()
_enum = _pk[_pk.index('enum PK {'):_pk.index('}', _pk.index('enum PK {'))]
for line in _enum.splitlines()[1:]:
    line = line.split('//')[0]
    PK_NAMES.update(x.strip() for x in line.split(',') if x.strip())

SLOTS = {**EXISTING['tiles'], **{k: v[1] for k, v in spec.NEW_TILES.items()}}
OBJ_NAMES = {**EXISTING['objectives'], **spec.NEW_OBJECTIVES}
OBSTACLES = {'crate', 'ice', 'chain', 'key'}
LEGEND = {'c': (1, 0, 0), 'C': (2, 0, 0), 'B': (3, 0, 0), 'i': (0, 1, 0), 'I': (0, 2, 0), 'l': (0, 0, 1),
          'L': (0, 0, 2), 'j': (0, 1, 1), 'J': (0, 2, 1)}
DIFFS = {'easy', 'easyMedium', 'medium', 'mediumHard', 'hard'}
prefix = f'b{N}_'

errors, warnings = [], []
custom_props = set(re.findall(r'const\s+_(\w+)\s*=\s*CustomProp\(', spec.DART))

for k in spec.NEW_TILES:
    if not k.startswith(prefix):
        errors.append(f'new tile {k} must start with {prefix}')
    if k in EXISTING['tiles']:
        errors.append(f'new tile {k} already exists')
for k in spec.NEW_OBJECTIVES:
    if not k.startswith(prefix):
        errors.append(f'new objective {k} must start with {prefix}')

number = spec.FIRST_NUMBER
prev_chapter = spec.PREV_CHAPTER
seen_levels = set()
for ci, ch in enumerate(spec.CHAPTERS):
    if ch['id'] in EXISTING['chapters']:
        errors.append(f"chapter id {ch['id']} already exists")
    ch['requires'] = prev_chapter
    prev_chapter = ch['id']
    if len(ch['levels']) != 5:
        errors.append(f"{ch['id']}: needs 5 levels")
    for lv in ch['levels']:
        lid = lv['id']
        if lid in EXISTING['levels'] or lid in seen_levels:
            errors.append(f'{lid}: level id already used')
        seen_levels.add(lid)
        lv['number'] = number
        number += 1
        if lv['diff'] not in DIFFS:
            errors.append(f"{lid}: bad diff {lv['diff']}")
        tiles = lv['tiles']
        missing = [t for t in tiles if t not in SLOTS]
        if missing:
            errors.append(f'{lid}: unknown tiles {missing}')
        elif sorted(SLOTS[t] for t in tiles) != [0, 1, 2, 3, 4, 5]:
            errors.append(f'{lid}: tile slots {sorted(SLOTS[t] for t in tiles)} must be 0..5 once each')
        rows = lv['obstacles']
        if len(rows) != 8 or any(len(r) != 8 for r in rows):
            errors.append(f'{lid}: layout must be 8 rows of 8')
            continue
        bad = {c for r in rows for c in r if c not in LEGEND and c not in '.#'}
        if bad:
            errors.append(f'{lid}: bad layout chars {bad}')
        cells = [(x, y) for y in range(8) for x in range(8) if rows[y][x] != '#']
        if len(cells) < 40:
            errors.append(f'{lid}: only {len(cells)} cells (need 40+)')
        # The shape must be one connected piece.
        cs = set(cells)
        q = deque([cells[0]])
        seen = {cells[0]}
        while q:
            x, y = q.popleft()
            for nx, ny in ((x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)):
                if (nx, ny) in cs and (nx, ny) not in seen:
                    seen.add((nx, ny))
                    q.append((nx, ny))
        if len(seen) != len(cells):
            errors.append(f'{lid}: board shape is not connected')
        totals = {'crate': 0, 'ice': 0, 'chain': 0}
        for r in rows:
            for c in r:
                if c in LEGEND:
                    a, b, d = LEGEND[c]
                    totals['crate'] += a
                    totals['ice'] += b
                    totals['chain'] += d
        objs = lv['objectives']
        if not 5 <= len(objs) <= 7:
            errors.append(f'{lid}: {len(objs)} objectives (5..7)')
        prop_ids = [o for o, _ in lv['scene']['props']]
        for oid, tile, target in objs:
            if oid not in OBJ_NAMES:
                errors.append(f'{lid}: objective {oid} has no name (add to NEW_OBJECTIVES)')
            if tile in totals and target > totals[tile]:
                errors.append(f'{lid}: {oid} wants {target} {tile}, layout has {totals[tile]}')
            if tile not in OBSTACLES and tile not in tiles:
                errors.append(f'{lid}: objective tile {tile} not on board')
            if oid not in prop_ids:
                errors.append(f'{lid}: scene lacks props for objective {oid}')
            if target <= 0:
                errors.append(f'{lid}: {oid} target must be positive')
        for oid in set(prop_ids) - {o for o, _, _ in objs}:
            errors.append(f'{lid}: scene props for unknown objective {oid}')
        for oid, props in lv['scene']['props']:
            for p in props:
                if len(p) != 7:
                    errors.append(f'{lid}: prop {p} needs 7 fields')
                    continue
                kind = p[0]
                if kind.startswith('@'):
                    if kind[1:] not in custom_props:
                        errors.append(f'{lid}: custom prop {kind} not defined in DART')
                elif kind not in PK_NAMES:
                    errors.append(f'{lid}: unknown PK.{kind}')
        a, b = lv['stars']
        if not 0 < a < b:
            errors.append(f'{lid}: stars {lv["stars"]}')
        if not 0 < lv.get('floor', 0) <= 1:
            errors.append(f'{lid}: floor (min bot win rate) missing')
        for i, lang in enumerate(('en', 'tr')):
            if len(lv['name'][i]) > 16:
                warnings.append(f'{lid}: {lang} name "{lv["name"][i]}" is long for map labels')
        if len(lv['theme']) not in (4, 5):
            errors.append(f'{lid}: theme needs 4 colours (+dark)')

if errors:
    print('\n'.join(errors))
    sys.exit(1)
if warnings:
    print('warnings:\n  ' + '\n  '.join(warnings))
if CHECK:
    print(f'batch {N}: spec OK ({number - spec.FIRST_NUMBER} levels)')
    sys.exit(0)


def w(rel, text):
    path = os.path.join(ROOT, rel)
    with open(path, 'w') as f:
        f.write(text)


def camel(s):
    parts = s.split('_')
    return parts[0] + ''.join(p.title() for p in parts[1:])


def q(s):
    return "'" + s.replace('\\', '\\\\').replace("'", "\\'") + "'"


GEN = f'// Generated by tool/content/gen_batch.py from tool/content/spec_b{N}.py — do not edit.'

# ----------------------------------------------------------------------------- levels
for ch in spec.CHAPTERS:
    cid = ch['id']
    lines = [
        "import '../models/chapter_data.dart';",
        "import '../models/level_data.dart';",
        '',
        GEN,
        '',
        f"/// {ch['doc']}",
        f'const {camel(cid)}Chapter = ChapterData(',
        f"  id: '{cid}',",
        f"  number: {ch['number']},",
        f"  mapArtId: '{cid}',",
        f"  requiresChapterId: '{ch['requires']}',",
        '  levelIds: [' + ', '.join(f"'{lv['id']}'" for lv in ch['levels']) + '],',
        ');',
        '',
        'const _all = {SpecialFeature.rocket, SpecialFeature.bomb, SpecialFeature.colorBomb};',
        '',
        f'const {camel(cid)}Levels = <LevelData>[',
    ]
    prev = None
    for lv in ch['levels']:
        lines += [
            '  LevelData(',
            f"    id: '{lv['id']}',",
            f"    chapterId: '{cid}',",
            f"    number: {lv['number']},",
            f"    environmentId: '{lv['id']}',",
            f"    moves: {lv['moves']},",
            f"    difficulty: Difficulty.{lv['diff']},",
        ]
        if prev:
            lines.append(f"    unlockRequirement: '{prev}',")
        lines.append('    specials: _all,')
        if lv.get('obstacle_intro'):
            lines.append(f"    introducesObstacle: '{lv['obstacle_intro']}',")
        lines.append('    tileTypeIds: [' + ', '.join(f"'{t}'" for t in lv['tiles']) + '],')
        lines.append('    obstacles: [')
        lines += [f"      '{r}'," for r in lv['obstacles']]
        lines.append('    ],')
        lines.append('    objectives: [')
        for oid, tile, target in lv['objectives']:
            lines.append(f"      ObjectiveData(id: '{oid}', tileTypeId: '{tile}', target: {target}),")
        lines.append('    ],')
        lines.append(f"    starThresholds: [{lv['stars'][0]}, {lv['stars'][1]}],")
        lines.append('  ),')
        prev = lv['id']
    lines += ['];', '']
    w(f'lib/data/content/{cid}_chapter.dart', '\n'.join(lines))

batch = ["import '../models/chapter_data.dart';", "import '../models/level_data.dart';"]
batch += [f"import '{ch['id']}_chapter.dart';" for ch in spec.CHAPTERS]
batch += ['', GEN, '', f'const batch{N}Chapters = <ChapterData>[']
batch += [f"  {camel(ch['id'])}Chapter," for ch in spec.CHAPTERS]
batch += ['];', '', f'const batch{N}Levels = <LevelData>[']
batch += [f"  ...{camel(ch['id'])}Levels," for ch in spec.CHAPTERS]
batch += ['];', '']
w(f'lib/data/content/batch_{N}.dart', '\n'.join(batch))

# ----------------------------------------------------------------------------- scenes
sc = [
    '// ignore_for_file: prefer_const_constructors, unused_element, unused_import',
    "import 'dart:math';",
    '',
    "import 'package:flutter/material.dart';",
    '',
    "import '../art/paint_kit.dart';",
    "import 'prop_kit.dart';",
    "import 'prop_scene.dart';",
    "import 'scene_art.dart';",
    '',
    GEN,
    '',
    'Rect _r(double l, double t, double w, double h) => Rect.fromLTWH(l, t, w, h);',
    '',
    spec.DART.strip(),
    '',
    f'final Map<String, SceneArt Function()> batch{N}Scenes = {{',
]
for ch in spec.CHAPTERS:
    sc.append(f"  // {'-' * 60} {ch['name'][0]}")
    for lv in ch['levels']:
        s = lv['scene']
        sc.append(f"  '{lv['id']}': () => PropScene(")
        sc.append(f"    backdrop: {s['backdrop']},")
        if s.get('scenery'):
            sc.append(f"    scenery: {s['scenery']},")
        sc.append('    objectives: [')
        for oid, props in s['props']:
            out = []
            for kind, l, t, wd, h, a, b in props:
                if kind.startswith('@'):
                    out.append(f"Prop.custom(_{kind[1:]}, _r({l}, {t}, {wd}, {h}), {a}, {b})")
                else:
                    out.append(f"Prop(PK.{kind}, _r({l}, {t}, {wd}, {h}), {a}, {b})")
            sc.append(f"      ObjectiveProps('{oid}', [{', '.join(out)}]),")
        sc.append('    ],')
        sc.append('  ),')
sc += ['};', '']
w(f'lib/ui/scenes/chapter_scenes_b{N}.dart', '\n'.join(sc))

# ----------------------------------------------------------------------------- themes + icons
th = ["import 'package:flutter/material.dart';", '', "import 'game_colors.dart';", '', GEN, '',
      'EnvironmentTheme _t(int top, int bottom, int frame, int accent, {bool dark = false}) => EnvironmentTheme(',
      '  bgTop: Color(top),', '  bgBottom: Color(bottom),', '  boardFrame: Color(frame),',
      '  cellA: Color(dark ? 0x26B38CFF : 0x38FFFFFF),', '  cellB: Color(dark ? 0x14B38CFF : 0x20FFFFFF),',
      '  accent: Color(accent),', '  dark: dark,', ');', '',
      f'final batch{N}Themes = <String, EnvironmentTheme>{{']
for ch in spec.CHAPTERS:
    for lv in ch['levels']:
        t = lv['theme']
        dark = ', dark: true' if len(t) > 4 and t[4] else ''
        th.append(f"  '{lv['id']}': _t(0x{t[0]:08X}, 0x{t[1]:08X}, 0x{t[2]:08X}, 0x{t[3]:08X}{dark}),")
th += ['};', '', f'const batch{N}Icons = <String, IconData>{{']
th += [f"  '{ch['id']}': Icons.{ch['icon']}," for ch in spec.CHAPTERS]
th += ['};', '']
w(f'lib/ui/theme/batch_{N}_theme.dart', '\n'.join(th))

# ----------------------------------------------------------------------------- tiles
tl = ["import 'package:flutter/material.dart';", '', "import 'tile_art.dart';", '', GEN, '',
      f'const batch{N}Tiles = <String, TileVisual>{{']
tl += [f"  '{k}': TileVisual(Icons.{icon}, {slot})," for k, (icon, slot) in spec.NEW_TILES.items()]
tl += ['};', '']
w(f'lib/ui/art/batch_{N}_tiles.dart', '\n'.join(tl))

# ----------------------------------------------------------------------------- strings
st = [GEN, '']
for lang, i in (('En', 0), ('Tr', 1)):
    st.append(f'const stringsB{N}{lang} = <String, String>{{')
    for ch in spec.CHAPTERS:
        st.append(f"  'chapter.{ch['id']}': {q(ch['name'][i])},")
        for lv in ch['levels']:
            st.append(f"  'level.{lv['id']}': {q(lv['name'][i])},")
            st.append(f"  'level.{lv['id']}.desc': {q(lv['desc'][i])},")
    for oid, names in spec.NEW_OBJECTIVES.items():
        st.append(f"  'obj.{oid}': {q(names[i])},")
    st += ['};', '']
w(f'lib/localization/strings_b{N}.dart', '\n'.join(st))

# ----------------------------------------------------------------------------- floors
fl = [GEN, '', '/// Minimum bot win rate per level (level_balance_test).', f'const floorsB{N} = <String, double>{{']
for ch in spec.CHAPTERS:
    for lv in ch['levels']:
        fl.append(f"  '{lv['id']}': {lv['floor']},")
fl += ['};', '']
w(f'test/support/floors_b{N}.dart', '\n'.join(fl))

print(f'batch {N}: wrote {len(spec.CHAPTERS)} chapters, {number - spec.FIRST_NUMBER} levels')
