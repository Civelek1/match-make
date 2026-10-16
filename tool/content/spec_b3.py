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
const _red = Color(0xFFE0533F);
'''

SCENES = {}

CHAPTER_META = [
    ('zen_garden', 21, 'spa', ('JAPANESE GARDEN', 'JAPON BAHÇESİ'), 'CHAPTER 21 — JAPANESE GARDEN. Ice: frost on ponds and lanterns.'),
    ('forest_camp', 22, 'forest', ('FOREST CAMP', 'ORMAN KAMPI'), 'CHAPTER 22 — FOREST CAMP. Crates: logs and supply boxes everywhere.'),
    ('circus', 23, 'festival', ('CIRCUS', 'SİRK'), 'CHAPTER 23 — CIRCUS. Chains: rigging and locked cages.'),
    ('oasis', 24, 'wb_sunny', ('DESERT OASIS', 'ÇÖL VAHASI'), 'CHAPTER 24 — DESERT OASIS. Keys: buried chests under the sand.'),
    ('pirate_ship', 25, 'sailing', ('PIRATE SHIP', 'KORSAN GEMİSİ'), 'CHAPTER 25 — PIRATE SHIP. Every obstacle at once, with treasure keys.'),
]

_PLACEHOLDER = "const Backdrop.outdoor(groundN: Color(0xFFA8A296), groundR: Color(0xFFE6DCCB), horizon: 150)"


def _scene(lid):
    if lid in SCENES:
        return SCENES[lid]
    objs = L[lid]['objectives']
    return dict(backdrop=_PLACEHOLDER, props=[(o, [('vase', 20 + k * 54, 150, 40, 50, '_red', '_red')]) for k, (o, _, _) in enumerate(objs)])


CHAPTERS = []
for cid, num, icon, name, doc in CHAPTER_META:
    levels = []
    for lid in [k for k in L if k.startswith(cid + '_')]:
        d = dict(L[lid])
        d['scene'] = _scene(lid)
        levels.append(d)
    CHAPTERS.append({'id': cid, 'number': num, 'icon': icon, 'name': name, 'doc': doc, 'levels': levels})
