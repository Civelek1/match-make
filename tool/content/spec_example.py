# Reference spec showing every feature of gen_batch.py (one chapter, 5 levels).
# Copy the structure into spec_b<N>.py. Not generated into the game.

BATCH = 1
FIRST_NUMBER = 51
PREV_CHAPTER = 'theater'

NEW_TILES = {
    # id: (Material icon name from Icons.*, colour/shape slot 0..5)
    'b1_croissant': ('bakery_dining', 2),
}

NEW_OBJECTIVES = {
    'b1_pastries': ('Pastries', 'Hamur İşleri'),
}

DART = r'''
const _wood = Color(0xFFC98A52);
const _darkWood = Color(0xFF8B5E3C);
const _cream = Color(0xFFFFF1DA);
const _gold = Color(0xFFFFC93C);
const _red = Color(0xFFE0533F);
const _leaf = Color(0xFF55C04A);
const _pink = Color(0xFFFF7AB6);
const _blue = Color(0xFF45A7F5);
const _white = Color(0xFFFFFFFF);
const _lampGlow = Color(0xFFFFE9A0);
const _navy = Color(0xFF2B3A67);

// A custom prop: draws inside r (400x240 scene space); a = main colour, b = accent.
void _paintCake(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.45, w, h * 0.55), a, radius: 4);
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.15, r.top + h * 0.1, w * 0.7, h * 0.4), Pk.light(a, 0.2), radius: 4);
  c.drawCircle(Offset(r.center.dx, r.top + h * 0.06), w * 0.06, Pk.fill(b));
}

const _cake = CustomProp(_paintCake);

// Scenery: painted after the backdrop, before props (e.g. a shop front wall).
void _shopWall(Canvas c, double ov, double t) {
  c.drawRect(const Rect.fromLTWH(0, 30, 400, 110), Pk.fill(Pk.mix(const Color(0xFFB5A99A), const Color(0xFFFFE3C2), ov)));
}
'''

_outdoor = "const Backdrop.outdoor(groundN: Color(0xFFA8A296), groundR: Color(0xFFE6DCCB), horizon: 150, floor: FloorStyle.stone)"
_indoor = ("const Backdrop.indoor(topN: Color(0xFFA59C8F), topR: Color(0xFFFFE3C2), groundN: Color(0xFF8D7F6E), "
           "groundR: Color(0xFFC98A52), floorAltN: Color(0xFF7E7060), floorAltR: Color(0xFFB9763F), floor: FloorStyle.planks)")


def _lv(i, shape, objectives):
    return dict(
        id=f'example_{i}', moves=26, diff='mediumHard',
        tiles=['b1_croissant', 'cabinets', 'table', 'herbs', 'fridge', 'decor_cup'],
        obstacles=shape,
        objectives=objectives,
        stars=[24000, 32000], floor=0.4,
        name=(f'EXAMPLE {i}', f'ÖRNEK {i}'),
        desc=('Bake the morning bread.', 'Sabah ekmeğini pişir.'),
        theme=(0xFFFFE3C2, 0xFFE0A86E, 0xFF8B4A2E, 0xFFFF9A3C),
        scene=dict(
            backdrop=_indoor if i % 2 else _outdoor,
            scenery='_shopWall' if i == 1 else None,
            props=[
                (o, [('@cake' if o == 'b1_pastries' else 'table', 40 + k * 60, 140, 50, 40, '_cream', '_red')])
                for k, (o, _, _) in enumerate(objectives)
            ],
        ),
    )


CHAPTERS = [
    {
        'id': 'example', 'number': 11, 'icon': 'bakery_dining',
        'name': ('BAKERY', 'PASTANE'),
        'doc': 'CHAPTER 11 — BAKERY (example).',
        'levels': [
            _lv(1, ['##....##', '##....##', '##....##', '........', '........', '........', '........', '........'],  # U
                [('b1_pastries', 'b1_croissant', 14), ('cabinets', 'cabinets', 14), ('table', 'table', 14), ('herbs', 'herbs', 14), ('fridge', 'fridge', 14)]),
            _lv(2, ['........', '........', '........', '##....##', '##....##', '##.cc.##', '##....##', '##....##'],  # T
                [('b1_pastries', 'b1_croissant', 14), ('fridge', 'fridge', 14), ('herbs', 'herbs', 14), ('crates', 'crate', 2), ('gates', 'key', 2)]),
            _lv(3, ['....####', '....####', '..i.####', '....####', '........', '...ii...', '........', '........'],  # L
                [('b1_pastries', 'b1_croissant', 14), ('decor', 'decor_cup', 14), ('ice', 'ice', 3), ('herbs', 'herbs', 14), ('table', 'table', 14)]),
            _lv(4, ['##....##', '##.ll.##', '........', '........', '........', '........', '##....##', '##....##'],  # plus
                [('b1_pastries', 'b1_croissant', 14), ('table', 'table', 14), ('chains', 'chain', 2), ('fridge', 'fridge', 14), ('herbs', 'herbs', 14)]),
            _lv(5, ['........', '#......#', '##....##', '###..###', '###..###', '##....##', '#......#', '........'],  # hourglass
                [('b1_pastries', 'b1_croissant', 14), ('cabinets', 'cabinets', 14), ('table', 'table', 14), ('fridge', 'fridge', 14), ('gates', 'key', 2)]),
        ],
    },
]
