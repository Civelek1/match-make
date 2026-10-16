# Content batch 3 (levels 101–125): Japanese Garden, Forest Camp, Circus, Desert Oasis, Pirate Ship.
# Generate with: python3 tool/content/gen_batch.py 3

BATCH = 3
FIRST_NUMBER = 101
PREV_CHAPTER = 'observatory'

NEW_TILES = {
    'b3_torii': ('temple_buddhist', 0),
    'b3_koi': ('set_meal', 1),
    'b3_lantern': ('light', 2),
    'b3_tea': ('emoji_food_beverage', 2),
    'b3_bamboo': ('grass', 3),
    'b3_bonsai': ('park', 3),
    'b3_lotus': ('spa', 5),
    'b3_campfire': ('local_fire_department', 0),
    'b3_cabin': ('cabin', 1),
    'b3_hike': ('hiking', 2),
    'b3_pine': ('forest', 3),
    'b3_canoe': ('kayaking', 4),
    'b3_bigtop': ('festival', 0),
    'b3_confetti': ('celebration', 1),
    'b3_star': ('star', 2),
    'b3_acrobat': ('sports_gymnastics', 3),
    'b3_paw': ('pets', 4),
    'b3_toy': ('toys', 5),
    'b3_palace': ('fort', 0),
    'b3_spice': ('rice_bowl', 1),
    'b3_coffee': ('coffee', 1),
    'b3_sunset': ('wb_twilight', 2),
    'b3_spring': ('water_drop', 4),
    'b3_gem': ('diamond', 4),
    'b3_moon': ('dark_mode', 5),
    'b3_flag': ('flag', 0),
    'b3_chest': ('inventory_2', 1),
    'b3_coin': ('paid', 2),
    'b3_parrot': ('flutter_dash', 3),
    'b3_map': ('map', 5),
}

NEW_OBJECTIVES = {
    'b3_torii': ('Torii Gate', 'Torii Kapısı'),
    'b3_stone_lanterns': ('Stone Lanterns', 'Taş Fenerler'),
    'b3_bamboo': ('Bamboo', 'Bambular'),
    'b3_cherry_trees': ('Cherry Trees', 'Kiraz Ağaçları'),
    'b3_basin': ('Water Basin', 'Su Taşı'),
    'b3_koi': ('Koi Fish', 'Koi Balıkları'),
    'b3_lotus': ('Lotus', 'Nilüferler'),
    'b3_lanterns': ('Lanterns', 'Fenerler'),
    'b3_tea_set': ('Tea Set', 'Çay Takımı'),
    'b3_cushions': ('Cushions', 'Minderler'),
    'b3_bonsai': ('Bonsai', 'Bonsailer'),
    'b3_shoji': ('Shoji Screens', 'Şoji Paravanlar'),
    'b3_kettle': ('Kettle', 'Demlik'),
    'b3_stream': ('Stream', 'Dere'),
    'b3_shrine': ('Shrine', 'Mabet'),
    'b3_wind_chimes': ('Wind Chimes', 'Rüzgâr Çanları'),
    'b3_bridge': ('Bridge', 'Köprü'),
    'b3_tents': ('Tents', 'Çadırlar'),
    'b3_supplies': ('Supplies', 'Erzak'),
    'b3_campfire': ('Campfire', 'Kamp Ateşi'),
    'b3_treehouse': ('Treehouse', 'Ağaç Ev'),
    'b3_ladder': ('Rope Ladder', 'İp Merdiven'),
    'b3_rope_bridge': ('Rope Bridge', 'İp Köprü'),
    'b3_canoes': ('Canoes', 'Kanolar'),
    'b3_catch': ('Catch', 'Av'),
    'b3_dock': ('Dock Planks', 'İskele Tahtaları'),
    'b3_bunks': ('Bunk Beds', 'Ranzalar'),
    'b3_big_top': ('Big Top', 'Büyük Çadır'),
    'b3_marquee': ('Marquee', 'Işıklı Tabela'),
    'b3_acrobats': ('Acrobats', 'Akrobatlar'),
    'b3_pedestals': ('Pedestals', 'Kürsüler'),
    'b3_trapeze': ('Trapeze', 'Trapez'),
    'b3_net': ('Safety Net', 'Güvenlik Ağı'),
    'b3_drums': ('Drums', 'Davullar'),
    'b3_rigging': ('Rigging', 'Sirk Halatları'),
    'b3_makeup': ('Makeup', 'Makyaj'),
    'b3_toys': ('Toys', 'Oyuncaklar'),
    'b3_caravans': ('Caravans', 'Karavanlar'),
    'b3_canopies': ('Canopies', 'Tenteler'),
    'b3_spices': ('Spices', 'Baharatlar'),
    'b3_spring_pool': ('Spring', 'Pınar'),
    'b3_jars': ('Water Jars', 'Su Testileri'),
    'b3_jewelry': ('Jewelry', 'Mücevherler'),
    'b3_rugs': ('Rugs', 'Halılar'),
    'b3_arches': ('Arches', 'Kemerler'),
    'b3_coffee_set': ('Coffee Set', 'Kahve Takımı'),
    'b3_parrots': ('Parrots', 'Papağanlar'),
    'b3_treasure': ('Treasure', 'Hazine'),
    'b3_sails': ('Sails', 'Yelkenler'),
    'b3_ship_wheel': ("Ship's Wheel", 'Dümen'),
    'b3_barrels': ('Barrels', 'Fıçılar'),
    'b3_cannons': ('Cannons', 'Toplar'),
    'b3_ropes': ('Ropes', 'Halatlar'),
    'b3_gold': ('Gold', 'Altın'),
}

# Level data for content batch 3 (imported by spec_b3.py).
# Each level: id, moves, diff, tiles, obstacles, objectives, stars, floor, name, desc, theme.

L = {}


def lv(id, moves, diff, tiles, obstacles, objectives, stars, floor, name, desc, theme):
    L[id] = dict(id=id, moves=moves, diff=diff, tiles=tiles, obstacles=obstacles, objectives=objectives,
                 stars=stars, floor=floor, name=name, desc=desc, theme=theme)


# ---------------------------------------------------------------- 21 JAPANESE GARDEN (ice)
lv('zen_garden_torii', 26, 'mediumHard',
   ['b3_torii', 'b3_koi', 'b3_lantern', 'b3_bamboo', 'water', 'blossom'],
   ['##....##',
    '##.ii.##',
    '........',
    '.i....i.',
    '.i....i.',
    '........',
    '##....##',
    '##....##'],  # plus
   [('b3_torii', 'b3_torii', 15), ('b3_stone_lanterns', 'b3_lantern', 14), ('b3_bamboo', 'b3_bamboo', 14),
    ('b3_cherry_trees', 'blossom', 14), ('b3_basin', 'ice', 6)],
   [22000, 30000], 0.55,
   ('TORII GATE', 'TORII KAPISI'),
   ('Raise the red gate over the garden path.', 'Bahçe yolunun üstündeki kırmızı kapıyı dik.'),
   (0xFFFFE4EC, 0xFFF2A7B8, 0xFFB0302A, 0xFFE0533F))

lv('zen_garden_koi', 26, 'mediumHard',
   ['flower', 'b3_koi', 'b3_lantern', 'b3_bamboo', 'water', 'b3_lotus'],
   ['##....##',
    '#..ii..#',
    '..i..i..',
    '.I....I.',
    '.I....I.',
    '..i..i..',
    '#..ii..#',
    '##....##'],  # octagon
   [('b3_koi', 'b3_koi', 16), ('b3_lotus', 'b3_lotus', 15), ('pond', 'water', 15),
    ('b3_lanterns', 'b3_lantern', 15), ('flowers', 'flower', 14), ('ice', 'ice', 14)],
   [24000, 32000], 0.46,
   ('KOI POND', 'KOİ GÖLETİ'),
   ('Thaw the pond and bring the koi home.', 'Göleti çöz, koi balıklarını geri getir.'),
   (0xFFDDF4F0, 0xFF8FD3C8, 0xFF2E6E5A, 0xFFFF8A3C))

lv('zen_garden_tea', 28, 'mediumHard',
   ['table', 'seat', 'b3_tea', 'b3_bonsai', 'window', 'curtain'],
   ['........',
    '.i.ll.i.',
    '........',
    '##.ii.##',
    '##....##',
    '##.ii.##',
    '##....##',
    '##....##'],  # T
   [('b3_tea_set', 'b3_tea', 16), ('table', 'table', 15), ('b3_cushions', 'seat', 15), ('b3_bonsai', 'b3_bonsai', 15),
    ('b3_shoji', 'window', 15), ('b3_kettle', 'ice', 6), ('scrolls', 'chain', 2)],
   [24000, 32000], 0.44,
   ('TEA HOUSE', 'ÇAY EVİ'),
   ('Set the low table for a quiet cup of tea.', 'Sakin bir çay için alçak masayı hazırla.'),
   (0xFFF5ECD6, 0xFFD9C29A, 0xFF6B4A2E, 0xFF7FB069))

lv('zen_garden_bamboo', 27, 'mediumHard',
   ['b3_torii', 'fence', 'b3_lantern', 'b3_bamboo', 'water', 'b3_lotus'],
   ['......##',
    '..l...##',
    '##..l...',
    '##......',
    '...l..##',
    '......##',
    '##..l...',
    '##......'],  # zigzag
   [('b3_bamboo', 'b3_bamboo', 16), ('b3_lanterns', 'b3_lantern', 15), ('fence', 'fence', 15),
    ('b3_stream', 'water', 15), ('b3_shrine', 'b3_torii', 14), ('b3_wind_chimes', 'chain', 4)],
   [23000, 31000], 0.44,
   ('BAMBOO GROVE', 'BAMBU KORUSU'),
   ('Clear a winding path through the bamboo.', 'Bambuların arasından dolambaçlı bir yol aç.'),
   (0xFFE4F2D6, 0xFF9CCB7E, 0xFF3E6B2E, 0xFFFFC93C))

lv('zen_garden_bridge', 25, 'hard',
   ['b3_torii', 'b3_koi', 'b3_lantern', 'b3_bamboo', 'water', 'blossom'],
   ['........',
    '.j.ii.j.',
    '........',
    '.i.jj.i.',
    '........',
    '...##...',
    '.i.##.i.',
    '...##...'],  # arch
   [('b3_cherry_trees', 'blossom', 16), ('b3_bridge', 'b3_torii', 16), ('b3_koi', 'b3_koi', 15),
    ('b3_stream', 'water', 15), ('b3_lanterns', 'b3_lantern', 15), ('ice', 'ice', 8), ('chains', 'chain', 4)],
   [25000, 33000], 0.34,
   ('BLOSSOM BRIDGE', 'ÇİÇEKLİ KÖPRÜ'),
   ('Cross the stream under falling petals.', 'Dökülen yaprakların altında dereyi geç.'),
   (0xFFFFE9F0, 0xFFF0A0BC, 0xFFA02A3A, 0xFFFF7AB6))

# ---------------------------------------------------------------- 22 FOREST CAMP (crates)
lv('forest_camp_gate', 24, 'mediumHard',
   ['b3_campfire', 'fence', 'sign', 'b3_pine', 'b3_canoe', 'lantern'],
   ['##....##',
    '##.cc.##',
    '##....##',
    '........',
    '.c....c.',
    '........',
    '..c..c..',
    '........'],  # U
   [('sign', 'sign', 15), ('fence', 'fence', 15), ('tree', 'b3_pine', 15), ('lamps', 'lantern', 14), ('crates', 'crate', 6)],
   [22000, 30000], 0.55,
   ('CAMP ENTRANCE', 'KAMP GİRİŞİ'),
   ('Rebuild the log arch that welcomes campers.', 'Kampçıları karşılayan kütük kemeri yeniden kur.'),
   (0xFFE6F0D8, 0xFF9DBE84, 0xFF5A3A22, 0xFFFF9A3C))

lv('forest_camp_tents', 24, 'mediumHard',
   ['b3_campfire', 'boxes', 'b3_hike', 'b3_pine', 'water', 'lantern'],
   ['###..###',
    '##....##',
    '#..cc..#',
    '........',
    '.C....C.',
    '........',
    '..c..c..',
    '........'],  # tent
   [('b3_campfire', 'b3_campfire', 16), ('b3_tents', 'b3_hike', 15), ('b3_supplies', 'boxes', 15),
    ('lamps', 'lantern', 15), ('tree', 'b3_pine', 14), ('crates', 'crate', 8)],
   [24000, 32000], 0.46,
   ('TENT CIRCLE', 'ÇADIR ALANI'),
   ('Pitch the tents around a crackling fire.', 'Çadırları çıtırdayan ateşin etrafına kur.'),
   (0xFF2E3A5A, 0xFF5A4A6A, 0xFF3A2A1A, 0xFFFFB347, True))

lv('forest_camp_treehouse', 24, 'mediumHard',
   ['saw', 'b3_cabin', 'construction', 'b3_pine', 'compass', 'lantern'],
   ['##....##',
    '#..cc..#',
    '........',
    '.c.ll.c.',
    '##....##',
    '##.cc.##',
    '##....##',
    '##....##'],  # arrow
   [('b3_treehouse', 'b3_cabin', 15), ('b3_ladder', 'construction', 14), ('tree', 'b3_pine', 14),
    ('lamps', 'lantern', 14), ('crates', 'crate', 6), ('b3_rope_bridge', 'chain', 2)],
   [23000, 31000], 0.44,
   ('TREEHOUSE', 'AĞAÇ EV'),
   ('Climb up and fix the hideout in the oak.', 'Yukarı tırman, meşedeki gizli evi onar.'),
   (0xFFE9F3DC, 0xFFA8CF8A, 0xFF6B4423, 0xFF7ACB52))

lv('forest_camp_dock', 28, 'mediumHard',
   ['anchor', 'boat', 'fish', 'rod', 'b3_canoe', 'kayak'],
   ['....####',
    '.i..####',
    '..c.####',
    '....####',
    '........',
    '.i.cc.i.',
    '........',
    '..i..c..'],  # L
   [('b3_canoes', 'b3_canoe', 15), ('fishing', 'rod', 15), ('b3_catch', 'fish', 14), ('boats', 'boat', 15),
    ('b3_dock', 'crate', 4), ('ice', 'ice', 4)],
   [24000, 32000], 0.44,
   ('LAKE DOCK', 'GÖL İSKELESİ'),
   ('Mend the dock and launch the canoes.', 'İskeleyi onar, kanoları suya indir.'),
   (0xFFDDEFF8, 0xFF8CC4E0, 0xFF5A3A22, 0xFF45A7F5))

lv('forest_camp_cabin', 23, 'hard',
   ['furniture', 'hearth', 'bed', 'book', 'window', 'lantern'],
   ['........',
    '.C....C.',
    '...cc...',
    '##....##',
    '##.BB.##',
    '...cc...',
    '.C....C.',
    '........'],  # dumbbell
   [('fireplace', 'hearth', 16), ('b3_bunks', 'bed', 15), ('books', 'book', 15), ('windows', 'window', 15),
    ('furniture', 'furniture', 15), ('crates', 'crate', 16)],
   [25000, 33000], 0.34,
   ('LOG CABIN', 'KÜTÜK KULÜBE'),
   ('Light the hearth in the cabin by the pines.', 'Çamların yanındaki kulübede ocağı yak.'),
   (0xFFF3E2C8, 0xFFC9925A, 0xFF5A3A22, 0xFFFF7A3C))

# ---------------------------------------------------------------- 23 CIRCUS (chains)
lv('circus_entrance', 29, 'mediumHard',
   ['b3_bigtop', 'ticket', 'b3_star', 'b3_acrobat', 'icecream', 'spotlight'],
   ['.##..##.',
    '.##..##.',
    '..l..l..',
    '........',
    '.l....l.',
    '........',
    '...ll...',
    '........'],  # crown
   [('b3_big_top', 'b3_bigtop', 15), ('tickets', 'ticket', 15), ('b3_marquee', 'b3_star', 14),
    ('ice_cream', 'icecream', 14), ('spotlights', 'spotlight', 14), ('chains', 'chain', 6)],
   [23000, 31000], 0.54,
   ('BIG TOP GATE', 'SİRK KAPISI'),
   ('Light up the marquee and open the gates.', 'Işıklı tabelayı yak, kapıları aç.'),
   (0xFFFFF0D6, 0xFFFFB86B, 0xFFB0302A, 0xFFFFC93C))

lv('circus_ring', 31, 'mediumHard',
   ['mask', 'b3_confetti', 'b3_star', 'b3_acrobat', 'b3_paw', 'spotlight'],
   ['........',
    '.L....L.',
    '..#..#..',
    '..####..',
    '..####..',
    '..#..#..',
    '.l....l.',
    '...ll...'],  # ring
   [('b3_acrobats', 'b3_acrobat', 14), ('b3_pedestals', 'b3_star', 13), ('animals', 'b3_paw', 13),
    ('spotlights', 'spotlight', 13), ('chains', 'chain', 6)],
   [24000, 32000], 0.46,
   ('CIRCUS RING', 'SİRK ARENASI'),
   ('Rake the sawdust ring for the grand show.', 'Büyük gösteri için talaş arenayı hazırla.'),
   (0xFF3A1E4A, 0xFF8A2E4A, 0xFFFFC93C, 0xFFFF4F7A, True))

lv('circus_trapeze', 28, 'mediumHard',
   ['b3_bigtop', 'b3_confetti', 'b3_star', 'b3_acrobat', 'music', 'spotlight'],
   ['........',
    '#.l..l.#',
    '##....##',
    '###..###',
    '###..###',
    '##....##',
    '#.l..l.#',
    '........'],  # hourglass
   [('b3_trapeze', 'b3_acrobat', 14), ('b3_net', 'b3_confetti', 13), ('spotlights', 'spotlight', 13),
    ('b3_drums', 'music', 13), ('b3_rigging', 'chain', 4)],
   [21000, 28000], 0.42,
   ('TRAPEZE', 'TRAPEZ'),
   ('Rig the swings high under the canvas.', 'Salıncakları çadırın tepesine as.'),
   (0xFF2A2050, 0xFF6A3A8A, 0xFFE0533F, 0xFF4FD6E8, True))

lv('circus_clowns', 26, 'mediumHard',
   ['mask', 'b3_confetti', 'mirror', 'brush', 'music', 'b3_toy'],
   ['#..##..#',
    '..l..l..',
    '........',
    '.j....j.',
    '#......#',
    '##.ll.##',
    '###..###',
    '########'],  # heart
   [('masks', 'mask', 14), ('mirror', 'mirror', 14), ('b3_makeup', 'brush', 14), ('b3_toys', 'b3_toy', 14),
    ('chains', 'chain', 5)],
   [22000, 29000], 0.42,
   ('CLOWN ROOM', 'PALYAÇO ODASI'),
   ('Find the red noses and polish the mirrors.', 'Kırmızı burunları bul, aynaları parlat.'),
   (0xFFFFE6F0, 0xFFFF9AC4, 0xFF6B3FA0, 0xFFFF5A6E))

lv('circus_caravans', 28, 'hard',
   ['animals', 'b3_confetti', 'hay', 'b3_acrobat', 'b3_paw', 'b3_toy'],
   ['...##...',
    '.l.##.l.',
    '...##...',
    '..L..L..',
    '........',
    '...##...',
    '.j.##.j.',
    '...##...'],  # twin rooms
   [('b3_caravans', 'b3_confetti', 15), ('animals', 'animals', 15), ('hay', 'hay', 14), ('b3_acrobats', 'b3_acrobat', 14),
    ('chains', 'chain', 6)],
   [25000, 33000], 0.34,
   ('CARAVANS', 'KARAVANLAR'),
   ('Paint the wagons before the circus rolls on.', 'Sirk yola çıkmadan vagonları boya.'),
   (0xFFFFF2D6, 0xFFE8B86B, 0xFF8A3A2A, 0xFF4FB548))

# ---------------------------------------------------------------- 24 DESERT OASIS (keys + crates)
lv('oasis_camp', 23, 'mediumHard',
   ['b3_campfire', 'luggage', 'sun', 'palm', 'b3_spring', 'sunshade'],
   ['....####',
    '.....###',
    '..c...##',
    '.......#',
    '..c..c..',
    '........',
    '.c....c.',
    '........'],  # staircase
   [('b3_canopies', 'sunshade', 15), ('palms', 'palm', 15), ('luggage', 'luggage', 15), ('b3_campfire', 'b3_campfire', 14),
    ('chests', 'key', 2), ('crates', 'crate', 5)],
   [23000, 31000], 0.52,
   ('CARAVAN CAMP', 'KERVAN KAMPI'),
   ('Shade the camp where the caravans rest.', 'Kervanların dinlendiği kampa gölge yap.'),
   (0xFFFFF1D6, 0xFFF2C27A, 0xFF8A5A2A, 0xFFFF9A3C))

lv('oasis_spring', 24, 'mediumHard',
   ['flower', 'b3_coffee', 'sun', 'palm', 'b3_spring', 'sunshade'],
   ['#......#',
    '........',
    '..i..i..',
    '...ii...',
    '...ii...',
    '..i..i..',
    '........',
    '#......#'],  # pill
   [('b3_spring_pool', 'b3_spring', 16), ('palms', 'palm', 16), ('flowers', 'flower', 15), ('sunshades', 'sunshade', 15),
    ('ice', 'ice', 8), ('b3_jars', 'key', 3)],
   [25000, 33000], 0.45,
   ('PALM SPRING', 'PALMİYE PINARI'),
   ('Let the cool spring flow under the palms.', 'Serin pınar palmiyelerin altından aksın.'),
   (0xFFE0F6F2, 0xFF7FD0C8, 0xFF2E6E6A, 0xFF4FD6E8))

lv('oasis_bazaar', 25, 'mediumHard',
   ['jewel', 'b3_spice', 'gold_lamp', 'herbs', 'glass', 'curtain'],
   ['...##...',
    '.c.##.c.',
    '...##...',
    '..c..c..',
    '........',
    '.C.ll.C.',
    '........',
    '........'],  # fork
   [('b3_spices', 'b3_spice', 16), ('lamps', 'gold_lamp', 15), ('b3_jewelry', 'jewel', 15), ('b3_rugs', 'curtain', 15),
    ('crates', 'crate', 8), ('chests', 'key', 3)],
   [25000, 33000], 0.44,
   ('BAZAAR', 'ÇARŞI'),
   ('Fill the market stalls with spice and silk.', 'Pazar tezgâhlarını baharat ve ipekle doldur.'),
   (0xFFFFEBD0, 0xFFE89A5A, 0xFF7A2E2A, 0xFFFFC93C))

lv('oasis_palace', 30, 'mediumHard',
   ['b3_palace', 'lounge', 'gold_lamp', 'plants', 'b3_gem', 'b3_moon'],
   ['.#.##.#.',
    '........',
    '.l.cc.l.',
    '........',
    '..L..L..',
    '........',
    '.c.jj.c.',
    '........'],  # battlement
   [('b3_arches', 'b3_palace', 16), ('lamps', 'gold_lamp', 15), ('b3_jewelry', 'b3_gem', 15), ('b3_cushions', 'lounge', 15),
    ('chains', 'chain', 8), ('chests', 'key', 3)],
   [25000, 33000], 0.42,
   ('PALACE HALL', 'SARAY SALONU'),
   ('Polish the arches of the desert palace.', 'Çöl sarayının kemerlerini parlat.'),
   (0xFFFFF4E0, 0xFFE8C08A, 0xFF2E5A8A, 0xFF45A7F5))

lv('oasis_rooftop', 23, 'hard',
   ['b3_palace', 'b3_coffee', 'b3_sunset', 'palm', 'fountain', 'b3_moon'],
   ['....####',
    '.l...###',
    '..c...##',
    '...i...#',
    '#...i...',
    '##...c..',
    '###..l..',
    '####....'],  # diagonal
   [('fountain', 'fountain', 15), ('b3_lanterns', 'b3_moon', 15), ('palms', 'palm', 14), ('b3_coffee_set', 'b3_coffee', 14),
    ('chests', 'key', 3), ('crates', 'crate', 2)],
   [24000, 32000], 0.33,
   ('SUNSET ROOFTOP', 'ÇATI TERASI'),
   ('Watch the dunes glow from the palace roof.', 'Saray çatısından parlayan kumulları izle.'),
   (0xFFFFD6A0, 0xFFE0607A, 0xFF5A2A4A, 0xFFFF9A3C))

# ---------------------------------------------------------------- 25 PIRATE SHIP (all + keys)
lv('pirate_ship_dock', 27, 'mediumHard',
   ['anchor', 'boat', 'b3_coin', 'b3_parrot', 'wave', 'cargo'],
   ['####....',
    '####.c..',
    '####....',
    '####..c.',
    '........',
    '.c..l...',
    '...l..c.',
    '........'],  # L mirrored
   [('anchors', 'anchor', 15), ('boats', 'boat', 15), ('cargo', 'cargo', 15), ('b3_parrots', 'b3_parrot', 14),
    ('crates', 'crate', 4), ('b3_treasure', 'key', 2)],
   [23000, 31000], 0.52,
   ('PIRATE DOCK', 'KORSAN İSKELESİ'),
   ('Load the cargo onto the old pirate ship.', 'Yükü eski korsan gemisine taşı.'),
   (0xFFDDEEF6, 0xFF7FB6D8, 0xFF5A3A22, 0xFFE0533F))

lv('pirate_ship_deck', 24, 'mediumHard',
   ['b3_flag', 'b3_chest', 'b3_coin', 'b3_parrot', 'compass', 'b3_map'],
   ['........',
    '.l....l.',
    '...cc...',
    '.i....i.',
    '........',
    '#.c..c.#',
    '##....##',
    '###..###'],  # hull
   [('b3_sails', 'b3_flag', 16), ('b3_ship_wheel', 'compass', 15), ('b3_barrels', 'b3_chest', 15), ('b3_cannons', 'b3_coin', 15),
    ('crates', 'crate', 4), ('b3_ropes', 'chain', 2)],
   [24000, 32000], 0.45,
   ('MAIN DECK', 'ANA GÜVERTE'),
   ('Hoist the sails and man the wheel.', 'Yelkenleri fora et, dümene geç.'),
   (0xFFE0F0FA, 0xFF6FB0DA, 0xFF4A2E1A, 0xFFFFC93C))

lv('pirate_ship_cabin', 28, 'mediumHard',
   ['anchor', 'b3_chest', 'b3_coin', 'b3_parrot', 'compass', 'b3_map'],
   ['##....##',
    '#.j..j.#',
    '...cc...',
    '.l....l.',
    '.l....l.',
    '...cc...',
    '#.j..j.#',
    '##....##'],  # octagon (porthole)
   [('maps', 'b3_map', 15), ('globes', 'compass', 15), ('b3_gold', 'b3_coin', 15), ('b3_parrots', 'b3_parrot', 15),
    ('chains', 'chain', 7), ('b3_treasure', 'key', 2)],
   [24000, 32000], 0.42,
   ("CAPTAIN'S CABIN", 'KAPTAN KAMARASI'),
   ('Chart a course from the captain\'s desk.', 'Kaptanın masasında rotayı çiz.'),
   (0xFFF3E2C8, 0xFFB98A5A, 0xFF4A2E1A, 0xFFFFC93C))

lv('pirate_ship_hold', 25, 'mediumHard',
   ['anchor', 'b3_chest', 'b3_coin', 'rod', 'compass', 'cargo'],
   ['........',
    '.#.cc.#.',
    '..c..c..',
    '.C....C.',
    '...BB...',
    '.c....c.',
    '.#.ll.#.',
    '........'],  # pillars
   [('cargo', 'cargo', 16), ('chests', 'b3_chest', 15), ('b3_gold', 'b3_coin', 15), ('b3_ropes', 'rod', 15),
    ('crates', 'crate', 14), ('b3_treasure', 'key', 2)],
   [25000, 33000], 0.42,
   ('CARGO HOLD', 'AMBAR'),
   ('Sort the barrels deep in the ship\'s hold.', 'Geminin ambarındaki fıçıları düzenle.'),
   (0xFFE8D8C0, 0xFF9A7A5A, 0xFF3A2414, 0xFFFF9A3C))

lv('pirate_ship_island', 22, 'hard',
   ['b3_flag', 'b3_chest', 'b3_coin', 'palm', 'wave', 'b3_map'],
   ['###..###',
    '##....##',
    '#..cc..#',
    '..l..l..',
    '..i..i..',
    '#..cc..#',
    '##....##',
    '###..###'],  # diamond (island)
   [('palms', 'palm', 14), ('maps', 'b3_map', 14), ('b3_gold', 'b3_coin', 14), ('chests', 'b3_chest', 14),
    ('b3_treasure', 'key', 3), ('crates', 'crate', 4)],
   [24000, 32000], 0.30,
   ('TREASURE BEACH', 'HAZİNE PLAJI'),
   ('Dig where the X marks the spot.', 'X işaretinin olduğu yeri kaz.'),
   (0xFFFFF1C8, 0xFF5FC8E0, 0xFF8A5A2A, 0xFFFFC93C))


# ============================================================================ art
DART = r'''
// ---------------------------------------------------------------- palette
const _red = Color(0xFFE0533F);
const _vermilion = Color(0xFFE2462F);
const _wood = Color(0xFFC98A52);
const _darkWood = Color(0xFF8B5E3C);
const _bark = Color(0xFF6B4A3A);
const _cream = Color(0xFFFFF1DA);
const _paper = Color(0xFFFFF6E6);
const _gold = Color(0xFFFFC93C);
const _leaf = Color(0xFF55C04A);
const _green = Color(0xFF4FB548);
const _pine = Color(0xFF2E7D4F);
const _bamboo = Color(0xFF8BC34A);
const _moss = Color(0xFF6E9E4A);
const _pink = Color(0xFFFF7AB6);
const _sakura = Color(0xFFFFB3CF);
const _blue = Color(0xFF45A7F5);
const _aqua = Color(0xFF4FD6E8);
const _water = Color(0xFF4FB8D8);
const _teal = Color(0xFF2BB3A0);
const _white = Color(0xFFFFFFFF);
const _stone = Color(0xFFCFC8BA);
const _slate = Color(0xFF8E887C);
const _ink = Color(0xFF3B3452);
const _navy = Color(0xFF2B3A67);
const _orange = Color(0xFFFF9A3C);
const _koiOrange = Color(0xFFFF7A2F);
const _flame = Color(0xFFFFB347);
const _lampGlow = Color(0xFFFFE9A0);
const _purple = Color(0xFF8A5CE6);
const _iris = Color(0xFF7A5CE6);
const _sand = Color(0xFFE8C98A);
const _terracotta = Color(0xFFE07A4F);
const _straw = Color(0xFFE8C66B);
const _canvas = Color(0xFFF4E8D0);
const _steel = Color(0xFFC9CCD8);
const _iron = Color(0xFF4A4658);
const _rope = Color(0xFFC9A36B);
const _brass = Color(0xFFD9A441);
const _lotus = Color(0xFFFF9AC4);
const _maroon = Color(0xFF8A2E4A);
const _ebony = Color(0xFF2B2440);
const _parchment = Color(0xFFF2DFB0);
const _olive = Color(0xFF7A8A3A);

RRect _rr(Rect r, double rad) => RRect.fromRectAndRadius(r, Radius.circular(rad));

/// Rect at fractions of [r].
Rect _f(Rect r, double x, double y, double w, double h) =>
    Rect.fromLTWH(r.left + r.width * x, r.top + r.height * y, r.width * w, r.height * h);

/// Point at fractions of [r].
Offset _o(Rect r, double x, double y) => Offset(r.left + r.width * x, r.top + r.height * y);

void _star(Canvas c, Offset o, double rad, Color col) {
  final pts = <Offset>[];
  for (var i = 0; i < 10; i++) {
    final a = -pi / 2 + i * pi / 5;
    final k = i.isEven ? rad : rad * 0.45;
    pts.add(o + Offset(cos(a), sin(a)) * k);
  }
  Pk.poly(c, pts, Pk.fill(col));
}

/// Swings everything drawn in [draw] around [pivot] by [angle].
void _swing(Canvas c, Offset pivot, double angle, void Function() draw) {
  c.save();
  c.translate(pivot.dx, pivot.dy);
  c.rotate(angle);
  c.translate(-pivot.dx, -pivot.dy);
  draw();
  c.restore();
}

void _steam(Canvas c, Offset o, double t, double s) {
  for (var i = 0; i < 3; i++) {
    final k = (t * 0.5 + i / 3) % 1;
    c.drawCircle(o + Offset(sin(k * 6 + i) * 2.5, -k * 18 * s), (1.5 + k * 3) * s, Pk.fill(Colors.white.withValues(alpha: 0.45 * (1 - k))));
  }
}

// ---------------------------------------------------------------- Japanese garden
void _paintTorii(Canvas c, Rect r, Color a, Color b, double t) {
  for (final x in [0.15, 0.75]) {
    Pk.poly(c, [_o(r, x + 0.01, 0.2), _o(r, x + 0.09, 0.2), _o(r, x + 0.105, 0.94), _o(r, x - 0.005, 0.94)], Pk.fill(a));
    Pk.box(c, _f(r, x - 0.015, 0.9, 0.13, 0.1), _ebony, radius: 1.5);
  }
  Pk.box(c, _f(r, 0.05, 0.34, 0.9, 0.07), a, radius: 1.5);
  Pk.box(c, _f(r, 0.44, 0.16, 0.12, 0.17), _ebony, radius: 1.5);
  c.drawRect(_f(r, 0.465, 0.19, 0.07, 0.11), Pk.fill(b));
  Pk.box(c, _f(r, 0.03, 0.12, 0.94, 0.07), a, radius: 1.5);
  final top = Path()
    ..moveTo(r.left - r.width * 0.03, r.top)
    ..quadraticBezierTo(r.center.dx, r.top + r.height * 0.11, r.right + r.width * 0.03, r.top)
    ..lineTo(r.right - r.width * 0.01, r.top + r.height * 0.09)
    ..quadraticBezierTo(r.center.dx, r.top + r.height * 0.17, r.left + r.width * 0.01, r.top + r.height * 0.09)
    ..close();
  c.drawPath(top, Pk.fill(_ebony));
  c.drawPath(
    Path()
      ..moveTo(r.left, r.top + r.height * 0.02)
      ..quadraticBezierTo(r.center.dx, r.top + r.height * 0.12, r.right, r.top + r.height * 0.02),
    Pk.stroke(Colors.white.withValues(alpha: 0.18), 1.2),
  );
}

void _paintToro(Canvas c, Rect r, Color a, Color b, double t) {
  final dk = Pk.dark(a, 0.16);
  Pk.box(c, _f(r, 0.16, 0.88, 0.68, 0.12), dk, radius: 2);
  Pk.box(c, _f(r, 0.37, 0.58, 0.26, 0.32), a, radius: 2);
  Pk.box(c, _f(r, 0.12, 0.5, 0.76, 0.09), dk, radius: 2);
  Pk.box(c, _f(r, 0.22, 0.3, 0.56, 0.21), a, radius: 2);
  final win = _f(r, 0.35, 0.34, 0.3, 0.12);
  Pk.glow(c, win.center, r.width * 0.75, b, 0.45 + 0.12 * sin(t * 3 + r.left));
  c.drawRRect(_rr(win, 1.5), Pk.fill(b));
  c.drawLine(win.topCenter, win.bottomCenter, Pk.stroke(dk, 1));
  Pk.poly(c, [_o(r, -0.02, 0.32), _o(r, 0.24, 0.15), _o(r, 0.76, 0.15), _o(r, 1.02, 0.32), _o(r, 0.9, 0.3), _o(r, 0.1, 0.3)], Pk.fill(dk));
  Pk.box(c, _f(r, 0.4, 0.08, 0.2, 0.08), dk, radius: 2);
  c.drawCircle(_o(r, 0.5, 0.05), r.width * 0.08, Pk.fill(a));
  // Moss on the roof.
  c.drawOval(_f(r, 0.3, 0.16, 0.2, 0.05), Pk.fill(_moss.withValues(alpha: 0.7)));
}

void _paintBamboo(Canvas c, Rect r, Color a, Color b, double t) {
  const n = 5;
  for (var i = 0; i < n; i++) {
    final x = r.left + r.width * (0.1 + i * 0.8 / (n - 1));
    final sw = r.width * 0.1;
    final lean = sin(t * 0.8 + i) * 1.2 + (i - 2) * 1.5;
    final top = r.top + r.height * (0.04 + Pk.rand(i + 3) * 0.16);
    final col = i.isEven ? a : Pk.dark(a, 0.14);
    c.drawPath(
      Path()
        ..moveTo(x - sw / 2, r.bottom)
        ..lineTo(x - sw / 2 + lean, top)
        ..lineTo(x + sw / 2 + lean, top)
        ..lineTo(x + sw / 2, r.bottom)
        ..close(),
      Pk.fill(col),
    );
    for (var y = r.bottom - r.height * 0.17; y > top + 6; y -= r.height * 0.17) {
      final k = (r.bottom - y) / (r.bottom - top);
      c.drawLine(Offset(x - sw / 2 + lean * k, y), Offset(x + sw / 2 + lean * k, y), Pk.stroke(Pk.dark(a, 0.38), 1.2));
    }
    for (var j = 0; j < 4; j++) {
      c.save();
      c.translate(x + lean * 0.95, top + r.height * (0.05 + j * 0.08));
      c.rotate((j.isEven ? -1 : 1) * (1.0 + 0.12 * sin(t * 1.3 + i + j)));
      c.drawOval(Rect.fromCenter(center: Offset(0, -r.width * 0.1), width: r.width * 0.06, height: r.width * 0.2), Pk.fill(Pk.light(a, 0.08)));
      c.restore();
    }
  }
}

void _paintCherry(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawPath(
    Path()
      ..moveTo(r.left + r.width * 0.42, r.bottom)
      ..quadraticBezierTo(r.left + r.width * 0.42, r.top + r.height * 0.62, r.left + r.width * 0.28, r.top + r.height * 0.44)
      ..lineTo(r.left + r.width * 0.34, r.top + r.height * 0.41)
      ..quadraticBezierTo(r.left + r.width * 0.5, r.top + r.height * 0.56, r.left + r.width * 0.68, r.top + r.height * 0.4)
      ..lineTo(r.left + r.width * 0.72, r.top + r.height * 0.44)
      ..quadraticBezierTo(r.left + r.width * 0.56, r.top + r.height * 0.62, r.left + r.width * 0.58, r.bottom)
      ..close(),
    Pk.fill(_bark),
  );
  const blobs = [(0.3, 0.3, 0.2), (0.55, 0.2, 0.24), (0.76, 0.33, 0.19), (0.16, 0.44, 0.14), (0.46, 0.4, 0.19), (0.86, 0.48, 0.12)];
  for (final (x, y, s) in blobs) {
    c.drawCircle(_o(r, x, y), r.width * s, Pk.fill(Pk.dark(a, 0.1)));
  }
  for (final (x, y, s) in blobs) {
    c.drawCircle(_o(r, x, y - 0.03), r.width * s * 0.84, Pk.fill(a));
  }
  for (final (x, y, s) in blobs) {
    c.drawCircle(_o(r, x - 0.05, y - 0.07), r.width * s * 0.34, Pk.fill(Pk.light(a, 0.4)));
  }
  for (var i = 0; i < 7; i++) {
    final k = (t * 0.12 + Pk.rand(i + r.left.toInt())) % 1;
    final p = Offset(r.left + r.width * (0.1 + Pk.rand(i + 7) * 0.8) + sin(t * 1.5 + i) * 4, r.top + r.height * (0.45 + k * 0.53));
    c.drawOval(Rect.fromCenter(center: p, width: 3.2, height: 2), Pk.fill(b.withValues(alpha: 0.9 * (1 - k))));
  }
}

void _paintBasin(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawLine(_o(r, 0.92, 0.05), _o(r, 0.92, 0.6), Pk.stroke(Pk.dark(_bamboo, 0.15), r.width * 0.07));
  c.drawLine(_o(r, 0.95, 0.16), _o(r, 0.56, 0.3), Pk.stroke(_bamboo, r.width * 0.06));
  final k = (t * 1.6) % 1;
  c.drawCircle(Offset(r.left + r.width * 0.55, r.top + r.height * (0.34 + k * 0.12)), 1.6, Pk.fill(b.withValues(alpha: 1 - k)));
  Pk.box(c, _f(r, 0.08, 0.44, 0.74, 0.56), a, radius: r.height * 0.22);
  c.drawOval(_f(r, 0.16, 0.42, 0.58, 0.17), Pk.fill(Pk.dark(a, 0.28)));
  c.drawOval(_f(r, 0.19, 0.445, 0.52, 0.12), Pk.fill(b));
  c.drawOval(Rect.fromCenter(center: _o(r, 0.45, 0.5), width: r.width * 0.12 * (1 + k), height: r.height * 0.04 * (1 + k)),
      Pk.stroke(Colors.white.withValues(alpha: 0.6 * (1 - k)), 0.8));
  c.drawOval(_f(r, -0.04, 0.82, 0.22, 0.18), Pk.fill(Pk.dark(a, 0.08)));
  c.drawOval(_f(r, 0.8, 0.86, 0.2, 0.14), Pk.fill(Pk.light(a, 0.08)));
  c.drawOval(_f(r, 0.2, 0.47, 0.18, 0.06), Pk.fill(_moss.withValues(alpha: 0.6)));
}

void _paintKoi(Canvas c, Rect r, Color a, Color b, double t) {
  for (var i = 0; i < 3; i++) {
    final dir = i.isEven ? 1.0 : -1.0;
    final ang = dir * t * (0.45 + i * 0.1) + i * 2.1;
    final p = Offset(r.center.dx + cos(ang) * r.width * (0.3 - i * 0.04), r.center.dy + sin(ang) * r.height * (0.28 - i * 0.04));
    final len = min(r.width * 0.2, r.height * 0.7);
    final body = i == 1 ? b : a, patch = i == 1 ? a : b;
    c.save();
    c.translate(p.dx, p.dy);
    c.rotate(ang + dir * pi / 2);
    c.scale(1, 0.6);
    final wag = sin(t * 6 + i) * len * 0.12;
    Pk.poly(c, [Offset(-len * 0.4, 0), Offset(-len * 0.75, -len * 0.22 + wag), Offset(-len * 0.75, len * 0.22 + wag)], Pk.fill(Pk.alpha(body, 0.9)));
    c.drawPath(
      Path()
        ..moveTo(-len * 0.5, 0)
        ..quadraticBezierTo(0, -len * 0.3, len * 0.5, 0)
        ..quadraticBezierTo(0, len * 0.3, -len * 0.5, 0)
        ..close(),
      Pk.fill(body),
    );
    c.drawCircle(Offset(len * 0.1, -len * 0.04), len * 0.11, Pk.fill(patch));
    c.drawCircle(Offset(-len * 0.18, len * 0.04), len * 0.07, Pk.fill(patch));
    c.restore();
  }
  for (var i = 0; i < 2; i++) {
    final k = (t * 0.4 + i * 0.5) % 1;
    c.drawOval(Rect.fromCenter(center: _o(r, 0.3 + i * 0.4, 0.5), width: r.width * 0.2 * (0.5 + k), height: r.height * 0.18 * (0.5 + k)),
        Pk.stroke(Colors.white.withValues(alpha: 0.45 * (1 - k)), 1));
  }
}

void _paintLotus(Canvas c, Rect r, Color a, Color b, double t) {
  for (final (x, y, s) in [(0.22, 0.72, 0.44), (0.74, 0.78, 0.38), (0.56, 0.52, 0.32)]) {
    final pr = Rect.fromCenter(center: _o(r, x, y), width: r.width * s, height: r.width * s * 0.42);
    c.drawOval(pr, Pk.fill(Pk.dark(_leaf, 0.18)));
    c.drawOval(pr.deflate(1.4), Pk.fill(_leaf));
    c.drawLine(pr.center, Offset(pr.right - 2, pr.center.dy - 1), Pk.stroke(Pk.dark(_leaf, 0.25), 1));
  }
  final f = _o(r, 0.42, 0.5);
  final s = r.width * 0.13;
  for (var i = 0; i < 5; i++) {
    c.save();
    c.translate(f.dx, f.dy);
    c.rotate((i - 2) * 0.5);
    c.drawOval(Rect.fromCenter(center: Offset(0, -s * 0.7), width: s * 0.7, height: s * 1.5), Pk.fill(i == 2 ? Pk.light(a, 0.25) : a));
    c.restore();
  }
  c.drawCircle(f + Offset(0, -s * 0.25), s * 0.24, Pk.fill(_gold));
}

void _paintChochin(Canvas c, Rect r, Color a, Color b, double t) {
  _swing(c, r.topCenter, sin(t * 1.2 + r.left) * 0.06, () {
    c.drawLine(r.topCenter, _o(r, 0.5, 0.18), Pk.stroke(_ink, 1));
    final body = _f(r, 0.06, 0.25, 0.88, 0.64);
    Pk.glow(c, body.center, r.width * 1.4, b, 0.5);
    c.drawOval(body, Pk.fill(a));
    c.drawOval(_f(r, 0.28, 0.38, 0.44, 0.36), Pk.fill(Pk.light(b, 0.4).withValues(alpha: 0.55)));
    final ribs = Pk.stroke(Pk.dark(a, 0.28), 0.8);
    for (var i = 1; i < 6; i++) {
      final y = body.top + body.height * i / 6;
      final dy = (y - body.center.dy) / (body.height / 2);
      final half = body.width / 2 * sqrt(max(0.0, 1 - dy * dy));
      c.drawLine(Offset(body.center.dx - half, y), Offset(body.center.dx + half, y), ribs);
    }
    Pk.box(c, _f(r, 0.26, 0.18, 0.48, 0.1), _ebony, radius: 1.5);
    Pk.box(c, _f(r, 0.26, 0.86, 0.48, 0.1), _ebony, radius: 1.5);
  });
}

void _paintTeaSet(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, _f(r, 0.0, 0.8, 1.0, 0.2), b, radius: 3);
  c.drawLine(_o(r, 0.48, 0.55), _o(r, 0.64, 0.42), Pk.stroke(a, r.height * 0.08));
  c.drawOval(_f(r, 0.1, 0.36, 0.42, 0.44), Pk.fill(a));
  c.drawArc(_f(r, 0.16, 0.14, 0.3, 0.42), pi, pi, false, Pk.stroke(_darkWood, 2));
  c.drawOval(_f(r, 0.21, 0.32, 0.2, 0.08), Pk.fill(Pk.dark(a, 0.2)));
  c.drawCircle(_o(r, 0.31, 0.31), r.height * 0.04, Pk.fill(Pk.dark(a, 0.32)));
  for (final x in [0.62, 0.81]) {
    Pk.box(c, _f(r, x, 0.58, 0.14, 0.22), _cream, radius: 2);
    c.drawRect(_f(r, x + 0.01, 0.58, 0.12, 0.05), Pk.fill(const Color(0xFF8BC34A)));
  }
  _steam(c, _o(r, 0.69, 0.55), t, 0.6);
}

void _paintCushion(Canvas c, Rect r, Color a, Color b, double t) {
  final top = [_o(r, 0.1, 0.0), _o(r, 0.9, 0.0), _o(r, 1.0, 0.68), _o(r, 0.0, 0.68)];
  Pk.poly(c, [_o(r, 0.0, 0.68), _o(r, 1.0, 0.68), _o(r, 0.98, 1.0), _o(r, 0.02, 1.0)], Pk.fill(Pk.dark(a, 0.28)));
  Pk.poly(c, top, Pk.fill(a));
  Pk.poly(c, [_o(r, 0.2, 0.12), _o(r, 0.8, 0.12), _o(r, 0.86, 0.56), _o(r, 0.14, 0.56)], Pk.stroke(Pk.light(a, 0.2), 1));
  c.drawCircle(_o(r, 0.5, 0.34), r.height * 0.09, Pk.fill(b));
  for (final p in top) {
    c.drawCircle(p, 1.8, Pk.fill(b));
  }
}

void _paintBonsai(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.poly(c, [_o(r, 0.12, 0.76), _o(r, 0.88, 0.76), _o(r, 0.8, 1), _o(r, 0.2, 1)], Pk.fill(b));
  c.drawRect(_f(r, 0.06, 0.72, 0.88, 0.07), Pk.fill(Pk.dark(b, 0.18)));
  c.drawPath(
    Path()
      ..moveTo(r.left + r.width * 0.44, r.top + r.height * 0.74)
      ..cubicTo(r.left + r.width * 0.28, r.top + r.height * 0.56, r.left + r.width * 0.72, r.top + r.height * 0.46, r.left + r.width * 0.5, r.top + r.height * 0.24),
    Pk.stroke(_bark, r.width * 0.09),
  );
  c.drawLine(_o(r, 0.54, 0.44), _o(r, 0.8, 0.36), Pk.stroke(_bark, r.width * 0.05));
  c.drawLine(_o(r, 0.42, 0.56), _o(r, 0.18, 0.48), Pk.stroke(_bark, r.width * 0.05));
  for (final (x, y, w) in [(0.5, 0.2, 0.52), (0.8, 0.32, 0.34), (0.18, 0.45, 0.34)]) {
    final pr = Rect.fromCenter(center: _o(r, x, y), width: r.width * w, height: r.height * 0.17);
    c.drawOval(pr, Pk.fill(Pk.dark(a, 0.15)));
    c.drawOval(pr.translate(0, -1.5).deflate(1.4), Pk.fill(a));
    c.drawOval(Rect.fromCenter(center: pr.center + Offset(-pr.width * 0.15, -pr.height * 0.2), width: pr.width * 0.3, height: pr.height * 0.3),
        Pk.fill(Pk.light(a, 0.25)));
  }
}

void _paintShoji(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, r, a, radius: 1);
  final inner = r.deflate(3.5);
  Pk.gradientRect(c, inner, _paper, Pk.mix(_paper, b, 0.4));
  final grid = Pk.stroke(a, 1.3);
  for (var i = 1; i < 4; i++) {
    final x = inner.left + inner.width * i / 4;
    c.drawLine(Offset(x, inner.top), Offset(x, inner.bottom), i == 2 ? Pk.stroke(Pk.dark(a, 0.15), 2.5) : grid);
  }
  for (var j = 1; j < 5; j++) {
    final y = inner.top + inner.height * j / 5;
    c.drawLine(Offset(inner.left, y), Offset(inner.right, y), grid);
  }
  c.drawRect(Rect.fromLTWH(inner.left, inner.bottom - inner.height * 0.18, inner.width, inner.height * 0.18), Pk.fill(Pk.dark(a, 0.05)));
}

void _paintKettle(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, _f(r, 0.08, 0.62, 0.84, 0.38), _darkWood, radius: 3);
  c.drawRect(_f(r, 0.18, 0.6, 0.64, 0.06), Pk.fill(_iron));
  Pk.glow(c, _o(r, 0.5, 0.63), r.width * 0.45, b, 0.45 + 0.1 * sin(t * 5));
  c.drawLine(_o(r, 0.72, 0.42), _o(r, 0.92, 0.28), Pk.stroke(a, r.height * 0.07));
  final body = _f(r, 0.2, 0.22, 0.6, 0.42);
  c.drawOval(body, Pk.fill(a));
  for (var i = 0; i < 4; i++) {
    for (var j = 0; j < 2; j++) {
      c.drawCircle(_o(r, 0.32 + i * 0.12, 0.36 + j * 0.1), 1.1, Pk.fill(Pk.light(a, 0.22)));
    }
  }
  c.drawArc(_f(r, 0.26, 0.04, 0.48, 0.42), pi, pi, false, Pk.stroke(Pk.dark(a, 0.25), 2));
  c.drawOval(_f(r, 0.38, 0.19, 0.24, 0.07), Pk.fill(Pk.dark(a, 0.35)));
  _steam(c, _o(r, 0.92, 0.26), t, 0.6);
}

void _paintScroll(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawLine(Offset(r.center.dx, r.top - 6), _o(r, 0.15, 0.0), Pk.stroke(_ink, 0.8));
  c.drawLine(Offset(r.center.dx, r.top - 6), _o(r, 0.85, 0.0), Pk.stroke(_ink, 0.8));
  Pk.box(c, _f(r, 0.0, 0.02, 1.0, 0.94), a, radius: 1);
  final paper = _f(r, 0.12, 0.12, 0.76, 0.7);
  c.drawRect(paper, Pk.fill(_paper));
  c.drawCircle(_o(r, 0.64, 0.28), r.width * 0.11, Pk.fill(b));
  Pk.poly(c, [_o(r, 0.12, 0.8), _o(r, 0.38, 0.44), _o(r, 0.54, 0.62), _o(r, 0.7, 0.5), _o(r, 0.88, 0.8)],
      Pk.fill(const Color(0xFF5A5A6A).withValues(alpha: 0.75)));
  Pk.poly(c, [_o(r, 0.32, 0.52), _o(r, 0.38, 0.44), _o(r, 0.44, 0.52)], Pk.fill(Colors.white));
  c.drawRect(_f(r, -0.1, 0.0, 1.2, 0.05), Pk.fill(_darkWood));
  c.drawRect(_f(r, -0.12, 0.94, 1.24, 0.06), Pk.fill(_darkWood));
}

void _paintShrine(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, _f(r, 0.08, 0.8, 0.84, 0.2), _stone, radius: 2);
  Pk.box(c, _f(r, 0.2, 0.42, 0.6, 0.4), a, radius: 2);
  c.drawRect(_f(r, 0.33, 0.52, 0.34, 0.28), Pk.fill(Pk.dark(a, 0.42)));
  c.drawLine(_o(r, 0.5, 0.52), _o(r, 0.5, 0.8), Pk.stroke(_gold, 1.2));
  c.drawPath(
    Path()
      ..moveTo(r.left - r.width * 0.04, r.top + r.height * 0.46)
      ..quadraticBezierTo(r.left + r.width * 0.3, r.top + r.height * 0.34, r.center.dx, r.top + r.height * 0.06)
      ..quadraticBezierTo(r.left + r.width * 0.7, r.top + r.height * 0.34, r.right + r.width * 0.04, r.top + r.height * 0.46)
      ..close(),
    Pk.fill(Pk.dark(_teal, 0.35)),
  );
  c.drawLine(_o(r, 0.18, 0.46), _o(r, 0.82, 0.46), Pk.stroke(_straw, 2.2));
  for (final x in [0.32, 0.5, 0.68]) {
    Pk.poly(c, [_o(r, x - 0.03, 0.47), _o(r, x + 0.03, 0.47), _o(r, x + 0.01, 0.56), _o(r, x + 0.04, 0.6), _o(r, x - 0.02, 0.6)], Pk.fill(_white));
  }
  c.drawCircle(_o(r, 0.5, 0.06), r.width * 0.05, Pk.fill(b));
}

void _paintChime(Canvas c, Rect r, Color a, Color b, double t) {
  final sway = sin(t * 2.2 + r.left) * 0.14;
  _swing(c, r.topCenter, sway * 0.35, () {
    c.drawLine(r.topCenter, _o(r, 0.5, 0.16), Pk.stroke(_ink, 1));
    c.drawPath(
      Path()
        ..moveTo(r.left + r.width * 0.12, r.top + r.height * 0.44)
        ..quadraticBezierTo(r.left + r.width * 0.12, r.top + r.height * 0.13, r.center.dx, r.top + r.height * 0.13)
        ..quadraticBezierTo(r.right - r.width * 0.12, r.top + r.height * 0.13, r.right - r.width * 0.12, r.top + r.height * 0.44)
        ..close(),
      Pk.fill(a.withValues(alpha: 0.8)),
    );
    c.drawCircle(_o(r, 0.5, 0.3), r.width * 0.09, Pk.fill(b));
    c.drawLine(_o(r, 0.3, 0.28), _o(r, 0.38, 0.19), Pk.stroke(Colors.white.withValues(alpha: 0.8), 1.2));
    _swing(c, _o(r, 0.5, 0.44), sway, () {
      c.drawLine(_o(r, 0.5, 0.44), _o(r, 0.5, 0.6), Pk.stroke(_ink, 0.8));
      c.drawRect(_f(r, 0.34, 0.6, 0.32, 0.38), Pk.fill(b));
    });
  });
}

void _paintBridge(Canvas c, Rect r, Color a, Color b, double t) {
  double deckY(double k, double ctrl) => (1 - k) * (1 - k) * r.bottom + 2 * k * (1 - k) * ctrl + k * k * r.bottom;
  final topCtrl = r.top - r.height * 0.1, underCtrl = r.top + r.height * 0.42;
  final deck = Path()
    ..moveTo(r.left, r.bottom)
    ..quadraticBezierTo(r.center.dx, topCtrl, r.right, r.bottom)
    ..lineTo(r.right - r.width * 0.07, r.bottom)
    ..quadraticBezierTo(r.center.dx, underCtrl, r.left + r.width * 0.07, r.bottom)
    ..close();
  c.drawPath(deck, Pk.fill(b));
  c.drawPath(
    Path()
      ..moveTo(r.left, r.bottom)
      ..quadraticBezierTo(r.center.dx, topCtrl, r.right, r.bottom),
    Pk.stroke(Pk.light(b, 0.25), 2),
  );
  final railH = r.height * 0.3;
  for (var i = 0; i <= 8; i++) {
    final k = 0.04 + i * 0.115;
    final x = r.left + r.width * k;
    final y = deckY(k, topCtrl);
    c.drawLine(Offset(x, y), Offset(x, y - railH), Pk.stroke(a, 2.6));
    if (i == 0 || i == 8) c.drawCircle(Offset(x, y - railH - 2), 3, Pk.fill(_gold));
  }
  for (final off in [railH, railH * 0.45]) {
    c.drawPath(
      Path()
        ..moveTo(r.left + r.width * 0.04, deckY(0.04, topCtrl) - off)
        ..quadraticBezierTo(r.center.dx, topCtrl - off, r.left + r.width * 0.96, deckY(0.96, topCtrl) - off),
      Pk.stroke(a, off == railH ? 3 : 1.8),
    );
  }
}

void _paintStones(Canvas c, Rect r, Color a, Color b, double t) {
  for (var i = 0; i < 4; i++) {
    final k = i / 3;
    final cx = r.center.dx + sin(i * 1.7) * r.width * 0.16;
    final cy = r.top + r.height * (0.12 + k * 0.76);
    final w = r.width * (0.34 + k * 0.3), h = r.height * (0.1 + k * 0.08);
    final sr = Rect.fromCenter(center: Offset(cx, cy), width: w, height: h);
    c.drawOval(sr.translate(0, h * 0.18), Pk.fill(Pk.dark(a, 0.3)));
    c.drawOval(sr, Pk.fill(a));
    c.drawOval(Rect.fromCenter(center: sr.center - Offset(w * 0.12, h * 0.15), width: w * 0.4, height: h * 0.35), Pk.fill(Pk.light(a, 0.25)));
  }
}

void _paintRocks(Canvas c, Rect r, Color a, Color b, double t) {
  for (final (x, y, w, h) in [(0.0, 0.3, 0.55, 0.7), (0.4, 0.0, 0.5, 1.0), (0.7, 0.45, 0.3, 0.55)]) {
    final rr = _f(r, x, y, w, h);
    c.drawPath(
      Path()
        ..moveTo(rr.left, rr.bottom)
        ..quadraticBezierTo(rr.left, rr.top + rr.height * 0.2, rr.center.dx, rr.top)
        ..quadraticBezierTo(rr.right, rr.top + rr.height * 0.25, rr.right, rr.bottom)
        ..close(),
      Pk.fill(a),
    );
    c.drawOval(Rect.fromLTWH(rr.left + rr.width * 0.2, rr.top + rr.height * 0.12, rr.width * 0.35, rr.height * 0.2), Pk.fill(Pk.light(a, 0.2)));
    c.drawOval(Rect.fromLTWH(rr.left + rr.width * 0.5, rr.top + rr.height * 0.3, rr.width * 0.3, rr.height * 0.14), Pk.fill(b.withValues(alpha: 0.7)));
  }
}

void _paintWaterfall(Canvas c, Rect r, Color a, Color b, double t) {
  _paintRocks(c, _f(r, 0.0, 0.0, 0.42, 1.0), a, _moss, t);
  _paintRocks(c, _f(r, 0.58, 0.1, 0.42, 0.9), a, _moss, t);
  final fall = _f(r, 0.36, 0.08, 0.28, 0.82);
  Pk.gradientRect(c, fall, Pk.light(b, 0.4), b);
  for (var i = 0; i < 4; i++) {
    final y = fall.top + ((t * 30 + i * 12) % fall.height);
    c.drawLine(Offset(fall.left + 2 + i * fall.width / 4, y), Offset(fall.left + 2 + i * fall.width / 4, y + 6), Pk.stroke(Colors.white.withValues(alpha: 0.7), 1.2));
  }
  c.drawOval(_f(r, 0.26, 0.84, 0.48, 0.16), Pk.fill(Colors.white.withValues(alpha: 0.7)));
}

void _paintStream(Canvas c, Rect r, Color a, Color b, double t) {
  final p = Path()
    ..moveTo(r.left, r.top + r.height * 0.15)
    ..quadraticBezierTo(r.left + r.width * 0.3, r.top - r.height * 0.05, r.left + r.width * 0.55, r.top + r.height * 0.2)
    ..quadraticBezierTo(r.left + r.width * 0.8, r.top + r.height * 0.4, r.right, r.top + r.height * 0.1)
    ..lineTo(r.right, r.bottom - r.height * 0.1)
    ..quadraticBezierTo(r.left + r.width * 0.75, r.bottom + r.height * 0.1, r.left + r.width * 0.5, r.bottom - r.height * 0.15)
    ..quadraticBezierTo(r.left + r.width * 0.25, r.bottom - r.height * 0.35, r.left, r.bottom - r.height * 0.05)
    ..close();
  c.drawPath(p, Pk.fill(Pk.dark(a, 0.15)));
  c.save();
  c.clipPath(p);
  Pk.gradientRect(c, r.inflate(4), Pk.light(a, 0.15), a);
  for (var i = 0; i < 7; i++) {
    final x = (t * 18 + i * 64) % (r.width + 40) + r.left - 20;
    final y = r.top + r.height * (0.3 + (i % 3) * 0.2);
    c.drawLine(Offset(x, y), Offset(x + 14, y), Pk.stroke(b.withValues(alpha: 0.7), 1.4));
  }
  c.restore();
  c.drawPath(p, Pk.stroke(Pk.light(a, 0.45), 1.2));
}

void _paintBambooFence(Canvas c, Rect r, Color a, Color b, double t) {
  final n = max(4, (r.width / 7).round());
  for (var i = 0; i < n; i++) {
    final x = r.left + r.width * (i + 0.5) / n;
    final top = r.top + r.height * (i.isEven ? 0.0 : 0.08);
    c.drawRRect(_rr(Rect.fromLTRB(x - r.width / n * 0.42, top, x + r.width / n * 0.42, r.bottom), 2), Pk.fill(i.isEven ? a : Pk.dark(a, 0.1)));
    c.drawLine(Offset(x - r.width / n * 0.4, r.top + r.height * 0.5), Offset(x + r.width / n * 0.4, r.top + r.height * 0.5), Pk.stroke(Pk.dark(a, 0.3), 1));
  }
  for (final y in [0.28, 0.7]) {
    c.drawRect(_f(r, -0.01, y, 1.02, 0.08), Pk.fill(Pk.dark(a, 0.2)));
    for (var i = 0; i < 4; i++) {
      final x = r.left + r.width * (0.12 + i * 0.25);
      c.drawLine(Offset(x - 2, r.top + r.height * y), Offset(x + 2, r.top + r.height * (y + 0.08)), Pk.stroke(b, 1.6));
      c.drawLine(Offset(x + 2, r.top + r.height * y), Offset(x - 2, r.top + r.height * (y + 0.08)), Pk.stroke(b, 1.6));
    }
  }
}

void _paintLowTable(Canvas c, Rect r, Color a, Color b, double t) {
  for (final x in [0.08, 0.86]) {
    c.drawRect(_f(r, x, 0.3, 0.06, 0.7), Pk.fill(Pk.dark(a, 0.35)));
  }
  Pk.poly(c, [_o(r, 0.06, 0.0), _o(r, 0.94, 0.0), _o(r, 1.0, 0.24), _o(r, 0.0, 0.24)], Pk.fill(Pk.light(a, 0.1)));
  Pk.box(c, _f(r, 0.0, 0.24, 1.0, 0.12), Pk.dark(a, 0.12), radius: 1.5);
  c.drawLine(_o(r, 0.12, 0.08), _o(r, 0.5, 0.08), Pk.stroke(Colors.white.withValues(alpha: 0.25), 1.5));
}

void _paintAndon(Canvas c, Rect r, Color a, Color b, double t) {
  for (final x in [0.12, 0.8]) {
    c.drawRect(_f(r, x, 0.1, 0.08, 0.9), Pk.fill(a));
  }
  final shade = _f(r, 0.14, 0.12, 0.72, 0.62);
  Pk.glow(c, shade.center, r.width * 1.6, b, 0.45 + 0.05 * sin(t * 2));
  Pk.gradientRect(c, shade, Pk.light(b, 0.6), b);
  c.drawRect(shade, Pk.stroke(a, 1.6));
  c.drawLine(shade.centerLeft, shade.centerRight, Pk.stroke(a, 1));
  c.drawRect(_f(r, 0.06, 0.06, 0.88, 0.07), Pk.fill(a));
  c.drawRect(_f(r, 0.06, 0.76, 0.88, 0.06), Pk.fill(a));
}

// ---------------------------------------------------------------- Forest camp
void _paintTent(Canvas c, Rect r, Color a, Color b, double t) {
  final rope = Pk.stroke(_rope, 1);
  c.drawLine(_o(r, 0.5, 0.02), _o(r, -0.06, 1.0), rope);
  c.drawLine(_o(r, 0.5, 0.02), _o(r, 1.06, 1.0), rope);
  for (final x in [-0.06, 1.06]) {
    c.drawLine(_o(r, x, 1.0), _o(r, x, 0.94), Pk.stroke(_darkWood, 2));
  }
  Pk.poly(c, [_o(r, 0.5, 0.0), _o(r, 1.0, 1.0), _o(r, 0.0, 1.0)], Pk.fill(a));
  Pk.poly(c, [_o(r, 0.5, 0.0), _o(r, 1.0, 1.0), _o(r, 0.62, 1.0)], Pk.fill(Pk.dark(a, 0.12)));
  Pk.poly(c, [_o(r, 0.5, 0.28), _o(r, 0.68, 1.0), _o(r, 0.32, 1.0)], Pk.fill(Pk.dark(a, 0.6)));
  Pk.glow(c, _o(r, 0.5, 0.86), r.width * 0.22, _lampGlow, 0.35);
  Pk.poly(c, [_o(r, 0.5, 0.28), _o(r, 0.32, 1.0), _o(r, 0.22, 1.0), _o(r, 0.42, 0.56)], Pk.fill(Pk.light(a, 0.12)));
  Pk.poly(c, [_o(r, 0.5, 0.28), _o(r, 0.68, 1.0), _o(r, 0.78, 1.0), _o(r, 0.58, 0.56)], Pk.fill(Pk.dark(a, 0.05)));
  c.drawLine(_o(r, 0.5, 0.0), _o(r, 0.0, 1.0), Pk.stroke(b, 2));
  c.drawLine(_o(r, 0.5, 0.0), _o(r, 1.0, 1.0), Pk.stroke(b, 2));
  c.drawLine(_o(r, 0.5, 0.0), _o(r, 0.5, -0.07), Pk.stroke(_darkWood, 2));
}

void _paintCampfire(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.glow(c, _o(r, 0.5, 0.6), r.width * 1.2, _flame, 0.45 + 0.08 * sin(t * 7));
  for (final s in [-1.0, 1.0]) {
    c.save();
    c.translate(r.center.dx, r.bottom - r.height * 0.16);
    c.rotate(s * 0.32);
    c.drawRRect(_rr(Rect.fromCenter(center: Offset.zero, width: r.width * 0.78, height: r.height * 0.14), 3), Pk.fill(a));
    c.drawCircle(Offset(s * r.width * 0.39, 0), r.height * 0.07, Pk.fill(Pk.light(a, 0.35)));
    c.restore();
  }
  final base = r.bottom - r.height * 0.22;
  for (var i = 0; i < 3; i++) {
    final fh = r.height * (0.5 + 0.12 * sin(t * 8 + i * 2)) * (i == 1 ? 1.2 : 0.85);
    final cx = r.left + r.width * (0.36 + i * 0.14);
    final fw = r.width * 0.15;
    final col = [const Color(0xFFFF6A3C), const Color(0xFFFF8A3C), const Color(0xFFFF5A3C)][i];
    c.drawPath(
      Path()
        ..moveTo(cx - fw, base)
        ..quadraticBezierTo(cx - fw, base - fh * 0.55, cx + sin(t * 5 + i) * 2, base - fh)
        ..quadraticBezierTo(cx + fw, base - fh * 0.55, cx + fw, base)
        ..close(),
      Pk.fill(col),
    );
  }
  final ih = r.height * (0.32 + 0.06 * sin(t * 9));
  c.drawPath(
    Path()
      ..moveTo(r.center.dx - r.width * 0.1, base)
      ..quadraticBezierTo(r.center.dx - r.width * 0.1, base - ih * 0.5, r.center.dx, base - ih)
      ..quadraticBezierTo(r.center.dx + r.width * 0.1, base - ih * 0.5, r.center.dx + r.width * 0.1, base)
      ..close(),
    Pk.fill(b),
  );
  for (var i = 0; i < 7; i++) {
    c.drawOval(Rect.fromCenter(center: Offset(r.left + r.width * (0.04 + i * 0.153), r.bottom - r.height * 0.06), width: r.width * 0.17, height: r.height * 0.13),
        Pk.fill(i.isEven ? _slate : Pk.light(_slate, 0.18)));
  }
  for (var i = 0; i < 4; i++) {
    final k = (t * 0.7 + i * 0.25) % 1;
    c.drawCircle(Offset(r.center.dx + sin(i * 2.3 + t) * r.width * 0.2, base - r.height * 0.5 - k * r.height * 0.6), 1.2, Pk.fill(_lampGlow.withValues(alpha: 1 - k)));
  }
}

void _paintLog(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, _f(r, 0.0, 0.0, 0.9, 1.0), a, radius: r.height * 0.45);
  for (var i = 0; i < 3; i++) {
    c.drawLine(_o(r, 0.1 + i * 0.22, 0.3), _o(r, 0.26 + i * 0.22, 0.3), Pk.stroke(Pk.dark(a, 0.25), 1));
  }
  final end = Rect.fromLTWH(r.right - r.width * 0.2, r.top, r.width * 0.2, r.height);
  c.drawOval(end, Pk.fill(Pk.light(a, 0.4)));
  c.drawOval(end.deflate(r.height * 0.17), Pk.stroke(Pk.dark(a, 0.1), 1));
  c.drawOval(end.deflate(r.height * 0.32), Pk.stroke(Pk.dark(a, 0.1), 1));
}

void _paintPine(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawRect(_f(r, 0.44, 0.8, 0.12, 0.2), Pk.fill(_bark));
  for (var i = 0; i < 4; i++) {
    final top = i * 0.17;
    final bot = 0.32 + i * 0.17;
    final hw = 0.2 + i * 0.1;
    final sway = sin(t * 0.7 + r.left) * (3 - i) * 0.006;
    Pk.poly(c, [_o(r, 0.5 + sway, top), _o(r, 0.5 + hw, bot), _o(r, 0.5 - hw, bot)], Pk.fill(i.isEven ? a : Pk.dark(a, 0.08)));
    Pk.poly(c, [_o(r, 0.5 + sway, top), _o(r, 0.5, bot), _o(r, 0.5 - hw, bot)], Pk.fill(Pk.light(a, 0.06)));
    c.drawCircle(_o(r, 0.5 + hw * 0.5, bot - 0.03), r.width * 0.035, Pk.fill(b));
  }
}

void _paintTreehouse(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, _f(r, 0.41, 0.45, 0.18, 0.55), _bark, radius: 3);
  c.drawLine(_o(r, 0.44, 0.62), _o(r, 0.16, 0.5), Pk.stroke(_bark, r.width * 0.045));
  c.drawLine(_o(r, 0.56, 0.62), _o(r, 0.84, 0.5), Pk.stroke(_bark, r.width * 0.045));
  Pk.box(c, _f(r, 0.04, 0.44, 0.92, 0.07), Pk.dark(a, 0.18), radius: 1.5);
  for (var i = 0; i <= 8; i++) {
    final x = 0.06 + i * 0.11;
    if (x > 0.22 && x < 0.8) continue;
    c.drawLine(_o(r, x, 0.44), _o(r, x, 0.36), Pk.stroke(Pk.dark(a, 0.2), 1.6));
  }
  c.drawLine(_o(r, 0.05, 0.37), _o(r, 0.22, 0.37), Pk.stroke(Pk.dark(a, 0.2), 1.6));
  c.drawLine(_o(r, 0.8, 0.37), _o(r, 0.95, 0.37), Pk.stroke(Pk.dark(a, 0.2), 1.6));
  Pk.box(c, _f(r, 0.22, 0.18, 0.56, 0.27), a, radius: 2);
  for (var i = 1; i < 4; i++) {
    c.drawLine(_o(r, 0.23, 0.18 + i * 0.065), _o(r, 0.77, 0.18 + i * 0.065), Pk.stroke(Pk.dark(a, 0.18), 1));
  }
  c.drawRRect(_rr(_f(r, 0.29, 0.24, 0.14, 0.1), 1.5), Pk.fill(_lampGlow));
  c.drawLine(_o(r, 0.36, 0.24), _o(r, 0.36, 0.34), Pk.stroke(Pk.dark(a, 0.3), 1));
  c.drawRect(_f(r, 0.56, 0.27, 0.13, 0.18), Pk.fill(Pk.dark(a, 0.45)));
  Pk.poly(c, [_o(r, 0.14, 0.21), _o(r, 0.5, 0.01), _o(r, 0.86, 0.21)], Pk.fill(b));
  Pk.poly(c, [_o(r, 0.5, 0.01), _o(r, 0.86, 0.21), _o(r, 0.5, 0.21)], Pk.fill(Pk.dark(b, 0.12)));
  c.drawLine(_o(r, 0.5, 0.01), _o(r, 0.5, -0.06), Pk.stroke(_darkWood, 1.5));
  Pk.poly(c, [_o(r, 0.5, -0.06), _o(r, 0.62, -0.035), _o(r, 0.5, -0.01)], Pk.fill(_red));
}

void _paintRopeLadder(Canvas c, Rect r, Color a, Color b, double t) {
  final sway = sin(t * 1.3 + r.left) * r.width * 0.12;
  final l0 = _o(r, 0.15, 0), r0 = _o(r, 0.85, 0);
  final l1 = Offset(r.left + r.width * 0.15 + sway, r.bottom), r1 = Offset(r.left + r.width * 0.85 + sway, r.bottom);
  c.drawLine(l0, l1, Pk.stroke(a, 1.6));
  c.drawLine(r0, r1, Pk.stroke(a, 1.6));
  const n = 7;
  for (var i = 1; i <= n; i++) {
    final k = i / (n + 0.4);
    c.drawLine(Offset.lerp(l0, l1, k)!, Offset.lerp(r0, r1, k)!, Pk.stroke(b, 2.6));
  }
}

void _paintSwing(Canvas c, Rect r, Color a, Color b, double t) {
  final ang = sin(t * 1.1 + r.left) * 0.18;
  _swing(c, r.topCenter, ang, () {
    c.drawLine(r.topCenter, _o(r, 0.5, 0.62), Pk.stroke(a, 1.6));
    c.drawOval(_f(r, 0.08, 0.6, 0.84, 0.36), Pk.fill(_ebony));
    c.drawOval(_f(r, 0.3, 0.7, 0.4, 0.16), Pk.fill(Pk.dark(b, 0.4)));
    c.drawOval(_f(r, 0.08, 0.6, 0.84, 0.36), Pk.stroke(Pk.light(_ebony, 0.25), 1.2));
  });
}

void _paintRopeBridge(Canvas c, Rect r, Color a, Color b, double t) {
  double sag(double k) => r.top + r.height * (0.55 + sin(pi * k) * 0.35);
  const n = 10;
  for (var i = 0; i < n; i++) {
    final k = (i + 0.5) / n;
    final x = r.left + r.width * k;
    c.drawLine(Offset(x, sag(k)), Offset(x, sag(k) - r.height * 0.45), Pk.stroke(a, 0.8));
    c.drawRRect(_rr(Rect.fromCenter(center: Offset(x, sag(k)), width: r.width / n * 0.8, height: r.height * 0.13), 1), Pk.fill(i.isEven ? b : Pk.dark(b, 0.1)));
  }
  for (final off in [0.0, 0.45]) {
    final p = Path()..moveTo(r.left, sag(0) - r.height * off);
    for (var i = 1; i <= 20; i++) {
      final k = i / 20;
      p.lineTo(r.left + r.width * k, sag(k) - r.height * off);
    }
    c.drawPath(p, Pk.stroke(a, 1.4));
  }
}

void _paintCanoe(Canvas c, Rect r, Color a, Color b, double t) {
  final bob = sin(t * 1.4 + r.left) * 1.2;
  c.save();
  c.translate(0, bob);
  c.drawLine(_o(r, 0.28, 0.0), _o(r, 0.6, 0.62), Pk.stroke(_wood, 2));
  c.drawOval(Rect.fromCenter(center: _o(r, 0.63, 0.66), width: r.width * 0.06, height: r.height * 0.34), Pk.fill(_wood));
  final hull = Path()
    ..moveTo(r.left, r.top + r.height * 0.3)
    ..quadraticBezierTo(r.center.dx, r.bottom + r.height * 0.3, r.right, r.top + r.height * 0.3)
    ..quadraticBezierTo(r.center.dx, r.top + r.height * 0.62, r.left, r.top + r.height * 0.3)
    ..close();
  c.drawPath(hull, Pk.fill(a));
  c.drawPath(
    Path()
      ..moveTo(r.left, r.top + r.height * 0.3)
      ..quadraticBezierTo(r.center.dx, r.top + r.height * 0.62, r.right, r.top + r.height * 0.3),
    Pk.stroke(b, 2.2),
  );
  c.drawLine(_o(r, 0.5, 0.48), _o(r, 0.5, 0.72), Pk.stroke(Pk.dark(a, 0.25), 1.2));
  c.restore();
}

void _paintCampArch(Canvas c, Rect r, Color a, Color b, double t) {
  for (final x in [0.04, 0.86]) {
    Pk.box(c, _f(r, x, 0.06, 0.1, 0.94), a, radius: 3);
    for (var i = 0; i < 4; i++) {
      c.drawLine(_o(r, x + 0.02, 0.25 + i * 0.18), _o(r, x + 0.06, 0.27 + i * 0.18), Pk.stroke(Pk.dark(a, 0.3), 1));
    }
  }
  Pk.box(c, _f(r, -0.02, 0.04, 1.04, 0.1), Pk.dark(a, 0.08), radius: 5);
  for (final x in [-0.02, 0.98]) {
    c.drawOval(_f(r, x, 0.04, 0.05, 0.1), Pk.fill(Pk.light(a, 0.35)));
  }
  for (final x in [0.3, 0.7]) {
    c.drawLine(_o(r, x, 0.14), _o(r, x, 0.22), Pk.stroke(_rope, 1.3));
  }
  Pk.box(c, _f(r, 0.18, 0.21, 0.64, 0.17), b, radius: 3);
  c.drawLine(_o(r, 0.27, 0.27), _o(r, 0.73, 0.27), Pk.stroke(Pk.dark(b, 0.5), 2.4));
  c.drawLine(_o(r, 0.33, 0.33), _o(r, 0.67, 0.33), Pk.stroke(Pk.dark(b, 0.4), 1.6));
  for (final x in [0.12, 0.88]) {
    Pk.poly(c, [_o(r, x, -0.08), _o(r, x + 0.06, 0.05), _o(r, x - 0.06, 0.05)], Pk.fill(_pine));
  }
}

void _paintSignpost(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawRect(_f(r, 0.44, 0.1, 0.12, 0.9), Pk.fill(Pk.dark(a, 0.2)));
  final boards = [(0.12, 1.0), (0.38, -1.0), (0.62, 1.0)];
  for (final (y, d) in boards) {
    final x0 = d > 0 ? 0.2 : 0.0, x1 = d > 0 ? 1.0 : 0.8;
    final tip = d > 0 ? x1 : x0;
    Pk.poly(c, [_o(r, d > 0 ? x0 : x0 + 0.12, y), _o(r, d > 0 ? x1 - 0.12 : x1, y), _o(r, d > 0 ? tip : x1, y + 0.08), _o(r, d > 0 ? x1 - 0.12 : x1, y + 0.16),
        _o(r, d > 0 ? x0 : x0 + 0.12, y + 0.16), _o(r, d > 0 ? x0 : tip, y + 0.08)], Pk.fill(a));
    c.drawLine(_o(r, 0.3, y + 0.08), _o(r, 0.7, y + 0.08), Pk.stroke(b, 1.4));
  }
}

void _paintLogFence(Canvas c, Rect r, Color a, Color b, double t) {
  final n = max(2, (r.width / 40).round());
  for (final y in [0.25, 0.6]) {
    Pk.box(c, _f(r, 0.0, y, 1.0, 0.14), Pk.dark(a, 0.05), radius: 3);
  }
  for (var i = 0; i <= n; i++) {
    final x = r.left + r.width * i / n - r.width * 0.025;
    Pk.box(c, Rect.fromLTWH(x.clamp(r.left, r.right - r.width * 0.05), r.top, r.width * 0.05, r.height), a, radius: 2);
  }
  c.drawLine(_o(r, 0.1, 0.32), _o(r, 0.3, 0.32), Pk.stroke(Pk.light(a, 0.3), 1));
  c.drawCircle(_o(r, 0.62, 0.78), 2.5, Pk.fill(b));
}

void _paintWoodpile(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, _f(r, 0.0, 0.1, 1.0, 0.9), Pk.dark(a, 0.3), radius: 3);
  final rows = [(0.78, 4), (0.5, 3), (0.22, 2)];
  for (final (y, n) in rows) {
    for (var i = 0; i < n; i++) {
      final cx = r.left + r.width * (0.5 + (i - (n - 1) / 2) * 0.24);
      final rad = min(r.width * 0.12, r.height * 0.15);
      final p = Offset(cx, r.top + r.height * y);
      c.drawCircle(p, rad, Pk.fill(Pk.light(a, 0.35)));
      c.drawCircle(p, rad * 0.62, Pk.stroke(Pk.dark(a, 0.05), 1));
      c.drawCircle(p, rad * 0.25, Pk.fill(Pk.dark(a, 0.1)));
      c.drawCircle(p, rad, Pk.stroke(Pk.dark(a, 0.35), 1.2));
    }
  }
}

void _paintBackpack(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, _f(r, 0.1, 0.12, 0.8, 0.88), a, radius: r.width * 0.25);
  Pk.box(c, _f(r, 0.1, 0.1, 0.8, 0.3), Pk.dark(a, 0.12), radius: r.width * 0.2);
  Pk.box(c, _f(r, 0.22, 0.52, 0.56, 0.34), Pk.light(a, 0.1), radius: 3);
  c.drawLine(_o(r, 0.5, 0.4), _o(r, 0.5, 0.5), Pk.stroke(b, 2));
  c.drawOval(_f(r, 0.0, 0.0, 1.0, 0.16), Pk.fill(b));
  c.drawArc(_f(r, 0.3, -0.08, 0.4, 0.2), pi, pi, false, Pk.stroke(Pk.dark(a, 0.3), 2));
}

void _paintCampLantern(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.glow(c, _o(r, 0.5, 0.52), r.width * 2.2, b, 0.5 + 0.06 * sin(t * 4 + r.left));
  c.drawArc(_f(r, 0.2, 0.0, 0.6, 0.3), pi, pi, false, Pk.stroke(a, 1.5));
  Pk.box(c, _f(r, 0.18, 0.14, 0.64, 0.12), a, radius: 2);
  c.drawRRect(_rr(_f(r, 0.24, 0.26, 0.52, 0.5), 3), Pk.fill(Pk.light(b, 0.3)));
  c.drawOval(_f(r, 0.38, 0.36, 0.24, 0.3), Pk.fill(_white));
  for (final x in [0.27, 0.73]) {
    c.drawLine(_o(r, x, 0.26), _o(r, x, 0.76), Pk.stroke(a, 1.2));
  }
  Pk.box(c, _f(r, 0.12, 0.76, 0.76, 0.24), a, radius: 2);
}

void _paintMooringPost(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, _f(r, 0.15, 0.0, 0.7, 1.0), a, radius: 3);
  c.drawOval(_f(r, 0.15, -0.02, 0.7, 0.1), Pk.fill(Pk.light(a, 0.3)));
  for (final y in [0.25, 0.33]) {
    c.drawRect(_f(r, 0.1, y, 0.8, 0.05), Pk.fill(_rope));
  }
  c.drawCircle(_o(r, 0.5, 0.58), r.width * 0.45, Pk.stroke(b, r.width * 0.26));
  c.drawCircle(_o(r, 0.5, 0.58), r.width * 0.45, Pk.stroke(Colors.white, r.width * 0.26)..strokeCap = StrokeCap.butt);
  for (var i = 0; i < 4; i++) {
    final a0 = i * pi / 2 + 0.3;
    c.drawArc(Rect.fromCircle(center: _o(r, 0.5, 0.58), radius: r.width * 0.45), a0, 0.5, false, Pk.stroke(b, r.width * 0.26)..strokeCap = StrokeCap.butt);
  }
}

void _paintFishingRod(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.poly(c, [_o(r, 0.55, 0.62), _o(r, 0.95, 0.62), _o(r, 0.9, 1.0), _o(r, 0.6, 1.0)], Pk.fill(_steel));
  c.drawOval(_f(r, 0.55, 0.58, 0.4, 0.1), Pk.fill(Pk.dark(_steel, 0.3)));
  c.drawArc(_f(r, 0.6, 0.45, 0.3, 0.3), pi, pi, false, Pk.stroke(Pk.dark(_steel, 0.3), 1.2));
  c.drawLine(_o(r, 0.1, 1.0), _o(r, 0.8, 0.0), Pk.stroke(a, 2));
  c.drawCircle(_o(r, 0.22, 0.83), r.width * 0.06, Pk.fill(_iron));
  final bob = Offset(r.right + r.width * 0.05, r.top + r.height * (0.55 + sin(t * 2) * 0.03));
  c.drawLine(_o(r, 0.8, 0.0), bob, Pk.stroke(Colors.white.withValues(alpha: 0.75), 0.8));
  c.drawCircle(bob, 2.5, Pk.fill(b));
}

void _paintFishBucket(Canvas c, Rect r, Color a, Color b, double t) {
  for (var i = 0; i < 3; i++) {
    c.save();
    c.translate(r.left + r.width * (0.3 + i * 0.2), r.top + r.height * 0.3);
    c.rotate(-0.6 + i * 0.5);
    c.drawOval(Rect.fromCenter(center: Offset.zero, width: r.width * 0.16, height: r.height * 0.5), Pk.fill(b));
    Pk.poly(c, [Offset(0, -r.height * 0.22), Offset(-r.width * 0.08, -r.height * 0.34), Offset(r.width * 0.08, -r.height * 0.34)], Pk.fill(b));
    c.restore();
  }
  Pk.poly(c, [_o(r, 0.04, 0.38), _o(r, 0.96, 0.38), _o(r, 0.86, 1.0), _o(r, 0.14, 1.0)], Pk.fill(a));
  for (final y in [0.55, 0.8]) {
    c.drawLine(_o(r, 0.08, y), _o(r, 0.92, y), Pk.stroke(Pk.dark(a, 0.25), 1.2));
  }
  c.drawOval(_f(r, 0.04, 0.34, 0.92, 0.1), Pk.fill(Pk.light(a, 0.2)));
}

void _paintReeds(Canvas c, Rect r, Color a, Color b, double t) {
  for (var i = 0; i < 7; i++) {
    final x = r.left + r.width * (0.08 + i * 0.14);
    final sway = sin(t * 1.4 + i) * 2;
    final top = r.top + r.height * (0.05 + Pk.rand(i + 21) * 0.3);
    c.drawLine(Offset(x, r.bottom), Offset(x + sway, top), Pk.stroke(i.isEven ? a : Pk.dark(a, 0.15), 1.6));
    if (i % 2 == 1) {
      c.drawRRect(_rr(Rect.fromCenter(center: Offset(x + sway, top + 5), width: 3.4, height: 10), 2), Pk.fill(b));
    } else {
      c.drawOval(Rect.fromCenter(center: Offset(x + sway * 0.6 + 3, top + (r.bottom - top) * 0.4), width: 4, height: 12), Pk.fill(Pk.light(a, 0.1)));
    }
  }
}

void _paintRowboat(Canvas c, Rect r, Color a, Color b, double t) {
  final bob = sin(t * 1.5 + r.left) * 1.2;
  c.save();
  c.translate(0, bob);
  c.drawLine(_o(r, 0.2, 0.2), _o(r, -0.05, 0.85), Pk.stroke(_wood, 2));
  final hull = Path()
    ..moveTo(r.left, r.top + r.height * 0.32)
    ..lineTo(r.right, r.top + r.height * 0.32)
    ..quadraticBezierTo(r.right - r.width * 0.04, r.bottom, r.left + r.width * 0.78, r.bottom)
    ..lineTo(r.left + r.width * 0.18, r.bottom)
    ..quadraticBezierTo(r.left + r.width * 0.02, r.bottom - r.height * 0.1, r.left, r.top + r.height * 0.32)
    ..close();
  c.drawPath(hull, Pk.fill(a));
  c.save();
  c.clipPath(hull);
  for (final y in [0.55, 0.75]) {
    c.drawLine(_o(r, 0, y), _o(r, 1, y), Pk.stroke(Pk.dark(a, 0.2), 1));
  }
  c.restore();
  c.drawRect(_f(r, -0.01, 0.26, 1.02, 0.1), Pk.fill(b));
  c.drawLine(_o(r, 0.7, 0.2), _o(r, 1.05, 0.85), Pk.stroke(_wood, 2));
  c.restore();
}

void _paintBunk(Canvas c, Rect r, Color a, Color b, double t) {
  for (final x in [0.0, 0.92]) {
    Pk.box(c, _f(r, x, 0.0, 0.08, 1.0), a, radius: 2);
  }
  for (final (y, col) in [(0.12, b), (0.56, Pk.mix(b, _navy, 0.4))]) {
    Pk.box(c, _f(r, 0.06, y + 0.07, 0.88, 0.13), _white, radius: 3);
    Pk.box(c, _f(r, 0.32, y + 0.05, 0.62, 0.16), col, radius: 3);
    for (var i = 0; i < 3; i++) {
      c.drawLine(_o(r, 0.38 + i * 0.18, y + 0.06), _o(r, 0.38 + i * 0.18, y + 0.2), Pk.stroke(Pk.dark(col, 0.2), 1));
    }
    Pk.box(c, _f(r, 0.09, y + 0.02, 0.2, 0.09), _cream, radius: 3);
    Pk.box(c, _f(r, 0.02, y + 0.2, 0.96, 0.08), Pk.dark(a, 0.08), radius: 2);
  }
  c.drawLine(_o(r, 0.78, 0.2), _o(r, 0.78, 1.0), Pk.stroke(Pk.dark(a, 0.15), 2));
  for (var i = 0; i < 4; i++) {
    c.drawLine(_o(r, 0.78, 0.38 + i * 0.16), _o(r, 0.92, 0.38 + i * 0.16), Pk.stroke(Pk.dark(a, 0.15), 2));
  }
}

// ---------------------------------------------------------------- Circus
void _paintBigTop(Canvas c, Rect r, Color a, Color b, double t) {
  final wall = _f(r, 0.06, 0.44, 0.88, 0.56);
  c.save();
  c.clipRect(wall);
  const n = 12;
  for (var i = 0; i < n; i++) {
    c.drawRect(Rect.fromLTWH(wall.left + wall.width * i / n, wall.top, wall.width / n + 0.5, wall.height), Pk.fill(i.isEven ? a : b));
  }
  c.restore();
  final door = Path()
    ..moveTo(r.left + r.width * 0.4, r.bottom)
    ..lineTo(r.left + r.width * 0.4, r.top + r.height * 0.7)
    ..quadraticBezierTo(r.center.dx, r.top + r.height * 0.55, r.left + r.width * 0.6, r.top + r.height * 0.7)
    ..lineTo(r.left + r.width * 0.6, r.bottom)
    ..close();
  c.drawPath(door, Pk.fill(const Color(0xFF3A1E2A)));
  Pk.glow(c, _o(r, 0.5, 0.88), r.width * 0.12, _lampGlow, 0.5);
  Pk.poly(c, [_o(r, 0.4, 0.7), _o(r, 0.46, 0.7), _o(r, 0.4, 1.0), _o(r, 0.36, 1.0)], Pk.fill(Pk.dark(a, 0.1)));
  Pk.poly(c, [_o(r, 0.6, 0.7), _o(r, 0.54, 0.7), _o(r, 0.6, 1.0), _o(r, 0.64, 1.0)], Pk.fill(Pk.dark(a, 0.1)));
  final apex = _o(r, 0.5, 0.08);
  final roof = Path()
    ..moveTo(r.left, r.top + r.height * 0.46)
    ..quadraticBezierTo(r.left + r.width * 0.28, r.top + r.height * 0.3, apex.dx, apex.dy)
    ..quadraticBezierTo(r.right - r.width * 0.28, r.top + r.height * 0.3, r.right, r.top + r.height * 0.46)
    ..close();
  c.save();
  c.clipPath(roof);
  c.drawPath(roof, Pk.fill(a));
  for (var i = 0; i < 10; i += 2) {
    final x0 = r.left + r.width * i / 10, x1 = r.left + r.width * (i + 1) / 10;
    Pk.poly(c, [apex, Offset(x1, r.top + r.height * 0.5), Offset(x0, r.top + r.height * 0.5)], Pk.fill(b));
  }
  c.restore();
  for (var i = 0; i < 12; i++) {
    final cx = r.left + r.width * (0.04 + i * 0.084);
    c.drawArc(Rect.fromCenter(center: Offset(cx, r.top + r.height * 0.455), width: r.width * 0.084, height: r.height * 0.07), 0, pi, true,
        Pk.fill(i.isEven ? _gold : Pk.dark(a, 0.1)));
  }
  c.drawLine(apex, _o(r, 0.5, -0.02), Pk.stroke(_ink, 1.5));
  final wave = sin(t * 3) * r.width * 0.01;
  Pk.poly(c, [_o(r, 0.5, -0.02), Offset(r.left + r.width * 0.6 + wave, r.top + r.height * 0.0), _o(r, 0.5, 0.03)], Pk.fill(_gold));
}

void _paintMarquee(Canvas c, Rect r, Color a, Color b, double t) {
  for (final x in [0.02, 0.88]) {
    Pk.box(c, _f(r, x, 0.3, 0.1, 0.7), Pk.dark(a, 0.15), radius: 2);
    for (var i = 0; i < 4; i++) {
      c.drawLine(_o(r, x, 0.4 + i * 0.15), _o(r, x + 0.1, 0.46 + i * 0.15), Pk.stroke(_gold, 1.5));
    }
  }
  final board = Path()
    ..moveTo(r.left, r.top + r.height * 0.4)
    ..lineTo(r.left, r.top + r.height * 0.16)
    ..quadraticBezierTo(r.center.dx, r.top - r.height * 0.1, r.right, r.top + r.height * 0.16)
    ..lineTo(r.right, r.top + r.height * 0.4)
    ..close();
  c.drawPath(board, Pk.fill(a));
  c.drawPath(board, Pk.stroke(_gold, 2));
  Pk.box(c, _f(r, 0.18, 0.13, 0.64, 0.2), b, radius: 4);
  for (final x in [0.3, 0.5, 0.7]) {
    _star(c, _o(r, x, 0.23), r.height * (x == 0.5 ? 0.09 : 0.06), _gold);
  }
  const n = 16;
  for (var i = 0; i < n; i++) {
    final k = i / (n - 1);
    final x = r.left + r.width * (0.03 + k * 0.94);
    final y = r.top + r.height * (0.16 + 0.03) - sin(pi * k) * r.height * 0.11;
    final on = (i + (t * 6).floor()) % 3 != 0;
    if (on) Pk.glow(c, Offset(x, y), 5, _lampGlow, 0.6);
    c.drawCircle(Offset(x, y), 1.8, Pk.fill(on ? _lampGlow : const Color(0xFF8A7F78)));
  }
}

void _paintBooth(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, _f(r, 0.08, 0.36, 0.84, 0.64), a, radius: 3);
  c.drawRRect(_rr(_f(r, 0.2, 0.46, 0.6, 0.24), 3), Pk.fill(_lampGlow));
  c.drawLine(_o(r, 0.5, 0.46), _o(r, 0.5, 0.7), Pk.stroke(Pk.dark(a, 0.3), 1));
  Pk.box(c, _f(r, 0.14, 0.7, 0.72, 0.05), Pk.light(a, 0.2), radius: 1);
  for (var i = 0; i < 3; i++) {
    c.drawRect(_f(r, 0.16 + i * 0.25, 0.8, 0.18, 0.14), Pk.stroke(_gold, 1.2));
  }
  const n = 6;
  for (var i = 0; i < n; i++) {
    final x = 0.0 + i / n;
    Pk.poly(c, [_o(r, x, 0.24), _o(r, x + 1 / n, 0.24), _o(r, x + 1 / n, 0.34), _o(r, x + 0.5 / n, 0.38), _o(r, x, 0.34)], Pk.fill(i.isEven ? b : _white));
  }
  Pk.poly(c, [_o(r, 0.0, 0.24), _o(r, 0.5, 0.06), _o(r, 1.0, 0.24)], Pk.fill(b));
  Pk.box(c, _f(r, 0.26, 0.12, 0.48, 0.1), _gold, radius: 2);
  c.drawLine(_o(r, 0.33, 0.17), _o(r, 0.67, 0.17), Pk.stroke(Pk.dark(_gold, 0.45), 1.6));
  c.drawLine(_o(r, 0.5, 0.06), _o(r, 0.5, -0.04), Pk.stroke(_ink, 1));
  Pk.poly(c, [_o(r, 0.5, -0.04), _o(r, 0.64, -0.01), _o(r, 0.5, 0.02)], Pk.fill(b));
}

void _paintIceCart(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawLine(_o(r, 0.5, 0.12), _o(r, 0.5, 0.48), Pk.stroke(_steel, 1.6));
  final canopy = Path()
    ..moveTo(r.left + r.width * 0.05, r.top + r.height * 0.24)
    ..quadraticBezierTo(r.center.dx, r.top - r.height * 0.08, r.right - r.width * 0.05, r.top + r.height * 0.24)
    ..close();
  c.drawPath(canopy, Pk.fill(a));
  c.save();
  c.clipPath(canopy);
  for (var i = 0; i < 6; i += 2) {
    Pk.poly(c, [_o(r, 0.5, 0.0), _o(r, (i + 1) / 6, 0.26), _o(r, (i + 2) / 6, 0.26)], Pk.fill(b));
  }
  c.restore();
  for (final (x, col) in [(0.32, _lotus), (0.5, _cream), (0.68, const Color(0xFF9A6A4A))]) {
    c.drawCircle(_o(r, x, 0.44), r.width * 0.08, Pk.fill(col));
  }
  Pk.box(c, _f(r, 0.1, 0.46, 0.8, 0.34), b, radius: 4);
  Pk.poly(c, [_o(r, 0.42, 0.56), _o(r, 0.58, 0.56), _o(r, 0.5, 0.74)], Pk.fill(_straw));
  c.drawCircle(_o(r, 0.5, 0.55), r.width * 0.07, Pk.fill(_lotus));
  for (final x in [0.25, 0.75]) {
    c.drawCircle(_o(r, x, 0.88), r.height * 0.11, Pk.fill(_ink));
    c.drawCircle(_o(r, x, 0.88), r.height * 0.04, Pk.fill(_gold));
  }
}

void _paintPedestal(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawRect(_f(r, 0.04, 0.16, 0.92, 0.72), Pk.fill(a));
  c.drawOval(_f(r, 0.04, 0.78, 0.92, 0.22), Pk.fill(a));
  final zig = <Offset>[];
  for (var i = 0; i <= 8; i++) {
    zig.add(_o(r, 0.04 + i * 0.115, i.isEven ? 0.42 : 0.62));
  }
  for (var i = 8; i >= 0; i--) {
    zig.add(_o(r, 0.04 + i * 0.115, (i.isEven ? 0.42 : 0.62) + 0.12));
  }
  Pk.poly(c, zig, Pk.fill(b));
  c.drawOval(_f(r, 0.04, 0.06, 0.92, 0.22), Pk.fill(Pk.light(a, 0.3)));
  c.drawOval(_f(r, 0.04, 0.06, 0.92, 0.22), Pk.stroke(b, 2));
}

void _paintTrapeze(Canvas c, Rect r, Color a, Color b, double t) {
  _swing(c, r.topCenter, sin(t * 1.4 + r.left) * 0.22, () {
    final hw = r.width * 0.32;
    c.drawLine(Offset(r.center.dx - hw, r.top), Offset(r.center.dx - hw, r.top + r.height * 0.9), Pk.stroke(a, 1.5));
    c.drawLine(Offset(r.center.dx + hw, r.top), Offset(r.center.dx + hw, r.top + r.height * 0.9), Pk.stroke(a, 1.5));
    c.drawRRect(_rr(Rect.fromLTWH(r.center.dx - hw - 3, r.top + r.height * 0.88, hw * 2 + 6, 4), 2), Pk.fill(b));
  });
}

void _paintNet(Canvas c, Rect r, Color a, Color b, double t) {
  for (final x in [0.0, 0.97]) {
    Pk.box(c, _f(r, x, 0.1, 0.03, 0.9), b, radius: 1);
  }
  double top(double k) => r.top + r.height * (0.16 + sin(pi * k) * 0.22);
  double bot(double k) => top(k) + r.height * 0.24;
  const n = 18;
  final p = Pk.stroke(a.withValues(alpha: 0.85), 0.9);
  for (var i = 0; i < n; i++) {
    final k0 = i / n, k1 = (i + 1) / n;
    final x0 = r.left + r.width * k0, x1 = r.left + r.width * k1;
    c.drawLine(Offset(x0, top(k0)), Offset(x1, bot(k1)), p);
    c.drawLine(Offset(x1, top(k1)), Offset(x0, bot(k0)), p);
  }
  for (final f in [top, bot]) {
    final path = Path()..moveTo(r.left, f(0));
    for (var i = 1; i <= 20; i++) {
      path.lineTo(r.left + r.width * i / 20, f(i / 20));
    }
    c.drawPath(path, Pk.stroke(a, 2));
  }
}

void _paintDrum(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawRect(_f(r, 0.05, 0.3, 0.9, 0.56), Pk.fill(a));
  c.drawOval(_f(r, 0.05, 0.76, 0.9, 0.22), Pk.fill(a));
  for (var i = 0; i < 6; i++) {
    c.drawLine(_o(r, 0.08 + i * 0.16, 0.36), _o(r, 0.16 + i * 0.16, 0.8), Pk.stroke(_cream, 1));
    c.drawLine(_o(r, 0.24 + i * 0.16, 0.36), _o(r, 0.16 + i * 0.16, 0.8), Pk.stroke(_cream, 1));
  }
  c.drawRect(_f(r, 0.05, 0.3, 0.9, 0.07), Pk.fill(b));
  c.drawRect(_f(r, 0.05, 0.8, 0.9, 0.06), Pk.fill(b));
  c.drawOval(_f(r, 0.05, 0.2, 0.9, 0.22), Pk.fill(_cream));
  c.drawOval(_f(r, 0.05, 0.2, 0.9, 0.22), Pk.stroke(b, 2));
  final hit = max(0.0, sin(t * 4)) * 0.08;
  c.drawLine(_o(r, 0.2, -0.05 + hit), _o(r, 0.5, 0.28), Pk.stroke(_wood, 2));
  c.drawLine(_o(r, 0.85, -0.02), _o(r, 0.56, 0.28), Pk.stroke(_wood, 2));
}

void _paintPole(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawLine(_o(r, 0.5, 0.06), _o(r, -0.4, 1.0), Pk.stroke(_rope, 1));
  c.drawLine(_o(r, 0.5, 0.06), _o(r, 1.4, 1.0), Pk.stroke(_rope, 1));
  final pole = _f(r, 0.36, 0.06, 0.28, 0.94);
  c.drawRect(pole, Pk.fill(a));
  c.save();
  c.clipRect(pole);
  for (var y = pole.top - pole.width; y < pole.bottom; y += 10) {
    c.drawLine(Offset(pole.left, y + pole.width), Offset(pole.right, y), Pk.stroke(b, 3));
  }
  c.restore();
  Pk.box(c, _f(r, -0.3, 0.12, 1.6, 0.03), _darkWood, radius: 1);
  c.drawLine(_o(r, -0.3, 0.15), _o(r, 0.4, 0.25), Pk.stroke(_darkWood, 1.2));
  c.drawLine(_o(r, 1.3, 0.15), _o(r, 0.6, 0.25), Pk.stroke(_darkWood, 1.2));
  c.drawCircle(_o(r, 0.5, 0.04), r.width * 0.24, Pk.fill(_gold));
  final wave = sin(t * 3 + r.left) * 0.15;
  Pk.poly(c, [_o(r, 0.5, -0.04), _o(r, 1.6 + wave, 0.0), _o(r, 0.5, 0.03)], Pk.fill(b));
  for (var i = 0; i < 3; i++) {
    c.drawOval(_f(r, -0.2, 0.9 - i * 0.025, 1.4, 0.07), Pk.stroke(_rope, 1.6));
  }
}

void _paintElephant(Canvas c, Rect r, Color a, Color b, double t) {
  final dk = Pk.dark(a, 0.12);
  for (final x in [0.16, 0.3, 0.56, 0.68]) {
    Pk.box(c, _f(r, x, 0.58, 0.11, 0.42), dk, radius: 3);
  }
  c.drawLine(_o(r, 0.12, 0.42), _o(r, 0.04, 0.62), Pk.stroke(dk, 1.6));
  Pk.box(c, _f(r, 0.1, 0.24, 0.68, 0.46), a, radius: r.height * 0.22);
  Pk.box(c, _f(r, 0.28, 0.2, 0.34, 0.24), b, radius: 4);
  for (var i = 0; i < 5; i++) {
    c.drawCircle(_o(r, 0.31 + i * 0.07, 0.45), 1.6, Pk.fill(_gold));
  }
  final trunkSwing = sin(t * 1.5 + r.left) * 0.03;
  c.drawPath(
    Path()
      ..moveTo(r.left + r.width * 0.88, r.top + r.height * 0.4)
      ..quadraticBezierTo(r.left + r.width * (0.99 + trunkSwing), r.top + r.height * 0.6, r.left + r.width * (0.95 + trunkSwing), r.top + r.height * 0.86)
      ..quadraticBezierTo(r.left + r.width * (0.92 + trunkSwing), r.top + r.height * 0.9, r.left + r.width * (0.9 + trunkSwing), r.top + r.height * 0.82),
    Pk.stroke(a, r.width * 0.07),
  );
  c.drawCircle(_o(r, 0.8, 0.34), r.width * 0.15, Pk.fill(a));
  c.drawOval(_f(r, 0.62, 0.2, 0.18, 0.34), Pk.fill(dk));
  c.drawOval(_f(r, 0.65, 0.24, 0.12, 0.26), Pk.fill(Pk.mix(a, _lotus, 0.35)));
  c.drawCircle(_o(r, 0.85, 0.3), 1.6, Pk.fill(_ink));
  c.drawLine(_o(r, 0.86, 0.46), _o(r, 0.93, 0.5), Pk.stroke(_cream, 2.2));
  Pk.poly(c, [_o(r, 0.8, 0.2), _o(r, 0.76, 0.05), _o(r, 0.84, 0.05)], Pk.fill(b));
  c.drawCircle(_o(r, 0.8, 0.04), 2.2, Pk.fill(_gold));
}

void _paintSeal(Canvas c, Rect r, Color a, Color b, double t) {
  final bounce = (sin(t * 3) * 0.5 + 0.5) * r.height * 0.08;
  c.drawPath(
    Path()
      ..moveTo(r.left + r.width * 0.1, r.bottom)
      ..quadraticBezierTo(r.left + r.width * 0.2, r.top + r.height * 0.5, r.left + r.width * 0.44, r.top + r.height * 0.38)
      ..lineTo(r.left + r.width * 0.66, r.top + r.height * 0.36)
      ..quadraticBezierTo(r.left + r.width * 0.72, r.top + r.height * 0.7, r.left + r.width * 0.62, r.bottom)
      ..close(),
    Pk.fill(a),
  );
  c.drawCircle(_o(r, 0.58, 0.32), r.width * 0.14, Pk.fill(a));
  c.drawOval(_f(r, 0.62, 0.3, 0.2, 0.1), Pk.fill(Pk.light(a, 0.15)));
  c.drawCircle(_o(r, 0.8, 0.33), 1.8, Pk.fill(_ebony));
  c.drawCircle(_o(r, 0.6, 0.27), 1.6, Pk.fill(_ebony));
  c.drawOval(_f(r, 0.56, 0.72, 0.3, 0.12), Pk.fill(Pk.dark(a, 0.15)));
  c.drawOval(_f(r, 0.0, 0.86, 0.3, 0.12), Pk.fill(Pk.dark(a, 0.15)));
  final ball = Offset(r.left + r.width * 0.8, r.top + r.height * 0.1 - bounce);
  final br = r.width * 0.12;
  c.drawCircle(ball, br, Pk.fill(_white));
  c.drawArc(Rect.fromCircle(center: ball, radius: br), -pi / 2, pi / 1.5, true, Pk.fill(b));
  c.drawArc(Rect.fromCircle(center: ball, radius: br), pi / 2, pi / 1.5, true, Pk.fill(_blue));
}

void _paintVanity(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, r, a, radius: 5);
  final g = r.deflate(min(r.width, r.height) * 0.16);
  Pk.gradientRect(c, g, const Color(0xFFDFF4FF), const Color(0xFF9CC8E0));
  c.drawLine(g.topLeft + Offset(g.width * 0.15, g.height * 0.6), g.topLeft + Offset(g.width * 0.4, g.height * 0.1), Pk.stroke(Colors.white.withValues(alpha: 0.7), 3));
  c.drawLine(g.topLeft + Offset(g.width * 0.3, g.height * 0.7), g.topLeft + Offset(g.width * 0.5, g.height * 0.3), Pk.stroke(Colors.white.withValues(alpha: 0.5), 1.5));
  final pts = <Offset>[];
  const nx = 6, ny = 3;
  for (var i = 0; i < nx; i++) {
    pts.add(Offset(r.left + r.width * (i + 0.5) / nx, r.top + min(r.width, r.height) * 0.08));
  }
  for (var j = 0; j < ny; j++) {
    final y = r.top + r.height * (j + 0.8) / (ny + 0.6);
    pts.add(Offset(r.left + min(r.width, r.height) * 0.08, y));
    pts.add(Offset(r.right - min(r.width, r.height) * 0.08, y));
  }
  for (var i = 0; i < pts.length; i++) {
    Pk.glow(c, pts[i], 6, b, 0.55 + 0.15 * sin(t * 3 + i));
    c.drawCircle(pts[i], 2.4, Pk.fill(Pk.light(b, 0.6)));
  }
}

void _paintClownFace(Canvas c, Rect r, Color a, Color b, double t) {
  final cx = r.center.dx, cy = r.center.dy + r.height * 0.06;
  final rad = min(r.width, r.height) * 0.34;
  for (final d in [-1.0, 1.0]) {
    for (var i = 0; i < 3; i++) {
      c.drawCircle(Offset(cx + d * rad * (0.95 + i * 0.12), cy - rad * (0.3 - i * 0.35)), rad * 0.32, Pk.fill(b));
    }
  }
  c.drawCircle(Offset(cx, cy), rad, Pk.fill(a));
  Pk.poly(c, [Offset(cx, cy - rad * 2.0), Offset(cx + rad * 0.5, cy - rad * 0.8), Offset(cx - rad * 0.5, cy - rad * 0.8)], Pk.fill(_blue));
  c.drawCircle(Offset(cx, cy - rad * 2.0), rad * 0.16, Pk.fill(_gold));
  for (final d in [-1.0, 1.0]) {
    final e = Offset(cx + d * rad * 0.38, cy - rad * 0.25);
    Pk.poly(c, [e - Offset(0, rad * 0.22), e + Offset(rad * 0.12, 0), e + Offset(0, rad * 0.22), e - Offset(rad * 0.12, 0)], Pk.fill(_blue));
    c.drawCircle(e, rad * 0.06, Pk.fill(_ebony));
  }
  c.drawArc(Rect.fromCenter(center: Offset(cx, cy + rad * 0.2), width: rad * 1.2, height: rad * 0.9), 0.2, pi - 0.4, false, Pk.stroke(_red, rad * 0.14));
  c.drawCircle(Offset(cx, cy + rad * 0.05), rad * 0.2, Pk.fill(_red));
  c.drawCircle(Offset(cx - rad * 0.06, cy - rad * 0.01), rad * 0.06, Pk.fill(Colors.white.withValues(alpha: 0.8)));
}

void _paintMakeup(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawOval(_f(r, 0.0, 0.7, 0.3, 0.3), Pk.fill(_cream));
  c.drawOval(_f(r, 0.04, 0.62, 0.22, 0.2), Pk.fill(_lotus));
  Pk.box(c, _f(r, 0.36, 0.4, 0.16, 0.6), a, radius: 2);
  for (var i = 0; i < 3; i++) {
    c.drawLine(_o(r, 0.4 + i * 0.04, 0.42), _o(r, 0.36 + i * 0.07, 0.0), Pk.stroke(_darkWood, 1.4));
    c.drawCircle(_o(r, 0.36 + i * 0.07, 0.02), 2, Pk.fill([b, _gold, _blue][i]));
  }
  for (var i = 0; i < 4; i++) {
    c.drawCircle(_o(r, 0.62 + i * 0.1, 0.84), r.height * 0.13, Pk.fill([_red, _blue, _gold, _green][i]));
  }
  Pk.box(c, _f(r, 0.62, 0.68, 0.4, 0.06), _white, radius: 1);
}

void _paintToyBox(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.poly(c, [_o(r, 0.04, 0.46), _o(r, 0.96, 0.46), _o(r, 1.0, 0.1), _o(r, 0.08, 0.06)], Pk.fill(Pk.dark(a, 0.2)));
  for (var i = 0; i < 2; i++) {
    c.save();
    c.translate(r.left + r.width * (0.25 + i * 0.16), r.top + r.height * 0.36);
    c.rotate(-0.3 + i * 0.5);
    c.drawOval(Rect.fromCenter(center: Offset.zero, width: r.width * 0.11, height: r.height * 0.42), Pk.fill(_white));
    c.drawRect(Rect.fromCenter(center: Offset(0, -r.height * 0.06), width: r.width * 0.11, height: r.height * 0.05), Pk.fill(b));
    c.restore();
  }
  for (final (x, y, col) in [(0.62, 0.36, _blue), (0.78, 0.4, _gold), (0.7, 0.24, _green)]) {
    c.drawCircle(_o(r, x, y), r.width * 0.08, Pk.fill(col));
  }
  Pk.box(c, _f(r, 0.0, 0.44, 1.0, 0.56), a, radius: 3);
  _star(c, _o(r, 0.5, 0.72), r.height * 0.14, b);
  c.drawRect(_f(r, 0.0, 0.48, 1.0, 0.05), Pk.fill(b));
}

void _paintBalloons(Canvas c, Rect r, Color a, Color b, double t) {
  final anchor = _o(r, 0.5, 0.95);
  final cols = [a, b, _blue, _gold, _green];
  const pos = [(0.25, 0.18), (0.55, 0.08), (0.78, 0.22), (0.4, 0.34), (0.68, 0.4)];
  for (var i = 0; i < 5; i++) {
    final sway = sin(t * 1.2 + i * 1.7) * r.width * 0.04;
    final p = Offset(r.left + r.width * pos[i].$1 + sway, r.top + r.height * pos[i].$2 + r.width * 0.2);
    c.drawLine(anchor, p + Offset(0, r.width * 0.17), Pk.stroke(Colors.white.withValues(alpha: 0.8), 0.8));
    c.drawOval(Rect.fromCenter(center: p, width: r.width * 0.3, height: r.width * 0.36), Pk.fill(cols[i]));
    Pk.poly(c, [p + Offset(0, r.width * 0.16), p + Offset(-2, r.width * 0.2), p + Offset(2, r.width * 0.2)], Pk.fill(cols[i]));
    c.drawOval(Rect.fromCenter(center: p - Offset(r.width * 0.05, r.width * 0.07), width: r.width * 0.07, height: r.width * 0.1), Pk.fill(Colors.white.withValues(alpha: 0.55)));
  }
  Pk.box(c, _f(r, 0.38, 0.9, 0.24, 0.1), _ink, radius: 2);
}

void _paintRack(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawLine(_o(r, 0.04, 0.06), _o(r, 0.96, 0.06), Pk.stroke(a, 2.5));
  for (final x in [0.06, 0.94]) {
    c.drawLine(_o(r, x, 0.06), _o(r, x, 0.94), Pk.stroke(a, 2.5));
    c.drawCircle(_o(r, x, 0.96), 2.5, Pk.fill(_ink));
  }
  final cols = [b, _blue, _gold, _purple];
  for (var i = 0; i < 4; i++) {
    final x0 = 0.14 + i * 0.2;
    final col = cols[i];
    c.drawLine(_o(r, x0 + 0.08, 0.06), _o(r, x0 + 0.08, 0.12), Pk.stroke(_steel, 1.2));
    Pk.poly(c, [_o(r, x0 + 0.02, 0.12), _o(r, x0 + 0.14, 0.12), _o(r, x0 + 0.2, 0.74), _o(r, x0 - 0.04, 0.74)], Pk.fill(col));
    for (var k = 0; k < 3; k++) {
      c.drawCircle(_o(r, x0 + 0.04 + k * 0.05, 0.4 + (k % 2) * 0.14), 1.6, Pk.fill(Pk.light(col, 0.5)));
    }
    c.drawLine(_o(r, x0 - 0.03, 0.72), _o(r, x0 + 0.19, 0.72), Pk.stroke(Pk.dark(col, 0.2), 2.5));
  }
}

void _paintWagon(Canvas c, Rect r, Color a, Color b, double t) {
  for (final x in [0.24, 0.76]) {
    c.drawCircle(_o(r, x, 0.82), r.height * 0.18, Pk.stroke(Pk.dark(b, 0.1), r.height * 0.04));
  }
  c.drawRect(_f(r, 0.06, 0.7, 0.88, 0.06), Pk.fill(_ebony));
  Pk.box(c, _f(r, 0.04, 0.16, 0.92, 0.56), a, radius: 4);
  final roof = Path()
    ..moveTo(r.left, r.top + r.height * 0.2)
    ..quadraticBezierTo(r.center.dx, r.top - r.height * 0.06, r.right, r.top + r.height * 0.2)
    ..lineTo(r.right, r.top + r.height * 0.24)
    ..lineTo(r.left, r.top + r.height * 0.24)
    ..close();
  c.drawPath(roof, Pk.fill(b));
  c.drawLine(_o(r, 0.0, 0.24), _o(r, 1.0, 0.24), Pk.stroke(_gold, 2));
  for (final x in [0.12, 0.38]) {
    final w = _f(r, x, 0.32, 0.2, 0.22);
    c.drawRRect(_rr(w, 3), Pk.fill(_lampGlow));
    Pk.poly(c, [w.topLeft, w.topLeft + Offset(w.width * 0.4, 0), w.bottomLeft], Pk.fill(b));
    Pk.poly(c, [w.topRight, w.topRight - Offset(w.width * 0.4, 0), w.bottomRight], Pk.fill(b));
    c.drawRRect(_rr(w, 3), Pk.stroke(_gold, 1.5));
  }
  final door = _f(r, 0.66, 0.3, 0.18, 0.4);
  c.drawRRect(RRect.fromRectAndCorners(door, topLeft: Radius.circular(door.width / 2), topRight: Radius.circular(door.width / 2)), Pk.fill(Pk.dark(a, 0.3)));
  c.drawRRect(RRect.fromRectAndCorners(door, topLeft: Radius.circular(door.width / 2), topRight: Radius.circular(door.width / 2)), Pk.stroke(_gold, 1.5));
  c.drawCircle(_o(r, 0.8, 0.52), 1.5, Pk.fill(_gold));
  for (var i = 0; i < 2; i++) {
    c.drawRect(_f(r, 0.68 + i * 0.03, 0.72 + i * 0.07, 0.16 - i * 0.03, 0.04), Pk.fill(_darkWood));
  }
  for (final x in [0.24, 0.76]) {
    final cc = _o(r, x, 0.82);
    final rad = r.height * 0.17;
    final spin = t * 0.0;
    for (var i = 0; i < 8; i++) {
      final ang = spin + i * pi / 4;
      c.drawLine(cc, cc + Offset(cos(ang), sin(ang)) * rad, Pk.stroke(_gold, 1.3));
    }
    c.drawCircle(cc, rad, Pk.stroke(b, r.height * 0.04));
    c.drawCircle(cc, rad * 0.22, Pk.fill(_gold));
  }
}

void _paintCageWagon(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawRect(_f(r, 0.06, 0.7, 0.88, 0.06), Pk.fill(_ebony));
  Pk.box(c, _f(r, 0.04, 0.16, 0.92, 0.56), a, radius: 4);
  final inner = _f(r, 0.1, 0.24, 0.8, 0.42);
  c.drawRect(inner, Pk.fill(const Color(0xFF3A2A2A)));
  final face = Offset(inner.center.dx, inner.center.dy + inner.height * 0.05);
  final fr = inner.height * 0.32;
  for (var i = 0; i < 12; i++) {
    final ang = i * pi / 6;
    c.drawCircle(face + Offset(cos(ang), sin(ang)) * fr * 0.9, fr * 0.42, Pk.fill(const Color(0xFFC9702A)));
  }
  c.drawCircle(face, fr * 0.85, Pk.fill(_straw));
  for (final d in [-1.0, 1.0]) {
    c.drawCircle(face + Offset(d * fr * 0.32, -fr * 0.15), fr * 0.1, Pk.fill(_ebony));
  }
  Pk.poly(c, [face + Offset(-fr * 0.15, fr * 0.12), face + Offset(fr * 0.15, fr * 0.12), face + Offset(0, fr * 0.3)], Pk.fill(_maroon));
  c.drawArc(Rect.fromCenter(center: face + Offset(0, fr * 0.35), width: fr * 0.5, height: fr * 0.3), 0.3, pi - 0.6, false, Pk.stroke(_maroon, 1.2));
  for (var i = 0; i <= 8; i++) {
    final x = inner.left + inner.width * i / 8;
    c.drawLine(Offset(x, inner.top), Offset(x, inner.bottom), Pk.stroke(_gold, 1.6));
  }
  final roof = Path()
    ..moveTo(r.left, r.top + r.height * 0.2)
    ..quadraticBezierTo(r.center.dx, r.top - r.height * 0.06, r.right, r.top + r.height * 0.2)
    ..lineTo(r.right, r.top + r.height * 0.24)
    ..lineTo(r.left, r.top + r.height * 0.24)
    ..close();
  c.drawPath(roof, Pk.fill(b));
  c.drawLine(_o(r, 0.0, 0.24), _o(r, 1.0, 0.24), Pk.stroke(_gold, 2));
  for (final x in [0.24, 0.76]) {
    final cc = _o(r, x, 0.82);
    final rad = r.height * 0.17;
    for (var i = 0; i < 8; i++) {
      c.drawLine(cc, cc + Offset(cos(i * pi / 4), sin(i * pi / 4)) * rad, Pk.stroke(_gold, 1.3));
    }
    c.drawCircle(cc, rad, Pk.stroke(b, r.height * 0.04));
    c.drawCircle(cc, rad * 0.22, Pk.fill(_gold));
  }
}

void _paintBalanceBall(Canvas c, Rect r, Color a, Color b, double t) {
  final roll = sin(t * 1.2 + r.left) * 0.4;
  final cc = r.center, rad = min(r.width, r.height) / 2;
  c.drawCircle(cc, rad, Pk.fill(a));
  c.save();
  c.translate(cc.dx, cc.dy);
  c.rotate(roll);
  c.drawRect(Rect.fromCenter(center: Offset.zero, width: rad * 2, height: rad * 0.45), Pk.fill(b));
  _star(c, Offset.zero, rad * 0.4, _white);
  c.restore();
  c.drawCircle(cc, rad, Pk.stroke(Pk.dark(a, 0.2), 1.2));
}

void _paintSearchlight(Canvas c, Rect r, Color a, Color b, double t) {
  final ang = -pi / 2 + sin(t * 0.6 + r.left) * 0.45;
  final base = _o(r, 0.5, 0.35);
  final beam = Path()
    ..moveTo(base.dx, base.dy)
    ..lineTo(base.dx + cos(ang - 0.1) * 220, base.dy + sin(ang - 0.1) * 220)
    ..lineTo(base.dx + cos(ang + 0.1) * 220, base.dy + sin(ang + 0.1) * 220)
    ..close();
  c.drawPath(beam, Pk.fill(b.withValues(alpha: 0.16)));
  Pk.box(c, _f(r, 0.2, 0.6, 0.6, 0.4), _iron, radius: 2);
  c.save();
  c.translate(base.dx, base.dy);
  c.rotate(ang + pi / 2);
  c.drawRRect(_rr(Rect.fromCenter(center: Offset.zero, width: r.width * 0.56, height: r.height * 0.5), 3), Pk.fill(a));
  c.drawOval(Rect.fromCenter(center: Offset(0, -r.height * 0.24), width: r.width * 0.5, height: r.height * 0.16), Pk.fill(b));
  c.restore();
  Pk.glow(c, base, r.width * 0.8, b, 0.4);
}

void _paintBunting(Canvas c, Rect r, Color a, Color b, double t) {
  double y(double k) => r.top + r.height * (0.1 + sin(pi * k) * 0.5);
  final p = Path()..moveTo(r.left, y(0));
  for (var i = 1; i <= 24; i++) {
    p.lineTo(r.left + r.width * i / 24, y(i / 24));
  }
  c.drawPath(p, Pk.stroke(_ink, 1));
  final n = max(5, (r.width / 18).round());
  final cols = [a, b, _blue, _gold, _green];
  for (var i = 0; i < n; i++) {
    final k0 = (i + 0.15) / n, k1 = (i + 0.85) / n, km = (i + 0.5) / n;
    final flap = sin(t * 3 + i) * 1.5;
    Pk.poly(c, [Offset(r.left + r.width * k0, y(k0)), Offset(r.left + r.width * k1, y(k1)), Offset(r.left + r.width * km + flap, y(km) + r.height * 0.42)],
        Pk.fill(cols[i % cols.length]));
  }
}

// ---------------------------------------------------------------- Desert oasis
void _paintBedouinTent(Canvas c, Rect r, Color a, Color b, double t) {
  for (final x in [0.2, 0.5, 0.8]) {
    c.drawLine(_o(r, x, 0.02), _o(r, x, 1.0), Pk.stroke(_darkWood, 2));
  }
  Pk.poly(c, [_o(r, 0.04, 0.38), _o(r, 0.96, 0.38), _o(r, 0.96, 1.0), _o(r, 0.04, 1.0)], Pk.fill(Pk.dark(a, 0.5)));
  Pk.glow(c, _o(r, 0.5, 0.75), r.width * 0.3, _lampGlow, 0.3);
  Pk.poly(c, [_o(r, 0.14, 0.86), _o(r, 0.86, 0.86), _o(r, 0.96, 1.0), _o(r, 0.04, 1.0)], Pk.fill(b));
  for (var i = 0; i < 4; i++) {
    final x = 0.24 + i * 0.17;
    Pk.poly(c, [_o(r, x, 0.9), _o(r, x + 0.04, 0.93), _o(r, x, 0.96), _o(r, x - 0.04, 0.93)], Pk.fill(_gold));
  }
  final roof = Path()
    ..moveTo(r.left, r.top + r.height * 0.4)
    ..quadraticBezierTo(r.left + r.width * 0.1, r.top + r.height * 0.18, r.left + r.width * 0.2, r.top + r.height * 0.04)
    ..quadraticBezierTo(r.left + r.width * 0.35, r.top + r.height * 0.22, r.center.dx, r.top)
    ..quadraticBezierTo(r.left + r.width * 0.65, r.top + r.height * 0.22, r.left + r.width * 0.8, r.top + r.height * 0.04)
    ..quadraticBezierTo(r.left + r.width * 0.9, r.top + r.height * 0.18, r.right, r.top + r.height * 0.4)
    ..lineTo(r.right, r.top + r.height * 0.44)
    ..lineTo(r.left, r.top + r.height * 0.44)
    ..close();
  c.drawPath(roof, Pk.fill(a));
  c.save();
  c.clipPath(roof);
  for (var i = 0; i < 4; i++) {
    c.drawRect(_f(r, 0, 0.12 + i * 0.09, 1, 0.035), Pk.fill(b));
  }
  c.restore();
  for (final side in [0.0, 1.0]) {
    final x0 = side == 0 ? 0.0 : 1.0, x1 = side == 0 ? 0.16 : 0.84;
    Pk.poly(c, [_o(r, x0, 0.42), _o(r, x1, 0.42), _o(r, x0, 1.0)], Pk.fill(Pk.dark(a, 0.08)));
  }
  c.drawLine(_o(r, 0.0, 0.42), _o(r, -0.06, 1.0), Pk.stroke(_rope, 1));
  c.drawLine(_o(r, 1.0, 0.42), _o(r, 1.06, 1.0), Pk.stroke(_rope, 1));
}

void _paintCamel(Canvas c, Rect r, Color a, Color b, double t) {
  final dk = Pk.dark(a, 0.15);
  for (final x in [0.24, 0.34, 0.6, 0.7]) {
    c.drawLine(_o(r, x, 0.55), _o(r, x, 0.97), Pk.stroke(x == 0.34 || x == 0.7 ? dk : a, r.width * 0.05));
  }
  c.drawLine(_o(r, 0.16, 0.45), _o(r, 0.12, 0.65), Pk.stroke(dk, 1.4));
  c.drawOval(_f(r, 0.16, 0.32, 0.62, 0.3), Pk.fill(a));
  c.drawOval(_f(r, 0.3, 0.14, 0.32, 0.34), Pk.fill(a));
  Pk.box(c, _f(r, 0.3, 0.26, 0.32, 0.18), b, radius: 3);
  for (var i = 0; i < 6; i++) {
    c.drawLine(_o(r, 0.31 + i * 0.06, 0.44), _o(r, 0.31 + i * 0.06, 0.5), Pk.stroke(_gold, 1.4));
  }
  for (final x in [0.26, 0.62]) {
    Pk.box(c, _f(r, x, 0.36, 0.12, 0.2), Pk.dark(_terracotta, 0.2), radius: 3);
  }
  final nod = sin(t * 1.2 + r.left) * 0.015;
  c.drawLine(_o(r, 0.74, 0.44), _o(r, 0.86, 0.18 + nod), Pk.stroke(a, r.width * 0.09));
  c.drawOval(_f(r, 0.8, 0.1 + nod, 0.2, 0.12), Pk.fill(a));
  c.drawCircle(_o(r, 0.88, 0.14 + nod), 1.4, Pk.fill(_ebony));
  c.drawOval(_f(r, 0.82, 0.07 + nod, 0.04, 0.06), Pk.fill(dk));
}

void _paintJar(Canvas c, Rect r, Color a, Color b, double t) {
  final body = Path()
    ..moveTo(r.left + r.width * 0.36, r.top + r.height * 0.1)
    ..lineTo(r.left + r.width * 0.36, r.top + r.height * 0.22)
    ..cubicTo(r.left - r.width * 0.02, r.top + r.height * 0.32, r.left - r.width * 0.02, r.top + r.height * 0.78, r.left + r.width * 0.3, r.bottom)
    ..lineTo(r.left + r.width * 0.7, r.bottom)
    ..cubicTo(r.right + r.width * 0.02, r.top + r.height * 0.78, r.right + r.width * 0.02, r.top + r.height * 0.32, r.left + r.width * 0.64, r.top + r.height * 0.22)
    ..lineTo(r.left + r.width * 0.64, r.top + r.height * 0.1)
    ..close();
  c.drawPath(body, Pk.fill(a));
  c.save();
  c.clipPath(body);
  c.drawRect(_f(r, 0, 0.42, 1, 0.06), Pk.fill(b));
  for (var i = 0; i < 5; i++) {
    Pk.poly(c, [_o(r, 0.1 + i * 0.2, 0.52), _o(r, 0.2 + i * 0.2, 0.52), _o(r, 0.15 + i * 0.2, 0.6)], Pk.fill(b));
  }
  c.restore();
  Pk.box(c, _f(r, 0.3, 0.04, 0.4, 0.08), Pk.dark(a, 0.15), radius: 2);
  for (final d in [-1.0, 1.0]) {
    c.drawArc(Rect.fromCenter(center: _o(r, 0.5 + d * 0.3, 0.26), width: r.width * 0.2, height: r.height * 0.18), d < 0 ? pi / 2 : -pi / 2, pi, false,
        Pk.stroke(Pk.dark(a, 0.12), 2));
  }
}

void _paintSpiceStall(Canvas c, Rect r, Color a, Color b, double t) {
  for (final x in [0.62, 0.8]) {
    Pk.box(c, _f(r, x, 0.12, 0.18, 0.46), _straw, radius: 4);
    c.drawOval(_f(r, x + 0.01, 0.08, 0.16, 0.1), Pk.fill(x == 0.62 ? _red : _orange));
  }
  Pk.box(c, _f(r, 0.0, 0.5, 1.0, 0.5), a, radius: 2);
  c.drawRect(_f(r, 0.0, 0.62, 1.0, 0.38), Pk.fill(b));
  for (var i = 0; i < 8; i++) {
    c.drawLine(_o(r, 0.06 + i * 0.125, 0.96), _o(r, 0.06 + i * 0.125, 1.0), Pk.stroke(_gold, 1.4));
  }
  c.drawLine(_o(r, 0, 0.66), _o(r, 1, 0.66), Pk.stroke(_gold, 1.4));
  final cols = [_red, _orange, _gold, const Color(0xFF8BC34A), const Color(0xFF9A5A3A)];
  for (var i = 0; i < 5; i++) {
    final x = 0.03 + i * 0.19;
    Pk.poly(c, [_o(r, x + 0.02, 0.48), _o(r, x + 0.08, 0.26 + (i % 2) * 0.05), _o(r, x + 0.14, 0.48)], Pk.fill(cols[i]));
    c.drawArc(_f(r, x, 0.4, 0.16, 0.16), 0, pi, true, Pk.fill(_darkWood));
  }
}

void _paintSacks(Canvas c, Rect r, Color a, Color b, double t) {
  for (final (x, w, col) in [(0.0, 0.55, b), (0.42, 0.58, _gold)]) {
    final s = _f(r, x, 0.2, w, 0.8);
    Pk.box(c, s, a, radius: s.width * 0.3);
    c.drawOval(Rect.fromLTWH(s.left + 2, s.top - 2, s.width - 4, s.height * 0.24), Pk.fill(Pk.dark(a, 0.1)));
    c.drawOval(Rect.fromLTWH(s.left + 4, s.top - 1, s.width - 8, s.height * 0.18), Pk.fill(col));
    c.drawLine(Offset(s.left + 3, s.top + s.height * 0.3), Offset(s.right - 3, s.top + s.height * 0.3), Pk.stroke(Pk.dark(a, 0.25), 1));
  }
}

void _paintRug(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawRect(_f(r, -0.04, 0.0, 1.08, 0.04), Pk.fill(_darkWood));
  final body = _f(r, 0.0, 0.04, 1.0, 0.88);
  Pk.box(c, body, a, radius: 1);
  c.drawRect(body.deflate(3), Pk.stroke(b, 2.5));
  c.drawRect(body.deflate(7), Pk.stroke(_cream, 1));
  final cc = body.center;
  final hw = body.width * 0.3, hh = body.height * 0.3;
  Pk.poly(c, [cc - Offset(0, hh), cc + Offset(hw, 0), cc + Offset(0, hh), cc - Offset(hw, 0)], Pk.fill(b));
  Pk.poly(c, [cc - Offset(0, hh * 0.55), cc + Offset(hw * 0.55, 0), cc + Offset(0, hh * 0.55), cc - Offset(hw * 0.55, 0)], Pk.fill(_cream));
  c.drawCircle(cc, hw * 0.18, Pk.fill(a));
  for (final (x, y) in [(0.2, 0.2), (0.8, 0.2), (0.2, 0.8), (0.8, 0.8)]) {
    final p = Offset(body.left + body.width * x, body.top + body.height * y);
    Pk.poly(c, [p - const Offset(0, 4), p + const Offset(4, 0), p + const Offset(0, 4), p - const Offset(4, 0)], Pk.fill(b));
  }
  for (var i = 0; i < 9; i++) {
    final x = r.left + r.width * (0.06 + i * 0.11);
    c.drawLine(Offset(x, body.bottom), Offset(x, r.bottom), Pk.stroke(_cream, 1.2));
  }
}

void _paintArabLamp(Canvas c, Rect r, Color a, Color b, double t) {
  _swing(c, r.topCenter, sin(t * 1.1 + r.left) * 0.05, () {
    c.drawLine(r.topCenter, _o(r, 0.5, 0.2), Pk.stroke(a, 1.2));
    Pk.glow(c, _o(r, 0.5, 0.58), r.width * 1.5, b, 0.5 + 0.08 * sin(t * 3 + r.left));
    Pk.poly(c, [_o(r, 0.5, 0.14), _o(r, 0.78, 0.3), _o(r, 0.22, 0.3)], Pk.fill(a));
    final body = [_o(r, 0.18, 0.3), _o(r, 0.82, 0.3), _o(r, 0.96, 0.56), _o(r, 0.74, 0.86), _o(r, 0.26, 0.86), _o(r, 0.04, 0.56)];
    Pk.poly(c, body, Pk.fill(Pk.light(b, 0.25)));
    Pk.poly(c, body, Pk.stroke(a, 1.6));
    c.drawLine(_o(r, 0.5, 0.3), _o(r, 0.5, 0.86), Pk.stroke(a, 1.2));
    c.drawLine(_o(r, 0.04, 0.56), _o(r, 0.96, 0.56), Pk.stroke(a, 1.2));
    for (final (x, y) in [(0.3, 0.42), (0.7, 0.42), (0.3, 0.7), (0.7, 0.7)]) {
      _star(c, _o(r, x, y), r.width * 0.07, _white);
    }
    Pk.poly(c, [_o(r, 0.36, 0.86), _o(r, 0.64, 0.86), _o(r, 0.5, 1.0)], Pk.fill(a));
  });
}

void _paintJewels(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.poly(c, [_o(r, 0.06, 0.02), _o(r, 0.94, 0.02), _o(r, 0.96, 0.46), _o(r, 0.04, 0.46)], Pk.fill(Pk.dark(a, 0.25)));
  Pk.poly(c, [_o(r, 0.12, 0.08), _o(r, 0.88, 0.08), _o(r, 0.9, 0.44), _o(r, 0.1, 0.44)], Pk.fill(_maroon));
  Pk.glow(c, _o(r, 0.5, 0.45), r.width * 0.5, _gold, 0.4);
  final gems = [_red, _blue, _green, _purple, _aqua, _red];
  for (var i = 0; i < 6; i++) {
    final p = _o(r, 0.14 + i * 0.145, 0.42 - (i % 2) * 0.06);
    final s = r.width * 0.05;
    Pk.poly(c, [p - Offset(0, s), p + Offset(s, 0), p + Offset(0, s), p - Offset(s, 0)], Pk.fill(gems[i]));
  }
  Pk.box(c, _f(r, 0.0, 0.46, 1.0, 0.54), a, radius: 3);
  for (final x in [0.1, 0.84]) {
    c.drawRect(_f(r, x, 0.46, 0.06, 0.54), Pk.fill(b));
  }
  c.drawRect(_f(r, 0.44, 0.52, 0.12, 0.16), Pk.fill(b));
  final pearls = Path()..moveTo(r.left + r.width * 0.22, r.top + r.height * 0.46);
  pearls.quadraticBezierTo(r.left + r.width * 0.36, r.top + r.height * 0.95, r.left + r.width * 0.52, r.top + r.height * 0.46);
  for (var i = 0; i <= 8; i++) {
    final k = i / 8;
    final x = (1 - k) * (1 - k) * 0.22 + 2 * k * (1 - k) * 0.36 + k * k * 0.52;
    final y = (1 - k) * (1 - k) * 0.46 + 2 * k * (1 - k) * 0.95 + k * k * 0.46;
    c.drawCircle(_o(r, x, y), 1.8, Pk.fill(_white));
  }
  final tw = 0.5 + 0.5 * sin(t * 3 + r.left);
  Pk.sparkle(c, _o(r, 0.7, 0.3), 3 + 2 * tw, _white);
}

Path _ogee(Rect r) => Path()
  ..moveTo(r.left, r.bottom)
  ..lineTo(r.left, r.top + r.height * 0.42)
  ..cubicTo(r.left, r.top + r.height * 0.14, r.center.dx - r.width * 0.06, r.top + r.height * 0.12, r.center.dx, r.top)
  ..cubicTo(r.center.dx + r.width * 0.06, r.top + r.height * 0.12, r.right, r.top + r.height * 0.14, r.right, r.top + r.height * 0.42)
  ..lineTo(r.right, r.bottom)
  ..close();

void _paintArch(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawPath(_ogee(r), Pk.fill(a));
  final inner = Rect.fromLTRB(r.left + r.width * 0.12, r.top + r.height * 0.1, r.right - r.width * 0.12, r.bottom);
  final ip = _ogee(inner);
  c.save();
  c.clipPath(ip);
  Pk.gradientRect(c, inner, Pk.light(b, 0.35), b);
  for (var y = 0; y < 8; y++) {
    for (var x = 0; x < 5; x++) {
      final p = Offset(inner.left + inner.width * (x + (y.isEven ? 0.25 : 0.75)) / 5 * 1.0, inner.top + inner.height * (y + 0.5) / 8);
      Pk.poly(c, [p - const Offset(0, 4), p + const Offset(3, 0), p + const Offset(0, 4), p - const Offset(3, 0)], Pk.fill(Colors.white.withValues(alpha: 0.18)));
    }
  }
  c.restore();
  c.drawPath(ip, Pk.stroke(_gold, 1.6));
  for (var i = 0; i < 7; i++) {
    final y = r.top + r.height * (0.45 + i * 0.08);
    c.drawCircle(Offset(r.left + r.width * 0.06, y), 1.6, Pk.fill(_gold));
    c.drawCircle(Offset(r.right - r.width * 0.06, y), 1.6, Pk.fill(_gold));
  }
  c.drawCircle(Offset(r.center.dx, r.top + r.height * 0.06), 2.4, Pk.fill(_gold));
}

void _paintCushions(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, _f(r, 0.0, 0.58, 1.0, 0.42), a, radius: 6);
  c.drawLine(_o(r, 0.04, 0.72), _o(r, 0.96, 0.72), Pk.stroke(_gold, 1.5));
  Pk.box(c, _f(r, 0.04, 0.16, 0.36, 0.48), b, radius: 8);
  Pk.box(c, _f(r, 0.56, 0.2, 0.38, 0.44), Pk.light(a, 0.2), radius: 8);
  Pk.box(c, _f(r, 0.34, 0.34, 0.3, 0.32), _gold, radius: 7);
  for (final (x, y) in [(0.04, 0.18), (0.4, 0.18), (0.56, 0.22), (0.94, 0.22)]) {
    c.drawCircle(_o(r, x, y), 2, Pk.fill(_gold));
  }
  _star(c, _o(r, 0.22, 0.4), r.height * 0.08, _gold);
}

void _paintDallah(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawOval(_f(r, 0.0, 0.8, 1.0, 0.2), Pk.fill(b));
  c.drawOval(_f(r, 0.04, 0.8, 0.92, 0.14), Pk.fill(Pk.light(b, 0.2)));
  c.drawPath(
    Path()
      ..moveTo(r.left + r.width * 0.5, r.top + r.height * 0.55)
      ..quadraticBezierTo(r.left + r.width * 0.62, r.top + r.height * 0.5, r.left + r.width * 0.68, r.top + r.height * 0.28),
    Pk.stroke(a, r.width * 0.05),
  );
  c.drawPath(
    Path()
      ..moveTo(r.left + r.width * 0.2, r.top + r.height * 0.84)
      ..lineTo(r.left + r.width * 0.52, r.top + r.height * 0.84)
      ..quadraticBezierTo(r.left + r.width * 0.56, r.top + r.height * 0.6, r.left + r.width * 0.44, r.top + r.height * 0.5)
      ..lineTo(r.left + r.width * 0.28, r.top + r.height * 0.5)
      ..quadraticBezierTo(r.left + r.width * 0.16, r.top + r.height * 0.6, r.left + r.width * 0.2, r.top + r.height * 0.84)
      ..close(),
    Pk.fill(a),
  );
  Pk.poly(c, [_o(r, 0.28, 0.5), _o(r, 0.44, 0.5), _o(r, 0.4, 0.3), _o(r, 0.32, 0.3)], Pk.fill(Pk.light(a, 0.1)));
  Pk.poly(c, [_o(r, 0.31, 0.3), _o(r, 0.41, 0.3), _o(r, 0.36, 0.12)], Pk.fill(a));
  c.drawCircle(_o(r, 0.36, 0.11), r.width * 0.025, Pk.fill(_gold));
  c.drawArc(_f(r, 0.08, 0.36, 0.2, 0.36), pi / 2, pi, false, Pk.stroke(Pk.dark(a, 0.1), 2));
  for (final x in [0.66, 0.82]) {
    Pk.poly(c, [_o(r, x, 0.66), _o(r, x + 0.12, 0.66), _o(r, x + 0.1, 0.84), _o(r, x + 0.02, 0.84)], Pk.fill(_cream));
  }
  _steam(c, _o(r, 0.68, 0.26), t, 0.5);
}

void _paintCanopy(Canvas c, Rect r, Color a, Color b, double t) {
  for (final x in [0.04, 0.94]) {
    c.drawRect(_f(r, x, 0.06, 0.03, 0.94), Pk.fill(_darkWood));
  }
  final cloth = Path()
    ..moveTo(r.left + r.width * 0.02, r.top + r.height * 0.06)
    ..quadraticBezierTo(r.center.dx, r.top + r.height * 0.28, r.right - r.width * 0.02, r.top + r.height * 0.06)
    ..lineTo(r.right - r.width * 0.02, r.top + r.height * 0.22)
    ..quadraticBezierTo(r.center.dx, r.top + r.height * 0.44, r.left + r.width * 0.02, r.top + r.height * 0.22)
    ..close();
  c.drawPath(cloth, Pk.fill(a));
  c.save();
  c.clipPath(cloth);
  for (var i = 0; i < 6; i += 2) {
    c.drawRect(_f(r, i / 6, 0, 1 / 6, 1), Pk.fill(b));
  }
  c.restore();
  for (var i = 0; i <= 10; i++) {
    final k = i / 10;
    final x = r.left + r.width * (0.02 + k * 0.96);
    final y = r.top + r.height * (0.22 + sin(pi * k) * 0.22 * 0.9);
    c.drawCircle(Offset(x, y + 2), 1.8, Pk.fill(_gold));
  }
}

void _paintPottedPalm(Canvas c, Rect r, Color a, Color b, double t) {
  PropKit.paint(c, PK.palm, _f(r, 0.0, 0.0, 1.0, 0.82), a, b, t);
  Pk.poly(c, [_o(r, 0.28, 0.76), _o(r, 0.72, 0.76), _o(r, 0.64, 1.0), _o(r, 0.36, 1.0)], Pk.fill(b));
  c.drawRect(_f(r, 0.25, 0.74, 0.5, 0.05), Pk.fill(Pk.dark(b, 0.15)));
}

// ---------------------------------------------------------------- Pirate ship
void _paintParrot(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawRect(_f(r, 0.47, 0.56, 0.06, 0.42), Pk.fill(_darkWood));
  Pk.box(c, _f(r, 0.3, 0.94, 0.4, 0.06), _darkWood, radius: 2);
  c.drawLine(_o(r, 0.14, 0.56), _o(r, 0.86, 0.56), Pk.stroke(_wood, 3));
  final bob = sin(t * 2.5 + r.left) * 1.2;
  c.save();
  c.translate(0, bob);
  Pk.poly(c, [_o(r, 0.42, 0.5), _o(r, 0.3, 0.78), _o(r, 0.38, 0.8), _o(r, 0.5, 0.52)], Pk.fill(b));
  c.drawOval(_f(r, 0.32, 0.18, 0.3, 0.38), Pk.fill(a));
  c.drawCircle(_o(r, 0.54, 0.18), r.width * 0.14, Pk.fill(a));
  c.drawOval(_f(r, 0.34, 0.28, 0.2, 0.28), Pk.fill(b));
  c.drawOval(_f(r, 0.36, 0.28, 0.16, 0.1), Pk.fill(_gold));
  c.drawPath(
    Path()
      ..moveTo(r.left + r.width * 0.62, r.top + r.height * 0.14)
      ..quadraticBezierTo(r.left + r.width * 0.78, r.top + r.height * 0.15, r.left + r.width * 0.72, r.top + r.height * 0.27)
      ..lineTo(r.left + r.width * 0.62, r.top + r.height * 0.22)
      ..close(),
    Pk.fill(_cream),
  );
  c.drawCircle(_o(r, 0.56, 0.15), r.width * 0.05, Pk.fill(_white));
  c.drawCircle(_o(r, 0.57, 0.15), r.width * 0.025, Pk.fill(_ebony));
  c.restore();
}

void _paintChest(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.poly(c, [_o(r, 0.04, 0.04), _o(r, 0.96, 0.04), _o(r, 0.98, 0.42), _o(r, 0.02, 0.42)], Pk.fill(Pk.dark(a, 0.25)));
  for (final x in [0.12, 0.82]) {
    c.drawRect(_f(r, x, 0.04, 0.06, 0.38), Pk.fill(Pk.dark(b, 0.15)));
  }
  Pk.glow(c, _o(r, 0.5, 0.42), r.width * 0.55, _gold, 0.45 + 0.1 * sin(t * 2 + r.left));
  for (var i = 0; i < 9; i++) {
    c.drawOval(Rect.fromCenter(center: _o(r, 0.12 + i * 0.095, 0.42 - (i % 3) * 0.04), width: r.width * 0.14, height: r.height * 0.1), Pk.fill(i.isEven ? _gold : Pk.dark(_gold, 0.1)));
  }
  Pk.box(c, _f(r, 0.0, 0.42, 1.0, 0.58), a, radius: 3);
  for (final x in [0.1, 0.84]) {
    c.drawRect(_f(r, x, 0.42, 0.06, 0.58), Pk.fill(b));
  }
  c.drawRect(_f(r, 0.0, 0.5, 1.0, 0.05), Pk.fill(Pk.dark(a, 0.25)));
  Pk.box(c, _f(r, 0.42, 0.5, 0.16, 0.2), b, radius: 2);
  c.drawCircle(_o(r, 0.5, 0.58), 1.6, Pk.fill(_ebony));
  final tw = 0.5 + 0.5 * sin(t * 3 + r.left);
  Pk.sparkle(c, _o(r, 0.3, 0.3), 2.5 + 2 * tw, _white);
}

void _paintMast(Canvas c, Rect r, Color a, Color b, double t) {
  final rig = Pk.stroke(_ink.withValues(alpha: 0.6), 0.8);
  for (final x in [-0.1, 1.1]) {
    c.drawLine(_o(r, 0.5, 0.04), _o(r, x, 1.0), rig);
  }
  Pk.box(c, _f(r, 0.47, 0.0, 0.06, 1.0), _darkWood, radius: 1);
  for (final y in [0.14, 0.5]) {
    c.drawLine(_o(r, 0.08, y), _o(r, 0.92, y), Pk.stroke(_darkWood, 2.5));
  }
  final billow = sin(t * 1.2) * 0.02;
  for (final (y0, y1, inset) in [(0.14, 0.46, 0.12), (0.5, 0.88, 0.06)]) {
    final s = Path()
      ..moveTo(r.left + r.width * inset, r.top + r.height * y0)
      ..lineTo(r.right - r.width * inset, r.top + r.height * y0)
      ..quadraticBezierTo(r.right - r.width * (inset - 0.08 - billow), r.top + r.height * (y0 + y1) / 2, r.right - r.width * (inset + 0.02), r.top + r.height * y1)
      ..lineTo(r.left + r.width * (inset + 0.02), r.top + r.height * y1)
      ..quadraticBezierTo(r.left + r.width * (inset - 0.08 - billow), r.top + r.height * (y0 + y1) / 2, r.left + r.width * inset, r.top + r.height * y0)
      ..close();
    c.drawPath(s, Pk.fill(a));
    c.drawLine(_o(r, 0.5, y0), _o(r, 0.5, y1), Pk.stroke(Pk.dark(a, 0.12), 1));
    c.drawLine(_o(r, inset + 0.06, (y0 + y1) / 2), _o(r, 1 - inset - 0.06, (y0 + y1) / 2), Pk.stroke(Pk.dark(a, 0.08), 1));
  }
  Pk.box(c, _f(r, 0.4, 0.06, 0.2, 0.05), _darkWood, radius: 1);
  final wave = sin(t * 3) * 0.02;
  final flag = [_o(r, 0.53, 0.0), _o(r, 0.78, 0.01 + wave), _o(r, 0.78, 0.09 + wave), _o(r, 0.53, 0.08)];
  Pk.poly(c, flag, Pk.fill(b));
  c.drawCircle(_o(r, 0.655, 0.04), r.width * 0.025, Pk.fill(_white));
}

void _paintWheel(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, _f(r, 0.38, 0.6, 0.24, 0.4), Pk.dark(a, 0.15), radius: 2);
  final cc = _o(r, 0.5, 0.4);
  final rad = min(r.width, r.height) * 0.3;
  final rot = sin(t * 0.5) * 0.4;
  for (var i = 0; i < 8; i++) {
    final ang = rot + i * pi / 4;
    final d = Offset(cos(ang), sin(ang));
    c.drawLine(cc, cc + d * rad * 1.3, Pk.stroke(a, 2.4));
    c.drawCircle(cc + d * rad * 1.34, 2.6, Pk.fill(a));
  }
  c.drawCircle(cc, rad, Pk.stroke(a, rad * 0.22));
  c.drawCircle(cc, rad * 0.86, Pk.stroke(b, 1.2));
  c.drawCircle(cc, rad * 0.24, Pk.fill(b));
}

void _paintCannon(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, _f(r, 0.12, 0.5, 0.56, 0.3), _darkWood, radius: 2);
  c.save();
  c.translate(r.left + r.width * 0.3, r.top + r.height * 0.48);
  c.rotate(-0.16);
  final len = r.width * 0.66, th = r.height * 0.28;
  c.drawRRect(_rr(Rect.fromLTWH(-len * 0.1, -th / 2, len, th), th * 0.4), Pk.fill(a));
  c.drawRect(Rect.fromLTWH(len * 0.82, -th * 0.6, len * 0.08, th * 1.2), Pk.fill(Pk.light(a, 0.15)));
  c.drawRect(Rect.fromLTWH(len * 0.25, -th / 2, len * 0.05, th), Pk.fill(b));
  c.drawCircle(Offset(-len * 0.14, 0), th * 0.25, Pk.fill(a));
  c.restore();
  for (final x in [0.22, 0.58]) {
    c.drawCircle(_o(r, x, 0.84), r.height * 0.15, Pk.fill(_bark));
    c.drawCircle(_o(r, x, 0.84), r.height * 0.05, Pk.fill(b));
  }
  for (final (x, y) in [(0.8, 0.92), (0.9, 0.92), (0.85, 0.82)]) {
    c.drawCircle(_o(r, x, y), r.height * 0.07, Pk.fill(_iron));
  }
}

void _paintRopeCoil(Canvas c, Rect r, Color a, Color b, double t) {
  for (var i = 0; i < 4; i++) {
    final rr = _f(r, 0.02 + i * 0.08, 0.3 + i * 0.05, 0.96 - i * 0.16, 0.66 - i * 0.12);
    c.drawOval(rr, Pk.stroke(i.isEven ? a : Pk.dark(a, 0.15), r.height * 0.14));
  }
  c.drawPath(
    Path()
      ..moveTo(r.left + r.width * 0.9, r.top + r.height * 0.6)
      ..quadraticBezierTo(r.right + r.width * 0.05, r.top + r.height * 0.2, r.left + r.width * 0.7, r.top),
    Pk.stroke(a, r.height * 0.12),
  );
}

void _paintMap(Canvas c, Rect r, Color a, Color b, double t) {
  final edge = Path()
    ..moveTo(r.left + 2, r.top)
    ..lineTo(r.right - 4, r.top + 2)
    ..lineTo(r.right, r.bottom - 3)
    ..lineTo(r.left + 4, r.bottom)
    ..close();
  c.drawPath(edge, Pk.fill(a));
  c.drawPath(edge, Pk.stroke(Pk.dark(a, 0.3), 1.5));
  c.drawOval(_f(r, 0.12, 0.22, 0.3, 0.28), Pk.fill(_olive.withValues(alpha: 0.6)));
  c.drawOval(_f(r, 0.56, 0.5, 0.3, 0.32), Pk.fill(_olive.withValues(alpha: 0.6)));
  for (var i = 0; i < 7; i++) {
    final k = i / 7;
    c.drawCircle(Offset.lerp(_o(r, 0.28, 0.36), _o(r, 0.7, 0.66), k)! + Offset(0, sin(k * pi * 2) * 4), 1, Pk.fill(Pk.dark(a, 0.5)));
  }
  final x = _o(r, 0.72, 0.66);
  c.drawLine(x - const Offset(4, 4), x + const Offset(4, 4), Pk.stroke(b, 2.2));
  c.drawLine(x + const Offset(-4, 4), x + const Offset(4, -4), Pk.stroke(b, 2.2));
  final cr = _o(r, 0.84, 0.22);
  _star(c, cr, min(r.width, r.height) * 0.1, Pk.dark(a, 0.4));
  for (final p in [_o(r, 0.05, 0.06), _o(r, 0.95, 0.08)]) {
    c.drawCircle(p, 2, Pk.fill(_red));
  }
}

void _paintGlobe(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, _f(r, 0.24, 0.88, 0.52, 0.12), _darkWood, radius: 2);
  c.drawRect(_f(r, 0.46, 0.72, 0.08, 0.18), Pk.fill(_darkWood));
  final cc = _o(r, 0.5, 0.4);
  final rad = min(r.width, r.height) * 0.34;
  c.drawCircle(cc, rad, Pk.fill(a));
  c.save();
  c.clipPath(Path()..addOval(Rect.fromCircle(center: cc, radius: rad)));
  final drift = (t * 4) % (rad * 2);
  for (final (x, y, w, h) in [(-0.6, -0.4, 0.7, 0.5), (0.3, 0.0, 0.6, 0.8), (-1.6, 0.1, 0.6, 0.6), (-0.4, 0.4, 0.4, 0.3)]) {
    c.drawOval(Rect.fromLTWH(cc.dx + rad * x + drift, cc.dy + rad * y, rad * w, rad * h), Pk.fill(_olive));
    c.drawOval(Rect.fromLTWH(cc.dx + rad * x + drift - rad * 2, cc.dy + rad * y, rad * w, rad * h), Pk.fill(_olive));
  }
  c.restore();
  c.drawArc(Rect.fromCircle(center: cc, radius: rad * 1.15), -pi * 0.85, pi * 1.7, false, Pk.stroke(b, 2.2));
  c.drawCircle(cc - Offset(rad * 0.35, rad * 0.35), rad * 0.2, Pk.fill(Colors.white.withValues(alpha: 0.35)));
}

void _paintGold(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawPath(
    Path()
      ..moveTo(r.left, r.bottom)
      ..quadraticBezierTo(r.left + r.width * 0.2, r.top + r.height * 0.3, r.center.dx, r.top + r.height * 0.25)
      ..quadraticBezierTo(r.right - r.width * 0.2, r.top + r.height * 0.3, r.right, r.bottom)
      ..close(),
    Pk.fill(Pk.dark(a, 0.12)),
  );
  for (var i = 0; i < 16; i++) {
    final x = 0.12 + Pk.rand(i + 3) * 0.76;
    final y = 0.4 + Pk.rand(i + 11) * 0.5;
    if ((x - 0.5).abs() > (y - 0.2) * 0.8) continue;
    c.drawOval(Rect.fromCenter(center: _o(r, x, y), width: r.width * 0.12, height: r.height * 0.1), Pk.fill(a));
    c.drawOval(Rect.fromCenter(center: _o(r, x, y), width: r.width * 0.12, height: r.height * 0.1), Pk.stroke(Pk.dark(a, 0.3), 0.8));
  }
  Pk.poly(c, [_o(r, 0.38, 0.28), _o(r, 0.38, 0.1), _o(r, 0.44, 0.18), _o(r, 0.5, 0.06), _o(r, 0.56, 0.18), _o(r, 0.62, 0.1), _o(r, 0.62, 0.28)], Pk.fill(a));
  c.drawCircle(_o(r, 0.5, 0.22), r.width * 0.03, Pk.fill(b));
  for (var i = 0; i < 3; i++) {
    final tw = 0.5 + 0.5 * sin(t * 3 + i * 2 + r.left);
    Pk.sparkle(c, _o(r, 0.25 + i * 0.25, 0.4 + (i % 2) * 0.2), 2 + 3 * tw, _white);
  }
}

void _paintFlag(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawLine(_o(r, 0.1, 1.0), _o(r, 0.1, 0.0), Pk.stroke(_darkWood, 2.5));
  final flag = Path()..moveTo(r.left + r.width * 0.12, r.top + r.height * 0.04);
  for (var i = 0; i <= 8; i++) {
    final k = i / 8;
    flag.lineTo(r.left + r.width * (0.12 + k * 0.86), r.top + r.height * (0.04 + sin(t * 3 + k * 4) * 0.03 * k));
  }
  for (var i = 8; i >= 0; i--) {
    final k = i / 8;
    flag.lineTo(r.left + r.width * (0.12 + k * 0.86), r.top + r.height * (0.48 + sin(t * 3 + k * 4) * 0.03 * k));
  }
  flag.close();
  c.drawPath(flag, Pk.fill(a));
  final s = _o(r, 0.55, 0.22);
  final sr = r.height * 0.09;
  c.drawLine(s + Offset(-sr * 1.6, -sr * 0.4), s + Offset(sr * 1.6, sr * 1.8), Pk.stroke(b, sr * 0.4));
  c.drawLine(s + Offset(sr * 1.6, -sr * 0.4), s + Offset(-sr * 1.6, sr * 1.8), Pk.stroke(b, sr * 0.4));
  c.drawCircle(s, sr, Pk.fill(b));
  c.drawRect(Rect.fromCenter(center: s + Offset(0, sr * 0.9), width: sr * 1.1, height: sr * 0.6), Pk.fill(b));
  for (final d in [-1.0, 1.0]) {
    c.drawCircle(s + Offset(d * sr * 0.38, -sr * 0.05), sr * 0.25, Pk.fill(a));
  }
}

void _paintPorthole(Canvas c, Rect r, Color a, Color b, double t) {
  final cc = r.center, rad = min(r.width, r.height) / 2;
  c.drawCircle(cc, rad, Pk.fill(a));
  c.save();
  c.clipPath(Path()..addOval(Rect.fromCircle(center: cc, radius: rad * 0.72)));
  Pk.gradientRect(c, Rect.fromCircle(center: cc, radius: rad), const Color(0xFF9AD8FF), const Color(0xFFDFF4FF));
  Pk.gradientRect(c, Rect.fromLTWH(cc.dx - rad, cc.dy + rad * 0.05, rad * 2, rad), b, Pk.dark(b, 0.3));
  for (var i = 0; i < 2; i++) {
    final x = (t * 8 + i * rad) % (rad * 2) + cc.dx - rad;
    c.drawLine(Offset(x, cc.dy + rad * (0.25 + i * 0.2)), Offset(x + rad * 0.4, cc.dy + rad * (0.25 + i * 0.2)), Pk.stroke(Colors.white.withValues(alpha: 0.6), 1.2));
  }
  c.restore();
  c.drawCircle(cc, rad * 0.72, Pk.stroke(Pk.dark(a, 0.25), 1.5));
  for (var i = 0; i < 8; i++) {
    final ang = i * pi / 4;
    c.drawCircle(cc + Offset(cos(ang), sin(ang)) * rad * 0.86, rad * 0.06, Pk.fill(Pk.dark(a, 0.3)));
  }
  c.drawLine(cc - Offset(rad * 0.4, rad * 0.4), cc - Offset(rad * 0.1, rad * 0.6), Pk.stroke(Colors.white.withValues(alpha: 0.6), 2));
}

void _paintXMark(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawOval(_f(r, 0.0, 0.4, 0.7, 0.6), Pk.fill(Pk.dark(_sand, 0.18)));
  c.drawOval(_f(r, 0.08, 0.5, 0.54, 0.4), Pk.fill(Pk.dark(_sand, 0.35)));
  c.drawLine(_o(r, 0.14, 0.52), _o(r, 0.56, 0.88), Pk.stroke(a, r.height * 0.1));
  c.drawLine(_o(r, 0.56, 0.52), _o(r, 0.14, 0.88), Pk.stroke(a, r.height * 0.1));
  c.drawLine(_o(r, 0.86, 0.0), _o(r, 0.78, 0.66), Pk.stroke(_wood, 2.5));
  c.drawLine(_o(r, 0.8, 0.02), _o(r, 0.92, 0.02), Pk.stroke(_wood, 2.5));
  Pk.poly(c, [_o(r, 0.7, 0.62), _o(r, 0.88, 0.66), _o(r, 0.84, 0.96), _o(r, 0.74, 0.92)], Pk.fill(b));
  c.drawOval(_f(r, 0.62, 0.86, 0.38, 0.14), Pk.fill(Pk.dark(_sand, 0.1)));
}

void _paintHammock(Canvas c, Rect r, Color a, Color b, double t) {
  final sway = sin(t * 1.0 + r.left) * r.height * 0.05;
  c.drawLine(r.topLeft, _o(r, 0.12, 0.4), Pk.stroke(_rope, 1.2));
  c.drawLine(r.topRight, _o(r, 0.88, 0.4), Pk.stroke(_rope, 1.2));
  final body = Path()
    ..moveTo(r.left + r.width * 0.1, r.top + r.height * 0.36)
    ..quadraticBezierTo(r.center.dx, r.bottom + r.height * 0.3 + sway, r.right - r.width * 0.1, r.top + r.height * 0.36)
    ..quadraticBezierTo(r.center.dx, r.top + r.height * 0.7 + sway, r.left + r.width * 0.1, r.top + r.height * 0.36)
    ..close();
  c.drawPath(body, Pk.fill(a));
  c.save();
  c.clipPath(body);
  for (var i = 0; i < 6; i += 2) {
    c.drawRect(_f(r, 0.1 + i * 0.14, 0, 0.14, 1.2), Pk.fill(b));
  }
  c.restore();
}

void _paintPlankTable(Canvas c, Rect r, Color a, Color b, double t) {
  for (final x in [0.06, 0.88]) {
    Pk.box(c, _f(r, x, 0.18, 0.06, 0.82), Pk.dark(a, 0.3), radius: 1);
  }
  Pk.box(c, _f(r, 0.18, 0.18, 0.64, 0.5), Pk.dark(a, 0.18), radius: 2);
  for (var i = 0; i < 2; i++) {
    Pk.box(c, _f(r, 0.24 + i * 0.3, 0.26, 0.22, 0.16), Pk.dark(a, 0.08), radius: 1);
    c.drawCircle(_o(r, 0.35 + i * 0.3, 0.34), 1.6, Pk.fill(b));
  }
  Pk.box(c, _f(r, 0.0, 0.0, 1.0, 0.2), a, radius: 2);
}

void _paintCandle(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.glow(c, _o(r, 0.5, 0.18), r.width * 2.5, b, 0.55 + 0.08 * sin(t * 6 + r.left));
  c.drawOval(_f(r, 0.0, 0.84, 1.0, 0.16), Pk.fill(_brass));
  Pk.box(c, _f(r, 0.3, 0.34, 0.4, 0.56), a, radius: 2);
  final f = 1 + 0.15 * sin(t * 9 + r.left);
  c.drawOval(Rect.fromCenter(center: _o(r, 0.5, 0.22), width: r.width * 0.3 * f, height: r.height * 0.22 * f), Pk.fill(b));
  c.drawOval(Rect.fromCenter(center: _o(r, 0.5, 0.25), width: r.width * 0.12, height: r.height * 0.1), Pk.fill(_white));
}

// ---------------------------------------------------------------- props
const _torii = CustomProp(_paintTorii);
const _toro = CustomProp(_paintToro);
const _bambooClump = CustomProp(_paintBamboo);
const _cherry = CustomProp(_paintCherry);
const _basin = CustomProp(_paintBasin);
const _koi = CustomProp(_paintKoi);
const _lotusPads = CustomProp(_paintLotus);
const _chochin = CustomProp(_paintChochin, wall: true, emissive: true);
const _teaSet = CustomProp(_paintTeaSet);
const _cushion = CustomProp(_paintCushion);
const _bonsai = CustomProp(_paintBonsai);
const _shoji = CustomProp(_paintShoji, wall: true);
const _kettle = CustomProp(_paintKettle);
const _scroll = CustomProp(_paintScroll, wall: true);
const _shrine = CustomProp(_paintShrine);
const _chime = CustomProp(_paintChime, wall: true);
const _bridge = CustomProp(_paintBridge);
const _stones = CustomProp(_paintStones);
const _rocks = CustomProp(_paintRocks);
const _waterfall = CustomProp(_paintWaterfall);
const _stream = CustomProp(_paintStream);
const _bambooFence = CustomProp(_paintBambooFence);
const _lowTable = CustomProp(_paintLowTable);
const _andon = CustomProp(_paintAndon, emissive: true);
const _tent = CustomProp(_paintTent);
const _campfire = CustomProp(_paintCampfire, emissive: true);
const _log = CustomProp(_paintLog);
const _pineTree = CustomProp(_paintPine);
const _treehouse = CustomProp(_paintTreehouse);
const _ropeLadder = CustomProp(_paintRopeLadder);
const _tireSwing = CustomProp(_paintSwing);
const _ropeBridge = CustomProp(_paintRopeBridge, wall: true);
const _canoe = CustomProp(_paintCanoe);
const _campArch = CustomProp(_paintCampArch);
const _signpost = CustomProp(_paintSignpost);
const _logFence = CustomProp(_paintLogFence);
const _woodpile = CustomProp(_paintWoodpile);
const _backpack = CustomProp(_paintBackpack);
const _campLantern = CustomProp(_paintCampLantern, emissive: true);
const _mooringPost = CustomProp(_paintMooringPost);
const _fishingRod = CustomProp(_paintFishingRod);
const _fishBucket = CustomProp(_paintFishBucket);
const _reeds = CustomProp(_paintReeds);
const _rowboat = CustomProp(_paintRowboat);
const _bunk = CustomProp(_paintBunk);
const _bigTop = CustomProp(_paintBigTop);
const _marquee = CustomProp(_paintMarquee);
const _booth = CustomProp(_paintBooth);
const _iceCart = CustomProp(_paintIceCart);
const _pedestal = CustomProp(_paintPedestal);
const _trapeze = CustomProp(_paintTrapeze, wall: true);
const _net = CustomProp(_paintNet);
const _drum = CustomProp(_paintDrum);
const _pole = CustomProp(_paintPole);
const _elephant = CustomProp(_paintElephant);
const _seal = CustomProp(_paintSeal);
const _vanity = CustomProp(_paintVanity, wall: true);
const _clownFace = CustomProp(_paintClownFace, wall: true);
const _makeup = CustomProp(_paintMakeup);
const _toyBox = CustomProp(_paintToyBox);
const _balloons = CustomProp(_paintBalloons);
const _rack = CustomProp(_paintRack);
const _wagon = CustomProp(_paintWagon);
const _cageWagon = CustomProp(_paintCageWagon);
const _balanceBall = CustomProp(_paintBalanceBall);
const _searchlight = CustomProp(_paintSearchlight, emissive: true);
const _bunting = CustomProp(_paintBunting, wall: true);
const _bedouinTent = CustomProp(_paintBedouinTent);
const _camel = CustomProp(_paintCamel);
const _jar = CustomProp(_paintJar);
const _spiceStall = CustomProp(_paintSpiceStall);
const _sacks = CustomProp(_paintSacks);
const _hangingRug = CustomProp(_paintRug, wall: true);
const _arabLamp = CustomProp(_paintArabLamp, wall: true, emissive: true);
const _jewels = CustomProp(_paintJewels);
const _arch = CustomProp(_paintArch, wall: true);
const _cushions = CustomProp(_paintCushions);
const _dallah = CustomProp(_paintDallah);
const _canopy = CustomProp(_paintCanopy);
const _pottedPalm = CustomProp(_paintPottedPalm);
const _parrot = CustomProp(_paintParrot);
const _chest = CustomProp(_paintChest);
const _mast = CustomProp(_paintMast);
const _wheel = CustomProp(_paintWheel);
const _cannon = CustomProp(_paintCannon);
const _ropeCoil = CustomProp(_paintRopeCoil);
const _wallMap = CustomProp(_paintMap, wall: true);
const _globe = CustomProp(_paintGlobe);
const _goldPile = CustomProp(_paintGold);
const _jollyFlag = CustomProp(_paintFlag);
const _porthole = CustomProp(_paintPorthole, wall: true);
const _xMark = CustomProp(_paintXMark);
const _hammock = CustomProp(_paintHammock, wall: true);
const _plankTable = CustomProp(_paintPlankTable);
const _candle = CustomProp(_paintCandle, emissive: true);

// ---------------------------------------------------------------- scenery
Color _m(int n, int r, double ov) => Pk.mix(Color(n), Color(r), ov);

void _gardenWall(Canvas c, double ov, double top, double bottom) {
  final plaster = _m(0xFFBDB5A6, 0xFFFFF8EC, ov);
  final roof = _m(0xFF6E6A70, 0xFF3E4A5A, ov);
  c.drawRect(Rect.fromLTWH(0, top + 8, 400, bottom - top - 8), Pk.fill(plaster));
  for (var i = 0; i < 3; i++) {
    c.drawLine(Offset(0, top + 20 + i * 5.0), Offset(400, top + 20 + i * 5.0), Pk.stroke(Pk.dark(plaster, 0.07), 1));
  }
  c.drawRect(Rect.fromLTWH(0, bottom - 9, 400, 9), Pk.fill(_m(0xFF8A847A, 0xFF7A7468, ov)));
  for (var x = 0.0; x < 400; x += 22) {
    c.drawLine(Offset(x, bottom - 9), Offset(x, bottom), Pk.stroke(Pk.dark(plaster, 0.35), 1));
  }
  Pk.poly(c, [Offset(-10, top + 10), Offset(410, top + 10), Offset(400, top), Offset(0, top)], Pk.fill(roof));
  for (var x = 0.0; x < 400; x += 7) {
    c.drawLine(Offset(x, top + 1), Offset(x - 1, top + 10), Pk.stroke(Pk.light(roof, 0.18), 1));
  }
  c.drawRect(Rect.fromLTWH(-2, top - 3, 404, 4), Pk.fill(Pk.dark(roof, 0.25)));
}

void _gravel(Canvas c, double ov, double top) {
  final line = Pk.stroke(Colors.white.withValues(alpha: 0.2 + 0.3 * ov), 1);
  for (var i = 0; i < 8; i++) {
    final y = top + 8 + i * 11.5;
    final p = Path()..moveTo(0, y);
    for (var x = 0.0; x < 400; x += 25) {
      p.quadraticBezierTo(x + 12.5, y + (i.isEven ? 2.5 : -2.5), x + 25, y);
    }
    c.drawPath(p, line);
  }
}

void _sceneZenGate(Canvas c, double ov, double t) {
  _gardenWall(c, ov, 96, 146);
  _gravel(c, ov, 146);
}

void _sceneKoi(Canvas c, double ov, double t) {
  for (var i = 0; i < 8; i++) {
    final col = i.isEven ? _m(0xFF8A9A7A, 0xFF4E9A4A, ov) : _m(0xFF7E8E70, 0xFF3E8A46, ov);
    Pk.bushy(c, Rect.fromLTWH(i * 56.0 - 24, 82, 84, 50), col);
  }
  final bam = _m(0xFFB5AE8A, 0xFFD8C27A, ov);
  for (var x = 0.0; x < 400; x += 6) {
    c.drawRect(Rect.fromLTWH(x, 108, 4.5, 24), Pk.fill(x % 12 == 0 ? bam : Pk.dark(bam, 0.08)));
  }
  for (final y in [113.0, 124.0]) {
    c.drawRect(Rect.fromLTWH(0, y, 400, 3), Pk.fill(Pk.dark(bam, 0.35)));
  }
  final moss = Pk.stroke(_m(0xFF8A8A6A, 0xFF6EAA5A, ov).withValues(alpha: 0.5), 3);
  for (var i = 0; i < 12; i++) {
    final x = Pk.rand(i + 90) * 400, y = 150 + Pk.rand(i + 91) * 80;
    c.drawLine(Offset(x, y), Offset(x + 10, y), moss);
  }
}

void _sceneTeaRoom(Canvas c, double ov, double t) {
  final wood = _m(0xFF7A6A5A, 0xFF8B5E3C, ov);
  c.drawRect(const Rect.fromLTWH(238, 20, 96, 132), Pk.fill(Colors.black.withValues(alpha: 0.08)));
  c.drawRect(const Rect.fromLTWH(234, 146, 104, 9), Pk.fill(Pk.dark(wood, 0.05)));
  c.drawRect(const Rect.fromLTWH(234, 146, 104, 2), Pk.fill(Pk.light(wood, 0.3)));
  for (final x in [6.0, 146.0, 230.0, 334.0, 388.0]) {
    c.drawRect(Rect.fromLTWH(x, 0, 7, 166), Pk.fill(wood));
    c.drawRect(Rect.fromLTWH(x, 0, 2, 166), Pk.fill(Pk.light(wood, 0.2)));
  }
  c.drawRect(const Rect.fromLTWH(0, 14, 400, 7), Pk.fill(wood));
  c.drawRect(const Rect.fromLTWH(0, 0, 400, 5), Pk.fill(Pk.dark(wood, 0.2)));
  final edge = Pk.stroke(_m(0xFF55524A, 0xFF3A5A32, ov), 2.4);
  c.drawLine(const Offset(0, 200), const Offset(400, 200), edge);
  for (final x in [-80.0, 130.0, 270.0, 480.0]) {
    c.drawLine(Offset(200 + (x - 200) * 0.7, 172), Offset(x, 240), edge);
  }
  for (var i = 0; i < 30; i++) {
    final y = 176 + i * 2.2;
    c.drawLine(Offset(0, y), Offset(400, y), Pk.stroke(Colors.black.withValues(alpha: 0.03), 0.8));
  }
}

void _sceneBambooGrove(Canvas c, double ov, double t) {
  for (var i = 0; i < 30; i++) {
    final x = Pk.rand(i + 50) * 410 - 5;
    final w = 4 + Pk.rand(i + 60) * 5;
    final col = _m(0xFFA8B094, 0xFF8FC46A, ov).withValues(alpha: 0.35 + Pk.rand(i + 70) * 0.45);
    c.drawRect(Rect.fromLTWH(x, 0, w, 150), Pk.fill(col));
    for (var y = 20.0 + Pk.rand(i) * 20; y < 150; y += 28) {
      c.drawLine(Offset(x, y), Offset(x + w, y), Pk.stroke(Colors.black.withValues(alpha: 0.12), 1));
    }
  }
  Pk.gradientRect(c, const Rect.fromLTWH(0, 90, 400, 60), Colors.white.withValues(alpha: 0), Colors.white.withValues(alpha: 0.25));
  final pole = _m(0xFF9A9A7A, 0xFF7CB342, ov);
  c.drawRRect(_rr(const Rect.fromLTWH(70, 8, 270, 5), 2.5), Pk.fill(pole));
  for (final x in [70.0, 336.0]) {
    c.drawLine(Offset(x + 2, 10), Offset(x - 26, 40), Pk.stroke(Pk.dark(pole, 0.15), 3));
  }
  Pk.poly(c, const [Offset(186, 150), Offset(214, 150), Offset(262, 240), Offset(138, 240)], Pk.fill(_m(0xFFA89E8A, 0xFFE6DCC4, ov)));
}

void _sceneBridgeValley(Canvas c, double ov, double t) {
  final m = _m(0xFFA8AEB8, 0xFF8FB0DA, ov);
  Pk.poly(c, const [Offset(110, 110), Offset(200, 40), Offset(290, 110)], Pk.fill(m));
  Pk.poly(c, const [Offset(176, 59), Offset(200, 40), Offset(224, 59), Offset(214, 66), Offset(206, 58), Offset(198, 66), Offset(188, 58)], Pk.fill(Colors.white));
  for (var i = 0; i < 9; i++) {
    Pk.bushy(c, Rect.fromLTWH(i * 48.0 - 20, 96, 70, 36), i.isEven ? _m(0xFF8A9A7A, 0xFF5AA850, ov) : _m(0xFF7E8E70, 0xFF4A9A48, ov));
  }
  c.drawRect(const Rect.fromLTWH(0, 128, 400, 8), Pk.fill(_m(0xFF9A9078, 0xFFB8A888, ov)));
}

void _forestLine(Canvas c, double ov, double h, {bool night = false}) {
  final far = Pk.mix(const Color(0xFF9AA49A), night ? const Color(0xFF3A4A6A) : const Color(0xFF7FA6C0), ov);
  Pk.poly(c, [Offset(-30, h), Offset(80, h - 74), Offset(190, h)], Pk.fill(far));
  Pk.poly(c, [Offset(150, h), Offset(285, h - 90), Offset(430, h)], Pk.fill(Pk.dark(far, 0.07)));
  Pk.poly(c, [Offset(64, h - 56), Offset(80, h - 74), Offset(96, h - 56), Offset(86, h - 60), Offset(80, h - 54), Offset(72, h - 60)], Pk.fill(Colors.white.withValues(alpha: 0.9)));
  Pk.poly(c, [Offset(266, h - 70), Offset(285, h - 90), Offset(304, h - 70), Offset(292, h - 74), Offset(285, h - 66), Offset(278, h - 74)], Pk.fill(Colors.white.withValues(alpha: 0.9)));
  final pine = Pk.mix(const Color(0xFF7A8A72), night ? const Color(0xFF1E3A34) : const Color(0xFF2E6E46), ov);
  for (var i = 0; i < 24; i++) {
    final x = i * 18.0 - 8 + Pk.rand(i) * 8;
    final ht = 22 + Pk.rand(i + 30) * 26;
    Pk.poly(c, [Offset(x, h + 3), Offset(x + 8, h - ht), Offset(x + 16, h + 3)], Pk.fill(i.isEven ? pine : Pk.dark(pine, 0.12)));
  }
}

void _sceneCampGate(Canvas c, double ov, double t) {
  _forestLine(c, ov, 142);
  Pk.poly(c, const [Offset(176, 142), Offset(224, 142), Offset(290, 240), Offset(110, 240)], Pk.fill(_m(0xFF9A8A6E, 0xFFC9A46E, ov)));
  for (var i = 0; i < 6; i++) {
    c.drawOval(Rect.fromCenter(center: Offset(170 + Pk.rand(i + 5) * 60, 160 + i * 14.0), width: 8, height: 4), Pk.fill(Colors.black.withValues(alpha: 0.12)));
  }
}

void _sceneCampNight(Canvas c, double ov, double t) {
  _forestLine(c, ov, 140, night: true);
  c.drawOval(const Rect.fromLTWH(60, 150, 280, 80), Pk.fill(_m(0xFF6E6A5A, 0xFF7A8A4A, ov).withValues(alpha: 0.5)));
  for (var i = 0; i < 6; i++) {
    final k = (t * 0.3 + i / 6) % 1;
    final p = Offset(40 + Pk.rand(i + 40) * 320, 60 + Pk.rand(i + 41) * 90 - k * 10);
    c.drawCircle(p, 1.4, Pk.fill(const Color(0xFFDFFF8A).withValues(alpha: ov * (0.4 + 0.6 * sin(t * 3 + i).abs()))));
  }
}

void _sceneTreehouse(Canvas c, double ov, double t) {
  _forestLine(c, ov, 150);
  final leaf = _m(0xFF8A9A7A, 0xFF4E9A44, ov);
  c.drawLine(const Offset(250, 66), const Offset(336, 50), Pk.stroke(_bark, 7));
  c.drawLine(const Offset(150, 70), const Offset(80, 60), Pk.stroke(_bark, 6));
  for (final (x, y, r) in [(200.0, 40.0, 70.0), (120.0, 52.0, 46.0), (285.0, 48.0, 50.0), (340.0, 40.0, 30.0), (70.0, 46.0, 30.0)]) {
    c.drawCircle(Offset(x, y), r, Pk.fill(Pk.dark(leaf, 0.12)));
  }
  for (final (x, y, r) in [(190.0, 26.0, 50.0), (120.0, 40.0, 30.0), (280.0, 34.0, 34.0), (238.0, 10.0, 34.0)]) {
    c.drawCircle(Offset(x, y), r, Pk.fill(leaf));
  }
}

void _sceneLake(Canvas c, double ov, double t) {
  _forestLine(c, ov, 100);
  Pk.gradientRect(c, const Rect.fromLTWH(0, 100, 400, 140), _m(0xFF8AA4AE, 0xFF5FBCE0, ov), _m(0xFF6E8A94, 0xFF2E86C0, ov));
  for (var i = 0; i < 9; i++) {
    final y = 108 + i * 14.0;
    final x = (t * (6 + i) + i * 53) % 460 - 40;
    c.drawLine(Offset(x, y), Offset(x + 18 + i * 2, y), Pk.stroke(Colors.white.withValues(alpha: 0.35), 1.2));
  }
  final grass = _m(0xFF9A9478, 0xFF6EB04A, ov);
  Pk.poly(c, const [Offset(0, 196), Offset(50, 204), Offset(96, 240), Offset(0, 240)], Pk.fill(grass));
  Pk.poly(c, const [Offset(400, 206), Offset(350, 214), Offset(318, 240), Offset(400, 240)], Pk.fill(grass));
  final wood = _m(0xFF8C7E6C, 0xFFC98A52, ov);
  for (final (x0, x1) in [(176.0, 128.0), (224.0, 272.0)]) {
    for (var k = 0; k < 4; k++) {
      final f = k / 3;
      final x = x0 + (x1 - x0) * f;
      final y = 136 + 104 * f;
      c.drawRect(Rect.fromLTWH(x - 2 - f * 2, y - 2, 4 + f * 4, 10 + f * 10), Pk.fill(Pk.dark(wood, 0.35)));
    }
  }
  Pk.poly(c, const [Offset(178, 134), Offset(222, 134), Offset(276, 236), Offset(124, 236)], Pk.fill(wood));
  for (var i = 1; i < 14; i++) {
    final f = i / 14;
    final y = 134 + 102 * f * f * 0.4 + 102 * f * 0.6;
    final hw = 22 + 54 * (y - 134) / 102;
    c.drawLine(Offset(200 - hw, y), Offset(200 + hw, y), Pk.stroke(Pk.dark(wood, 0.25), 1));
  }
  c.drawLine(const Offset(178, 134), const Offset(124, 236), Pk.stroke(Pk.dark(wood, 0.3), 2));
  c.drawLine(const Offset(222, 134), const Offset(276, 236), Pk.stroke(Pk.dark(wood, 0.3), 2));
}

void _sceneCabin(Canvas c, double ov, double t) {
  for (var y = 6.0; y < 160; y += 14) {
    c.drawLine(Offset(0, y), Offset(400, y), Pk.stroke(Colors.black.withValues(alpha: 0.22), 1.4));
    c.drawLine(Offset(0, y + 4), Offset(400, y + 4), Pk.stroke(Colors.white.withValues(alpha: 0.16), 2));
    for (final x in [0.0, 400.0]) {
      c.drawCircle(Offset(x, y + 7), 7, Pk.fill(Colors.black.withValues(alpha: 0.12)));
    }
  }
}

void _distantTent(Canvas c, Offset base, double w, Color a, Color b) {
  Pk.poly(c, [base + Offset(-w / 2, 0), base + Offset(0, -w * 0.7), base + Offset(w / 2, 0)], Pk.fill(a));
  Pk.poly(c, [base + Offset(-w / 6, 0), base + Offset(0, -w * 0.7), base + Offset(w / 6, 0)], Pk.fill(b));
}

void _sceneCircusGrounds(Canvas c, double ov, double t) {
  final a = _m(0xFF6E6478, 0xFF8A3A6A, ov), b = _m(0xFF8A8494, 0xFFE8D0A0, ov);
  _distantTent(c, const Offset(40, 146), 60, a, b);
  _distantTent(c, const Offset(360, 146), 56, b, a);
  for (var i = 0; i < 30; i++) {
    final x = i * 14.0;
    final on = (i + (t * 4).floor()) % 4 != 0;
    c.drawCircle(Offset(x, 138 - sin(i * 0.8) * 3), 1.5, Pk.fill((on ? _lampGlow : Colors.white).withValues(alpha: 0.2 + 0.6 * ov)));
  }
}

void _tentWall(Canvas c, double ov, {double bleachers = 120}) {
  final a = _m(0xFF7A5A64, 0xFFC8364A, ov);
  for (var i = 0; i < 18; i += 2) {
    final x0 = -160 + i * 40.0, x1 = x0 + 40;
    Pk.poly(c, [Offset(200 + (x0 - 200) * 0.08, -4), Offset(200 + (x1 - 200) * 0.08, -4), Offset(x1, 172), Offset(x0, 172)], Pk.fill(a.withValues(alpha: 0.85)));
  }
  final seat = _m(0xFF4A4458, 0xFF3A2A4A, ov);
  for (var k = 0; k < 4; k++) {
    final y = bleachers + k * 12.0;
    c.drawRect(Rect.fromLTWH(0, y, 400, 12), Pk.fill(k.isEven ? seat : Pk.light(seat, 0.08)));
    c.drawRect(Rect.fromLTWH(0, y, 400, 1.5), Pk.fill(_m(0xFF8A847A, 0xFFFFC93C, ov).withValues(alpha: 0.6)));
    for (var x = 4.0 + (k % 2) * 5; x < 400; x += 10) {
      final hue = Pk.rand(x.toInt() + k * 97) * 360;
      c.drawCircle(Offset(x, y + 6), 3, Pk.fill(Pk.hue(hue, 0.45, 0.85).withValues(alpha: 0.25 + 0.5 * ov)));
    }
  }
}

void _sceneRing(Canvas c, double ov, double t) {
  _tentWall(c, ov);
  final curb = _m(0xFF8A6A6A, 0xFFD8323F, ov);
  c.drawOval(const Rect.fromLTWH(40, 180, 320, 58), Pk.fill(Pk.dark(curb, 0.3)));
  c.drawOval(const Rect.fromLTWH(40, 176, 320, 56), Pk.fill(curb));
  c.drawOval(const Rect.fromLTWH(52, 181, 296, 44), Pk.fill(_m(0xFFB8A888, 0xFFF2D49A, ov)));
  c.drawOval(const Rect.fromLTWH(40, 176, 320, 56), Pk.stroke(_m(0xFF9A9070, 0xFFFFC93C, ov), 2));
  _star(c, const Offset(200, 204), 14, _m(0xFFA89878, 0xFFFFE08A, ov));
}

void _sceneTrapeze(Canvas c, double ov, double t) {
  _tentWall(c, ov, bleachers: 124);
  for (final x in [20.0, 100.0, 300.0, 380.0]) {
    c.drawLine(Offset(x, 0), const Offset(200, -20), Pk.stroke(_rope.withValues(alpha: 0.6), 1));
  }
  c.drawLine(const Offset(70, 30), const Offset(330, 30), Pk.stroke(_m(0xFF8A847A, 0xFFC9A36B, ov), 1.5));
}

void _scenePolka(Canvas c, double ov, double t) {
  final dot = Colors.white.withValues(alpha: 0.18 + 0.2 * ov);
  for (var y = 10.0; y < 160; y += 20) {
    for (var x = (y ~/ 20).isEven ? 10.0 : 20.0; x < 400; x += 20) {
      c.drawCircle(Offset(x, y), 3.5, Pk.fill(dot));
    }
  }
  c.drawRect(const Rect.fromLTWH(0, 130, 400, 4), Pk.fill(_m(0xFF9A8A9A, 0xFFFFC93C, ov)));
}

void _sceneCaravanField(Canvas c, double ov, double t) {
  final a = _m(0xFF8A7A84, 0xFFD8323F, ov), b = _m(0xFFB0A8A0, 0xFFFFF0DA, ov);
  final base = const Offset(200, 128);
  Pk.poly(c, [base + const Offset(-70, 0), base + const Offset(-40, -36), base + const Offset(0, -52), base + const Offset(40, -36), base + const Offset(70, 0)], Pk.fill(a));
  for (var i = -2; i <= 2; i += 2) {
    Pk.poly(c, [base + Offset(i * 14.0 - 7, 0), base + const Offset(0, -52), base + Offset(i * 14.0 + 7, 0)], Pk.fill(b));
  }
  c.drawLine(base + const Offset(0, -52), base + const Offset(0, -64), Pk.stroke(_ink, 1.2));
  Pk.poly(c, [base + const Offset(0, -64), base + const Offset(10, -61), base + const Offset(0, -58)], Pk.fill(_gold));
  Pk.poly(c, const [Offset(170, 140), Offset(230, 140), Offset(300, 240), Offset(100, 240)], Pk.fill(_m(0xFF9A8A6E, 0xFFD8B47A, ov).withValues(alpha: 0.8)));
}

void _dunes(Canvas c, double ov, double h) {
  final s1 = _m(0xFFC9B896, 0xFFF0C27A, ov), s2 = _m(0xFFBDAA86, 0xFFE8A85A, ov);
  c.drawPath(
    Path()
      ..moveTo(0, h + 4)
      ..lineTo(0, h - 40)
      ..quadraticBezierTo(70, h - 70, 150, h - 38)
      ..quadraticBezierTo(230, h - 10, 290, h - 46)
      ..quadraticBezierTo(350, h - 72, 400, h - 44)
      ..lineTo(400, h + 4)
      ..close(),
    Pk.fill(s1),
  );
  c.drawPath(
    Path()
      ..moveTo(0, h + 4)
      ..lineTo(0, h - 16)
      ..quadraticBezierTo(110, h - 40, 200, h - 14)
      ..quadraticBezierTo(300, h + 4, 400, h - 22)
      ..lineTo(400, h + 4)
      ..close(),
    Pk.fill(s2),
  );
}

void _sceneDesertCamp(Canvas c, double ov, double t) => _dunes(c, ov, 140);

void _sceneSpring(Canvas c, double ov, double t) {
  _dunes(c, ov, 132);
  c.drawOval(const Rect.fromLTWH(40, 140, 320, 96), Pk.fill(_m(0xFFB0A880, 0xFF8ACB5A, ov).withValues(alpha: 0.75)));
}

void _sceneBazaar(Canvas c, double ov, double t) {
  final dome = _m(0xFF9A948A, 0xFF2E8A9A, ov);
  for (final (x, r) in [(70.0, 26.0), (330.0, 30.0), (200.0, 20.0)]) {
    c.drawCircle(Offset(x, 34), r, Pk.fill(dome));
    c.drawLine(Offset(x, 34 - r), Offset(x, 34 - r - 10), Pk.stroke(_m(0xFF8A847A, 0xFFFFC93C, ov), 2));
  }
  final wall = _m(0xFFB5A99A, 0xFFF2DCB4, ov);
  c.drawRect(const Rect.fromLTWH(0, 30, 400, 120), Pk.fill(wall));
  c.drawRect(const Rect.fromLTWH(0, 26, 400, 6), Pk.fill(Pk.dark(wall, 0.15)));
  for (final x in [14.0, 160.0, 306.0]) {
    final r = Rect.fromLTWH(x, 44, 80, 106);
    c.drawPath(_ogee(r), Pk.fill(Pk.dark(wall, 0.45)));
    c.save();
    c.clipPath(_ogee(r));
    Pk.glow(c, Offset(x + 40, 120), 50, _flame, 0.15 + 0.25 * ov);
    c.restore();
    c.drawPath(_ogee(r), Pk.stroke(Pk.dark(wall, 0.2), 3));
  }
  for (var x = 0.0; x < 400; x += 12) {
    c.drawLine(Offset(x, 150), Offset(x + 6, 150), Pk.stroke(Pk.dark(wall, 0.2), 2));
  }
}

void _scenePalace(Canvas c, double ov, double t) {
  final tile = _m(0xFF8A9AA0, 0xFF2E7AB0, ov), tile2 = _m(0xFFB0B8B8, 0xFFFFFFFF, ov);
  c.drawRect(const Rect.fromLTWH(0, 136, 400, 29), Pk.fill(tile));
  for (var x = 0.0; x < 400; x += 14) {
    final p = Offset(x + 7, 150.5);
    Pk.poly(c, [p - const Offset(0, 7), p + const Offset(7, 0), p + const Offset(0, 7), p - const Offset(7, 0)], Pk.fill(tile2.withValues(alpha: 0.75)));
    c.drawCircle(p, 2, Pk.fill(_m(0xFF9A8A6A, 0xFFFFC93C, ov)));
  }
  c.drawRect(const Rect.fromLTWH(0, 134, 400, 3), Pk.fill(_m(0xFF9A8A6A, 0xFFFFC93C, ov)));
  final col = _m(0xFFC9C0B0, 0xFFFFF8EC, ov);
  for (final x in [124.0, 262.0]) {
    Pk.box(c, Rect.fromLTWH(x, 10, 14, 126), col, radius: 2);
    c.drawRect(Rect.fromLTWH(x - 3, 8, 20, 6), Pk.fill(_m(0xFF9A8A6A, 0xFFFFC93C, ov)));
  }
  c.drawRect(const Rect.fromLTWH(0, 0, 400, 6), Pk.fill(_m(0xFF9A8A6A, 0xFFE0B040, ov)));
}

void _sceneRooftop(Canvas c, double ov, double t) {
  final sil = _m(0xFF8A8494, 0xFF8A4A7A, ov);
  for (final (x, w, h) in [(20.0, 50.0, 40.0), (90.0, 40.0, 26.0), (250.0, 60.0, 46.0), (330.0, 44.0, 30.0)]) {
    c.drawRect(Rect.fromLTWH(x, 150 - h, w, h), Pk.fill(sil));
    c.drawCircle(Offset(x + w / 2, 150 - h), w * 0.36, Pk.fill(sil));
  }
  for (final x in [160.0, 236.0]) {
    c.drawRect(Rect.fromLTWH(x, 70, 8, 80), Pk.fill(sil));
    c.drawCircle(Offset(x + 4, 70), 6, Pk.fill(sil));
  }
  final wall = _m(0xFFB8A894, 0xFFF0C8A0, ov);
  c.drawRect(const Rect.fromLTWH(0, 132, 400, 20), Pk.fill(wall));
  for (var x = 0.0; x < 400; x += 24) {
    c.drawRect(Rect.fromLTWH(x + 4, 124, 14, 10), Pk.fill(wall));
  }
  c.drawRect(const Rect.fromLTWH(0, 150, 400, 3), Pk.fill(Pk.dark(wall, 0.25)));
  final beam = _m(0xFF7A6A5A, 0xFF8B5E3C, ov);
  for (final x in [26.0, 368.0]) {
    c.drawRect(Rect.fromLTWH(x, 22, 7, 132), Pk.fill(beam));
  }
  c.drawRect(const Rect.fromLTWH(14, 20, 372, 6), Pk.fill(beam));
  for (var i = 0; i < 9; i++) {
    c.drawCircle(Offset(30 + i * 43.0, 26), 7, Pk.fill(_m(0xFF8A9A7A, 0xFF4E9A44, ov)));
  }
}

void _pirateShip(Canvas c, double ov, Offset o, double s) {
  final hull = _m(0xFF6E6260, 0xFF6B3A22, ov);
  final sail = _m(0xFFC9C0B0, 0xFFFFF4DC, ov);
  for (final (mx, mh) in [(0.3, 1.0), (0.62, 1.15)]) {
    final x = o.dx + 160 * mx * s;
    c.drawLine(Offset(x, o.dy), Offset(x, o.dy - 100 * mh * s), Pk.stroke(_darkWood, 2.5 * s));
    for (final (y0, y1, w) in [(0.9, 0.55, 28.0), (0.5, 0.18, 22.0)]) {
      c.drawPath(
        Path()
          ..moveTo(x - w * s, o.dy - 100 * mh * s * y0)
          ..quadraticBezierTo(x, o.dy - 100 * mh * s * (y0 + y1) / 2 + 8 * s, x + w * s, o.dy - 100 * mh * s * y0)
          ..lineTo(x + w * s * 0.9, o.dy - 100 * mh * s * y1)
          ..lineTo(x - w * s * 0.9, o.dy - 100 * mh * s * y1)
          ..close(),
        Pk.fill(sail),
      );
    }
    Pk.poly(c, [Offset(x, o.dy - 100 * mh * s), Offset(x + 16 * s, o.dy - 100 * mh * s + 4 * s), Offset(x, o.dy - 100 * mh * s + 8 * s)], Pk.fill(_ebony));
  }
  Pk.poly(c, [o + Offset(-10 * s, -30 * s), o + Offset(170 * s, -30 * s), o + Offset(150 * s, 6 * s), o + Offset(10 * s, 6 * s)], Pk.fill(hull));
  Pk.poly(c, [o + Offset(120 * s, -30 * s), o + Offset(176 * s, -44 * s), o + Offset(170 * s, -30 * s)], Pk.fill(hull));
  c.drawRect(Rect.fromLTWH(o.dx - 8 * s, o.dy - 24 * s, 176 * s, 4 * s), Pk.fill(_m(0xFF9A8A6A, 0xFFFFC93C, ov)));
  for (var i = 0; i < 5; i++) {
    c.drawRect(Rect.fromLTWH(o.dx + (18 + i * 26) * s, o.dy - 16 * s, 8 * s, 6 * s), Pk.fill(_ebony));
  }
}

void _sceneHarbor(Canvas c, double ov, double t) {
  _pirateShip(c, ov, Offset(196, 118 + sin(t) * 1.2), 1.15);
  final wood = Colors.black.withValues(alpha: 0.12);
  for (var i = 0; i < 9; i++) {
    final y = 128 + i * 13.0;
    c.drawLine(Offset(0, y), Offset(400, y), Pk.stroke(wood, 1));
  }
  c.drawRect(const Rect.fromLTWH(0, 120, 400, 6), Pk.fill(_m(0xFF7A6A5A, 0xFF8B5E3C, ov)));
}

void _sceneDeck(Canvas c, double ov, double t) {
  final rail = _m(0xFF6E6260, 0xFF7A4426, ov);
  c.drawRect(const Rect.fromLTWH(0, 104, 400, 42), Pk.fill(rail));
  c.drawRect(const Rect.fromLTWH(0, 100, 400, 7), Pk.fill(Pk.light(rail, 0.15)));
  for (var x = 10.0; x < 400; x += 30) {
    c.drawRect(Rect.fromLTWH(x, 107, 5, 39), Pk.fill(Pk.dark(rail, 0.2)));
  }
  for (var i = 0; i < 10; i++) {
    final x = -120 + i * 72.0;
    c.drawLine(Offset(200 + (x - 200) * 0.3, 146), Offset(x, 240), Pk.stroke(Colors.black.withValues(alpha: 0.12), 1));
  }
}

void _sceneCaptain(Canvas c, double ov, double t) {
  for (var x = 0.0; x < 400; x += 26) {
    c.drawLine(Offset(x, 0), Offset(x, 166), Pk.stroke(Colors.black.withValues(alpha: 0.12), 1.2));
  }
  c.drawRect(const Rect.fromLTWH(0, 116, 400, 5), Pk.fill(_m(0xFF7A6A5A, 0xFF7A4426, ov)));
  c.drawRect(const Rect.fromLTWH(0, 0, 400, 10), Pk.fill(_m(0xFF6E6260, 0xFF5A3420, ov)));
  for (final x in [90.0, 310.0]) {
    c.drawRect(Rect.fromLTWH(x, 0, 12, 16), Pk.fill(_m(0xFF6E6260, 0xFF5A3420, ov)));
  }
}

void _sceneHold(Canvas c, double ov, double t) {
  final rib = _m(0xFF4A4038, 0xFF5A3420, ov);
  for (final x in [30.0, 120.0, 280.0, 370.0]) {
    final d = x < 200 ? -1.0 : 1.0;
    c.drawPath(
      Path()
        ..moveTo(x, 172)
        ..quadraticBezierTo(x + d * 30, 80, x - d * 10, -4),
      Pk.stroke(rib, 9),
    );
  }
  c.drawRect(const Rect.fromLTWH(0, 0, 400, 12), Pk.fill(rib));
  Pk.poly(c, const [Offset(176, 0), Offset(224, 0), Offset(260, 172), Offset(140, 172)], Pk.fill(_lampGlow.withValues(alpha: 0.08 + 0.1 * ov)));
}

void _sceneIsland(Canvas c, double ov, double t) {
  _pirateShip(c, ov, Offset(40, 104 + sin(t) * 0.8), 0.45);
  final rock = _m(0xFF8A847A, 0xFF9A8A7A, ov);
  Pk.poly(c, const [Offset(300, 120), Offset(330, 92), Offset(352, 98), Offset(372, 120)], Pk.fill(rock));
  c.drawRect(const Rect.fromLTWH(0, 120, 400, 10), Pk.fill(_m(0xFFB0A488, 0xFFE0C48A, ov)));
  for (var i = 0; i < 8; i++) {
    final p = Offset(20 + Pk.rand(i + 8) * 360, 150 + Pk.rand(i + 9) * 80);
    c.drawCircle(p, 2, Pk.fill(i.isEven ? _m(0xFFC9BCA8, 0xFFFFB3C7, ov) : Colors.white.withValues(alpha: 0.8)));
  }
}
'''

# ---------------------------------------------------------------------------- scenes


def _out(gN, gR, horizon=146, floor='sand', **kw):
    extra = ''.join(f', {k}: {v}' for k, v in kw.items())
    return f"const Backdrop.outdoor(groundN: Color(0x{gN:08X}), groundR: Color(0x{gR:08X}), horizon: {horizon}, floor: FloorStyle.{floor}{extra})"


def _in(tN, tR, gN, gR, fN, fR, floor='planks', **kw):
    extra = ''.join(f', {k}: {v}' for k, v in kw.items())
    return (f"const Backdrop.indoor(topN: Color(0x{tN:08X}), topR: Color(0x{tR:08X}), groundN: Color(0x{gN:08X}), groundR: Color(0x{gR:08X}), "
            f"floorAltN: Color(0x{fN:08X}), floorAltR: Color(0x{fR:08X}), floor: FloorStyle.{floor}{extra})")


def P(kind, l, t, w, h, a='_white', b='_gold'):
    return (kind, l, t, w, h, a, b)


C = lambda v: f'Color(0x{v:08X})'  # noqa: E731

SCENES = {
    # ------------------------------------------------------------------ JAPANESE GARDEN
    'zen_garden_torii': dict(
        backdrop=_out(0xFFA8A296, 0xFFEDE6D4, 146, 'sand'),
        scenery='_sceneZenGate',
        props=[
            ('b3_torii', [P('@torii', 138, 40, 124, 118, '_vermilion', '_gold'), P('@stones', 168, 160, 64, 78, '_stone')]),
            ('b3_stone_lanterns', [P('@toro', 92, 118, 32, 58, '_stone', '_lampGlow'), P('@toro', 276, 118, 32, 58, '_stone', '_lampGlow')]),
            ('b3_bamboo', [P('@bambooClump', 0, 34, 62, 114, '_bamboo'), P('@bambooClump', 340, 30, 60, 118, '_bamboo')]),
            ('b3_cherry_trees', [P('@cherry', 40, 24, 100, 126, '_sakura', '_pink'), P('@cherry', 262, 20, 100, 130, '_sakura', '_pink'),
                                 P('bush', 14, 192, 70, 34, '_leaf', '_pink')]),
            ('b3_basin', [P('@basin', 314, 182, 62, 42, '_stone', '_water'), P('bush', 254, 204, 50, 26, '_moss', '_white')]),
        ],
    ),
    'zen_garden_koi': dict(
        backdrop=_out(0xFF9A9A82, 0xFF8CC46A, 132, 'sand'),
        scenery='_sceneKoi',
        props=[
            ('pond', [P('pond', 80, 150, 240, 78, '_water', C(0xFF8FE0F0)), P('@rocks', 52, 186, 44, 34, '_slate', '_moss'),
                      P('@rocks', 300, 148, 42, 28, '_slate', '_moss')]),
            ('b3_koi', [P('@koi', 110, 166, 120, 52, '_koiOrange', '_white'), P('@koi', 200, 172, 100, 50, '_white', '_koiOrange')]),
            ('b3_lotus', [P('@lotusPads', 98, 194, 62, 36, '_lotus'), P('@lotusPads', 252, 160, 56, 32, '_lotus')]),
            ('b3_lanterns', [P('@toro', 30, 92, 34, 62, '_stone', '_lampGlow'), P('@toro', 336, 88, 36, 66, '_stone', '_lampGlow')]),
            ('flowers', [P('flowerbed', 0, 206, 80, 26, '_iris', '_white'), P('flowerbed', 320, 206, 80, 26, '_iris', '_gold')]),
            ('ice', [P('@waterfall', 160, 104, 76, 58, '_slate', '_water'), P('tree', 250, 34, 80, 108, '_red', '_orange')]),
        ],
    ),
    'zen_garden_tea': dict(
        backdrop=_in(0xFFA59C8F, 0xFFF3E6CC, 0xFF9A9478, 0xFFD4D49A, 0xFF8A846A, 0xFFBCC07E, 'carpet'),
        scenery='_sceneTeaRoom',
        props=[
            ('b3_shoji', [P('@shoji', 16, 28, 62, 136, '_darkWood', '_lampGlow'), P('@shoji', 80, 28, 62, 136, '_darkWood', '_lampGlow')]),
            ('scrolls', [P('@scroll', 266, 30, 34, 82, '_teal', '_red')]),
            ('b3_bonsai', [P('@bonsai', 296, 112, 32, 34, '_pine', '_slate'), P('vase', 244, 118, 18, 28, '_cream', '_pink')]),
            ('table', [P('@lowTable', 118, 176, 164, 34, '_darkWood')]),
            ('b3_tea_set', [P('@teaSet', 160, 146, 80, 32, '_pine', '_darkWood'), P('@andon', 350, 104, 32, 64, '_darkWood', '_lampGlow')]),
            ('b3_cushions', [P('@cushion', 56, 200, 60, 26, '_red', '_gold'), P('@cushion', 284, 200, 60, 26, '_red', '_gold'),
                             P('@cushion', 168, 214, 64, 24, '_navy', '_gold')]),
            ('b3_kettle', [P('@kettle', 16, 166, 46, 54, '_iron', '_flame')]),
        ],
    ),
    'zen_garden_bamboo': dict(
        backdrop=_out(0xFF9A9A82, 0xFF9CC870, 150, 'sand'),
        scenery='_sceneBambooGrove',
        props=[
            ('b3_bamboo', [P('@bambooClump', 0, 18, 74, 140, '_bamboo'), P('@bambooClump', 326, 14, 74, 146, '_bamboo'),
                           P('@bambooClump', 244, 46, 52, 104, '_bamboo')]),
            ('b3_lanterns', [P('@toro', 112, 120, 26, 46, '_stone', '_lampGlow'), P('@toro', 262, 128, 28, 50, '_stone', '_lampGlow')]),
            ('fence', [P('@bambooFence', 60, 134, 64, 30, '_straw', '_ink'), P('@bambooFence', 296, 140, 60, 30, '_straw', '_ink')]),
            ('b3_stream', [P('@stream', 0, 194, 400, 34, '_water', '_white'), P('@stones', 166, 168, 68, 70, '_stone')]),
            ('b3_shrine', [P('@shrine', 178, 96, 44, 54, '_darkWood', '_gold'), P('@torii', 152, 82, 96, 82, '_vermilion', '_gold')]),
            ('b3_wind_chimes', [P('@chime', 108, 12, 16, 38, '_aqua', '_red'), P('@chime', 196, 12, 14, 32, '_aqua', '_gold'),
                                P('@chime', 284, 12, 16, 38, '_aqua', '_pink')]),
        ],
    ),
    'zen_garden_bridge': dict(
        backdrop=_out(0xFF9A9A82, 0xFF8CC46A, 128, 'sand'),
        scenery='_sceneBridgeValley',
        props=[
            ('b3_bridge', [P('@bridge', 112, 96, 176, 80, '_vermilion', '_darkWood')]),
            ('b3_stream', [P('@stream', 0, 132, 400, 42, '_water', '_white'), P('@rocks', 20, 170, 46, 26, '_slate', '_moss')]),
            ('b3_koi', [P('@koi', 18, 142, 92, 32, '_koiOrange', '_white'), P('@koi', 296, 142, 92, 32, '_white', '_koiOrange')]),
            ('b3_cherry_trees', [P('@cherry', 0, 14, 104, 118, '_sakura', '_pink'), P('@cherry', 296, 10, 104, 122, '_sakura', '_pink'),
                                 P('bush', 316, 206, 70, 32, '_leaf', '_pink')]),
            ('b3_lanterns', [P('@toro', 84, 166, 28, 52, '_stone', '_lampGlow'), P('@toro', 290, 168, 28, 52, '_stone', '_lampGlow')]),
            ('ice', [P('@stones', 166, 182, 68, 56, '_stone'), P('@lotusPads', 330, 152, 50, 26, '_lotus')]),
            ('chains', [P('@bambooFence', 0, 200, 70, 30, '_straw', '_ink'), P('bush', 100, 206, 56, 28, '_leaf', '_white')]),
        ],
    ),
    # ------------------------------------------------------------------ FOREST CAMP
    'forest_camp_gate': dict(
        backdrop=_out(0xFFA89C80, 0xFF8FC45E, 142, 'sand'),
        scenery='_sceneCampGate',
        props=[
            ('sign', [P('@campArch', 124, 32, 152, 128, '_wood', '_cream'), P('@signpost', 300, 150, 40, 56, '_wood', '_ink')]),
            ('fence', [P('@logFence', 0, 136, 118, 34, '_wood', '_gold'), P('@logFence', 282, 136, 118, 34, '_wood', '_gold')]),
            ('tree', [P('@pineTree', 8, 22, 64, 116, '_pine', '_darkWood'), P('@pineTree', 330, 18, 66, 122, '_pine', '_darkWood'),
                      P('@pineTree', 74, 54, 44, 86, '_green', '_darkWood')]),
            ('lamps', [P('lamppost', 98, 112, 16, 82, '_ink', '_lampGlow'), P('lamppost', 286, 112, 16, 82, '_ink', '_lampGlow')]),
            ('crates', [P('crates', 330, 182, 62, 48, '_wood', '_red'), P('@woodpile', 18, 186, 70, 42, '_wood')]),
        ],
    ),
    'forest_camp_tents': dict(
        backdrop=_out(0xFF7A7A6A, 0xFF5E8A46, 140, 'sand', topN='Color(0xFF4A5068)', topR='Color(0xFF1E2A5A)',
                      bottomN='Color(0xFF6A6A7A)', bottomR='Color(0xFF4A3A6A)', night='true'),
        scenery='_sceneCampNight',
        props=[
            ('b3_campfire', [P('@campfire', 168, 170, 64, 52, '_darkWood', '_gold')]),
            ('b3_tents', [P('@tent', 16, 94, 104, 64, '_orange', '_cream'), P('@tent', 274, 88, 112, 72, '_green', '_cream'),
                          P('@tent', 152, 104, 92, 52, '_blue', '_cream')]),
            ('b3_supplies', [P('@backpack', 120, 170, 26, 36, '_red', '_navy'), P('@log', 78, 204, 74, 22, '_wood'), P('@log', 248, 204, 74, 22, '_wood')]),
            ('lamps', [P('stringLights', 16, 30, 368, 28, '_gold', '_pink'), P('@campLantern', 64, 188, 20, 32, '_ink', '_lampGlow')]),
            ('tree', [P('@pineTree', 100, 36, 50, 104, '_pine', '_darkWood'), P('@pineTree', 236, 28, 52, 112, '_pine', '_darkWood')]),
            ('crates', [P('crates', 326, 178, 64, 50, '_wood', '_gold'), P('@woodpile', 6, 194, 58, 38, '_wood')]),
        ],
    ),
    'forest_camp_treehouse': dict(
        backdrop=_out(0xFFA89C80, 0xFF8FC45E, 150, 'sand'),
        scenery='_sceneTreehouse',
        props=[
            ('b3_treehouse', [P('@treehouse', 128, 14, 144, 146, '_wood', '_red')]),
            ('b3_ladder', [P('@ropeLadder', 188, 80, 24, 86, '_rope', '_wood'), P('@tireSwing', 312, 54, 30, 104, '_rope', '_ink')]),
            ('tree', [P('@pineTree', 6, 40, 60, 112, '_pine', '_darkWood'), P('@pineTree', 352, 50, 46, 102, '_pine', '_darkWood'),
                      P('bush', 228, 196, 70, 32, '_leaf', '_gold')]),
            ('lamps', [P('@campLantern', 108, 152, 18, 28, '_ink', '_lampGlow'), P('@campLantern', 276, 154, 18, 28, '_ink', '_lampGlow')]),
            ('crates', [P('crates', 40, 172, 62, 46, '_wood', '_gold'), P('@woodpile', 316, 182, 72, 40, '_wood')]),
            ('b3_rope_bridge', [P('@ropeBridge', 258, 64, 104, 32, '_rope', '_wood')]),
        ],
    ),
    'forest_camp_dock': dict(
        backdrop=_out(0xFF9A9478, 0xFF6EB04A, 100, 'sand'),
        scenery='_sceneLake',
        props=[
            ('b3_canoes', [P('@canoe', 282, 140, 104, 28, '_red', '_cream'), P('@canoe', 10, 128, 84, 24, '_orange', '_cream')]),
            ('boats', [P('@rowboat', 40, 168, 92, 34, '_white', '_blue')]),
            ('fishing', [P('@fishingRod', 186, 106, 52, 54, '_darkWood', '_red'), P('toolbox', 226, 196, 32, 24, '_blue', '_steel')]),
            ('b3_catch', [P('@fishBucket', 150, 186, 34, 32, '_steel', '_aqua')]),
            ('b3_dock', [P('@mooringPost', 128, 194, 16, 40, '_darkWood', '_red'), P('@mooringPost', 264, 198, 16, 40, '_darkWood', '_red')]),
            ('ice', [P('@reeds', 0, 180, 56, 50, '_olive', '_darkWood'), P('@reeds', 340, 186, 56, 46, '_olive', '_darkWood')]),
        ],
    ),
    'forest_camp_cabin': dict(
        backdrop=_in(0xFFA59C8F, 0xFFD9A066, 0xFF8D7F6E, 0xFFB9763F, 0xFF7E7060, 0xFF9A5E33, 'planks'),
        scenery='_sceneCabin',
        props=[
            ('fireplace', [P('fireplace', 152, 80, 100, 92, '_stone', '_flame'), P('@woodpile', 256, 140, 40, 32, '_wood')]),
            ('b3_bunks', [P('@bunk', 302, 66, 88, 106, '_darkWood', '_red')]),
            ('books', [P('bookshelf', 14, 72, 62, 100, '_darkWood', '_red'), P('painting', 176, 26, 52, 36, '_darkWood', '_pine')]),
            ('windows', [P('window', 92, 40, 46, 54, '_darkWood', '_white'), P('curtains', 84, 34, 62, 66, '_red', '_darkWood')]),
            ('furniture', [P('sofa', 60, 168, 100, 50, '_pine', '_cream'), P('rug', 140, 198, 150, 34, '_red', '_gold')]),
            ('crates', [P('crates', 330, 184, 62, 46, '_wood', '_gold'), P('barrel', 294, 192, 28, 38, '_darkWood', '_steel')]),
        ],
    ),
    # ------------------------------------------------------------------ CIRCUS
    'circus_entrance': dict(
        backdrop=_out(0xFF8A8478, 0xFF6E9A4A, 146, 'sand', topN='Color(0xFF5A6078)', topR='Color(0xFF2A2060)',
                      bottomN='Color(0xFF8A7A8A)', bottomR='Color(0xFFE07A6A)', night='true'),
        scenery='_sceneCircusGrounds',
        props=[
            ('b3_big_top', [P('@bigTop', 96, 8, 208, 144, '_red', '_cream')]),
            ('tickets', [P('@booth', 22, 96, 66, 82, '_navy', '_red'), P('@balloons', 92, 104, 40, 84, '_red', '_pink')]),
            ('b3_marquee', [P('@marquee', 142, 98, 116, 82, '_maroon', '_cream')]),
            ('ice_cream', [P('@iceCart', 300, 128, 62, 70, '_pink', '_white')]),
            ('spotlights', [P('@searchlight', 6, 192, 34, 32, '_steel', '_lampGlow'), P('@searchlight', 360, 194, 34, 32, '_steel', '_lampGlow')]),
            ('chains', [P('@bunting', 0, 18, 150, 40, '_red', '_cream'), P('@bunting', 250, 18, 150, 40, '_blue', '_cream')]),
        ],
    ),
    'circus_ring': dict(
        backdrop=_in(0xFFA59C8F, 0xFFFFF0DA, 0xFF9A8A6E, 0xFFD8B47A, 0xFF8A7A5E, 0xFFC09A5A, 'sand', night='true'),
        scenery='_sceneRing',
        props=[
            ('b3_acrobats', [P('@trapeze', 150, 0, 40, 70, '_steel', '_red'), P('@balanceBall', 230, 170, 36, 36, '_blue', '_gold')]),
            ('b3_pedestals', [P('@pedestal', 108, 176, 42, 34, '_red', '_gold'), P('@pedestal', 272, 178, 42, 34, '_blue', '_gold'),
                              P('@pedestal', 178, 154, 44, 32, '_purple', '_gold')]),
            ('animals', [P('@elephant', 12, 136, 86, 72, C(0xFFA8A8B8), '_red'), P('@seal', 318, 148, 54, 56, C(0xFF6E7A8A), '_red')]),
            ('spotlights', [P('spotlight', 30, 0, 50, 120, '_iron', '_lampGlow'), P('spotlight', 320, 0, 50, 120, '_iron', '_lampGlow')]),
            ('chains', [P('@pole', 92, 18, 16, 154, '_white', '_red'), P('@pole', 292, 18, 16, 154, '_white', '_blue')]),
        ],
    ),
    'circus_trapeze': dict(
        backdrop=_in(0xFFA59C8F, 0xFFFFF0DA, 0xFF9A8A6E, 0xFFD8B47A, 0xFF8A7A5E, 0xFFC09A5A, 'sand', night='true'),
        scenery='_sceneTrapeze',
        props=[
            ('b3_trapeze', [P('@trapeze', 124, 30, 44, 84, '_steel', '_red'), P('@trapeze', 232, 30, 44, 70, '_steel', '_blue')]),
            ('b3_net', [P('@net', 40, 160, 320, 52, '_white', '_steel')]),
            ('spotlights', [P('spotlight', 0, 0, 50, 150, '_iron', '_lampGlow'), P('spotlight', 350, 0, 50, 150, '_iron', '_lampGlow'),
                            P('stringLights', 90, 4, 220, 24, '_gold', '_pink')]),
            ('b3_drums', [P('@drum', 330, 192, 52, 42, '_red', '_gold'), P('@drum', 16, 194, 46, 40, '_blue', '_gold')]),
            ('b3_rigging', [P('@pole', 62, 26, 16, 146, '_white', '_red'), P('@pole', 322, 26, 16, 146, '_white', '_blue'),
                            P('@ropeLadder', 80, 40, 18, 116, '_rope', '_wood')]),
        ],
    ),
    'circus_clowns': dict(
        backdrop=_in(0xFFA59CA8, 0xFFFFC2DC, 0xFF8D877D, 0xFFFFFFFF, 0xFF6E6A62, 0xFF3A2A4A, 'checker'),
        scenery='_scenePolka',
        props=[
            ('masks', [P('@clownFace', 300, 22, 44, 46, '_white', '_orange'), P('@clownFace', 350, 44, 40, 42, '_white', '_green')]),
            ('mirror', [P('@vanity', 130, 18, 140, 82, '_purple', '_lampGlow'), P('floorLamp', 108, 112, 18, 60, '_pink', '_gold')]),
            ('b3_makeup', [P('counter', 126, 118, 148, 54, '_purple', '_cream'), P('@makeup', 150, 96, 64, 24, '_pink', '_red'),
                           P('chair', 178, 164, 44, 56, '_red', '_gold')]),
            ('b3_toys', [P('@toyBox', 296, 172, 66, 50, '_blue', '_gold'), P('@balloons', 340, 80, 52, 104, '_red', '_purple')]),
            ('chains', [P('@rack', 14, 88, 88, 88, '_steel', '_red'), P('luggage', 26, 182, 64, 44, '_orange', '_purple')]),
        ],
    ),
    'circus_caravans': dict(
        backdrop=_out(0xFF9A9478, 0xFF8CC85A, 140, 'sand'),
        scenery='_sceneCaravanField',
        props=[
            ('b3_caravans', [P('@wagon', 8, 86, 124, 86, '_red', '_gold'), P('@wagon', 270, 86, 124, 86, '_blue', '_red')]),
            ('animals', [P('@cageWagon', 144, 80, 112, 86, '_green', '_gold'), P('@elephant', 36, 150, 94, 78, C(0xFFA8A8B8), '_purple')]),
            ('hay', [P('haybale', 292, 196, 62, 30, '_straw', '_red'), P('haybale', 340, 182, 52, 26, '_straw', '_red'),
                     P('haybale', 248, 202, 46, 26, '_straw', '_red')]),
            ('b3_acrobats', [P('@balanceBall', 148, 196, 32, 32, '_red', '_gold'), P('@pedestal', 192, 188, 42, 36, '_purple', '_gold')]),
            ('chains', [P('@bunting', 0, 20, 200, 40, '_red', '_cream'), P('@bunting', 200, 20, 200, 40, '_purple', '_gold')]),
        ],
    ),
    # ------------------------------------------------------------------ DESERT OASIS
    'oasis_camp': dict(
        backdrop=_out(0xFFC9B48A, 0xFFF2D49A, 140, 'sand', topR='Color(0xFF6AC0F0)'),
        scenery='_sceneDesertCamp',
        props=[
            ('b3_canopies', [P('@bedouinTent', 124, 70, 156, 90, '_cream', '_red'), P('@canopy', 300, 108, 86, 60, '_orange', '_cream')]),
            ('palms', [P('palm', 4, 18, 74, 134, '_green', '_gold'), P('palm', 336, 12, 64, 138, '_green', '_gold')]),
            ('luggage', [P('@camel', 36, 118, 104, 84, C(0xFFD9A066), '_red'), P('luggage', 288, 178, 46, 42, '_darkWood', '_red')]),
            ('b3_campfire', [P('@campfire', 182, 178, 48, 40, '_darkWood', '_gold')]),
            ('chests', [P('@chest', 338, 184, 50, 40, '_darkWood', '_gold')]),
            ('crates', [P('crates', 108, 194, 56, 40, '_wood', '_red'), P('@jar', 242, 186, 24, 36, '_terracotta', '_cream')]),
        ],
    ),
    'oasis_spring': dict(
        backdrop=_out(0xFFC9B48A, 0xFFF2D49A, 132, 'sand', topR='Color(0xFF6AC0F0)'),
        scenery='_sceneSpring',
        props=[
            ('b3_spring_pool', [P('pond', 100, 152, 200, 66, '_aqua', C(0xFFBFF6FF)), P('@waterfall', 168, 104, 64, 54, C(0xFFD9B88A), '_aqua')]),
            ('palms', [P('palm', 8, 14, 84, 136, '_green', '_gold'), P('palm', 302, 6, 92, 144, '_green', '_gold'), P('palm', 236, 54, 56, 92, '_leaf', '_gold')]),
            ('flowers', [P('flowerbed', 0, 206, 96, 28, '_pink', '_gold'), P('flowerbed', 304, 208, 96, 26, '_red', '_gold')]),
            ('sunshades', [P('@canopy', 100, 84, 72, 56, '_red', '_cream')]),
            ('ice', [P('@reeds', 96, 150, 30, 32, '_olive', '_darkWood'), P('@reeds', 276, 156, 30, 32, '_olive', '_darkWood')]),
            ('b3_jars', [P('@jar', 54, 156, 26, 40, '_terracotta', '_cream'), P('@jar', 78, 166, 22, 34, '_terracotta', '_blue'),
                         P('@jar', 322, 176, 26, 40, '_terracotta', '_cream')]),
        ],
    ),
    'oasis_bazaar': dict(
        backdrop=_out(0xFFA8A296, 0xFFE6D2B0, 150, 'stone', topR='Color(0xFF6AC0F0)'),
        scenery='_sceneBazaar',
        props=[
            ('b3_spices', [P('@spiceStall', 14, 132, 110, 62, '_wood', '_red'), P('@sacks', 128, 164, 50, 40, C(0xFFC9A66B), '_red'),
                           P('awning', 10, 112, 118, 22, '_red', '_cream')]),
            ('lamps', [P('@arabLamp', 42, 46, 24, 40, '_brass', '_flame'), P('@arabLamp', 188, 40, 24, 42, '_brass', '_flame'),
                       P('@arabLamp', 334, 46, 24, 40, '_brass', '_flame')]),
            ('b3_jewelry', [P('@jewels', 276, 156, 76, 50, '_darkWood', '_gold')]),
            ('b3_rugs', [P('@hangingRug', 104, 50, 46, 78, '_red', '_navy'), P('@hangingRug', 250, 50, 46, 78, '_blue', '_gold')]),
            ('crates', [P('crates', 348, 168, 48, 44, '_wood', '_gold'), P('@jar', 252, 176, 24, 38, '_terracotta', '_blue')]),
            ('chests', [P('@chest', 176, 190, 52, 38, '_darkWood', '_gold')]),
        ],
    ),
    'oasis_palace': dict(
        backdrop=_in(0xFFA8A296, 0xFFFFF0DA, 0xFF8A9AA0, 0xFF5AA8D0, 0xFF9AA8A8, 0xFFF4FAFF, 'checker'),
        scenery='_scenePalace',
        props=[
            ('b3_arches', [P('@arch', 30, 26, 76, 108, '_terracotta', '_blue'), P('@arch', 162, 14, 76, 120, '_terracotta', '_blue'),
                           P('@arch', 294, 26, 76, 108, '_terracotta', '_blue')]),
            ('lamps', [P('@arabLamp', 118, 8, 26, 44, '_brass', '_flame'), P('@arabLamp', 256, 8, 26, 44, '_brass', '_flame')]),
            ('b3_jewelry', [P('@jewels', 168, 140, 64, 40, '_purple', '_gold')]),
            ('b3_cushions', [P('@cushions', 14, 168, 112, 50, '_red', '_purple'), P('@cushions', 274, 168, 112, 50, '_teal', '_red'),
                             P('rug', 118, 194, 164, 38, '_red', '_gold')]),
            ('chains', [P('vase', 136, 132, 26, 42, '_brass', '_pink'), P('vase', 238, 132, 26, 42, '_brass', '_pink')]),
            ('chests', [P('@chest', 176, 196, 48, 36, '_darkWood', '_gold')]),
        ],
    ),
    'oasis_rooftop': dict(
        backdrop=_out(0xFFB0A090, 0xFFD9A07A, 152, 'stone', topN='Color(0xFFA0A0B0)', topR='Color(0xFF6A4A9A)',
                      bottomN='Color(0xFFD8CCB8)', bottomR='Color(0xFFFFA86A)'),
        scenery='_sceneRooftop',
        props=[
            ('fountain', [P('fountain', 160, 154, 80, 54, '_aqua', '_white')]),
            ('b3_lanterns', [P('@arabLamp', 70, 26, 24, 42, '_brass', '_flame'), P('@arabLamp', 188, 26, 24, 42, '_brass', '_flame'),
                             P('@arabLamp', 306, 26, 24, 42, '_brass', '_flame')]),
            ('palms', [P('@pottedPalm', 40, 84, 54, 96, '_green', '_terracotta'), P('@pottedPalm', 306, 82, 56, 98, '_green', '_terracotta')]),
            ('b3_coffee_set', [P('@lowTable', 100, 196, 90, 26, '_darkWood'), P('@dallah', 116, 166, 56, 34, '_brass', '_gold'),
                               P('@cushions', 214, 186, 86, 40, '_purple', '_gold')]),
            ('chests', [P('@chest', 336, 192, 50, 36, '_darkWood', '_gold')]),
            ('crates', [P('crates', 14, 190, 52, 40, '_wood', '_gold')]),
        ],
    ),
    # ------------------------------------------------------------------ PIRATE SHIP
    'pirate_ship_dock': dict(
        backdrop=_out(0xFF8C7E6C, 0xFFC98A52, 122, 'sand', sea='true'),
        scenery='_sceneHarbor',
        props=[
            ('anchors', [P('anchor', 14, 140, 36, 50, '_iron', '_red'), P('@ropeCoil', 56, 200, 48, 26, '_rope')]),
            ('boats', [P('@rowboat', 20, 96, 84, 28, '_red', '_cream'), P('@rowboat', 330, 100, 66, 22, '_white', '_blue')]),
            ('cargo', [P('crates', 250, 154, 72, 58, '_wood', '_gold'), P('barrel', 326, 168, 28, 40, '_darkWood', '_steel'),
                       P('barrel', 356, 174, 28, 38, '_darkWood', '_steel')]),
            ('b3_parrots', [P('@parrot', 106, 134, 42, 66, '_red', '_blue')]),
            ('crates', [P('crates', 60, 160, 50, 40, '_wood', '_red'), P('barrel', 220, 186, 26, 36, '_darkWood', '_steel')]),
            ('b3_treasure', [P('@chest', 150, 182, 62, 46, '_darkWood', '_gold')]),
        ],
    ),
    'pirate_ship_deck': dict(
        backdrop=_out(0xFF8C7E6C, 0xFFB9824A, 146, 'sand', sea='true'),
        scenery='_sceneDeck',
        props=[
            ('b3_sails', [P('@mast', 140, 0, 120, 168, '_cream', '_ebony')]),
            ('b3_ship_wheel', [P('@wheel', 250, 118, 64, 82, '_darkWood', '_brass')]),
            ('b3_barrels', [P('barrel', 18, 162, 32, 46, '_darkWood', '_steel'), P('barrel', 50, 170, 30, 42, '_darkWood', '_steel'),
                            P('barrel', 34, 190, 30, 40, '_darkWood', '_steel')]),
            ('b3_cannons', [P('@cannon', 84, 132, 84, 46, '_iron', '_brass'), P('@cannon', 312, 136, 82, 44, '_iron', '_brass')]),
            ('crates', [P('crates', 326, 184, 64, 48, '_wood', '_gold')]),
            ('b3_ropes', [P('@ropeCoil', 120, 200, 52, 28, '_rope'), P('@ropeCoil', 210, 206, 44, 24, '_rope')]),
        ],
    ),
    'pirate_ship_cabin': dict(
        backdrop=_in(0xFF9A8C7C, 0xFFC98A52, 0xFF7D7064, 0xFF8B5E3C, 0xFF6E6254, 0xFF7A4426, 'planks'),
        scenery='_sceneCaptain',
        props=[
            ('maps', [P('@wallMap', 136, 24, 128, 74, '_parchment', '_red'), P('@plankTable', 124, 136, 152, 52, '_darkWood', '_gold')]),
            ('globes', [P('@globe', 32, 116, 54, 66, C(0xFF45A7F5), '_brass'), P('bookshelf', 330, 74, 60, 98, '_darkWood', '_red')]),
            ('b3_gold', [P('@goldPile', 290, 186, 66, 40, '_gold', '_red'), P('@candle', 236, 112, 16, 26, '_cream', '_flame')]),
            ('b3_parrots', [P('@parrot', 88, 96, 40, 76, '_red', '_blue')]),
            ('chains', [P('@porthole', 24, 30, 52, 52, '_brass', C(0xFF2E86C0)), P('@porthole', 292, 24, 46, 46, '_brass', C(0xFF2E86C0))]),
            ('b3_treasure', [P('@chest', 168, 176, 70, 52, '_darkWood', '_gold')]),
        ],
    ),
    'pirate_ship_hold': dict(
        backdrop=_in(0xFF8A7E70, 0xFF9A6A44, 0xFF6E6254, 0xFF7A5232, 0xFF5E5446, 0xFF6A4428, 'planks', night='true'),
        scenery='_sceneHold',
        props=[
            ('cargo', [P('crates', 14, 104, 92, 72, '_wood', '_gold'), P('crates', 300, 116, 84, 60, '_wood', '_red')]),
            ('chests', [P('@chest', 146, 158, 64, 48, '_darkWood', '_gold'), P('@chest', 300, 184, 56, 42, '_maroon', '_gold')]),
            ('b3_gold', [P('@goldPile', 214, 176, 70, 44, '_gold', '_red')]),
            ('b3_ropes', [P('@ropeCoil', 96, 202, 52, 26, '_rope'), P('@hammock', 140, 24, 124, 46, '_canvas', '_red')]),
            ('crates', [P('barrel', 114, 140, 30, 42, '_darkWood', '_steel'), P('barrel', 240, 136, 30, 42, '_darkWood', '_steel'),
                        P('barrel', 26, 186, 32, 44, '_darkWood', '_steel')]),
            ('b3_treasure', [P('lantern', 70, 14, 22, 44, '_ink', '_lampGlow'), P('lantern', 306, 14, 22, 44, '_ink', '_lampGlow')]),
        ],
    ),
    'pirate_ship_island': dict(
        backdrop=_out(0xFFC9B48A, 0xFFF6DC9C, 124, 'sand', sea='true'),
        scenery='_sceneIsland',
        props=[
            ('palms', [P('palm', 6, 14, 92, 140, '_green', '_gold'), P('palm', 300, 4, 100, 150, '_green', '_gold')]),
            ('maps', [P('@xMark', 172, 186, 74, 44, '_red', '_steel'), P('@jollyFlag', 96, 104, 54, 72, '_ebony', '_white')]),
            ('b3_gold', [P('@goldPile', 252, 170, 72, 42, '_gold', '_red')]),
            ('chests', [P('@chest', 128, 158, 70, 50, '_darkWood', '_gold')]),
            ('b3_treasure', [P('@rowboat', 300, 140, 90, 30, '_red', '_cream')]),
            ('crates', [P('barrel', 334, 186, 30, 42, '_darkWood', '_steel'), P('crates', 26, 180, 62, 46, '_wood', '_gold')]),
        ],
    ),
}

CHAPTER_META = [
    ('zen_garden', 21, 'spa', ('JAPANESE GARDEN', 'JAPON BAHÇESİ'), 'CHAPTER 21 — JAPANESE GARDEN. Ice: frost on ponds and lanterns.'),
    ('forest_camp', 22, 'forest', ('FOREST CAMP', 'ORMAN KAMPI'), 'CHAPTER 22 — FOREST CAMP. Crates: logs and supply boxes everywhere.'),
    ('circus', 23, 'festival', ('CIRCUS', 'SİRK'), 'CHAPTER 23 — CIRCUS. Chains: rigging and locked cages.'),
    ('oasis', 24, 'wb_sunny', ('DESERT OASIS', 'ÇÖL VAHASI'), 'CHAPTER 24 — DESERT OASIS. Keys: buried chests under the sand.'),
    ('pirate_ship', 25, 'sailing', ('PIRATE SHIP', 'KORSAN GEMİSİ'), 'CHAPTER 25 — PIRATE SHIP. Every obstacle at once, with treasure keys.'),
]



CHAPTERS = []
for cid, num, icon, name, doc in CHAPTER_META:
    levels = []
    for lid in [k for k in L if k.startswith(cid + '_')]:
        d = dict(L[lid])
        d['scene'] = SCENES[lid]
        levels.append(d)
    CHAPTERS.append({'id': cid, 'number': num, 'icon': icon, 'name': name, 'doc': doc, 'levels': levels})
