# Content batch 2: chapters 16–20 (levels 76–100).
# ZOO · AQUARIUM · FUNFAIR · BOOKSHOP · OBSERVATORY
# Generate with: python3 tool/content/gen_batch.py 2

BATCH = 2
FIRST_NUMBER = 76
PREV_CHAPTER = 'school'

NEW_TILES = {
    # Zoo
    'b2_paw': ('pets', 0),
    'b2_rabbit': ('cruelty_free', 1),
    'b2_bird': ('flutter_dash', 2),
    'b2_leaf': ('eco', 3),
    'b2_bee': ('emoji_nature', 4),
    'b2_egg': ('egg', 5),
    # Aquarium
    'b2_diver': ('scuba_diving', 0),
    'b2_drop': ('water_drop', 1),
    'b2_tide': ('tsunami', 3),
    'b2_jelly': ('blur_on', 4),
    'b2_bubble': ('bubble_chart', 5),
    # Funfair
    'b2_wheel': ('attractions', 0),
    'b2_toy': ('toys', 1),
    'b2_dice': ('casino', 2),
    'b2_candy': ('cake', 3),
    'b2_tent': ('festival', 4),
    'b2_prize': ('redeem', 5),
    # Bookshop
    'b2_story': ('auto_stories', 0),
    'b2_books': ('library_books', 1),
    'b2_bookmark': ('bookmark', 2),
    'b2_pen': ('draw', 3),
    'b2_puzzle': ('extension', 4),
    'b2_cafe': ('local_cafe', 4),
    'b2_shop': ('storefront', 5),
    # Observatory
    'b2_star': ('star', 0),
    'b2_moon': ('dark_mode', 1),
    'b2_satellite': ('satellite_alt', 2),
    'b2_rocket': ('rocket_launch', 3),
    'b2_hike': ('hiking', 4),
    'b2_radar': ('radar', 4),
    'b2_lens': ('lens', 5),
}

NEW_OBJECTIVES = {
    'b2_giraffes': ('Giraffes', 'Zürafalar'),
    'b2_penguins': ('Penguins', 'Penguenler'),
    'b2_ice_rocks': ('Ice Rocks', 'Buz Kayaları'),
    'b2_floes': ('Ice Floes', 'Buz Kütleleri'),
    'b2_slide': ('Ice Slide', 'Buz Kaydırağı'),
    'b2_reptiles': ('Reptiles', 'Sürüngenler'),
    'b2_terrariums': ('Terrariums', 'Teraryumlar'),
    'b2_insects': ('Insects', 'Böcekler'),
    'b2_tanks': ('Fish Tanks', 'Akvaryumlar'),
    'b2_bubbles': ('Bubbles', 'Kabarcıklar'),
    'b2_coral': ('Coral', 'Mercanlar'),
    'b2_fish': ('Fish', 'Balıklar'),
    'b2_divers': ('Divers', 'Dalgıçlar'),
    'b2_sharks': ('Sharks', 'Köpekbalıkları'),
    'b2_rays': ('Stingrays', 'Vatozlar'),
    'b2_jellyfish': ('Jellyfish', 'Denizanaları'),
    'b2_starfish': ('Starfish', 'Deniz Yıldızları'),
    'b2_arch': ('Entrance Arch', 'Giriş Kemeri'),
    'b2_balloons': ('Balloons', 'Balonlar'),
    'b2_treats': ('Treats', 'İkramlar'),
    'b2_carousel': ('Carousel', 'Atlıkarınca'),
    'b2_horses': ('Horses', 'Atlar'),
    'b2_organ': ('Music Organ', 'Müzik Kutusu'),
    'b2_ferris': ('Ferris Wheel', 'Dönme Dolap'),
    'b2_prizes': ('Prizes', 'Ödüller'),
    'b2_stalls': ('Game Stalls', 'Oyun Stantları'),
    'b2_games': ('Games', 'Oyunlar'),
    'b2_toys': ('Toys', 'Oyuncaklar'),
    'b2_coaster': ('Roller Coaster', 'Hız Treni'),
    'b2_shopfront': ('Shop Windows', 'Vitrinler'),
    'b2_book_cart': ('Book Carts', 'Kitap Arabaları'),
    'b2_picture_books': ('Picture Books', 'Resimli Kitaplar'),
    'b2_crayons': ('Crayons', 'Boya Kalemleri'),
    'b2_puzzles': ('Puzzles', 'Yapbozlar'),
    'b2_espresso': ('Coffee Bar', 'Kahve Barı'),
    'b2_cups': ('Cups', 'Fincanlar'),
    'b2_rare_books': ('Rare Books', 'Nadir Kitaplar'),
    'b2_path': ('Hill Path', 'Tepe Yolu'),
    'b2_telescope': ('Telescope', 'Teleskop'),
    'b2_dome': ('Night Sky', 'Gece Gökyüzü'),
    'b2_lenses': ('Lenses', 'Mercekler'),
    'b2_projector': ('Star Projector', 'Yıldız Projektörü'),
    'b2_planets': ('Planets', 'Gezegenler'),
    'b2_stars': ('Stars', 'Yıldızlar'),
    'b2_rockets': ('Rockets', 'Roketler'),
    'b2_constellations': ('Constellations', 'Takımyıldızlar'),
}

DART = r'''
const _wood = Color(0xFFC98A52);
const _darkWood = Color(0xFF8B5E3C);
const _cream = Color(0xFFFFF1DA);
const _gold = Color(0xFFFFC93C);
const _red = Color(0xFFE0533F);
const _leaf = Color(0xFF55C04A);
const _green = Color(0xFF3E9A3A);
const _pine = Color(0xFF2E7D4F);
const _pink = Color(0xFFFF7AB6);
const _blue = Color(0xFF45A7F5);
const _aqua = Color(0xFF4FD6E8);
const _teal = Color(0xFF1FA59A);
const _white = Color(0xFFFFFFFF);
const _navy = Color(0xFF2B3A67);
const _ink = Color(0xFF2B2440);
const _orange = Color(0xFFFF9A3C);
const _purple = Color(0xFF8A5CE6);
const _lilac = Color(0xFFC9A8FF);
const _steel = Color(0xFFC9CCD8);
const _stone = Color(0xFFBDB4A4);
const _sand = Color(0xFFF2D59A);
const _straw = Color(0xFFE8C66B);
const _coral = Color(0xFFFF7F6B);
const _mint = Color(0xFF8FE3C0);
const _lampGlow = Color(0xFFFFE9A0);
const _iceBlue = Color(0xFFBFEFFF);
const _giraffeY = Color(0xFFF2B648);
const _spot = Color(0xFF9A5A2A);
const _brass = Color(0xFFD9A441);
const _sky = Color(0xFF8ED8FF);
const _deep = Color(0xFF1E5FA8);
const _night = Color(0xFF1F2350);
const _grey = Color(0xFF8A8F9C);
const _wool = Color(0xFFF4F0E6);
const _brown = Color(0xFFA0683E);
const _terracotta = Color(0xFFE07A4F);
const _sun = Color(0xFFFFE066);

// ------------------------------------------------------------------ helpers
Paint _glass([double a = 0.35]) => Pk.fill(const Color(0xFFCFF3FF).withValues(alpha: a));

void _star(Canvas c, Offset o, double s, Color col) {
  final p = Path();
  for (var i = 0; i < 10; i++) {
    final ang = -pi / 2 + i * pi / 5;
    final rad = i.isEven ? s : s * 0.45;
    final q = o + Offset(cos(ang), sin(ang)) * rad;
    if (i == 0) {
      p.moveTo(q.dx, q.dy);
    } else {
      p.lineTo(q.dx, q.dy);
    }
  }
  p.close();
  c.drawPath(p, Pk.fill(col));
}

void _paw(Canvas c, Offset o, double s, Color col) {
  c.drawOval(Rect.fromCenter(center: o + Offset(0, s * 0.35), width: s * 1.1, height: s * 0.85), Pk.fill(col));
  for (var i = 0; i < 4; i++) {
    final ang = -pi * 0.85 + i * pi * 0.23;
    c.drawCircle(o + Offset(cos(ang), sin(ang)) * s * 0.78, s * 0.24, Pk.fill(col));
  }
}

void _fishShape(Canvas c, Offset o, double s, double dir, Color col) {
  c.drawOval(Rect.fromCenter(center: o, width: s * 2.2, height: s * 1.3), Pk.fill(col));
  Pk.poly(c, [o + Offset(-dir * s * 0.9, 0), o + Offset(-dir * s * 1.7, -s * 0.7), o + Offset(-dir * s * 1.7, s * 0.7)], Pk.fill(Pk.dark(col, 0.1)));
  c.drawCircle(o + Offset(dir * s * 0.55, -s * 0.15), s * 0.18, Pk.fill(_ink));
}

void _jellyMini(Canvas c, Offset o, double s, Color col, double t) {
  for (var i = 0; i < 4; i++) {
    final x = o.dx - s * 0.6 + i * s * 0.4;
    c.drawLine(Offset(x, o.dy), Offset(x + sin(t * 3 + i) * s * 0.25, o.dy + s * 1.3), Pk.stroke(Pk.alpha(Pk.light(col, 0.4), 0.8), 1));
  }
  c.drawArc(Rect.fromCenter(center: o, width: s * 2, height: s * 1.7), pi, pi, true, Pk.fill(Pk.alpha(Pk.light(col, 0.3), 0.9)));
}

void _horse(Canvas c, Rect r, Color col, Color mane) {
  final w = r.width, h = r.height;
  c.drawLine(Offset(r.left + w * 0.24, r.top + h * 0.6), Offset(r.left + w * 0.06, r.bottom), Pk.stroke(Pk.dark(col, 0.08), w * 0.09));
  c.drawLine(Offset(r.left + w * 0.66, r.top + h * 0.6), Offset(r.left + w * 0.84, r.bottom), Pk.stroke(Pk.dark(col, 0.08), w * 0.09));
  c.drawOval(Rect.fromLTWH(r.left + w * 0.1, r.top + h * 0.32, w * 0.68, h * 0.4), Pk.fill(col));
  Pk.poly(c, [Offset(r.left + w * 0.6, r.top + h * 0.42), Offset(r.left + w * 0.8, r.top), Offset(r.right, r.top + h * 0.16), Offset(r.left + w * 0.78, r.top + h * 0.52)], Pk.fill(col));
  c.drawLine(Offset(r.left + w * 0.78, r.top + h * 0.04), Offset(r.left + w * 0.6, r.top + h * 0.38), Pk.stroke(mane, w * 0.08));
  c.drawLine(Offset(r.left + w * 0.12, r.top + h * 0.45), Offset(r.left - w * 0.02, r.top + h * 0.7), Pk.stroke(mane, w * 0.07));
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.34, r.top + h * 0.26, w * 0.2, h * 0.14), _red, radius: 2);
}

// ------------------------------------------------------------------ zoo
void _paintGiraffe(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (final x in [0.12, 0.26, 0.5, 0.63]) {
    c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(r.left + w * x, r.top + h * 0.62, w * 0.07, h * 0.38), const Radius.circular(2)), Pk.fill(Pk.dark(a, 0.06)));
    c.drawRect(Rect.fromLTWH(r.left + w * x, r.bottom - h * 0.04, w * 0.07, h * 0.04), Pk.fill(Pk.dark(b, 0.3)));
  }
  c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(r.left + w * 0.06, r.top + h * 0.47, w * 0.68, h * 0.21), Radius.circular(h * 0.1)), Pk.fill(a));
  final sway = sin(t * 0.9 + r.left) * w * 0.02;
  Pk.poly(c, [
    Offset(r.left + w * 0.54, r.top + h * 0.52),
    Offset(r.left + w * 0.72 + sway, r.top + h * 0.12),
    Offset(r.left + w * 0.84 + sway, r.top + h * 0.14),
    Offset(r.left + w * 0.74, r.top + h * 0.56),
  ], Pk.fill(a));
  c.drawLine(Offset(r.left + w * 0.6, r.top + h * 0.48), Offset(r.left + w * 0.74 + sway, r.top + h * 0.12), Pk.stroke(Pk.dark(b, 0.1), w * 0.025));
  final head = Offset(r.left + w * 0.82 + sway, r.top + h * 0.11);
  c.drawOval(Rect.fromCenter(center: head + Offset(w * 0.05, h * 0.015), width: w * 0.28, height: h * 0.09), Pk.fill(a));
  c.drawOval(Rect.fromCenter(center: head + Offset(-w * 0.07, -h * 0.01), width: w * 0.1, height: h * 0.035), Pk.fill(Pk.dark(a, 0.1)));
  for (final dx in [-0.02, 0.04]) {
    c.drawLine(head + Offset(w * dx, -h * 0.03), head + Offset(w * dx, -h * 0.085), Pk.stroke(Pk.dark(b, 0.1), w * 0.03));
    c.drawCircle(head + Offset(w * dx, -h * 0.09), w * 0.026, Pk.fill(Pk.dark(b, 0.25)));
  }
  c.drawCircle(head + Offset(w * 0.03, -h * 0.005), w * 0.022, Pk.fill(_ink));
  final sp = Pk.fill(b);
  for (var i = 0; i < 9; i++) {
    c.drawCircle(Offset(r.left + w * (0.12 + Pk.rand(i) * 0.56), r.top + h * (0.5 + Pk.rand(i + 7) * 0.14)), w * 0.036, sp);
  }
  for (var i = 0; i < 4; i++) {
    final k = (i + 0.5) / 4;
    c.drawCircle(Offset(r.left + w * (0.65 + k * 0.13) + sway * k, r.top + h * (0.5 - k * 0.34)), w * 0.025, sp);
  }
  c.drawLine(Offset(r.left + w * 0.07, r.top + h * 0.52), Offset(r.left + w * 0.01, r.top + h * 0.68), Pk.stroke(Pk.dark(a, 0.2), 1.5));
}

void _paintPenguin(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final bob = sin(t * 3 + r.left) * h * 0.02;
  for (final s in [-1.0, 1.0]) {
    c.drawOval(Rect.fromCenter(center: Offset(r.center.dx + s * w * 0.16, r.bottom - h * 0.035), width: w * 0.28, height: h * 0.07), Pk.fill(b));
  }
  for (final s in [-1.0, 1.0]) {
    c.save();
    c.translate(r.center.dx + s * w * 0.36, r.top + h * 0.42 + bob);
    c.rotate(s * (0.3 + 0.12 * sin(t * 4 + r.left)));
    c.drawOval(Rect.fromCenter(center: Offset(0, h * 0.14), width: w * 0.18, height: h * 0.36), Pk.fill(Pk.dark(a, 0.1)));
    c.restore();
  }
  c.drawOval(Rect.fromLTWH(r.left + w * 0.12, r.top + h * 0.1 + bob, w * 0.76, h * 0.84), Pk.fill(a));
  c.drawOval(Rect.fromLTWH(r.left + w * 0.27, r.top + h * 0.34 + bob, w * 0.46, h * 0.56), Pk.fill(_white));
  for (final s in [-1.0, 1.0]) {
    c.drawCircle(Offset(r.center.dx + s * w * 0.14, r.top + h * 0.25 + bob), w * 0.085, Pk.fill(_white));
    c.drawCircle(Offset(r.center.dx + s * w * 0.12, r.top + h * 0.255 + bob), w * 0.04, Pk.fill(_ink));
  }
  Pk.poly(c, [Offset(r.center.dx - w * 0.1, r.top + h * 0.32 + bob), Offset(r.center.dx + w * 0.1, r.top + h * 0.32 + bob), Offset(r.center.dx, r.top + h * 0.42 + bob)], Pk.fill(b));
}

void _paintAcacia(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawLine(Offset(r.center.dx, r.bottom), Offset(r.center.dx, r.top + h * 0.5), Pk.stroke(b, w * 0.06));
  c.drawLine(Offset(r.center.dx, r.top + h * 0.6), Offset(r.left + w * 0.28, r.top + h * 0.24), Pk.stroke(b, w * 0.04));
  c.drawLine(Offset(r.center.dx, r.top + h * 0.56), Offset(r.right - w * 0.25, r.top + h * 0.22), Pk.stroke(b, w * 0.04));
  final sway = sin(t * 0.7 + r.left) * w * 0.01;
  for (final (x, y, ww, hh) in [(0.0, 0.14, 0.55, 0.2), (0.42, 0.1, 0.58, 0.22), (0.18, 0.0, 0.62, 0.2)]) {
    final rr = Rect.fromLTWH(r.left + w * x + sway, r.top + h * y, w * ww, h * hh);
    c.drawOval(rr, Pk.fill(Pk.dark(a, 0.15)));
    c.drawOval(Rect.fromLTWH(rr.left + w * 0.02, rr.top, rr.width - w * 0.04, rr.height * 0.8), Pk.fill(a));
  }
  c.drawOval(Rect.fromLTWH(r.left + w * 0.3 + sway, r.top + h * 0.03, w * 0.25, h * 0.06), Pk.fill(Pk.light(a, 0.2)));
}

void _paintRock(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final p1 = Path()
    ..moveTo(r.left, r.bottom)
    ..lineTo(r.left + w * 0.06, r.top + h * 0.35)
    ..lineTo(r.left + w * 0.3, r.top + h * 0.06)
    ..lineTo(r.left + w * 0.56, r.top + h * 0.2)
    ..lineTo(r.left + w * 0.68, r.bottom)
    ..close();
  c.drawPath(p1, Pk.fill(a));
  final p2 = Path()
    ..moveTo(r.left + w * 0.44, r.bottom)
    ..lineTo(r.left + w * 0.55, r.top + h * 0.42)
    ..lineTo(r.left + w * 0.8, r.top + h * 0.3)
    ..lineTo(r.right, r.top + h * 0.62)
    ..lineTo(r.right, r.bottom)
    ..close();
  c.drawPath(p2, Pk.fill(Pk.dark(a, 0.12)));
  c.drawLine(Offset(r.left + w * 0.1, r.top + h * 0.38), Offset(r.left + w * 0.3, r.top + h * 0.12), Pk.stroke(Pk.light(a, 0.3), 2));
  c.drawOval(Rect.fromLTWH(r.left + w * 0.17, r.top + h * 0.04, w * 0.3, h * 0.14), Pk.fill(b));
  c.drawOval(Rect.fromLTWH(r.left + w * 0.66, r.top + h * 0.3, w * 0.2, h * 0.1), Pk.fill(b));
}

void _paintZooArch(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.22, w * 0.11, h * 0.78), a, radius: 2);
  Pk.box(c, Rect.fromLTWH(r.right - w * 0.11, r.top + h * 0.22, w * 0.11, h * 0.78), a, radius: 2);
  for (final x in [r.left + w * 0.055, r.right - w * 0.055]) {
    c.drawCircle(Offset(x, r.top + h * 0.22), w * 0.07, Pk.fill(Pk.dark(a, 0.15)));
    Pk.bushy(c, Rect.fromLTWH(x - w * 0.08, r.top + h * 0.1, w * 0.16, h * 0.12), _leaf);
  }
  final arcR = Rect.fromLTWH(r.left + w * 0.03, r.top + h * 0.1, w * 0.94, h * 0.5);
  c.drawArc(arcR, pi, pi, false, Pk.stroke(Pk.dark(a, 0.25), h * 0.17));
  c.drawArc(arcR, pi, pi, false, Pk.stroke(b, h * 0.12));
  for (var i = 1; i < 12; i++) {
    if (i >= 5 && i <= 7) continue;
    final ang = pi + pi * i / 12;
    c.drawCircle(arcR.center + Offset(cos(ang) * arcR.width / 2, sin(ang) * arcR.height / 2), h * 0.022, Pk.fill(_cream));
  }
  final m = Offset(r.center.dx, r.top + h * 0.1);
  c.drawCircle(m, h * 0.13, Pk.fill(Pk.dark(a, 0.25)));
  c.drawCircle(m, h * 0.105, Pk.fill(_cream));
  _paw(c, m + Offset(0, -h * 0.015), h * 0.06, Pk.dark(a, 0.3));
}

void _paintBooth(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.06, r.top + h * 0.3, w * 0.88, h * 0.7), a, radius: 3);
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.2, r.top + h * 0.4, w * 0.6, h * 0.26), const Color(0xFFBFEFFA), radius: 2, outline: Pk.dark(a, 0.3));
  c.drawRect(Rect.fromLTWH(r.left + w * 0.14, r.top + h * 0.66, w * 0.72, h * 0.06), Pk.fill(Pk.dark(a, 0.25)));
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.3, r.top + h * 0.8, w * 0.4, h * 0.1), b, radius: 2);
  const n = 5;
  for (var i = 0; i < n; i++) {
    final x = r.left - w * 0.04 + w * 1.08 * i / n;
    Pk.poly(c, [Offset(r.center.dx, r.top), Offset(x, r.top + h * 0.3), Offset(x + w * 1.08 / n, r.top + h * 0.3)], Pk.fill(i.isEven ? b : _white));
    c.drawArc(Rect.fromLTWH(x, r.top + h * 0.25, w * 1.08 / n, h * 0.1), 0, pi, true, Pk.fill(i.isEven ? b : _white));
  }
  c.drawCircle(Offset(r.center.dx, r.top), w * 0.05, Pk.fill(_gold));
}

void _paintFloe(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final bob = sin(t * 1.2 + r.left) * h * 0.05;
  final side = Path()
    ..moveTo(r.left, r.top + h * 0.45 + bob)
    ..lineTo(r.right, r.top + h * 0.45 + bob)
    ..lineTo(r.right - w * 0.06, r.bottom + bob)
    ..lineTo(r.left + w * 0.06, r.bottom + bob)
    ..close();
  c.drawPath(side, Pk.fill(b));
  final top = Path()
    ..moveTo(r.left, r.top + h * 0.45 + bob)
    ..lineTo(r.left + w * 0.15, r.top + h * 0.1 + bob)
    ..lineTo(r.left + w * 0.55, r.top + bob)
    ..lineTo(r.right - w * 0.1, r.top + h * 0.15 + bob)
    ..lineTo(r.right, r.top + h * 0.45 + bob)
    ..close();
  c.drawPath(top, Pk.fill(a));
  c.drawLine(Offset(r.left + w * 0.2, r.top + h * 0.2 + bob), Offset(r.left + w * 0.45, r.top + h * 0.1 + bob), Pk.stroke(_white, 2));
}

void _paintSlide(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawLine(Offset(r.right - w * 0.12, r.top + h * 0.06), Offset(r.right - w * 0.06, r.bottom), Pk.stroke(_steel, 2.5));
  c.drawLine(Offset(r.right - w * 0.36, r.top + h * 0.55), Offset(r.right - w * 0.34, r.bottom), Pk.stroke(_steel, 2.5));
  for (var i = 1; i < 5; i++) {
    final y = r.top + h * (0.1 + i * 0.18);
    c.drawLine(Offset(r.right - w * 0.11, y), Offset(r.right - w * 0.03, y), Pk.stroke(_steel, 1.5));
  }
  final p = Path()
    ..moveTo(r.right - w * 0.12, r.top + h * 0.06)
    ..cubicTo(r.right - w * 0.1, r.top + h * 0.62, r.left + w * 0.4, r.bottom - h * 0.12, r.left, r.bottom - h * 0.06);
  c.drawPath(p, Pk.stroke(Pk.dark(b, 0.2), h * 0.18));
  c.drawPath(p, Pk.stroke(b, h * 0.13));
  c.drawPath(p, Pk.stroke(a, h * 0.05));
}

void _paintTerrarium(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.04, r.top + h * 0.64, w * 0.92, h * 0.36), a, radius: 3);
  c.drawRect(Rect.fromLTWH(r.left + w * 0.12, r.top + h * 0.74, w * 0.34, h * 0.18), Pk.fill(Pk.light(a, 0.1)));
  c.drawRect(Rect.fromLTWH(r.left + w * 0.54, r.top + h * 0.74, w * 0.34, h * 0.18), Pk.fill(Pk.light(a, 0.1)));
  final glass = Rect.fromLTWH(r.left, r.top, w, h * 0.64);
  c.drawRect(glass, _glass(0.32));
  c.drawRect(Rect.fromLTWH(glass.left, glass.bottom - h * 0.12, w, h * 0.12), Pk.fill(_sand));
  for (var i = 0; i < 3; i++) {
    final x = glass.left + w * (0.14 + i * 0.36);
    for (var k = -1; k <= 1; k++) {
      c.drawLine(Offset(x, glass.bottom - h * 0.08), Offset(x + k * w * 0.06, glass.bottom - h * (0.26 + Pk.rand(i * 3 + k + 2) * 0.14)), Pk.stroke(b, 3));
    }
  }
  c.drawLine(Offset(glass.left + w * 0.08, glass.bottom - h * 0.12), Offset(glass.right - w * 0.1, glass.top + h * 0.3), Pk.stroke(_darkWood, 3.5));
  Pk.glow(c, Offset(glass.center.dx, glass.top + h * 0.05), w * 0.45, _lampGlow, 0.45);
  c.drawRect(glass, Pk.stroke(Pk.dark(a, 0.25), 2.5));
  c.drawLine(glass.topLeft + Offset(w * 0.1, h * 0.14), glass.topLeft + Offset(w * 0.26, h * 0.05), Pk.stroke(_white.withValues(alpha: 0.7), 2));
}

void _paintLizard(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final wig = sin(t * 2 + r.left) * h * 0.1;
  final tail = Path()
    ..moveTo(r.left + w * 0.36, r.center.dy)
    ..quadraticBezierTo(r.left + w * 0.12, r.center.dy + h * 0.3 + wig, r.left, r.center.dy - h * 0.1);
  c.drawPath(tail, Pk.stroke(a, h * 0.16));
  for (final x in [0.38, 0.64]) {
    c.drawLine(Offset(r.left + w * x, r.top + h * 0.55), Offset(r.left + w * (x - 0.06), r.bottom), Pk.stroke(Pk.dark(a, 0.15), h * 0.1));
  }
  c.drawOval(Rect.fromLTWH(r.left + w * 0.3, r.top + h * 0.3, w * 0.46, h * 0.4), Pk.fill(a));
  c.drawOval(Rect.fromLTWH(r.left + w * 0.68, r.top + h * 0.2, w * 0.3, h * 0.34), Pk.fill(a));
  for (var i = 0; i < 3; i++) {
    c.drawCircle(Offset(r.left + w * (0.4 + i * 0.1), r.top + h * 0.42), h * 0.06, Pk.fill(b));
  }
  c.drawCircle(Offset(r.left + w * 0.86, r.top + h * 0.31), h * 0.055, Pk.fill(_ink));
}

void _paintTurtle(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (final x in [0.2, 0.66]) {
    c.drawOval(Rect.fromLTWH(r.left + w * x - w * 0.06, r.bottom - h * 0.3, w * 0.16, h * 0.3), Pk.fill(b));
  }
  final hx = sin(t * 1.5 + r.left) * w * 0.02;
  c.drawOval(Rect.fromLTWH(r.right - w * 0.26 + hx, r.top + h * 0.4, w * 0.26, h * 0.34), Pk.fill(b));
  c.drawCircle(Offset(r.right - w * 0.07 + hx, r.top + h * 0.5), h * 0.045, Pk.fill(_ink));
  final shell = Rect.fromLTWH(r.left + w * 0.04, r.top, w * 0.76, h * 1.7);
  c.drawArc(shell, pi, pi, true, Pk.fill(a));
  for (var i = 0; i < 3; i++) {
    c.drawCircle(Offset(shell.left + shell.width * (0.25 + i * 0.25), r.top + h * (i == 1 ? 0.32 : 0.48)), w * 0.07, Pk.fill(Pk.dark(a, 0.18)));
  }
  c.drawRect(Rect.fromLTWH(shell.left, r.top + h * 0.78, shell.width, h * 0.08), Pk.fill(Pk.dark(a, 0.28)));
}

void _paintSheep(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (final x in [0.2, 0.34, 0.58, 0.72]) {
    c.drawRect(Rect.fromLTWH(r.left + w * x, r.top + h * 0.6, w * 0.07, h * 0.4), Pk.fill(b));
  }
  final wool = Pk.fill(a);
  for (var i = 0; i < 6; i++) {
    c.drawCircle(Offset(r.left + w * (0.18 + (i % 3) * 0.22), r.top + h * (0.34 + (i ~/ 3) * 0.2)), h * 0.2, wool);
  }
  final bob = sin(t * 2 + r.left) * h * 0.02;
  c.drawOval(Rect.fromLTWH(r.left + w * 0.7, r.top + h * 0.18 + bob, w * 0.28, h * 0.36), Pk.fill(b));
  c.drawOval(Rect.fromLTWH(r.left + w * 0.64, r.top + h * 0.24 + bob, w * 0.12, h * 0.1), Pk.fill(b));
  c.drawCircle(Offset(r.left + w * 0.88, r.top + h * 0.3 + bob), h * 0.035, Pk.fill(_white));
  c.drawCircle(Offset(r.left + w * 0.82, r.top + h * 0.17 + bob), h * 0.09, wool);
}

void _paintRabbit(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final hop = max(0.0, sin(t * 3 + r.left)) * h * 0.05;
  c.drawOval(Rect.fromLTWH(r.left, r.top + h * 0.42 - hop, w * 0.75, h * 0.55), Pk.fill(a));
  c.drawCircle(Offset(r.left + w * 0.05, r.top + h * 0.6 - hop), w * 0.1, Pk.fill(_white));
  final head = Offset(r.left + w * 0.72, r.top + h * 0.44 - hop);
  for (final dx in [-0.06, 0.06]) {
    c.drawOval(Rect.fromCenter(center: head + Offset(w * dx, -h * 0.28), width: w * 0.13, height: h * 0.38), Pk.fill(a));
    c.drawOval(Rect.fromCenter(center: head + Offset(w * dx, -h * 0.27), width: w * 0.06, height: h * 0.26), Pk.fill(b));
  }
  c.drawCircle(head, w * 0.2, Pk.fill(a));
  c.drawCircle(head + Offset(w * 0.08, -h * 0.03), w * 0.035, Pk.fill(_ink));
  c.drawCircle(head + Offset(w * 0.18, h * 0.04), w * 0.03, Pk.fill(b));
}

void _paintHutch(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (final x in [0.08, 0.86]) {
    c.drawRect(Rect.fromLTWH(r.left + w * x, r.top + h * 0.7, w * 0.06, h * 0.3), Pk.fill(Pk.dark(a, 0.3)));
  }
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.04, r.top + h * 0.28, w * 0.92, h * 0.44), a, radius: 2);
  final mesh = Rect.fromLTWH(r.left + w * 0.1, r.top + h * 0.34, w * 0.45, h * 0.32);
  c.drawRect(mesh, Pk.fill(Pk.dark(a, 0.45)));
  for (var i = 1; i < 5; i++) {
    c.drawLine(Offset(mesh.left + mesh.width * i / 5, mesh.top), Offset(mesh.left + mesh.width * i / 5, mesh.bottom), Pk.stroke(_steel, 1));
  }
  c.drawLine(mesh.centerLeft, mesh.centerRight, Pk.stroke(_steel, 1));
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.62, r.top + h * 0.36, w * 0.26, h * 0.3), Pk.light(a, 0.12), radius: 2);
  Pk.poly(c, [Offset(r.left - w * 0.03, r.top + h * 0.32), Offset(r.center.dx, r.top), Offset(r.right + w * 0.03, r.top + h * 0.32)], Pk.fill(b));
}

void _paintFeeder(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawRect(Rect.fromLTWH(r.center.dx - w * 0.07, r.top + h * 0.2, w * 0.14, h * 0.8), Pk.fill(a));
  for (var i = 0; i < 6; i++) {
    c.drawLine(Offset(r.left + w * (0.12 + i * 0.15), r.top + h * 0.08), Offset(r.left + w * (0.08 + i * 0.15), r.top - h * 0.02), Pk.stroke(b, 1.6));
  }
  c.drawOval(Rect.fromLTWH(r.left + w * 0.04, r.top, w * 0.92, h * 0.14), Pk.fill(b));
  final basket = Path()
    ..moveTo(r.left, r.top + h * 0.08)
    ..lineTo(r.right, r.top + h * 0.08)
    ..lineTo(r.right - w * 0.15, r.top + h * 0.3)
    ..lineTo(r.left + w * 0.15, r.top + h * 0.3)
    ..close();
  c.drawPath(basket, Pk.fill(Pk.dark(a, 0.1)));
  for (var i = 1; i < 6; i++) {
    final x = r.left + w * i / 6;
    c.drawLine(Offset(x, r.top + h * 0.08), Offset(r.center.dx + (x - r.center.dx) * 0.7, r.top + h * 0.3), Pk.stroke(Pk.dark(a, 0.35), 1));
  }
}

void _paintBugCase(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, r, a, radius: 2);
  final inner = r.deflate(4);
  c.drawRect(inner, Pk.fill(_cream));
  for (var i = 0; i < 6; i++) {
    final p = Offset(inner.left + inner.width * (0.18 + (i % 3) * 0.32), inner.top + inner.height * (0.3 + (i ~/ 3) * 0.42));
    final s = inner.width * 0.085;
    final col = [b, _blue, _orange, _purple, _leaf, _red][i];
    final flap = 0.85 + 0.15 * sin(t * 3 + i);
    for (final d in [-1.0, 1.0]) {
      c.drawOval(Rect.fromCenter(center: p + Offset(d * s * 0.55 * flap, -s * 0.2), width: s * 0.95 * flap, height: s * 0.85), Pk.fill(col));
      c.drawOval(Rect.fromCenter(center: p + Offset(d * s * 0.45 * flap, s * 0.38), width: s * 0.6 * flap, height: s * 0.55), Pk.fill(Pk.dark(col, 0.15)));
    }
    c.drawLine(p + Offset(0, -s * 0.5), p + Offset(0, s * 0.6), Pk.stroke(_ink, 1.2));
  }
}

void _paintNest(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (var i = 0; i < 3; i++) {
    c.drawOval(Rect.fromLTWH(r.left + w * (0.2 + i * 0.2), r.top + (i == 1 ? 0 : h * 0.08), w * 0.22, h * 0.6), Pk.fill(b));
  }
  c.drawOval(Rect.fromLTWH(r.left, r.top + h * 0.4, w, h * 0.6), Pk.fill(a));
  for (var i = 0; i < 6; i++) {
    c.drawLine(Offset(r.left + w * (0.06 + i * 0.15), r.top + h * 0.5), Offset(r.left + w * (0.18 + i * 0.14), r.bottom - h * 0.1), Pk.stroke(Pk.dark(a, 0.25), 1.2));
  }
}

// ------------------------------------------------------------------ aquarium
void _paintTank(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, r.inflate(4), a, radius: 4);
  c.save();
  c.clipRect(r);
  Pk.gradientRect(c, r, Pk.light(b, 0.25), Pk.dark(b, 0.25));
  for (var i = 0; i < 3; i++) {
    final x = r.left + w * (0.2 + i * 0.3);
    Pk.poly(c, [Offset(x, r.top), Offset(x + w * 0.08, r.top), Offset(x + w * 0.02, r.bottom), Offset(x - w * 0.12, r.bottom)], Pk.fill(_white.withValues(alpha: 0.08)));
  }
  c.drawOval(Rect.fromLTWH(r.left - w * 0.1, r.bottom - h * 0.16, w * 1.2, h * 0.3), Pk.fill(_sand));
  for (var i = 0; i < 5; i++) {
    final x = r.left + w * (0.08 + i * 0.21);
    final sway = sin(t * 1.3 + i) * w * 0.03;
    c.drawPath(
      Path()
        ..moveTo(x, r.bottom)
        ..quadraticBezierTo(x + sway * 2, r.bottom - h * 0.3, x + sway, r.bottom - h * (0.4 + Pk.rand(i) * 0.2)),
      Pk.stroke(i.isEven ? _leaf : _teal, 3),
    );
  }
  for (var i = 0; i < 4; i++) {
    final dir = i.isEven ? 1.0 : -1.0;
    final px = r.left + ((Pk.rand(i) * w + dir * t * (8 + i * 3)) % (w + 20)) - 10;
    final py = r.top + h * (0.2 + Pk.rand(i + 4) * 0.45);
    _fishShape(c, Offset(px, py), h * 0.065, dir, [_orange, _gold, _coral, _pink][i]);
  }
  for (var i = 0; i < 5; i++) {
    final k = (t * 0.4 + i / 5) % 1;
    c.drawCircle(Offset(r.left + w * 0.8 + sin(k * 8) * 3, r.bottom - k * h), 1.5 + k * 1.5, Pk.stroke(_white.withValues(alpha: 0.7), 1));
  }
  c.restore();
  c.drawLine(r.topLeft + Offset(w * 0.05, h * 0.3), r.topLeft + Offset(w * 0.14, h * 0.08), Pk.stroke(_white.withValues(alpha: 0.5), 2));
}

void _paintFish(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final y = r.center.dy + sin(t * 1.6 + r.left) * h * 0.08;
  final wag = sin(t * 5 + r.left) * h * 0.08;
  Pk.poly(c, [Offset(r.left + w * 0.28, y), Offset(r.left, y - h * 0.4 + wag), Offset(r.left + w * 0.07, y + wag * 0.3), Offset(r.left, y + h * 0.4 + wag)], Pk.fill(b));
  Pk.poly(c, [Offset(r.left + w * 0.48, y - h * 0.24), Offset(r.left + w * 0.6, y - h * 0.5), Offset(r.left + w * 0.72, y - h * 0.22)], Pk.fill(b));
  final body = Path()
    ..moveTo(r.right, y)
    ..quadraticBezierTo(r.left + w * 0.6, y - h * 0.62, r.left + w * 0.22, y)
    ..quadraticBezierTo(r.left + w * 0.6, y + h * 0.62, r.right, y)
    ..close();
  c.drawPath(body, Pk.fill(a));
  for (final x in [0.48, 0.68]) {
    c.drawLine(Offset(r.left + w * x, y - h * 0.24), Offset(r.left + w * x, y + h * 0.24), Pk.stroke(_white.withValues(alpha: 0.85), w * 0.05));
  }
  c.drawCircle(Offset(r.left + w * 0.84, y - h * 0.05), h * 0.07, Pk.fill(_ink));
}

void _paintShark(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final y = r.center.dy + sin(t * 0.9 + r.left) * h * 0.06;
  final wag = sin(t * 3 + r.left) * h * 0.06;
  Pk.poly(c, [Offset(r.left + w * 0.22, y + h * 0.02), Offset(r.left, y - h * 0.42 + wag), Offset(r.left + w * 0.08, y + h * 0.02 + wag * 0.5), Offset(r.left + w * 0.02, y + h * 0.34 + wag)], Pk.fill(a));
  Pk.poly(c, [Offset(r.left + w * 0.46, y - h * 0.16), Offset(r.left + w * 0.55, y - h * 0.5), Offset(r.left + w * 0.66, y - h * 0.18)], Pk.fill(Pk.dark(a, 0.08)));
  final body = Path()
    ..moveTo(r.right, y + h * 0.05)
    ..quadraticBezierTo(r.left + w * 0.7, y - h * 0.44, r.left + w * 0.18, y - h * 0.02)
    ..lineTo(r.left + w * 0.18, y + h * 0.06)
    ..quadraticBezierTo(r.left + w * 0.7, y + h * 0.42, r.right, y + h * 0.05)
    ..close();
  c.drawPath(body, Pk.fill(a));
  final belly = Path()
    ..moveTo(r.right - w * 0.04, y + h * 0.08)
    ..quadraticBezierTo(r.left + w * 0.6, y + h * 0.34, r.left + w * 0.26, y + h * 0.06)
    ..quadraticBezierTo(r.left + w * 0.6, y + h * 0.12, r.right - w * 0.04, y + h * 0.08)
    ..close();
  c.drawPath(belly, Pk.fill(b));
  Pk.poly(c, [Offset(r.left + w * 0.55, y + h * 0.12), Offset(r.left + w * 0.47, y + h * 0.44), Offset(r.left + w * 0.66, y + h * 0.16)], Pk.fill(Pk.dark(a, 0.12)));
  c.drawCircle(Offset(r.left + w * 0.86, y - h * 0.04), h * 0.05, Pk.fill(_ink));
  for (var i = 0; i < 3; i++) {
    c.drawLine(Offset(r.left + w * (0.72 + i * 0.03), y - h * 0.02), Offset(r.left + w * (0.71 + i * 0.03), y + h * 0.1), Pk.stroke(Pk.dark(a, 0.25), 1));
  }
}

void _paintRay(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final flap = sin(t * 2 + r.left) * h * 0.12;
  c.drawLine(Offset(r.center.dx, r.bottom - h * 0.32), Offset(r.center.dx + sin(t * 2) * w * 0.05, r.bottom), Pk.stroke(Pk.dark(a, 0.2), 2));
  final body = Path()
    ..moveTo(r.center.dx, r.top)
    ..quadraticBezierTo(r.right - w * 0.1, r.top + h * 0.1 + flap, r.right, r.center.dy + flap)
    ..quadraticBezierTo(r.center.dx + w * 0.2, r.center.dy + h * 0.1, r.center.dx, r.bottom - h * 0.3)
    ..quadraticBezierTo(r.center.dx - w * 0.2, r.center.dy + h * 0.1, r.left, r.center.dy + flap)
    ..quadraticBezierTo(r.left + w * 0.1, r.top + h * 0.1 + flap, r.center.dx, r.top)
    ..close();
  c.drawPath(body, Pk.fill(a));
  for (var i = 0; i < 6; i++) {
    c.drawCircle(Offset(r.center.dx + (Pk.rand(i) - 0.5) * w * 0.5, r.top + h * (0.22 + Pk.rand(i + 3) * 0.3)), w * 0.025, Pk.fill(b));
  }
}

void _paintJelly(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final pulse = sin(t * 2 + r.left);
  final y = r.top + h * 0.04 - pulse * h * 0.03;
  Pk.glow(c, Offset(r.center.dx, y + h * 0.25), w * 0.9, b, 0.45);
  for (var i = 0; i < 5; i++) {
    final x = r.left + w * (0.2 + i * 0.15);
    final p = Path()..moveTo(x, y + h * 0.3);
    for (var k = 1; k <= 4; k++) {
      p.lineTo(x + sin(t * 3 + i + k) * w * 0.05, y + h * 0.3 + k * h * 0.16);
    }
    c.drawPath(p, Pk.stroke(Pk.alpha(b, 0.8), 1.4));
  }
  final bell = Rect.fromLTWH(r.left + w * (0.08 + pulse * 0.02), y, w * (0.84 - pulse * 0.04), h * 0.6);
  c.drawArc(bell, pi, pi, true, Pk.fill(Pk.alpha(a, 0.85)));
  c.drawArc(bell.deflate(w * 0.12), pi, pi, true, Pk.fill(Pk.alpha(Pk.light(a, 0.4), 0.8)));
  c.drawRect(Rect.fromLTWH(bell.left, bell.center.dy - 1, bell.width, 2.5), Pk.fill(Pk.alpha(b, 0.9)));
}

void _paintCoral(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  void branch(Offset o, double ang, double len, int depth) {
    final e = o + Offset(sin(ang), -cos(ang)) * len;
    c.drawLine(o, e, Pk.stroke(depth.isEven ? a : Pk.light(a, 0.12), w * (0.03 + depth * 0.025)));
    if (depth > 0) {
      branch(e, ang - 0.5, len * 0.72, depth - 1);
      branch(e, ang + 0.45, len * 0.7, depth - 1);
    } else {
      c.drawCircle(e, w * 0.045, Pk.fill(b));
    }
  }

  branch(Offset(r.center.dx, r.bottom), sin(t * 0.8 + r.left) * 0.04, h * 0.36, 3);
}

void _paintWeed(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (var i = 0; i < 4; i++) {
    final x = r.left + w * (0.15 + i * 0.23);
    final sway = sin(t * 1.2 + i + r.left) * w * 0.12;
    final top = Offset(x + sway, r.top + h * (0.05 + Pk.rand(i) * 0.25));
    final p = Path()
      ..moveTo(x - w * 0.07, r.bottom)
      ..quadraticBezierTo(x - w * 0.16 + sway * 0.5, r.center.dy, top.dx, top.dy)
      ..quadraticBezierTo(x + w * 0.12 + sway * 0.5, r.center.dy, x + w * 0.07, r.bottom)
      ..close();
    c.drawPath(p, Pk.fill(i.isEven ? a : b));
  }
}

void _paintBubbles(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (var i = 0; i < 9; i++) {
    final k = (t * 0.35 + i / 9) % 1;
    final rad = w * (0.12 + Pk.rand(i) * 0.14);
    final p = Offset(r.center.dx + sin(k * 9 + i) * w * 0.25, r.bottom - rad - k * (h - rad * 2));
    c.drawCircle(p, rad, Pk.fill(Pk.alpha(a, 0.3)));
    c.drawCircle(p, rad, Pk.stroke(Pk.alpha(b, 0.85), 1.2));
    c.drawCircle(p + Offset(-rad * 0.35, -rad * 0.35), rad * 0.25, Pk.fill(_white.withValues(alpha: 0.8)));
  }
}

void _paintTouchPool(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.3, w, h * 0.7), Pk.dark(a, 0.08), radius: 8);
  for (var i = 0; i < 6; i++) {
    c.drawRect(Rect.fromLTWH(r.left + w * (0.06 + i * 0.16), r.top + h * 0.62, w * 0.12, h * 0.26), Pk.fill(Pk.light(a, 0.12)));
  }
  final water = RRect.fromRectAndRadius(Rect.fromLTWH(r.left + w * 0.04, r.top, w * 0.92, h * 0.48), Radius.circular(h * 0.24));
  c.drawRRect(water.inflate(3), Pk.fill(Pk.light(a, 0.2)));
  c.drawRRect(water, Pk.fill(b));
  c.save();
  c.clipRRect(water);
  c.drawOval(Rect.fromLTWH(r.left + w * 0.1, r.top + h * 0.26, w * 0.8, h * 0.3), Pk.fill(Pk.light(_sand, 0.1).withValues(alpha: 0.55)));
  for (var i = 0; i < 4; i++) {
    final y = r.top + h * (0.08 + i * 0.09);
    final x = r.left + w * (0.1 + (i * 0.23 + t * 0.03) % 0.7);
    c.drawLine(Offset(x, y), Offset(x + w * 0.14, y), Pk.stroke(_white.withValues(alpha: 0.55), 1.5));
  }
  for (var i = 0; i < 3; i++) {
    _star(c, Offset(r.left + w * (0.25 + i * 0.25), r.top + h * (0.3 + (i.isEven ? 0.04 : -0.04))), h * 0.09, [_orange, _coral, _purple][i]);
  }
  c.restore();
}

void _paintStarfish(Canvas c, Rect r, Color a, Color b, double t) {
  final rad = min(r.width, r.height) / 2;
  c.save();
  c.translate(r.center.dx, r.center.dy);
  c.rotate(r.left * 0.1 + sin(t * 0.8 + r.top) * 0.05);
  _star(c, Offset.zero, rad, a);
  for (var i = 0; i < 5; i++) {
    final ang = -pi / 2 + i * 2 * pi / 5;
    c.drawCircle(Offset(cos(ang), sin(ang)) * rad * 0.45, rad * 0.08, Pk.fill(b));
  }
  c.drawCircle(Offset.zero, rad * 0.12, Pk.fill(b));
  c.restore();
}

void _paintHelmet(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.08, r.top + h * 0.74, w * 0.84, h * 0.26), _stone, radius: 2);
  final cc = Offset(r.center.dx, r.top + h * 0.4);
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.16, r.top + h * 0.6, w * 0.68, h * 0.15), Pk.dark(a, 0.15), radius: 3);
  c.drawCircle(cc, w * 0.36, Pk.fill(a));
  final port = cc + Offset(0, h * 0.02);
  c.drawCircle(port, w * 0.2, Pk.fill(Pk.dark(a, 0.3)));
  c.drawCircle(port, w * 0.155, Pk.fill(b));
  for (var i = 0; i < 8; i++) {
    final ang = i * pi / 4;
    c.drawCircle(port + Offset(cos(ang), sin(ang)) * w * 0.2, w * 0.024, Pk.fill(Pk.light(a, 0.35)));
  }
  for (final s in [-1.0, 1.0]) {
    c.drawCircle(cc + Offset(s * w * 0.3, h * 0.04), w * 0.07, Pk.fill(Pk.dark(a, 0.2)));
  }
  c.drawLine(port + Offset(-w * 0.07, -h * 0.02), port + Offset(-w * 0.02, -h * 0.07), Pk.stroke(_white.withValues(alpha: 0.75), 2));
}

void _paintDiver(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final y = r.center.dy + sin(t * 1.2 + r.left) * h * 0.06;
  final kick = sin(t * 4 + r.left) * h * 0.1;
  for (final (dy, k) in [(-0.12, kick), (0.04, -kick)]) {
    c.drawLine(Offset(r.left + w * 0.26, y + h * dy), Offset(r.left + w * 0.1, y + h * dy + k), Pk.stroke(_ink, h * 0.12));
    Pk.poly(c, [
      Offset(r.left + w * 0.11, y + h * dy + k - h * 0.07),
      Offset(r.left, y + h * dy + k - h * 0.15),
      Offset(r.left, y + h * dy + k + h * 0.12),
      Offset(r.left + w * 0.11, y + h * dy + k + h * 0.06),
    ], Pk.fill(a));
  }
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.3, y - h * 0.38, w * 0.36, h * 0.17), b, radius: 3);
  c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(r.left + w * 0.2, y - h * 0.22, w * 0.58, h * 0.3), Radius.circular(h * 0.15)), Pk.fill(_ink));
  c.drawRect(Rect.fromLTWH(r.left + w * 0.24, y - h * 0.11, w * 0.5, h * 0.06), Pk.fill(a));
  c.drawLine(Offset(r.left + w * 0.6, y - h * 0.04), Offset(r.left + w * 0.86, y + h * 0.14), Pk.stroke(_ink, h * 0.1));
  c.drawCircle(Offset(r.left + w * 0.84, y - h * 0.12), h * 0.16, Pk.fill(_ink));
  c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(r.left + w * 0.84, y - h * 0.22, w * 0.12, h * 0.14), const Radius.circular(3)), Pk.fill(_sky));
  for (var i = 0; i < 3; i++) {
    final k = (t * 0.7 + i / 3) % 1;
    c.drawCircle(Offset(r.left + w * 0.92 + sin(k * 6) * 2, y - h * 0.3 - k * h * 0.15), 1.2 + k * 1.5, Pk.stroke(_white.withValues(alpha: 0.7 * (1 - k)), 1));
  }
}

void _paintPorthole(Canvas c, Rect r, Color a, Color b, double t) {
  final cc = r.center;
  final rad = min(r.width, r.height) / 2;
  c.drawCircle(cc, rad, Pk.fill(a));
  c.drawCircle(cc, rad * 0.8, Pk.fill(Pk.dark(b, 0.4)));
  Pk.glow(c, cc, rad * 0.8, b, 0.6);
  _jellyMini(c, cc + Offset(0, sin(t * 1.5 + r.left) * rad * 0.1 - rad * 0.15), rad * 0.32, b, t);
  for (var i = 0; i < 8; i++) {
    final ang = i * pi / 4;
    c.drawCircle(cc + Offset(cos(ang), sin(ang)) * rad * 0.9, rad * 0.05, Pk.fill(Pk.light(a, 0.35)));
  }
  c.drawArc(Rect.fromCircle(center: cc, radius: rad * 0.62), pi * 1.1, pi * 0.4, false, Pk.stroke(_white.withValues(alpha: 0.6), 2));
}

void _paintColumnTank(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final glass = Rect.fromLTWH(r.left, r.top + h * 0.07, w, h * 0.83);
  Pk.gradientRect(c, glass, Pk.dark(b, 0.45), Pk.dark(b, 0.7));
  Pk.glow(c, glass.center, w * 0.9, b, 0.4);
  for (var i = 0; i < 3; i++) {
    final y = glass.top + glass.height * (0.18 + i * 0.27) + sin(t * 1.3 + i * 2) * h * 0.03;
    _jellyMini(c, Offset(glass.left + w * (0.32 + (i % 2) * 0.36), y), w * 0.17, i == 1 ? _pink : b, t);
  }
  for (var i = 0; i < 4; i++) {
    final k = (t * 0.3 + i / 4) % 1;
    c.drawCircle(Offset(glass.left + w * 0.2 + i * w * 0.18, glass.bottom - k * glass.height), 1.4, Pk.fill(_white.withValues(alpha: 0.5 * (1 - k))));
  }
  c.drawLine(glass.topLeft + Offset(w * 0.15, h * 0.04), glass.bottomLeft + Offset(w * 0.15, -h * 0.04), Pk.stroke(_white.withValues(alpha: 0.3), 2));
  Pk.box(c, Rect.fromLTWH(r.left - 3, r.bottom - h * 0.1, w + 6, h * 0.1), a, radius: 3);
  Pk.box(c, Rect.fromLTWH(r.left - 3, r.top, w + 6, h * 0.07), a, radius: 3);
}

// ------------------------------------------------------------------ funfair
void _paintCarousel(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawOval(Rect.fromLTWH(r.left, r.bottom - h * 0.15, w, h * 0.15), Pk.fill(Pk.dark(a, 0.35)));
  c.drawOval(Rect.fromLTWH(r.left, r.bottom - h * 0.2, w, h * 0.13), Pk.fill(_cream));
  for (var i = 0; i < 5; i++) {
    final x = r.left + w * (0.18 + i * 0.16);
    c.drawLine(Offset(x, r.top + h * 0.28), Offset(x, r.bottom - h * 0.16), Pk.stroke(Pk.alpha(_brass, 0.7), 1.6));
  }
  Pk.box(c, Rect.fromLTWH(r.center.dx - w * 0.09, r.top + h * 0.26, w * 0.18, h * 0.6), b, radius: 3);
  for (var i = 0; i < 3; i++) {
    c.drawCircle(Offset(r.center.dx, r.top + h * (0.38 + i * 0.14)), w * 0.025, Pk.fill(_lampGlow));
  }
  final canopy = Rect.fromLTWH(r.left - w * 0.04, r.top + h * 0.06, w * 1.08, h * 0.24);
  const n = 8;
  for (var i = 0; i < n; i++) {
    final x0 = canopy.left + canopy.width * i / n, x1 = canopy.left + canopy.width * (i + 1) / n;
    Pk.poly(c, [Offset(r.center.dx, r.top), Offset(x0, canopy.bottom - h * 0.05), Offset(x1, canopy.bottom - h * 0.05)], Pk.fill(i.isEven ? a : _white));
  }
  c.drawRect(Rect.fromLTWH(canopy.left, canopy.bottom - h * 0.06, canopy.width, h * 0.04), Pk.fill(b));
  for (var i = 0; i < n; i++) {
    final cx = canopy.left + canopy.width * (i + 0.5) / n;
    c.drawArc(Rect.fromCenter(center: Offset(cx, canopy.bottom - h * 0.02), width: canopy.width / n, height: h * 0.08), 0, pi, true, Pk.fill(i.isEven ? _white : a));
  }
  for (var i = 0; i <= n; i++) {
    final on = (i + (t * 4).floor()) % 2 == 0;
    c.drawCircle(Offset(canopy.left + canopy.width * i / n, canopy.bottom - h * 0.04), 1.8, Pk.fill(on ? _lampGlow : Pk.dark(_lampGlow, 0.3)));
  }
  c.drawLine(Offset(r.center.dx, r.top), Offset(r.center.dx, r.top - h * 0.06), Pk.stroke(_ink, 1));
  Pk.poly(c, [Offset(r.center.dx, r.top - h * 0.06), Offset(r.center.dx + w * 0.07, r.top - h * 0.04), Offset(r.center.dx, r.top - h * 0.02)], Pk.fill(b));
  c.drawCircle(Offset(r.center.dx, r.top), w * 0.025, Pk.fill(_gold));
}

void _paintPoleHorse(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawLine(Offset(r.center.dx, r.top), Offset(r.center.dx, r.bottom), Pk.stroke(_brass, 2.2));
  final up = sin(t * 2 + r.left * 0.1) * h * 0.05;
  _horse(c, Rect.fromLTWH(r.left, r.top + h * 0.42 + up, w, h * 0.34), a, b);
}

void _paintFerris(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final rad = min(w * 0.46, h * 0.42);
  final hub = Offset(r.center.dx, r.top + rad + 3);
  final leg = Pk.stroke(Pk.dark(a, 0.2), 3.5);
  for (final s in [-1.0, 1.0]) {
    c.drawLine(hub, Offset(hub.dx + s * w * 0.3, r.bottom), leg);
  }
  c.drawLine(Offset(hub.dx - w * 0.2, r.bottom - h * 0.22), Offset(hub.dx + w * 0.2, r.bottom - h * 0.22), Pk.stroke(Pk.dark(a, 0.2), 2));
  final rot = t * 0.25;
  c.drawCircle(hub, rad, Pk.stroke(a, 3));
  c.drawCircle(hub, rad * 0.8, Pk.stroke(a, 1.5));
  const n = 8;
  for (var i = 0; i < n; i++) {
    final ang = rot + i * 2 * pi / n;
    c.drawLine(hub, hub + Offset(cos(ang), sin(ang)) * rad, Pk.stroke(a, 1.4));
  }
  for (var i = 0; i < 16; i++) {
    final ang = rot + i * pi / 8;
    final on = (i + (t * 3).floor()) % 3 != 0;
    c.drawCircle(hub + Offset(cos(ang), sin(ang)) * rad, 1.6, Pk.fill(on ? _lampGlow : Pk.dark(_lampGlow, 0.35)));
  }
  for (var i = 0; i < n; i++) {
    final ang = rot + i * 2 * pi / n;
    final p = hub + Offset(cos(ang), sin(ang)) * rad;
    c.drawLine(p, p + Offset(0, rad * 0.1), Pk.stroke(_ink, 1));
    final cab = Rect.fromCenter(center: p + Offset(0, rad * 0.19), width: rad * 0.28, height: rad * 0.2);
    c.drawRRect(
      RRect.fromRectAndCorners(cab, bottomLeft: Radius.circular(rad * 0.1), bottomRight: Radius.circular(rad * 0.1), topLeft: Radius.circular(rad * 0.04), topRight: Radius.circular(rad * 0.04)),
      Pk.fill([b, _sky, _gold, _pink][i % 4]),
    );
    c.drawRect(Rect.fromLTWH(cab.left, cab.top - rad * 0.03, cab.width, rad * 0.04), Pk.fill(Pk.dark(a, 0.1)));
  }
  c.drawCircle(hub, rad * 0.1, Pk.fill(b));
  Pk.box(c, Rect.fromLTWH(hub.dx - w * 0.13, r.bottom - h * 0.12, w * 0.26, h * 0.12), Pk.dark(a, 0.05), radius: 2);
}

void _paintStall(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (final x in [0.03, 0.91]) {
    c.drawRect(Rect.fromLTWH(r.left + w * x, r.top + h * 0.2, w * 0.06, h * 0.8), Pk.fill(_white));
  }
  c.drawRect(Rect.fromLTWH(r.left + w * 0.08, r.top + h * 0.24, w * 0.84, h * 0.42), Pk.fill(Pk.light(b, 0.55)));
  for (var i = 0; i < 4; i++) {
    final col = [_pink, _sky, _gold, _leaf][i];
    final p = Offset(r.left + w * (0.2 + i * 0.2), r.top + h * 0.44 + (i.isEven ? 0 : -h * 0.06));
    c.drawCircle(p, w * 0.06, Pk.fill(col));
    c.drawCircle(p + Offset(-w * 0.045, -w * 0.05), w * 0.022, Pk.fill(col));
    c.drawCircle(p + Offset(w * 0.045, -w * 0.05), w * 0.022, Pk.fill(col));
    c.drawCircle(p + Offset(0, w * 0.015), w * 0.02, Pk.fill(_ink));
  }
  Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.62, w, h * 0.38), b, radius: 3);
  for (var i = 0; i < 4; i++) {
    c.drawRect(Rect.fromLTWH(r.left + w * (0.06 + i * 0.24), r.top + h * 0.72, w * 0.16, h * 0.22), Pk.fill(Pk.light(b, 0.18)));
  }
  const n = 6;
  final aw = w * 1.06 / n;
  for (var i = 0; i < n; i++) {
    final x = r.left - w * 0.03 + aw * i;
    c.drawRect(Rect.fromLTWH(x, r.top, aw, h * 0.18), Pk.fill(i.isEven ? a : _white));
    c.drawArc(Rect.fromLTWH(x, r.top + h * 0.12, aw, h * 0.12), 0, pi, true, Pk.fill(i.isEven ? a : _white));
  }
}

void _paintBalloons(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final base = Offset(r.center.dx, r.bottom);
  final cols = [a, b, _sky, _gold, _leaf];
  for (var i = 0; i < 5; i++) {
    final sway = sin(t * 1.3 + i) * w * 0.04;
    final p = Offset(r.left + w * (i < 3 ? 0.2 + i * 0.3 : 0.35 + (i - 3) * 0.3) + sway, r.top + h * (i < 3 ? 0.16 : 0.34));
    c.drawLine(base, p + Offset(0, w * 0.17), Pk.stroke(_ink.withValues(alpha: 0.55), 0.8));
    c.drawOval(Rect.fromCenter(center: p, width: w * 0.32, height: w * 0.38), Pk.fill(cols[i]));
    c.drawCircle(p + Offset(-w * 0.05, -w * 0.08), w * 0.045, Pk.fill(_white.withValues(alpha: 0.7)));
  }
}

void _paintBunting(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final p = Path()
    ..moveTo(r.left, r.top)
    ..quadraticBezierTo(r.center.dx, r.top + h * 0.8, r.right, r.top);
  c.drawPath(p, Pk.stroke(_ink.withValues(alpha: 0.6), 1));
  final n = max(6, (w / 14).round());
  for (var i = 1; i < n; i++) {
    final k = i / n;
    final x = r.left + w * k;
    final y = r.top + h * 1.6 * k * (1 - k);
    final fw = w / n * 0.38;
    final sway = sin(t * 2 + i) * 1.5;
    Pk.poly(c, [Offset(x - fw, y), Offset(x + fw, y), Offset(x + sway, y + h * 0.45)], Pk.fill([a, b, _sky, _gold, _leaf][i % 5]));
  }
}

void _paintCoaster(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final base = r.top + h * 0.8;
  Offset at(double k) => Offset(r.left + w * k, base - h * (0.72 - 0.32 * k) * (0.5 - 0.5 * cos(k * 3 * pi)));
  final sup = Pk.stroke(Pk.dark(_steel, 0.25), 1.8);
  for (var i = 0; i <= 16; i++) {
    final p = at(i / 16);
    c.drawLine(p, Offset(p.dx, r.bottom), sup);
  }
  for (var i = 0; i < 16; i++) {
    final p = at(i / 16), q = at((i + 1) / 16);
    c.drawLine(Offset(p.dx, r.bottom), Offset(q.dx, (q.dy + r.bottom) / 2), Pk.stroke(Pk.dark(_steel, 0.25), 0.9));
    c.drawLine(Offset(q.dx, r.bottom), Offset(p.dx, (p.dy + r.bottom) / 2), Pk.stroke(Pk.dark(_steel, 0.25), 0.9));
  }
  final track = Path();
  for (var i = 0; i <= 80; i++) {
    final p = at(i / 80);
    if (i == 0) {
      track.moveTo(p.dx, p.dy);
    } else {
      track.lineTo(p.dx, p.dy);
    }
  }
  c.drawPath(track.shift(const Offset(0, 4)), Pk.stroke(Pk.dark(a, 0.3), 2));
  c.drawPath(track, Pk.stroke(a, 4));
  for (var car = 0; car < 3; car++) {
    final k = (t * 0.06 + car * 0.025) % 1;
    final p = at(k), q = at(min(1.0, k + 0.01));
    final ang = atan2(q.dy - p.dy, q.dx - p.dx);
    c.save();
    c.translate(p.dx, p.dy);
    c.rotate(ang);
    Pk.box(c, Rect.fromLTWH(-w * 0.025, -h * 0.09, w * 0.05, h * 0.08), car == 0 ? b : Pk.light(b, 0.15), radius: 3);
    c.drawCircle(Offset(0, -h * 0.11), h * 0.025, Pk.fill([_gold, _sky, _pink][car]));
    c.restore();
  }
}

void _paintPopcorn(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (final x in [0.25, 0.75]) {
    c.drawCircle(Offset(r.left + w * x, r.bottom - h * 0.08), h * 0.08, Pk.fill(_ink));
    c.drawCircle(Offset(r.left + w * x, r.bottom - h * 0.08), h * 0.03, Pk.fill(_steel));
  }
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.05, r.top + h * 0.55, w * 0.9, h * 0.33), a, radius: 3);
  c.drawRect(Rect.fromLTWH(r.left + w * 0.05, r.top + h * 0.62, w * 0.9, h * 0.05), Pk.fill(b));
  final glass = Rect.fromLTWH(r.left + w * 0.12, r.top + h * 0.2, w * 0.76, h * 0.35);
  c.drawRect(glass, Pk.fill(const Color(0xFFFFF6D8)));
  for (var i = 0; i < 16; i++) {
    c.drawCircle(Offset(glass.left + glass.width * Pk.rand(i), glass.bottom - glass.height * (0.1 + Pk.rand(i + 20) * 0.5)), w * 0.05, Pk.fill(i.isEven ? _cream : const Color(0xFFFFE08A)));
  }
  c.drawRect(glass, Pk.stroke(Pk.dark(a, 0.2), 1.5));
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.05, r.top + h * 0.08, w * 0.9, h * 0.13), a, radius: 3);
  Pk.poly(c, [Offset(r.left + w * 0.2, r.top + h * 0.08), Offset(r.center.dx, r.top), Offset(r.right - w * 0.2, r.top + h * 0.08)], Pk.fill(b));
}

void _paintIceCart(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (final x in [0.22, 0.78]) {
    c.drawCircle(Offset(r.left + w * x, r.bottom - h * 0.08), h * 0.08, Pk.fill(_ink));
    c.drawCircle(Offset(r.left + w * x, r.bottom - h * 0.08), h * 0.03, Pk.fill(_steel));
  }
  c.drawLine(Offset(r.center.dx, r.top + h * 0.12), Offset(r.center.dx, r.top + h * 0.5), Pk.stroke(_steel, 1.5));
  for (var i = 0; i < 3; i++) {
    c.drawCircle(Offset(r.left + w * (0.28 + i * 0.22), r.top + h * 0.5), w * 0.085, Pk.fill([_pink, _cream, _brown][i]));
  }
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.04, r.top + h * 0.52, w * 0.92, h * 0.36), a, radius: 4);
  c.drawRect(Rect.fromLTWH(r.left + w * 0.04, r.top + h * 0.62, w * 0.92, h * 0.05), Pk.fill(b));
  final canopy = Path()
    ..moveTo(r.left, r.top + h * 0.2)
    ..quadraticBezierTo(r.center.dx, r.top - h * 0.12, r.right, r.top + h * 0.2)
    ..close();
  c.drawPath(canopy, Pk.fill(b));
  for (var i = 0; i < 4; i++) {
    c.drawArc(Rect.fromLTWH(r.left + w * i / 4, r.top + h * 0.15, w / 4, h * 0.1), 0, pi, true, Pk.fill(i.isOdd ? b : _white));
  }
}

void _paintTeddy(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final body = Pk.fill(a);
  c.drawOval(Rect.fromLTWH(r.left + w * 0.2, r.top + h * 0.42, w * 0.6, h * 0.5), body);
  for (final s in [-1.0, 1.0]) {
    c.drawOval(Rect.fromCenter(center: Offset(r.center.dx + s * w * 0.32, r.top + h * 0.6), width: w * 0.2, height: h * 0.3), body);
    c.drawOval(Rect.fromCenter(center: Offset(r.center.dx + s * w * 0.2, r.bottom - h * 0.07), width: w * 0.28, height: h * 0.16), body);
    c.drawCircle(Offset(r.center.dx + s * w * 0.22, r.top + h * 0.1), w * 0.12, body);
    c.drawCircle(Offset(r.center.dx + s * w * 0.22, r.top + h * 0.1), w * 0.06, Pk.fill(Pk.light(a, 0.3)));
  }
  c.drawCircle(Offset(r.center.dx, r.top + h * 0.27), w * 0.28, body);
  c.drawOval(Rect.fromCenter(center: Offset(r.center.dx, r.top + h * 0.33), width: w * 0.24, height: h * 0.12), Pk.fill(Pk.light(a, 0.35)));
  c.drawCircle(Offset(r.center.dx, r.top + h * 0.31), w * 0.045, Pk.fill(_ink));
  for (final s in [-1.0, 1.0]) {
    c.drawCircle(Offset(r.center.dx + s * w * 0.1, r.top + h * 0.23), w * 0.032, Pk.fill(_ink));
    Pk.poly(c, [Offset(r.center.dx, r.top + h * 0.47), Offset(r.center.dx + s * w * 0.15, r.top + h * 0.42), Offset(r.center.dx + s * w * 0.15, r.top + h * 0.53)], Pk.fill(b));
  }
  c.drawOval(Rect.fromCenter(center: Offset(r.center.dx, r.top + h * 0.68), width: w * 0.3, height: h * 0.22), Pk.fill(Pk.light(a, 0.25)));
}

void _paintStriker(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final tower = Rect.fromLTWH(r.center.dx - w * 0.2, r.top + h * 0.12, w * 0.4, h * 0.8);
  Pk.box(c, tower, a, radius: 3);
  for (var i = 0; i < 6; i++) {
    c.drawRect(Rect.fromLTWH(tower.left + 3, tower.top + tower.height * (0.06 + i * 0.15), tower.width - 6, tower.height * 0.07), Pk.fill(Pk.hue(i * 26.0, 0.75)));
  }
  final k = (sin(t * 1.5) + 1) / 2;
  c.drawCircle(Offset(tower.center.dx, tower.bottom - 4 - k * tower.height * 0.85), w * 0.09, Pk.fill(_steel));
  Pk.glow(c, Offset(r.center.dx, r.top + h * 0.07), w * 0.6, b, 0.15 + 0.35 * k);
  c.drawArc(Rect.fromCenter(center: Offset(r.center.dx, r.top + h * 0.12), width: w * 0.5, height: h * 0.18), pi, pi, true, Pk.fill(b));
  Pk.box(c, Rect.fromLTWH(r.left, r.bottom - h * 0.08, w, h * 0.08), Pk.dark(a, 0.25), radius: 2);
  c.drawLine(Offset(r.right - w * 0.1, r.bottom - h * 0.08), Offset(r.right - w * 0.3, r.bottom - h * 0.3), Pk.stroke(_darkWood, 2.5));
  Pk.box(c, Rect.fromLTWH(r.right - w * 0.42, r.bottom - h * 0.36, w * 0.24, h * 0.08), _darkWood, radius: 2);
}

void _paintFairArch(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (final x in [r.left, r.right - w * 0.12]) {
    final pr = Rect.fromLTWH(x, r.top + h * 0.28, w * 0.12, h * 0.72);
    Pk.box(c, pr, _white, radius: 3);
    c.save();
    c.clipRect(pr);
    for (var i = 0; i < 9; i++) {
      final y = pr.top + i * pr.height / 6;
      c.drawLine(Offset(pr.left, y), Offset(pr.right, y - pr.width), Pk.stroke(a, pr.width * 0.28));
    }
    c.restore();
    c.drawCircle(Offset(x + w * 0.06, r.top + h * 0.26), w * 0.075, Pk.fill(b));
  }
  final arcR = Rect.fromLTWH(r.left + w * 0.04, r.top + h * 0.08, w * 0.92, h * 0.6);
  c.drawArc(arcR, pi, pi, false, Pk.stroke(Pk.dark(a, 0.25), h * 0.16));
  c.drawArc(arcR, pi, pi, false, Pk.stroke(a, h * 0.115));
  for (var i = 0; i <= 14; i++) {
    final ang = pi + pi * i / 14;
    final p = arcR.center + Offset(cos(ang) * arcR.width / 2, sin(ang) * arcR.height / 2);
    final on = (i + (t * 5).floor()) % 3 != 0;
    if (on) Pk.glow(c, p, h * 0.06, _lampGlow, 0.6);
    c.drawCircle(p, h * 0.022, Pk.fill(on ? _lampGlow : Pk.dark(_lampGlow, 0.35)));
  }
  Pk.glow(c, Offset(r.center.dx, r.top + h * 0.06), h * 0.14, b, 0.5);
  _star(c, Offset(r.center.dx, r.top + h * 0.07), h * 0.08, b);
}

void _paintOrgan(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawArc(Rect.fromLTWH(r.left + w * 0.1, r.top, w * 0.8, h * 0.5), pi, pi, true, Pk.fill(b));
  c.drawCircle(Offset(r.center.dx, r.top + h * 0.14), w * 0.06, Pk.fill(_gold));
  Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.25, w, h * 0.75), a, radius: 4);
  for (var i = 0; i < 7; i++) {
    final ph = h * (0.18 + (3 - (i - 3).abs()) * 0.05);
    c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(r.left + w * (0.12 + i * 0.11), r.top + h * 0.6 - ph, w * 0.08, ph), const Radius.circular(3)), Pk.fill(_gold));
  }
  c.drawCircle(Offset(r.center.dx, r.top + h * 0.78), h * 0.12, Pk.fill(_red));
  c.drawCircle(Offset(r.center.dx, r.top + h * 0.78), h * 0.08, Pk.fill(_cream));
  for (var i = 0; i < 2; i++) {
    final k = (t * 0.5 + i * 0.5) % 1;
    final p = Offset(r.right - w * 0.1 + k * w * 0.16, r.top + h * 0.3 - k * h * 0.25);
    c.drawCircle(p, 2.2, Pk.fill(_ink.withValues(alpha: 1 - k)));
    c.drawLine(p + const Offset(2, 0), p + const Offset(2, -7), Pk.stroke(_ink.withValues(alpha: 1 - k), 1));
  }
}

// ------------------------------------------------------------------ bookshop
void _paintBookStack(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  const n = 5;
  final cols = [a, b, _blue, _gold, _leaf, _purple];
  for (var i = 0; i < n; i++) {
    final bh = h / n;
    final off = (Pk.rand(i + r.left.toInt()) - 0.5) * w * 0.16;
    final br = Rect.fromLTWH(r.left + w * 0.08 + off, r.bottom - bh * (i + 1), w * 0.84, bh - 0.8);
    Pk.box(c, br, cols[i % cols.length], radius: 1.5);
    c.drawRect(Rect.fromLTWH(br.right - w * 0.12, br.top + 1, w * 0.06, br.height - 2), Pk.fill(_cream));
    c.drawLine(Offset(br.left + w * 0.12, br.center.dy), Offset(br.left + w * 0.4, br.center.dy), Pk.stroke(_gold, 1));
  }
}

void _paintShopWindow(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, r.inflate(4), a, radius: 3);
  Pk.gradientRect(c, r, const Color(0xFFFFF4D6), const Color(0xFFF2D7A8));
  Pk.glow(c, r.center, w * 0.6, _lampGlow, 0.4);
  for (var s = 0; s < 2; s++) {
    final y = r.top + h * (0.46 + s * 0.44);
    c.drawRect(Rect.fromLTWH(r.left, y, w, 2.5), Pk.fill(Pk.dark(a, 0.1)));
    for (var i = 0; i < 9; i++) {
      final x = r.left + w * 0.05 + i * w * 0.1;
      if (i == 4 && s == 0) {
        Pk.box(c, Rect.fromLTWH(x - w * 0.04, y - h * 0.34, w * 0.16, h * 0.34), b, radius: 1);
        c.drawCircle(Offset(x + w * 0.04, y - h * 0.2), w * 0.03, Pk.fill(_gold));
        continue;
      }
      final bh = h * (0.22 + Pk.rand(s * 11 + i) * 0.12);
      c.drawRect(Rect.fromLTWH(x, y - bh, w * 0.08, bh), Pk.fill([b, _blue, _gold, _leaf, _red, _purple][(i + s * 2) % 6]));
    }
  }
  c.drawLine(r.topCenter, Offset(r.center.dx, r.top + h * 0.12), Pk.stroke(a, 2));
  c.drawLine(r.topLeft + Offset(w * 0.06, h * 0.32), r.topLeft + Offset(w * 0.18, h * 0.06), Pk.stroke(_white.withValues(alpha: 0.6), 2));
}

void _paintLadder(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (var i = 1; i < 8; i++) {
    final k = i / 8;
    c.drawLine(Offset(r.left + w * 0.35 * (1 - k), r.top + h * k), Offset(r.right - w * 0.35 * k, r.top + h * k), Pk.stroke(Pk.dark(a, 0.15), w * 0.07));
  }
  final p = Pk.stroke(a, w * 0.11);
  c.drawLine(Offset(r.left + w * 0.35, r.top), Offset(r.left, r.bottom), p);
  c.drawLine(Offset(r.right, r.top), Offset(r.right - w * 0.35, r.bottom), p);
  c.drawLine(Offset(r.left + w * 0.3, r.top + 1), Offset(r.right + w * 0.05, r.top + 1), Pk.stroke(b, 2.5));
}

void _paintGlobe(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final rad = min(w * 0.42, h * 0.34);
  final cc = Offset(r.center.dx, r.top + rad + 3);
  Pk.poly(c, [Offset(r.center.dx - w * 0.06, r.top + h * 0.8), Offset(r.center.dx + w * 0.06, r.top + h * 0.8), Offset(r.center.dx + w * 0.3, r.bottom), Offset(r.center.dx - w * 0.3, r.bottom)], Pk.fill(b));
  c.drawLine(Offset(r.center.dx, cc.dy + rad), Offset(r.center.dx, r.top + h * 0.82), Pk.stroke(b, 3));
  c.drawCircle(cc, rad, Pk.fill(a));
  c.save();
  c.clipPath(Path()..addOval(Rect.fromCircle(center: cc, radius: rad)));
  for (var i = 0; i < 3; i++) {
    final x = cc.dx - rad * 2 + ((i * rad * 1.4 + t * 6) % (rad * 4));
    c.drawOval(Rect.fromCenter(center: Offset(x, cc.dy + (i - 1) * rad * 0.45), width: rad * 0.9, height: rad * 0.6), Pk.fill(_leaf));
  }
  c.drawCircle(cc + Offset(rad * 0.45, rad * 0.35), rad, Pk.fill(Colors.black.withValues(alpha: 0.1)));
  c.restore();
  c.drawArc(Rect.fromCircle(center: cc, radius: rad + 3), -pi * 0.85, pi * 1.7, false, Pk.stroke(b, 2));
  c.drawCircle(cc + Offset(-rad * 0.35, -rad * 0.35), rad * 0.18, Pk.fill(_white.withValues(alpha: 0.45)));
}

void _paintArmchair(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (final x in [0.1, 0.84]) {
    c.drawRect(Rect.fromLTWH(r.left + w * x, r.bottom - h * 0.12, w * 0.06, h * 0.12), Pk.fill(_darkWood));
  }
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.12, r.top, w * 0.76, h * 0.7), a, radius: w * 0.2);
  for (var i = 0; i < 3; i++) {
    c.drawCircle(Offset(r.left + w * (0.35 + i * 0.15), r.top + h * 0.22), 1.4, Pk.fill(Pk.dark(a, 0.3)));
  }
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.18, r.top + h * 0.56, w * 0.64, h * 0.3), Pk.light(a, 0.1), radius: 4);
  Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.36, w * 0.22, h * 0.54), Pk.dark(a, 0.06), radius: w * 0.1);
  Pk.box(c, Rect.fromLTWH(r.right - w * 0.22, r.top + h * 0.36, w * 0.22, h * 0.54), Pk.dark(a, 0.06), radius: w * 0.1);
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.3, r.top + h * 0.38, w * 0.26, h * 0.2), b, radius: 3);
}

void _paintEspresso(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (var i = 0; i < 3; i++) {
    Pk.box(c, Rect.fromLTWH(r.left + w * (0.14 + i * 0.26), r.top, w * 0.16, h * 0.11), _white, radius: 2);
  }
  Pk.box(c, Rect.fromLTWH(r.left, r.top + h * 0.2, w, h * 0.8), a, radius: 4);
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.06, r.top + h * 0.1, w * 0.88, h * 0.14), Pk.dark(a, 0.15), radius: 3);
  c.drawCircle(Offset(r.center.dx, r.top + h * 0.36), w * 0.09, Pk.fill(_cream));
  c.drawLine(Offset(r.center.dx, r.top + h * 0.36), Offset(r.center.dx + w * 0.05, r.top + h * 0.32), Pk.stroke(_red, 1.2));
  for (final x in [0.28, 0.72]) {
    c.drawRect(Rect.fromLTWH(r.left + w * x - w * 0.08, r.top + h * 0.5, w * 0.16, h * 0.08), Pk.fill(_ink));
    Pk.box(c, Rect.fromLTWH(r.left + w * x - w * 0.07, r.top + h * 0.72, w * 0.14, h * 0.12), b, radius: 2);
    final k = (t * 0.6 + x) % 1;
    c.drawCircle(Offset(r.left + w * x + sin(k * 6) * 2, r.top + h * 0.68 - k * h * 0.12), 1.4 + k * 1.6, Pk.fill(_white.withValues(alpha: 0.55 * (1 - k))));
  }
  c.drawRect(Rect.fromLTWH(r.left + w * 0.05, r.bottom - h * 0.1, w * 0.9, h * 0.05), Pk.fill(_steel));
}

void _paintCakeStand(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawRect(Rect.fromLTWH(r.center.dx - w * 0.04, r.top + h * 0.7, w * 0.08, h * 0.24), Pk.fill(_steel));
  c.drawOval(Rect.fromLTWH(r.left + w * 0.25, r.bottom - h * 0.08, w * 0.5, h * 0.08), Pk.fill(_steel));
  c.drawOval(Rect.fromLTWH(r.left, r.top + h * 0.64, w, h * 0.1), Pk.fill(_white));
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.14, r.top + h * 0.32, w * 0.72, h * 0.36), a, radius: 4);
  c.drawRect(Rect.fromLTWH(r.left + w * 0.14, r.top + h * 0.46, w * 0.72, h * 0.05), Pk.fill(_cream));
  for (var i = 0; i < 4; i++) {
    c.drawCircle(Offset(r.left + w * (0.24 + i * 0.17), r.top + h * 0.32), w * 0.06, Pk.fill(_white));
  }
  c.drawCircle(Offset(r.center.dx, r.top + h * 0.24), w * 0.07, Pk.fill(b));
  c.drawArc(Rect.fromLTWH(r.left + w * 0.04, r.top, w * 0.92, h * 1.3), pi, pi, false, Pk.stroke(_white.withValues(alpha: 0.65), 1.5));
}

void _paintBlocks(Canvas c, Rect r, Color a, Color b, double t) {
  final s = min(r.width / 2.1, r.height / 2);
  final cols = [a, b, _sky];
  final pos = [Offset(r.left, r.bottom - s), Offset(r.left + s * 1.05, r.bottom - s), Offset(r.left + s * 0.52, r.bottom - s * 2)];
  for (var i = 0; i < 3; i++) {
    final br = Rect.fromLTWH(pos[i].dx, pos[i].dy, s, s);
    Pk.box(c, br, cols[i], radius: 2);
    c.drawRect(br.deflate(s * 0.18), Pk.stroke(_white.withValues(alpha: 0.75), 1.5));
    if (i == 1) {
      _star(c, br.center, s * 0.22, _white);
    } else {
      c.drawCircle(br.center, s * 0.14, Pk.fill(_white));
    }
  }
}

void _paintRareCase(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.05, r.top + h * 0.5, w * 0.9, h * 0.5), a, radius: 3);
  c.drawRect(Rect.fromLTWH(r.left + w * 0.14, r.top + h * 0.62, w * 0.72, h * 0.26), Pk.fill(Pk.dark(a, 0.15)));
  c.drawRect(Rect.fromLTWH(r.left + w * 0.05, r.top + h * 0.42, w * 0.9, h * 0.1), Pk.fill(_red));
  for (final s in [-1.0, 1.0]) {
    final page = Path()
      ..moveTo(r.center.dx, r.top + h * 0.46)
      ..lineTo(r.center.dx + s * w * 0.28, r.top + h * 0.44)
      ..lineTo(r.center.dx + s * w * 0.26, r.top + h * 0.3)
      ..quadraticBezierTo(r.center.dx + s * w * 0.12, r.top + h * 0.26, r.center.dx, r.top + h * 0.32)
      ..close();
    c.drawPath(page, Pk.fill(s < 0 ? _cream : Pk.dark(_cream, 0.05)));
    for (var i = 0; i < 3; i++) {
      final y = r.top + h * (0.34 + i * 0.03);
      c.drawLine(Offset(r.center.dx + s * w * 0.05, y), Offset(r.center.dx + s * w * 0.21, y), Pk.stroke(_grey, 0.8));
    }
  }
  final glass = Rect.fromLTWH(r.left + w * 0.05, r.top, w * 0.9, h * 0.44);
  c.drawRect(glass, _glass(0.18));
  Pk.glow(c, glass.center, w * 0.4, _lampGlow, 0.3);
  c.drawRect(glass, Pk.stroke(b, 2));
  c.drawLine(glass.topLeft + Offset(w * 0.08, h * 0.32), glass.topLeft + Offset(w * 0.2, h * 0.06), Pk.stroke(_white.withValues(alpha: 0.6), 2));
}

void _paintDeskLamp(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.glow(c, Offset(r.center.dx, r.top + h * 0.5), w * 1.3, _lampGlow, 0.5);
  c.drawOval(Rect.fromLTWH(r.left + w * 0.15, r.bottom - h * 0.12, w * 0.7, h * 0.12), Pk.fill(b));
  c.drawRect(Rect.fromLTWH(r.center.dx - w * 0.04, r.top + h * 0.4, w * 0.08, h * 0.52), Pk.fill(b));
  final shade = Path()
    ..moveTo(r.left, r.top + h * 0.42)
    ..quadraticBezierTo(r.center.dx, r.top - h * 0.05, r.right, r.top + h * 0.42)
    ..close();
  c.drawPath(shade, Pk.fill(a));
  c.drawRect(Rect.fromLTWH(r.left + w * 0.05, r.top + h * 0.4, w * 0.9, h * 0.05), Pk.fill(_lampGlow));
}

void _paintBookCart(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawRect(Rect.fromLTWH(r.left, r.top + h * 0.1, w * 0.04, h * 0.8), Pk.fill(Pk.dark(a, 0.2)));
  c.drawRect(Rect.fromLTWH(r.right - w * 0.04, r.top + h * 0.1, w * 0.04, h * 0.8), Pk.fill(Pk.dark(a, 0.2)));
  for (var s = 0; s < 2; s++) {
    final y = r.top + h * (0.42 + s * 0.38);
    for (var i = 0; i < 7; i++) {
      final bh = h * (0.24 + Pk.rand(s * 7 + i) * 0.1);
      c.drawRect(Rect.fromLTWH(r.left + w * (0.06 + i * 0.125), y - bh, w * 0.105, bh), Pk.fill([b, _blue, _gold, _leaf, _red, _purple, _orange][(i + s * 3) % 7]));
    }
    Pk.box(c, Rect.fromLTWH(r.left, y, w, h * 0.07), a, radius: 2);
  }
  for (final x in [0.15, 0.85]) {
    c.drawCircle(Offset(r.left + w * x, r.bottom - h * 0.06), h * 0.06, Pk.fill(_ink));
  }
  c.drawLine(Offset(r.right - w * 0.02, r.top + h * 0.1), Offset(r.right + w * 0.06, r.top), Pk.stroke(_steel, 2));
}

void _paintHangSign(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawLine(Offset(r.left, r.top + 2), Offset(r.right, r.top + 2), Pk.stroke(_ink, 2.5));
  c.drawLine(Offset(r.left + 2, r.top), Offset(r.left + 2, r.top + h * 0.3), Pk.stroke(_ink, 2.5));
  c.save();
  c.translate(r.center.dx + w * 0.08, r.top + 2);
  c.rotate(sin(t * 1.2 + r.left) * 0.05);
  for (final dx in [-0.25, 0.25]) {
    c.drawLine(Offset(w * dx, 0), Offset(w * dx, h * 0.25), Pk.stroke(_ink, 1));
  }
  final board = Rect.fromLTWH(-w * 0.38, h * 0.25, w * 0.76, h * 0.7);
  Pk.box(c, board, a, radius: 4, outline: Pk.dark(a, 0.3));
  final bc = board.center;
  for (final s in [-1.0, 1.0]) {
    Pk.poly(c, [
      bc + Offset(s * board.width * 0.3, -board.height * 0.2),
      bc + Offset(0, -board.height * 0.1),
      bc + Offset(0, board.height * 0.25),
      bc + Offset(s * board.width * 0.3, board.height * 0.15),
    ], Pk.fill(s < 0 ? b : Pk.light(b, 0.25)));
  }
  c.restore();
}

void _paintBeanbag(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final p = Path()
    ..moveTo(r.left, r.bottom)
    ..quadraticBezierTo(r.left - w * 0.05, r.top + h * 0.3, r.left + w * 0.38, r.top)
    ..quadraticBezierTo(r.right + w * 0.02, r.top + h * 0.05, r.right, r.bottom)
    ..close();
  c.drawPath(p, Pk.fill(a));
  c.drawOval(Rect.fromLTWH(r.left + w * 0.2, r.top + h * 0.4, w * 0.6, h * 0.3), Pk.fill(Pk.dark(a, 0.12)));
  c.drawLine(Offset(r.left + w * 0.24, r.top + h * 0.2), Offset(r.left + w * 0.46, r.top + h * 0.08), Pk.stroke(Pk.light(a, 0.3), 2));
  c.drawCircle(Offset(r.left + w * 0.72, r.top + h * 0.28), w * 0.05, Pk.fill(b));
}

void _paintRainbow(Canvas c, Rect r, Color a, Color b, double t) {
  final cols = [_red, _orange, _gold, _leaf, _blue, _purple];
  final th = r.height * 0.11;
  for (var i = 0; i < 6; i++) {
    final inset = th / 2 + i * th;
    final rr = Rect.fromLTRB(r.left + inset, r.top + inset, r.right - inset, r.bottom + (r.bottom - r.top) - inset);
    c.drawArc(rr, pi, pi, false, Pk.stroke(cols[i], th));
  }
  final s = r.width / 150;
  Pk.cloud(c, Offset(r.left + 8 * s, r.bottom - 6 * s), s, a);
  Pk.cloud(c, Offset(r.right - 36 * s, r.bottom - 6 * s), s, a);
}

void _paintScrolls(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (var i = 0; i < 4; i++) {
    c.save();
    c.translate(r.left + w * (0.25 + i * 0.17), r.top + h * 0.55);
    c.rotate((i - 1.5) * 0.18);
    Pk.box(c, Rect.fromLTWH(-w * 0.07, -h * 0.52, w * 0.14, h * 0.6), _cream, radius: w * 0.07);
    c.drawCircle(Offset(0, -h * 0.5), w * 0.055, Pk.fill(Pk.dark(_cream, 0.18)));
    c.drawRect(Rect.fromLTWH(-w * 0.07, -h * 0.24, w * 0.14, h * 0.04), Pk.fill(b));
    c.restore();
  }
  final urn = Path()
    ..moveTo(r.left + w * 0.14, r.top + h * 0.45)
    ..lineTo(r.right - w * 0.14, r.top + h * 0.45)
    ..quadraticBezierTo(r.right, r.top + h * 0.7, r.right - w * 0.24, r.bottom)
    ..lineTo(r.left + w * 0.24, r.bottom)
    ..quadraticBezierTo(r.left, r.top + h * 0.7, r.left + w * 0.14, r.top + h * 0.45)
    ..close();
  c.drawPath(urn, Pk.fill(a));
  c.drawRect(Rect.fromLTWH(r.left + w * 0.1, r.top + h * 0.42, w * 0.8, h * 0.06), Pk.fill(Pk.dark(a, 0.2)));
  c.drawLine(Offset(r.left + w * 0.18, r.top + h * 0.7), Offset(r.right - w * 0.18, r.top + h * 0.7), Pk.stroke(b, 1.5));
}

// ------------------------------------------------------------------ observatory
void _paintTelescope(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final pivot = Offset(r.center.dx, r.top + h * 0.5);
  final leg = Pk.stroke(Pk.dark(b, 0.35), max(1.5, w * 0.045));
  c.drawLine(pivot, Offset(r.left + w * 0.14, r.bottom), leg);
  c.drawLine(pivot, Offset(r.right - w * 0.14, r.bottom), leg);
  c.drawLine(pivot, Offset(r.center.dx + w * 0.06, r.bottom - h * 0.03), leg);
  c.save();
  c.translate(pivot.dx, pivot.dy);
  c.rotate(-0.55 + sin(t * 0.3 + r.left) * 0.03);
  final len = w * 0.95;
  final th = h * 0.16;
  c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(-len * 0.45, -th / 2, len, th), Radius.circular(th * 0.3)), Pk.fill(a));
  c.drawRect(Rect.fromLTWH(-len * 0.45, -th / 2, len, th * 0.3), Pk.fill(Pk.light(a, 0.25)));
  c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(len * 0.42, -th * 0.65, len * 0.14, th * 1.3), const Radius.circular(2)), Pk.fill(b));
  c.drawRect(Rect.fromLTWH(-len * 0.56, -th * 0.28, len * 0.12, th * 0.56), Pk.fill(Pk.dark(a, 0.25)));
  c.drawRect(Rect.fromLTWH(-len * 0.04, -th / 2 - 1, len * 0.07, th + 2), Pk.fill(b));
  c.restore();
  c.drawCircle(pivot, w * 0.05, Pk.fill(b));
}

void _paintBigScope(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, Rect.fromLTWH(r.center.dx - w * 0.12, r.top + h * 0.55, w * 0.24, h * 0.45), Pk.dark(b, 0.05), radius: 3);
  Pk.box(c, Rect.fromLTWH(r.center.dx - w * 0.22, r.bottom - h * 0.08, w * 0.44, h * 0.08), Pk.dark(b, 0.25), radius: 2);
  final pivot = Offset(r.center.dx, r.top + h * 0.52);
  c.save();
  c.translate(pivot.dx, pivot.dy);
  c.rotate(-0.68 + sin(t * 0.2) * 0.03);
  final len = w * 1.0;
  final th = h * 0.22;
  final tube = Rect.fromLTWH(-len * 0.38, -th / 2, len, th);
  c.drawRRect(RRect.fromRectAndRadius(tube, Radius.circular(th * 0.2)), Pk.fill(a));
  c.drawRect(Rect.fromLTWH(tube.left, tube.top, tube.width, th * 0.3), Pk.fill(Pk.light(a, 0.2)));
  c.drawRect(Rect.fromLTWH(tube.right - len * 0.16, tube.top - th * 0.08, len * 0.16, th * 1.16), Pk.fill(Pk.dark(a, 0.12)));
  c.drawRect(Rect.fromLTWH(tube.left - len * 0.04, -th * 0.3, len * 0.05, th * 0.6), Pk.fill(_ink));
  c.drawRect(Rect.fromLTWH(-len * 0.06, tube.top - 1, len * 0.12, th + 2), Pk.fill(b));
  c.drawRect(Rect.fromLTWH(tube.left + len * 0.08, tube.top - th * 0.3, len * 0.24, th * 0.22), Pk.fill(Pk.dark(a, 0.25)));
  c.restore();
  c.drawCircle(pivot, w * 0.09, Pk.fill(b));
  c.drawCircle(pivot, w * 0.04, Pk.fill(Pk.light(b, 0.3)));
}

void _paintPlanet(Canvas c, Rect r, Color a, Color b, double t) {
  final cc = r.center;
  final rad = min(r.width / 3.4, r.height * 0.42);
  final ring = Rect.fromCenter(center: cc, width: rad * 3.2, height: rad * 0.9);
  c.drawLine(Offset(cc.dx, r.top), Offset(cc.dx, cc.dy - rad), Pk.stroke(_steel.withValues(alpha: 0.5), 0.8));
  c.drawArc(ring, pi, pi, false, Pk.stroke(b, rad * 0.2));
  c.drawCircle(cc, rad, Pk.fill(a));
  c.save();
  c.clipPath(Path()..addOval(Rect.fromCircle(center: cc, radius: rad)));
  for (var i = 0; i < 3; i++) {
    c.drawRect(Rect.fromLTWH(cc.dx - rad, cc.dy - rad * 0.6 + i * rad * 0.45, rad * 2, rad * 0.16), Pk.fill(Pk.dark(a, 0.12)));
  }
  c.drawCircle(cc + Offset(rad * 0.45, rad * 0.35), rad, Pk.fill(Colors.black.withValues(alpha: 0.14)));
  c.restore();
  c.drawArc(ring, 0, pi, false, Pk.stroke(b, rad * 0.2));
}

void _paintOrrery(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.poly(c, [Offset(r.center.dx - w * 0.07, r.top + h * 0.62), Offset(r.center.dx + w * 0.07, r.top + h * 0.62), Offset(r.center.dx + w * 0.28, r.bottom), Offset(r.center.dx - w * 0.28, r.bottom)], Pk.fill(Pk.dark(a, 0.15)));
  final cc = Offset(r.center.dx, r.top + h * 0.4);
  c.drawLine(cc, Offset(cc.dx, r.top + h * 0.64), Pk.stroke(a, 2.5));
  for (var i = 0; i < 3; i++) {
    final orbit = Rect.fromCenter(center: cc, width: w * (0.42 + i * 0.27), height: h * (0.12 + i * 0.08));
    c.drawOval(orbit, Pk.stroke(Pk.alpha(a, 0.6), 1));
    final ang = t * (0.8 - i * 0.2) + i * 2;
    final p = cc + Offset(cos(ang) * orbit.width / 2, sin(ang) * orbit.height / 2);
    c.drawLine(cc, p, Pk.stroke(a, 1));
    c.drawCircle(p, w * (0.035 + i * 0.012), Pk.fill([_blue, _red, b][i]));
  }
  Pk.glow(c, cc, w * 0.25, _gold, 0.5);
  c.drawCircle(cc, w * 0.08, Pk.fill(_gold));
}

void _paintStarChart(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, r, a, radius: 2);
  final inner = r.deflate(3);
  Pk.gradientRect(c, inner, _night, Pk.light(_night, 0.18));
  c.drawCircle(inner.center, min(inner.width, inner.height) * 0.42, Pk.stroke(Pk.alpha(b, 0.45), 1));
  final pts = <Offset>[];
  for (var i = 0; i < 6; i++) {
    pts.add(Offset(inner.left + inner.width * (0.15 + Pk.rand(i + r.left.toInt()) * 0.7), inner.top + inner.height * (0.15 + Pk.rand(i + 30 + r.top.toInt()) * 0.7)));
  }
  for (var i = 0; i < 5; i++) {
    c.drawLine(pts[i], pts[i + 1], Pk.stroke(Pk.alpha(b, 0.75), 0.9));
  }
  for (final p in pts) {
    c.drawCircle(p, 1.7, Pk.fill(_white));
  }
  for (var i = 0; i < 14; i++) {
    c.drawCircle(Offset(inner.left + inner.width * Pk.rand(i * 3 + 1), inner.top + inner.height * Pk.rand(i * 5 + 2)), 0.7, Pk.fill(_white.withValues(alpha: 0.7)));
  }
}

void _paintStarProjector(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final o = Offset(r.center.dx, r.top + h * 0.3);
  for (var i = 0; i < 7; i++) {
    final ang = -pi / 2 + (i - 3) * 0.38 + sin(t * 0.2) * 0.1;
    c.drawLine(o, o + Offset(cos(ang), sin(ang)) * h * 0.9, Pk.stroke(Pk.alpha(b, 0.14), 6));
  }
  Pk.box(c, Rect.fromLTWH(r.center.dx - w * 0.14, r.top + h * 0.48, w * 0.28, h * 0.52), Pk.dark(a, 0.15), radius: 3);
  Pk.box(c, Rect.fromLTWH(r.center.dx - w * 0.3, r.bottom - h * 0.08, w * 0.6, h * 0.08), Pk.dark(a, 0.3), radius: 2);
  c.save();
  c.translate(o.dx, o.dy);
  c.rotate(-0.35);
  c.drawRect(Rect.fromLTWH(-w * 0.32, -h * 0.04, w * 0.64, h * 0.08), Pk.fill(Pk.dark(a, 0.1)));
  for (final s in [-1.0, 1.0]) {
    c.drawCircle(Offset(s * w * 0.34, 0), w * 0.16, Pk.fill(a));
    for (var i = 0; i < 6; i++) {
      final ang = i * pi / 3 + t * 0.3;
      c.drawCircle(Offset(s * w * 0.34, 0) + Offset(cos(ang), sin(ang)) * w * 0.1, w * 0.026, Pk.fill(b));
    }
  }
  c.restore();
}

void _paintSignpost(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawRect(Rect.fromLTWH(r.center.dx - w * 0.05, r.top + h * 0.05, w * 0.1, h * 0.95), Pk.fill(Pk.dark(a, 0.25)));
  for (var i = 0; i < 2; i++) {
    final y = r.top + h * (0.12 + i * 0.26);
    final right = i == 0;
    final x0 = right ? r.center.dx - w * 0.1 : r.left;
    final x1 = right ? r.right : r.center.dx + w * 0.1;
    final pts = right
        ? [Offset(x0, y), Offset(x1 - w * 0.12, y), Offset(x1, y + h * 0.08), Offset(x1 - w * 0.12, y + h * 0.16), Offset(x0, y + h * 0.16)]
        : [Offset(x1, y), Offset(x0 + w * 0.12, y), Offset(x0, y + h * 0.08), Offset(x0 + w * 0.12, y + h * 0.16), Offset(x1, y + h * 0.16)];
    Pk.poly(c, pts, Pk.fill(i == 0 ? a : Pk.light(a, 0.12)));
    c.drawLine(Offset(x0 + w * 0.12, y + h * 0.08), Offset(x1 - w * 0.16, y + h * 0.08), Pk.stroke(b, 1.4));
  }
}

void _paintMoon(Canvas c, Rect r, Color a, Color b, double t) {
  final cc = r.center;
  final rad = min(r.width, r.height) / 2;
  Pk.glow(c, cc, rad * 2.2, b, 0.45);
  c.drawCircle(cc, rad, Pk.fill(a));
  for (var i = 0; i < 4; i++) {
    c.drawCircle(cc + Offset((Pk.rand(i) - 0.5) * rad * 1.1, (Pk.rand(i + 4) - 0.5) * rad * 1.1), rad * (0.1 + Pk.rand(i + 8) * 0.12), Pk.fill(Pk.dark(a, 0.1)));
  }
}

void _paintStarW(Canvas c, Rect r, Color a, Color b, double t) {
  final tw = 0.85 + 0.15 * sin(t * 2.5 + r.left);
  Pk.glow(c, r.center, r.width * 1.1, b, 0.5 * tw);
  _star(c, r.center, r.width * 0.5 * tw, a);
}

void _paintComet(Canvas c, Rect r, Color a, Color b, double t) {
  final head = Offset(r.right - r.height * 0.3, r.top + r.height * 0.3);
  final tail = Path()
    ..moveTo(head.dx - r.height * 0.12, head.dy - r.height * 0.2)
    ..lineTo(r.left, r.bottom)
    ..lineTo(head.dx + r.height * 0.12, head.dy + r.height * 0.2)
    ..close();
  c.drawPath(tail, Paint()..shader = LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Pk.alpha(b, 0.8), Pk.alpha(b, 0)]).createShader(r));
  Pk.glow(c, head, r.height * 0.8, b, 0.6);
  _star(c, head, r.height * 0.28, a);
}

void _paintRocket(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, Rect.fromLTWH(r.left + w * 0.1, r.bottom - h * 0.07, w * 0.8, h * 0.07), _steel, radius: 2);
  c.drawLine(Offset(r.center.dx, r.top + h * 0.86), Offset(r.center.dx, r.bottom - h * 0.07), Pk.stroke(_steel, 2));
  Pk.poly(c, [Offset(r.left + w * 0.26, r.top + h * 0.55), Offset(r.left, r.top + h * 0.9), Offset(r.left + w * 0.3, r.top + h * 0.8)], Pk.fill(b));
  Pk.poly(c, [Offset(r.right - w * 0.26, r.top + h * 0.55), Offset(r.right, r.top + h * 0.9), Offset(r.right - w * 0.3, r.top + h * 0.8)], Pk.fill(b));
  Pk.poly(c, [Offset(r.center.dx - w * 0.14, r.top + h * 0.78), Offset(r.center.dx + w * 0.14, r.top + h * 0.78), Offset(r.center.dx + w * 0.18, r.top + h * 0.86), Offset(r.center.dx - w * 0.18, r.top + h * 0.86)], Pk.fill(_grey));
  final body = Path()
    ..moveTo(r.center.dx, r.top)
    ..quadraticBezierTo(r.right - w * 0.12, r.top + h * 0.22, r.right - w * 0.24, r.top + h * 0.78)
    ..lineTo(r.left + w * 0.24, r.top + h * 0.78)
    ..quadraticBezierTo(r.left + w * 0.12, r.top + h * 0.22, r.center.dx, r.top)
    ..close();
  c.drawPath(body, Pk.fill(a));
  c.save();
  c.clipPath(body);
  c.drawRect(Rect.fromLTWH(r.left, r.top, w, h * 0.16), Pk.fill(b));
  c.drawRect(Rect.fromLTWH(r.left, r.top + h * 0.62, w, h * 0.05), Pk.fill(b));
  c.restore();
  c.drawCircle(Offset(r.center.dx, r.top + h * 0.36), w * 0.14, Pk.fill(Pk.dark(b, 0.3)));
  c.drawCircle(Offset(r.center.dx, r.top + h * 0.36), w * 0.095, Pk.fill(_sky));
}

const _giraffe = CustomProp(_paintGiraffe);
const _penguin = CustomProp(_paintPenguin);
const _acacia = CustomProp(_paintAcacia);
const _rock = CustomProp(_paintRock);
const _zooArch = CustomProp(_paintZooArch);
const _booth = CustomProp(_paintBooth);
const _floe = CustomProp(_paintFloe);
const _slide = CustomProp(_paintSlide);
const _terrarium = CustomProp(_paintTerrarium);
const _lizard = CustomProp(_paintLizard);
const _turtle = CustomProp(_paintTurtle);
const _sheep = CustomProp(_paintSheep);
const _rabbit = CustomProp(_paintRabbit);
const _hutch = CustomProp(_paintHutch);
const _feeder = CustomProp(_paintFeeder);
const _bugCase = CustomProp(_paintBugCase, wall: true);
const _nest = CustomProp(_paintNest);
const _tank = CustomProp(_paintTank, wall: true);
const _fish = CustomProp(_paintFish, wall: true);
const _shark = CustomProp(_paintShark, wall: true);
const _ray = CustomProp(_paintRay, wall: true);
const _jelly = CustomProp(_paintJelly, wall: true, emissive: true);
const _coralProp = CustomProp(_paintCoral);
const _weed = CustomProp(_paintWeed);
const _bubbles = CustomProp(_paintBubbles, wall: true, emissive: true);
const _touchPool = CustomProp(_paintTouchPool);
const _starfish = CustomProp(_paintStarfish);
const _starfishWall = CustomProp(_paintStarfish, wall: true);
const _helmet = CustomProp(_paintHelmet);
const _diver = CustomProp(_paintDiver, wall: true);
const _porthole = CustomProp(_paintPorthole, wall: true, emissive: true);
const _columnTank = CustomProp(_paintColumnTank, emissive: true);
const _carousel = CustomProp(_paintCarousel);
const _poleHorse = CustomProp(_paintPoleHorse);
const _ferris = CustomProp(_paintFerris);
const _stall = CustomProp(_paintStall);
const _balloons = CustomProp(_paintBalloons);
const _bunting = CustomProp(_paintBunting, wall: true);
const _coaster = CustomProp(_paintCoaster);
const _popcorn = CustomProp(_paintPopcorn);
const _iceCart = CustomProp(_paintIceCart);
const _teddy = CustomProp(_paintTeddy);
const _striker = CustomProp(_paintStriker);
const _fairArch = CustomProp(_paintFairArch);
const _organ = CustomProp(_paintOrgan);
const _bookStack = CustomProp(_paintBookStack);
const _shopWindow = CustomProp(_paintShopWindow, wall: true);
const _ladder = CustomProp(_paintLadder);
const _globe = CustomProp(_paintGlobe);
const _armchair = CustomProp(_paintArmchair);
const _espresso = CustomProp(_paintEspresso);
const _cakeStand = CustomProp(_paintCakeStand);
const _blocks = CustomProp(_paintBlocks);
const _rareCase = CustomProp(_paintRareCase);
const _deskLamp = CustomProp(_paintDeskLamp, emissive: true);
const _bookCart = CustomProp(_paintBookCart);
const _hangSign = CustomProp(_paintHangSign, wall: true);
const _beanbag = CustomProp(_paintBeanbag);
const _rainbow = CustomProp(_paintRainbow, wall: true);
const _scrolls = CustomProp(_paintScrolls);
const _telescope = CustomProp(_paintTelescope);
const _bigScope = CustomProp(_paintBigScope);
const _planet = CustomProp(_paintPlanet, wall: true);
const _orrery = CustomProp(_paintOrrery);
const _starChart = CustomProp(_paintStarChart, wall: true);
const _starProjector = CustomProp(_paintStarProjector);
const _signpost = CustomProp(_paintSignpost);
const _moon = CustomProp(_paintMoon, wall: true, emissive: true);
const _starW = CustomProp(_paintStarW, wall: true, emissive: true);
const _comet = CustomProp(_paintComet, wall: true, emissive: true);
const _rocket = CustomProp(_paintRocket);

// ------------------------------------------------------------------ scenery
void _bricks(Canvas c, Rect area, Color col, {double bw = 24, double bh = 12}) {
  c.save();
  c.clipRect(area);
  final p = Pk.stroke(Pk.dark(col, 0.22).withValues(alpha: 0.5), 1);
  var row = 0;
  for (var y = area.top; y < area.bottom; y += bh) {
    for (var x = area.left - (row.isEven ? 0 : bw / 2); x < area.right; x += bw) {
      c.drawRect(Rect.fromLTWH(x, y, bw, bh), p);
    }
    row++;
  }
  c.restore();
}

void _zooWall(Canvas c, double ov, double t) {
  final leaf = Pk.mix(const Color(0xFF8A9478), const Color(0xFF4FAE52), ov);
  for (var i = 0; i < 8; i++) {
    final x = 10 + i * 56.0;
    c.drawCircle(Offset(x, 82 + Pk.rand(i) * 10), 24 + Pk.rand(i + 3) * 10, Pk.fill(Pk.dark(leaf, Pk.rand(i + 9) * 0.15)));
  }
  final stone = Pk.mix(const Color(0xFF9E978A), const Color(0xFFE8C99A), ov);
  for (final (x0, x1) in [(0.0, 132.0), (268.0, 400.0)]) {
    final wall = Rect.fromLTRB(x0, 96, x1, 152);
    c.drawRect(wall, Pk.fill(stone));
    _bricks(c, wall, stone, bw: 26, bh: 14);
    c.drawRect(Rect.fromLTRB(x0, 90, x1, 98), Pk.fill(Pk.dark(stone, 0.18)));
  }
  final ivy = Pk.mix(const Color(0xFF7E8A6A), const Color(0xFF3E9A3A), ov);
  for (var i = 0; i < 14; i++) {
    final x = i < 7 ? 6 + i * 18.0 : 274 + (i - 7) * 18.0;
    c.drawOval(Rect.fromLTWH(x, 96 + Pk.rand(i + 20) * 10, 12, 8), Pk.fill(ivy));
  }
}

void _savanna(Canvas c, double ov, double t) {
  final far = Pk.mix(const Color(0xFFB5AD92), const Color(0xFFE8C77A), ov);
  final hills = Path()
    ..moveTo(0, 130)
    ..quadraticBezierTo(70, 104, 150, 124)
    ..quadraticBezierTo(250, 100, 400, 122)
    ..lineTo(400, 150)
    ..lineTo(0, 150)
    ..close();
  c.drawPath(hills, Pk.fill(far));
  final wood = Pk.mix(const Color(0xFF8C7E6C), const Color(0xFFB9763F), ov);
  Pk.box(c, const Rect.fromLTWH(296, 70, 96, 76), wood, radius: 2);
  Pk.poly(c, const [Offset(288, 74), Offset(344, 44), Offset(400, 74)], Pk.fill(Pk.mix(const Color(0xFF6E6260), const Color(0xFF7A3E2E), ov)));
  final door = Path()
    ..moveTo(326, 146)
    ..lineTo(326, 92)
    ..quadraticBezierTo(344, 80, 362, 92)
    ..lineTo(362, 146)
    ..close();
  c.drawPath(door, Pk.fill(Pk.dark(wood, 0.45)));
  for (var i = 0; i < 4; i++) {
    c.drawLine(Offset(296, 84 + i * 16.0), Offset(392, 84 + i * 16.0), Pk.stroke(Pk.dark(wood, 0.2), 1.2));
  }
}

void _penguinCove(Canvas c, double ov, double t) {
  final cliff = Pk.mix(const Color(0xFFA9AFB4), const Color(0xFFE6F6FF), ov);
  final shade = Pk.mix(const Color(0xFF8E959C), const Color(0xFFB5DDF2), ov);
  Pk.poly(c, const [Offset(0, 150), Offset(0, 70), Offset(40, 52), Offset(90, 84), Offset(130, 150)], Pk.fill(shade));
  Pk.poly(c, const [Offset(0, 150), Offset(0, 90), Offset(30, 74), Offset(70, 96), Offset(100, 150)], Pk.fill(cliff));
  Pk.poly(c, const [Offset(400, 150), Offset(400, 62), Offset(350, 48), Offset(300, 86), Offset(262, 150)], Pk.fill(shade));
  Pk.poly(c, const [Offset(400, 150), Offset(400, 82), Offset(362, 70), Offset(320, 100), Offset(300, 150)], Pk.fill(cliff));
  final water = Pk.mix(const Color(0xFF7FA3AE), const Color(0xFF2EB6E0), ov);
  final pool = Rect.fromLTWH(96, 170, 208, 58);
  c.drawOval(pool.inflate(5), Pk.fill(Pk.mix(const Color(0xFFB8B4AA), const Color(0xFFF2FBFF), ov)));
  c.drawOval(pool, Pk.fill(water));
  c.drawOval(Rect.fromLTWH(110, 176, 180, 22), Pk.fill(Pk.light(water, 0.18)));
  for (var i = 0; i < 4; i++) {
    final x = 120 + ((i * 47 + t * 8) % 150);
    c.drawLine(Offset(x, 200 + i * 6.0), Offset(x + 18, 200 + i * 6.0), Pk.stroke(Colors.white.withValues(alpha: 0.45), 1.5));
  }
}

void _jungleMural(Canvas c, double ov, double t) {
  final leaf = Pk.mix(const Color(0xFF7D8A70), const Color(0xFF3FAA5A), ov);
  final leaf2 = Pk.mix(const Color(0xFF6E7A62), const Color(0xFF2E8A4A), ov);
  for (var i = 0; i < 9; i++) {
    final base = Offset(20 + i * 46.0, 172);
    final hgt = 70 + Pk.rand(i) * 60;
    c.save();
    c.translate(base.dx, base.dy);
    c.rotate((Pk.rand(i + 4) - 0.5) * 0.7);
    c.drawOval(Rect.fromCenter(center: Offset(0, -hgt / 2), width: 26, height: hgt), Pk.fill(i.isEven ? leaf : leaf2));
    c.drawLine(Offset(0, 0), Offset(0, -hgt * 0.95), Pk.stroke(Pk.light(leaf, 0.25), 1.2));
    c.restore();
  }
  c.drawRect(const Rect.fromLTWH(0, 0, 400, 14), Pk.fill(Pk.mix(const Color(0xFF6E6254), const Color(0xFF8B5E3C), ov)));
}

void _farmBarn(Canvas c, double ov, double t) {
  final red = Pk.mix(const Color(0xFF9A6A5E), const Color(0xFFC8412F), ov);
  Pk.box(c, const Rect.fromLTWH(108, 64, 120, 78), red, radius: 2);
  Pk.poly(c, const [Offset(100, 68), Offset(168, 30), Offset(236, 68)], Pk.fill(Pk.dark(red, 0.25)));
  Pk.poly(c, const [Offset(98, 70), Offset(168, 30), Offset(238, 70), Offset(230, 74), Offset(168, 38), Offset(106, 74)], Pk.fill(Colors.white));
  c.drawRect(const Rect.fromLTWH(144, 92, 48, 50), Pk.fill(Pk.dark(red, 0.35)));
  c.drawLine(const Offset(144, 92), const Offset(192, 142), Pk.stroke(Colors.white, 2));
  c.drawLine(const Offset(192, 92), const Offset(144, 142), Pk.stroke(Colors.white, 2));
  final wood = Pk.mix(const Color(0xFF9A8D7C), const Color(0xFFE8D2A8), ov);
  for (var i = 0; i < 20; i++) {
    c.drawRect(Rect.fromLTWH(i * 20.0 + 4, 124, 5, 24), Pk.fill(wood));
  }
  c.drawRect(const Rect.fromLTWH(0, 130, 400, 4), Pk.fill(wood));
  c.drawRect(const Rect.fromLTWH(0, 140, 400, 4), Pk.fill(wood));
}

void _aquaHall(Canvas c, double ov, double t) {
  final wave = Pk.mix(const Color(0xFF8DA4A8), const Color(0xFF5CC8E8), ov);
  for (var k = 0; k < 3; k++) {
    final p = Path()..moveTo(0, 150 + k * 7.0);
    for (var x = 0.0; x <= 400; x += 20) {
      p.quadraticBezierTo(x + 10, 144 + k * 7.0 + sin(t + k) * 1.5, x + 20, 150 + k * 7.0);
    }
    c.drawPath(p, Pk.stroke(Pk.alpha(wave, 0.7 - k * 0.15), 3));
  }
  c.drawRect(const Rect.fromLTWH(0, 0, 400, 10), Pk.fill(Pk.mix(const Color(0xFF6E7A80), const Color(0xFF1E6FA8), ov)));
}

void _coralWall(Canvas c, double ov, double t) {
  final frame = Pk.mix(const Color(0xFF7E848C), const Color(0xFF2B3A67), ov);
  final water = Pk.mix(const Color(0xFF6E8E98), const Color(0xFF1E9FD8), ov);
  final r = const Rect.fromLTWH(0, 12, 400, 150);
  Pk.gradientRect(c, r, Pk.light(water, 0.25), Pk.dark(water, 0.3));
  for (var i = 0; i < 5; i++) {
    final x = 30 + i * 90.0 + sin(t * 0.3 + i) * 8;
    Pk.poly(c, [Offset(x, 12), Offset(x + 26, 12), Offset(x - 10, 162), Offset(x - 44, 162)], Pk.fill(Colors.white.withValues(alpha: 0.05 + 0.05 * ov)));
  }
  final sand = Pk.mix(const Color(0xFFB8AE96), const Color(0xFFF2D59A), ov);
  final dunes = Path()
    ..moveTo(0, 150)
    ..quadraticBezierTo(100, 136, 200, 148)
    ..quadraticBezierTo(300, 140, 400, 148)
    ..lineTo(400, 162)
    ..lineTo(0, 162)
    ..close();
  c.drawPath(dunes, Pk.fill(sand));
  c.drawRect(const Rect.fromLTWH(0, 6, 400, 8), Pk.fill(frame));
  c.drawRect(const Rect.fromLTWH(0, 160, 400, 12), Pk.fill(frame));
  for (final x in [133.0, 266.0]) {
    c.drawRect(Rect.fromLTWH(x - 2, 12, 4, 150), Pk.fill(Pk.alpha(frame, 0.8)));
  }
}

void _sharkTunnel(Canvas c, double ov, double t) {
  final water = Pk.mix(const Color(0xFF5E7F8A), const Color(0xFF1E8FD0), ov);
  Pk.gradientRect(c, const Rect.fromLTWH(0, 0, 400, 172), Pk.light(water, 0.2), Pk.dark(water, 0.3));
  for (var i = 0; i < 4; i++) {
    final x = 40 + i * 100.0 + sin(t * 0.3 + i) * 10;
    Pk.poly(c, [Offset(x, 0), Offset(x + 30, 0), Offset(x - 20, 172), Offset(x - 60, 172)], Pk.fill(Colors.white.withValues(alpha: 0.05 + 0.04 * ov)));
  }
  final sand = Pk.mix(const Color(0xFFA8A090), const Color(0xFFE8CF96), ov);
  final dunes = Path()
    ..moveTo(0, 150)
    ..quadraticBezierTo(80, 128, 170, 146)
    ..quadraticBezierTo(280, 132, 400, 148)
    ..lineTo(400, 172)
    ..lineTo(0, 172)
    ..close();
  c.drawPath(dunes, Pk.fill(sand));
  final rib = Pk.mix(const Color(0xFF8A8F9C), const Color(0xFFE6EEF5), ov);
  for (final (inset, wd) in [(64.0, 4.0), (30.0, 5.0), (4.0, 7.0)]) {
    c.drawArc(Rect.fromLTRB(inset, inset * 0.6 + 4, 400 - inset, 340 - inset * 0.6), pi, pi, false, Pk.stroke(rib, wd));
  }
  for (var i = 0; i < 5; i++) {
    final ang = pi + pi * (i + 1) / 6;
    final outer = const Offset(200, 172) + Offset(cos(ang) * 196, sin(ang) * 166);
    final inner = const Offset(200, 172) + Offset(cos(ang) * 136, sin(ang) * 128);
    c.drawLine(outer, inner, Pk.stroke(Pk.alpha(rib, 0.8), 2));
  }
}

void _jellyRoom(Canvas c, double ov, double t) {
  for (var i = 0; i < 7; i++) {
    final x = 30 + i * 58.0;
    final y = 30 + Pk.rand(i) * 100;
    Pk.glow(c, Offset(x + sin(t * 0.5 + i) * 8, y), 26, i.isEven ? const Color(0xFF9CF0FF) : const Color(0xFFE0A8FF), 0.08 + 0.12 * ov);
  }
  for (var k = 0; k < 2; k++) {
    final p = Path()..moveTo(0, 20 + k * 12.0);
    for (var x = 0.0; x <= 400; x += 25) {
      p.quadraticBezierTo(x + 12, 14 + k * 12.0 + sin(t + x * 0.05) * 3, x + 25, 20 + k * 12.0);
    }
    c.drawPath(p, Pk.stroke(Colors.white.withValues(alpha: 0.06 + 0.06 * ov), 2));
  }
}

void _touchMural(Canvas c, double ov, double t) {
  final sea = Pk.mix(const Color(0xFF9FB2B5), const Color(0xFF7FD8F0), ov);
  final p = Path()..moveTo(0, 96);
  for (var x = 0.0; x <= 400; x += 40) {
    p.quadraticBezierTo(x + 20, 86 + sin(t * 0.8 + x) * 2, x + 40, 96);
  }
  p
    ..lineTo(400, 172)
    ..lineTo(0, 172)
    ..close();
  c.drawPath(p, Pk.fill(Pk.alpha(sea, 0.55)));
  final sand = Pk.mix(const Color(0xFFC9C0AE), const Color(0xFFF6E0B0), ov);
  c.drawRect(const Rect.fromLTWH(0, 150, 400, 22), Pk.fill(Pk.alpha(sand, 0.8)));
}

void _fairBack(Canvas c, double ov, double t) {
  for (var i = 0; i < 6; i++) {
    final x = 10 + i * 70.0;
    final col = Pk.mix(const Color(0xFFB0A89C), i.isEven ? const Color(0xFFFF8A80) : const Color(0xFF8AC8FF), ov);
    Pk.poly(c, [Offset(x, 140), Offset(x + 28, 104 + Pk.rand(i) * 10), Offset(x + 56, 140)], Pk.fill(col));
    c.drawLine(Offset(x + 28, 104 + Pk.rand(i) * 10), Offset(x + 28, 96 + Pk.rand(i) * 10), Pk.stroke(Pk.dark(col, 0.3), 1));
  }
}

void _fairNight(Canvas c, double ov, double t) {
  _fairBack(c, ov, t);
  for (var i = 0; i < 12; i++) {
    final on = (i + (t * 3).floor()) % 3 != 0;
    c.drawCircle(Offset(16 + i * 34.0, 100 + sin(i * 1.3) * 4), 2, Pk.fill((on ? const Color(0xFFFFE066) : const Color(0xFF8A7F78)).withValues(alpha: 0.3 + 0.6 * ov)));
  }
}

void _shopFacade(Canvas c, double ov, double t) {
  final brick = Pk.mix(const Color(0xFF9A8C82), const Color(0xFFC9644A), ov);
  final wall = const Rect.fromLTWH(10, 0, 380, 152);
  c.drawRect(wall, Pk.fill(brick));
  _bricks(c, wall, brick, bw: 22, bh: 10);
  final trim = Pk.mix(const Color(0xFF6E6A70), const Color(0xFF2B3A67), ov);
  c.drawRect(const Rect.fromLTWH(10, 34, 380, 10), Pk.fill(trim));
  c.drawRect(const Rect.fromLTWH(10, 138, 380, 14), Pk.fill(Pk.dark(trim, 0.1)));
  for (final x in [10.0, 384.0]) {
    c.drawRect(Rect.fromLTWH(x, 0, 6, 152), Pk.fill(Pk.dark(brick, 0.2)));
  }
}

void _wallpaper(Canvas c, double ov, double t) {
  final s = Pk.mix(const Color(0xFF9E958A), const Color(0xFFE8B98A), ov);
  for (var i = 0; i < 20; i++) {
    c.drawRect(Rect.fromLTWH(i * 20.0 + 6, 0, 8, 118), Pk.fill(Pk.alpha(s, 0.35)));
  }
  final wood = Pk.mix(const Color(0xFF7E7060), const Color(0xFF8B5E3C), ov);
  c.drawRect(const Rect.fromLTWH(0, 118, 400, 54), Pk.fill(wood));
  for (var i = 0; i < 8; i++) {
    c.drawRect(Rect.fromLTWH(8 + i * 50.0, 126, 40, 38), Pk.stroke(Pk.dark(wood, 0.2), 1.5));
  }
  c.drawRect(const Rect.fromLTWH(0, 114, 400, 6), Pk.fill(Pk.light(wood, 0.15)));
}

void _kidsWall(Canvas c, double ov, double t) {
  final cols = [const Color(0xFFFF9AB8), const Color(0xFF8ED8FF), const Color(0xFFFFD86B), const Color(0xFF9CE38A)];
  for (var i = 0; i < 26; i++) {
    final p = Offset(12 + Pk.rand(i) * 376, 8 + Pk.rand(i + 40) * 150);
    c.drawCircle(p, 4 + Pk.rand(i + 7) * 3, Pk.fill(Pk.alpha(Pk.mix(const Color(0xFFB0A89C), cols[i % 4], ov), 0.45)));
  }
  c.drawRect(const Rect.fromLTWH(0, 150, 400, 22), Pk.fill(Pk.mix(const Color(0xFFA8A296), const Color(0xFFFFFFFF), ov)));
}

void _cafeWall(Canvas c, double ov, double t) {
  final brick = Pk.mix(const Color(0xFFA0968C), const Color(0xFFD9825F), ov);
  final r = const Rect.fromLTWH(0, 0, 400, 120);
  c.drawRect(r, Pk.fill(brick));
  _bricks(c, r, brick, bw: 26, bh: 11);
  final wood = Pk.mix(const Color(0xFF7E7060), const Color(0xFF6E4B3A), ov);
  c.drawRect(const Rect.fromLTWH(0, 118, 400, 54), Pk.fill(wood));
  for (var i = 0; i < 20; i++) {
    c.drawLine(Offset(i * 20.0, 120), Offset(i * 20.0, 172), Pk.stroke(Pk.dark(wood, 0.2), 1));
  }
}

void _rareWall(Canvas c, double ov, double t) {
  final wood = Pk.mix(const Color(0xFF6E6458), const Color(0xFF5A3A28), ov);
  for (var i = 0; i < 8; i++) {
    final pr = Rect.fromLTWH(6 + i * 50.0, 8, 40, 150);
    c.drawRect(pr, Pk.fill(Pk.light(wood, 0.06)));
    c.drawRect(pr.deflate(5), Pk.stroke(Pk.dark(wood, 0.25), 1.5));
  }
  Pk.glow(c, const Offset(200, 60), 120, const Color(0xFFFFD68A), 0.1 + 0.2 * ov);
}

void _hillNight(Canvas c, double ov, double t) {
  final hill = Pk.mix(const Color(0xFF5E6470), const Color(0xFF3E6E5A), ov);
  final h2 = Path()
    ..moveTo(150, 140)
    ..quadraticBezierTo(250, 70, 400, 90)
    ..lineTo(400, 140)
    ..close();
  c.drawPath(h2, Pk.fill(hill));
  final white = Pk.mix(const Color(0xFF9A9AA4), const Color(0xFFF2F2F8), ov);
  Pk.box(c, const Rect.fromLTWH(292, 66, 52, 26), white, radius: 2);
  c.drawArc(const Rect.fromLTWH(292, 44, 52, 44), pi, pi, true, Pk.fill(white));
  c.drawRect(const Rect.fromLTWH(314, 46, 8, 20), Pk.fill(Pk.mix(const Color(0xFF3E3A40), const Color(0xFFFFE9A6), ov)));
  Pk.glow(c, const Offset(318, 56), 30, const Color(0xFFFFE9A6), 0.4 * ov);
  final path = Pk.mix(const Color(0xFF8A8478), const Color(0xFFE6D2A8), ov);
  final p = Path()
    ..moveTo(170, 240)
    ..quadraticBezierTo(250, 190, 210, 160)
    ..quadraticBezierTo(180, 138, 300, 96);
  c.drawPath(p, Pk.stroke(Pk.alpha(path, 0.85), 10));
}

void _domeInterior(Canvas c, double ov, double t) {
  final dome = Pk.mix(const Color(0xFF5E6470), const Color(0xFF3A4A8A), ov);
  final arc = Path()
    ..moveTo(0, 172)
    ..lineTo(0, 60)
    ..quadraticBezierTo(200, -40, 400, 60)
    ..lineTo(400, 172)
    ..close();
  c.drawPath(arc, Pk.fill(dome));
  for (var i = 0; i < 9; i++) {
    final x = i * 50.0;
    c.drawLine(Offset(x, 172), Offset(200 + (x - 200) * 0.25, 2), Pk.stroke(Pk.dark(dome, 0.2), 2));
  }
  final slit = Path()
    ..moveTo(170, 120)
    ..lineTo(176, 8)
    ..lineTo(224, 8)
    ..lineTo(230, 120)
    ..close();
  c.drawPath(slit, Pk.fill(Pk.mix(const Color(0xFF2E2E3A), const Color(0xFF141A44), ov)));
  for (var i = 0; i < 12; i++) {
    c.drawCircle(Offset(178 + Pk.rand(i) * 44, 12 + Pk.rand(i + 9) * 104), 0.8 + Pk.rand(i + 3), Pk.fill(Colors.white.withValues(alpha: 0.3 + 0.6 * ov)));
  }
  c.drawRect(const Rect.fromLTWH(0, 150, 400, 22), Pk.fill(Pk.dark(dome, 0.3)));
}

void _planetariumSky(Canvas c, double ov, double t) {
  final sky = Pk.mix(const Color(0xFF3A3A48), const Color(0xFF141A44), ov);
  final arc = Path()
    ..moveTo(0, 172)
    ..lineTo(0, 80)
    ..quadraticBezierTo(200, -50, 400, 80)
    ..lineTo(400, 172)
    ..close();
  c.drawPath(arc, Pk.fill(sky));
  for (var i = 0; i < 46; i++) {
    final p = Offset(8 + Pk.rand(i) * 384, 6 + Pk.rand(i + 50) * 140);
    final tw = 0.6 + 0.4 * sin(t * 2 + i);
    c.drawCircle(p, 0.7 + Pk.rand(i + 9) * 1.2, Pk.fill(Colors.white.withValues(alpha: (0.15 + 0.7 * ov) * tw)));
  }
  final band = Path()
    ..moveTo(0, 120)
    ..quadraticBezierTo(200, 10, 400, 70);
  c.drawPath(band, Pk.stroke(const Color(0xFFB8A8FF).withValues(alpha: 0.1 + 0.12 * ov), 26));
  c.drawRect(const Rect.fromLTWH(0, 156, 400, 16), Pk.fill(Pk.mix(const Color(0xFF2E2E36), const Color(0xFF2B2440), ov)));
}

void _starLibrary(Canvas c, double ov, double t) {
  final night = Pk.mix(const Color(0xFF4A4E5A), const Color(0xFF1E2A66), ov);
  final frame = Pk.mix(const Color(0xFF7E7060), const Color(0xFF8B5E3C), ov);
  final win = Path()
    ..moveTo(150, 120)
    ..lineTo(150, 50)
    ..quadraticBezierTo(200, 14, 250, 50)
    ..lineTo(250, 120)
    ..close();
  c.drawPath(win, Pk.fill(frame));
  c.save();
  c.translate(200, 70);
  c.scale(0.88);
  c.translate(-200, -70);
  c.drawPath(win, Pk.fill(night));
  for (var i = 0; i < 10; i++) {
    c.drawCircle(Offset(158 + Pk.rand(i) * 84, 36 + Pk.rand(i + 4) * 80), 1 + Pk.rand(i + 2), Pk.fill(Colors.white.withValues(alpha: 0.3 + 0.6 * ov)));
  }
  c.restore();
  c.drawLine(const Offset(200, 30), const Offset(200, 120), Pk.stroke(frame, 2.5));
  c.drawLine(const Offset(154, 76), const Offset(246, 76), Pk.stroke(frame, 2.5));
}

void _roofDeck(Canvas c, double ov, double t) {
  final dome = Pk.mix(const Color(0xFF8A8A94), const Color(0xFFECEEF6), ov);
  Pk.box(c, const Rect.fromLTWH(10, 96, 70, 56), Pk.dark(dome, 0.1), radius: 2);
  c.drawArc(const Rect.fromLTWH(10, 66, 70, 62), pi, pi, true, Pk.fill(dome));
  c.drawRect(const Rect.fromLTWH(40, 68, 10, 28), Pk.fill(Pk.mix(const Color(0xFF3E3A40), const Color(0xFF141A44), ov)));
}
'''

# ----------------------------------------------------------------------------- backdrops


def indoor(topN, topR, gN, gR, aN, aR, floor='checker', night=False):
    s = (f'const Backdrop.indoor(topN: Color(0x{topN:08X}), topR: Color(0x{topR:08X}), '
         f'groundN: Color(0x{gN:08X}), groundR: Color(0x{gR:08X}), '
         f'floorAltN: Color(0x{aN:08X}), floorAltR: Color(0x{aR:08X}), floor: FloorStyle.{floor}')
    if night:
        s += ', night: true'
    return s + ')'


def outdoor(gN, gR, horizon=148, floor='sand', topN=None, topR=None, bottomN=None, bottomR=None,
            sea=False, skyline=False, night=False):
    s = f'const Backdrop.outdoor(groundN: Color(0x{gN:08X}), groundR: Color(0x{gR:08X}), horizon: {horizon}, floor: FloorStyle.{floor}'
    for k, v in (('topN', topN), ('topR', topR), ('bottomN', bottomN), ('bottomR', bottomR)):
        if v is not None:
            s += f', {k}: Color(0x{v:08X})'
    if sea:
        s += ', sea: true'
    if skyline:
        s += ', skyline: true'
    if night:
        s += ', night: true'
    return s + ')'


def P(kind, l, t, w, h, a='_white', b='_gold'):
    return (kind, l, t, w, h, a, b)


def L(id, number_hint, moves, diff, tiles, obstacles, objectives, stars, floor, name, desc, theme, scene):
    return dict(id=id, moves=moves, diff=diff, tiles=tiles, obstacles=obstacles, objectives=objectives,
                stars=stars, floor=floor, name=name, desc=desc, theme=theme, scene=scene)


# Shapes used across the batch (each at most twice).
OCTAGON = ['##....##', '#......#', '........', '........', '........', '........', '#......#', '##....##']

# ============================================================================= ZOO
ZOO = [
    L('zoo_gate', 76, 26, 'mediumHard',
      ['b2_paw', 'ticket', 'sign', 'b2_leaf', 'fountain', 'tree'],
      ['##....##',
       '#..cc..#',
       '........',
       '.c....c.',
       '.c....c.',
       '........',
       '#......#',
       '##....##'],  # octagon
      [('gates', 'b2_paw', 15), ('tickets', 'ticket', 15), ('sign', 'sign', 15), ('hedges', 'b2_leaf', 15),
       ('fountain', 'fountain', 14), ('tree', 'tree', 14), ('crates', 'crate', 6)],
      [24000, 31000], 0.55,
      ('ZOO GATE', 'HAYVANAT KAPISI'),
      ('Open the zoo gates for visitors.', 'Hayvanat bahçesinin kapılarını ziyaretçilere aç.'),
      (0xFFBFE8A8, 0xFF6FB85A, 0xFF5A7A3A, 0xFFFFB347),
      dict(backdrop=outdoor(0xFFA8A296, 0xFFE6D3AE, 150, 'stone'), scenery='_zooWall', props=[
          ('gates', [P('@zooArch', 126, 34, 148, 118, '_darkWood', '_leaf'), P('gate', 150, 98, 100, 54, '_darkWood', '_gold'),
                     P('statue', 96, 108, 28, 46, '_stone', '_gold')]),
          ('tickets', [P('@booth', 296, 92, 56, 66, '_cream', '_red'), P('@balloons', 354, 104, 30, 56, '_red', '_pink')]),
          ('sign', [P('sign', 24, 100, 84, 26, '_wood', '_cream'), P('@signpost', 104, 150, 36, 62, '_wood', '_cream')]),
          ('hedges', [P('hedge', 0, 158, 92, 30, '_leaf', '_pink'), P('hedge', 306, 166, 94, 30, '_leaf', '_pink')]),
          ('fountain', [P('fountain', 162, 168, 76, 52, '_white', '_aqua')]),
          ('tree', [P('tree', 0, 52, 46, 104, '_leaf', '_orange'), P('tree', 356, 50, 44, 104, '_leaf', '_pink')]),
          ('crates', [P('crates', 70, 184, 52, 40, '_wood', '_gold'), P('crates', 262, 188, 48, 38, '_wood', '_leaf')]),
      ])),
    L('zoo_giraffes', 77, 27, 'mediumHard',
      ['b2_paw', 'fence', 'hay', 'b2_leaf', 'water', 'tree'],
      ['..####..',
       '..####..',
       '..####..',
       '..c..c..',
       '.C....C.',
       '..####..',
       '..####..',
       '..####..'],  # H
      [('b2_giraffes', 'b2_paw', 13), ('tree', 'tree', 13), ('hay', 'hay', 13), ('fence', 'fence', 13),
       ('trough', 'water', 12), ('crates', 'crate', 6)],
      [20000, 26000], 0.45,
      ('GIRAFFE YARD', 'ZÜRAFA BAHÇESİ'),
      ('Give the giraffes a sunny yard.', 'Zürafalara güneşli bir bahçe hazırla.'),
      (0xFFFFE3A8, 0xFFE8A85A, 0xFF8B5E3C, 0xFFFFC93C),
      dict(backdrop=outdoor(0xFFB8AE92, 0xFFF0D59A, 146, 'sand', topR=0xFF7CCBFF), scenery='_savanna', props=[
          ('b2_giraffes', [P('@giraffe', 136, 40, 78, 124, '_giraffeY', '_spot'), P('@giraffe', 222, 76, 58, 94, '_giraffeY', '_spot')]),
          ('tree', [P('@acacia', 6, 26, 126, 124, '_leaf', '_darkWood'), P('@acacia', 280, 30, 100, 104, '_leaf', '_darkWood')]),
          ('hay', [P('@feeder', 98, 66, 36, 96, '_darkWood', '_straw'), P('haybale', 26, 178, 58, 32, '_straw', '_red')]),
          ('fence', [P('fence', 0, 142, 96, 30, '_wood', '_wood'), P('fence', 300, 144, 100, 30, '_wood', '_wood'),
                     P('@rock', 100, 194, 64, 32, '_stone', '_leaf')]),
          ('trough', [P('trough', 206, 190, 76, 28, '_wood', '_aqua')]),
          ('crates', [P('crates', 318, 182, 58, 44, '_wood', '_gold')]),
      ])),
    L('zoo_penguins', 78, 26, 'mediumHard',
      ['snowflake', 'ski', 'b2_bird', 'rod', 'wave', 'b2_egg'],
      ['........',
       '.i....i.',
       '...cc...',
       '#i....i#',
       '#......#',
       '##.ii.##',
       '##....##',
       '###..###'],  # funnel
      [('b2_penguins', 'b2_bird', 15), ('b2_ice_rocks', 'snowflake', 15), ('b2_floes', 'wave', 14),
       ('eggs', 'b2_egg', 14), ('b2_slide', 'ski', 14), ('ice', 'ice', 6)],
      [22000, 28500], 0.45,
      ('PENGUIN POOL', 'PENGUEN HAVUZU'),
      ('Chill the pool for the penguins.', 'Penguenler için havuzu serinlet.'),
      (0xFFDFF6FF, 0xFF8FD0F0, 0xFF3A6E9A, 0xFF4FD6E8),
      dict(backdrop=outdoor(0xFFB9B6AE, 0xFFF4FAFF, 150, 'sand', topR=0xFF8FD0FF), scenery='_penguinCove', props=[
          ('b2_ice_rocks', [P('@rock', 0, 116, 92, 50, '_iceBlue', '_white'), P('@rock', 312, 110, 88, 56, '_iceBlue', '_white')]),
          ('b2_slide', [P('@slide', 286, 96, 76, 82, '_white', '_blue')]),
          ('b2_floes', [P('@floe', 130, 184, 48, 20, '_white', '_iceBlue'), P('@floe', 214, 196, 54, 22, '_white', '_iceBlue')]),
          ('b2_penguins', [P('@penguin', 64, 148, 28, 42, '_navy', '_orange'), P('@penguin', 146, 160, 22, 32, '_navy', '_orange'),
                           P('@penguin', 316, 176, 30, 46, '_navy', '_orange')]),
          ('eggs', [P('@nest', 20, 200, 50, 26, '_straw', '_cream'), P('@nest', 350, 214, 44, 22, '_straw', '_cream')]),
          ('ice', [P('@penguin', 96, 196, 24, 34, '_ink', '_gold'), P('snowman', 270, 156, 20, 46, '_white', '_red')]),
      ])),
    L('zoo_reptiles', 79, 27, 'mediumHard',
      ['b2_paw', 'fence', 'torch', 'b2_leaf', 'b2_bee', 'b2_egg'],
      ['..l##l..',
       '...##...',
       '.c.##.c.',
       '...ll...',
       '..c..c..',
       '...##...',
       '.l.##.l.',
       '...##...'],  # twin rooms
      [('b2_reptiles', 'b2_paw', 15), ('b2_terrariums', 'b2_leaf', 15), ('lamps', 'torch', 14), ('b2_insects', 'b2_bee', 14),
       ('eggs', 'b2_egg', 13), ('chains', 'chain', 6), ('crates', 'crate', 4)],
      [23000, 30000], 0.42,
      ('REPTILE HOUSE', 'SÜRÜNGEN EVİ'),
      ('Warm up the reptile house.', 'Sürüngen evini ısıt.'),
      (0xFFCDEBB0, 0xFF5E9A4A, 0xFF3A5A2A, 0xFFFF9A3C),
      dict(backdrop=indoor(0xFF9E9A88, 0xFFCFE6B0, 0xFF8D8270, 0xFFB8A27A, 0xFF7E7262, 0xFFA08A62, 'tiles'), scenery='_jungleMural', props=[
          ('b2_terrariums', [P('@terrarium', 14, 84, 100, 92, '_darkWood', '_leaf'), P('@terrarium', 286, 84, 100, 92, '_darkWood', '_leaf')]),
          ('b2_reptiles', [P('@lizard', 30, 104, 56, 24, '_leaf', '_orange'), P('@lizard', 312, 100, 54, 24, '_orange', '_gold'),
                           P('@turtle', 166, 190, 70, 34, '_green', '_leaf')]),
          ('lamps', [P('pendant', 48, 18, 34, 40, '_red', '_gold'), P('pendant', 320, 18, 34, 40, '_red', '_gold')]),
          ('b2_insects', [P('@bugCase', 146, 28, 108, 66, '_darkWood', '_pink')]),
          ('eggs', [P('@nest', 120, 150, 40, 22, '_straw', '_cream'), P('@nest', 252, 154, 36, 20, '_straw', '_white')]),
          ('chains', [P('plant', 128, 112, 32, 40, '_terracotta', '_leaf'), P('@rock', 90, 196, 64, 30, '_stone', '_leaf'),
                      P('plant', 244, 112, 32, 40, '_terracotta', '_leaf')]),
          ('crates', [P('crates', 300, 186, 62, 42, '_wood', '_leaf')]),
      ])),
    L('zoo_petting', 80, 28, 'hard',
      ['hen', 'b2_rabbit', 'hay', 'grass', 'water', 'b2_egg'],
      ['#..##..#',
       '.c....c.',
       '........',
       '..c..c..',
       '#......#',
       '##....##',
       '###..###',
       '########'],  # heart
      [('animals', 'b2_rabbit', 14), ('hens', 'hen', 14), ('hay', 'hay', 14), ('grass', 'grass', 13),
       ('trough', 'water', 13), ('eggs', 'b2_egg', 13), ('gates', 'key', 2)],
      [21000, 27500], 0.35,
      ('PETTING FARM', 'MİNİ ÇİFTLİK'),
      ('Make a cosy farm for gentle animals.', 'Sevimli hayvanlar için şirin bir çiftlik kur.'),
      (0xFFD9F2B8, 0xFF7CC860, 0xFF8B5E3C, 0xFFFF7AB6),
      dict(backdrop=outdoor(0xFFB39460, 0xFF7CCB52, 142, 'sand'), scenery='_farmBarn', props=[
          ('gates', [P('gate', 236, 96, 70, 48, '_wood', '_gold'), P('@hutch', 316, 92, 76, 58, '_wood', '_red')]),
          ('hay', [P('haybale', 12, 146, 62, 34, '_straw', '_red'), P('haybale', 50, 128, 46, 26, '_straw', '_red')]),
          ('animals', [P('@sheep', 140, 146, 74, 48, '_wool', '_ink'), P('@rabbit', 72, 192, 36, 32, '_cream', '_pink'),
                       P('@rabbit', 300, 198, 32, 28, '_brown', '_pink')]),
          ('hens', [P('chicken', 230, 170, 32, 30, '_white', '_orange'), P('chicken', 262, 184, 28, 26, '_wood', '_orange')]),
          ('grass', [P('flowerbed', 104, 210, 84, 24, '_pink', '_gold'), P('bush', 340, 160, 56, 30, '_leaf', '_pink')]),
          ('trough', [P('trough', 196, 206, 76, 26, '_wood', '_aqua')]),
          ('eggs', [P('nestbox', 16, 96, 64, 42, '_wood', '_cream'), P('@nest', 356, 206, 40, 22, '_straw', '_cream')]),
      ])),
]

# ============================================================================= AQUARIUM
AQUARIUM = [
    L('aquarium_hall', 81, 26, 'mediumHard',
      ['b2_diver', 'ticket', 'fish', 'b2_tide', 'photo', 'b2_bubble'],
      ['##....##',
       '##.ii.##',
       '##....##',
       '.i....i.',
       '........',
       '..i..i..',
       '........',
       '........'],  # U
      [('tickets', 'ticket', 15), ('b2_tanks', 'fish', 15), ('statues', 'b2_diver', 14), ('posters', 'photo', 15),
       ('b2_bubbles', 'b2_bubble', 14), ('ice', 'ice', 6)],
      [23000, 30000], 0.55,
      ('ENTRANCE HALL', 'GİRİŞ SALONU'),
      ('Welcome guests to the aquarium.', 'Akvaryuma gelen misafirleri karşıla.'),
      (0xFFD6F4FF, 0xFF5CC0E8, 0xFF1E5F8A, 0xFF4FD6E8),
      dict(backdrop=indoor(0xFFA2AEB2, 0xFFD6F0F8, 0xFF8E9696, 0xFFE6EEF2, 0xFF7E8686, 0xFFB8D8E6, 'tiles'), scenery='_aquaHall', props=[
          ('b2_tanks', [P('@tank', 124, 22, 152, 96, '_steel', '_blue')]),
          ('b2_bubbles', [P('@bubbles', 96, 26, 20, 96, '_aqua', '_white'), P('@bubbles', 284, 26, 20, 96, '_aqua', '_white')]),
          ('posters', [P('painting', 22, 34, 50, 62, '_white', '_aqua'), P('painting', 330, 34, 50, 62, '_white', '_coral')]),
          ('tickets', [P('counter', 16, 128, 104, 48, '_teal', '_cream'), P('sign', 30, 104, 76, 20, '_navy', '_aqua')]),
          ('statues', [P('@helmet', 296, 112, 60, 70, '_brass', '_aqua')]),
          ('ice', [P('bench', 140, 186, 120, 30, '_blue', '_steel'), P('plant', 364, 140, 30, 44, '_teal', '_leaf'),
                   P('plant', 120, 140, 30, 44, '_teal', '_leaf')]),
      ])),
    L('aquarium_coral', 82, 27, 'mediumHard',
      ['b2_diver', 'b2_drop', 'fish', 'plants', 'wave', 'b2_bubble'],
      ['i..ii..i',
       '.##..##.',
       '.##II##.',
       '........',
       'i.i..i.i',
       '.##..##.',
       '.##..##.',
       '...ii...'],  # window panes
      [('b2_coral', 'plants', 15), ('b2_fish', 'fish', 15), ('b2_bubbles', 'b2_bubble', 14), ('b2_divers', 'b2_diver', 14),
       ('seats', 'b2_drop', 14), ('ice', 'ice', 12)],
      [23000, 30000], 0.46,
      ('CORAL TANK', 'MERCAN TANKI'),
      ('Bring the coral reef back to life.', 'Mercan resifini yeniden canlandır.'),
      (0xFFC6F0FF, 0xFF2EA6D8, 0xFF1E4F7A, 0xFFFF7F6B),
      dict(backdrop=indoor(0xFF8E9AA0, 0xFF7CC8E8, 0xFF7E8686, 0xFF2B3A67, 0xFF6E7676, 0xFF1E2A50, 'carpet'), scenery='_coralWall', props=[
          ('b2_fish', [P('@fish', 100, 44, 46, 28, '_orange', '_white'), P('@fish', 236, 70, 40, 24, '_gold', '_blue'),
                       P('@fish', 326, 32, 34, 20, '_pink', '_aqua')]),
          ('b2_divers', [P('@diver', 168, 26, 70, 42, '_orange', '_steel')]),
          ('b2_bubbles', [P('@bubbles', 64, 30, 20, 120, '_aqua', '_white'), P('@bubbles', 284, 20, 20, 120, '_aqua', '_white')]),
          ('b2_coral', [P('@coralProp', 20, 92, 60, 66, '_coral', '_gold'), P('@weed', 172, 96, 52, 62, '_leaf', '_teal'),
                        P('@coralProp', 310, 86, 62, 72, '_pink', '_white')]),
          ('seats', [P('bench', 50, 190, 110, 30, '_coral', '_steel'), P('bench', 240, 192, 110, 30, '_coral', '_steel')]),
          ('ice', [P('railing', 0, 158, 400, 22, '_steel', '_aqua'), P('plant', 182, 184, 36, 48, '_navy', '_leaf')]),
      ])),
    L('aquarium_tunnel', 83, 26, 'mediumHard',
      ['anchor', 'b2_drop', 'fish', 'b2_tide', 'wave', 'b2_bubble'],
      ['i......i',
       '#.l..l.#',
       '##.ii.##',
       '###..###',
       '###..###',
       '##.ii.##',
       '#.l..l.#',
       '........'],  # hourglass
      [('b2_sharks', 'fish', 13), ('lights', 'b2_drop', 13), ('b2_rays', 'b2_tide', 13), ('anchors', 'anchor', 12),
       ('b2_bubbles', 'b2_bubble', 12), ('ice', 'ice', 6), ('chains', 'chain', 4)],
      [20000, 26000], 0.44,
      ('SHARK TUNNEL', 'KÖPEKBALIĞI YOLU'),
      ('Walk beneath the sharks again.', 'Köpekbalıklarının altından yeniden yürü.'),
      (0xFFB8E8FF, 0xFF1E7FC0, 0xFF143E6A, 0xFF8FD0FF),
      dict(backdrop=indoor(0xFF6E8088, 0xFF2E7FB8, 0xFF6E6E70, 0xFF3A4A7A, 0xFF5E5E60, 0xFF2B3A67, 'carpet'), scenery='_sharkTunnel', props=[
          ('b2_sharks', [P('@shark', 40, 40, 116, 46, '_grey', '_white'), P('@shark', 244, 70, 96, 38, '_grey', '_white')]),
          ('b2_rays', [P('@ray', 168, 30, 70, 50, '_sand', '_cream'), P('@ray', 300, 18, 52, 38, '_stone', '_white')]),
          ('b2_bubbles', [P('@bubbles', 136, 40, 16, 110, '_aqua', '_white'), P('@bubbles', 252, 34, 16, 110, '_aqua', '_white')]),
          ('anchors', [P('anchor', 52, 112, 34, 46, '_grey', '_gold'), P('crates', 330, 128, 42, 30, '_darkWood', '_gold')]),
          ('lights', [P('pendant', 186, 6, 28, 30, '_steel', '_aqua'), P('spotlight', 70, 60, 32, 50, '_steel', '_aqua'),
                      P('spotlight', 298, 60, 32, 50, '_steel', '_aqua')]),
          ('ice', [P('bench', 146, 192, 108, 28, '_steel', '_navy'), P('@coralProp', 102, 116, 36, 44, '_coral', '_gold')]),
          ('chains', [P('railing', 0, 172, 120, 24, '_steel', '_aqua'), P('railing', 280, 172, 120, 24, '_steel', '_aqua')]),
      ])),
    L('aquarium_jelly', 84, 27, 'mediumHard',
      ['b2_diver', 'b2_drop', 'fish', 'b2_tide', 'b2_jelly', 'b2_bubble'],
      ['###..###',
       '##.ii.##',
       '#I....I#',
       '..i..i..',
       '..i..i..',
       '#I....I#',
       '##.ii.##',
       '###..###'],  # diamond
      [('b2_jellyfish', 'b2_jelly', 14), ('b2_tanks', 'b2_drop', 13), ('lights', 'b2_bubble', 13), ('b2_fish', 'fish', 13),
       ('seats', 'b2_tide', 12), ('ice', 'ice', 12)],
      [21000, 27500], 0.42,
      ('JELLYFISH ROOM', 'DENİZANASI ODASI'),
      ('Light up the glowing jellyfish.', 'Parlayan denizanalarını aydınlat.'),
      (0xFF4A3A8A, 0xFF1A1440, 0xFF6B4BD6, 0xFFFF7AD9, True),
      dict(backdrop=indoor(0xFF4A4E58, 0xFF27306A, 0xFF3E3E44, 0xFF1E2448, 0xFF34343A, 0xFF161A38, 'tiles', night=True), scenery='_jellyRoom', props=[
          ('b2_jellyfish', [P('@jelly', 150, 18, 52, 76, '_pink', '_lilac'), P('@jelly', 214, 40, 40, 58, '_lilac', '_aqua'),
                            P('@jelly', 346, 14, 38, 54, '_aqua', '_mint')]),
          ('b2_tanks', [P('@columnTank', 34, 36, 54, 140, '_steel', '_aqua'), P('@columnTank', 288, 46, 48, 130, '_steel', '_purple')]),
          ('lights', [P('@porthole', 102, 34, 42, 42, '_brass', '_aqua'), P('@porthole', 344, 92, 40, 40, '_brass', '_pink')]),
          ('b2_fish', [P('@tank', 156, 108, 88, 50, '_steel', '_deep')]),
          ('seats', [P('bench', 108, 188, 78, 28, '_purple', '_steel'), P('bench', 218, 192, 78, 28, '_purple', '_steel')]),
          ('ice', [P('rug', 96, 208, 210, 26, '_navy', '_aqua'), P('plant', 362, 168, 28, 40, '_navy', '_teal')]),
      ])),
    L('aquarium_touch', 85, 27, 'hard',
      ['b2_star', 'b2_drop', 'fish', 'b2_tide', 'wave', 'b2_bubble'],
      ['##.ii.##',
       '##....##',
       'i......i',
       '..I..I..',
       '..I..I..',
       'i......i',
       '##....##',
       '##....##'],  # plus
      [('b2_starfish', 'b2_star', 14), ('pool', 'wave', 14), ('b2_fish', 'fish', 13), ('b2_rays', 'b2_tide', 13),
       ('b2_bubbles', 'b2_bubble', 12), ('ice', 'ice', 10), ('gates', 'key', 2)],
      [21000, 27500], 0.35,
      ('TOUCH POOL', 'DOKUNMA HAVUZU'),
      ('Let little hands meet sea stars.', 'Minik eller deniz yıldızlarıyla tanışsın.'),
      (0xFFD8F8F0, 0xFF4FC8C0, 0xFF1F6F6A, 0xFFFF9A3C),
      dict(backdrop=indoor(0xFFA8B0AE, 0xFFE6FAF4, 0xFF8E9696, 0xFFFFF1DA, 0xFF7E8686, 0xFFF2D59A, 'tiles'), scenery='_touchMural', props=[
          ('pool', [P('@touchPool', 104, 136, 192, 64, '_stone', '_aqua')]),
          ('b2_starfish', [P('@starfishWall', 30, 112, 24, 24, '_orange', '_gold'), P('@starfishWall', 352, 104, 28, 28, '_coral', '_cream'),
                           P('@starfish', 70, 206, 24, 24, '_purple', '_gold')]),
          ('b2_rays', [P('@ray', 40, 28, 70, 50, '_teal', '_cream'), P('@ray', 300, 36, 56, 40, '_sand', '_white')]),
          ('b2_fish', [P('@fish', 150, 36, 40, 24, '_orange', '_white'), P('@fish', 214, 58, 34, 20, '_gold', '_blue')]),
          ('b2_bubbles', [P('@bubbles', 124, 40, 16, 80, '_aqua', '_white'), P('@bubbles', 262, 30, 16, 80, '_aqua', '_white')]),
          ('ice', [P('bench', 16, 180, 76, 28, '_teal', '_steel'), P('plant', 324, 168, 30, 44, '_teal', '_leaf')]),
          ('gates', [P('door', 356, 104, 36, 68, '_teal', '_gold'), P('@bookStack', 300, 196, 30, 30, '_teal', '_orange')]),
      ])),
]

# ============================================================================= FUNFAIR
FUNFAIR = [
    L('funfair_arch', 86, 26, 'mediumHard',
      ['party', 'ticket', 'sign', 'b2_candy', 'icecream', 'spotlight'],
      ['..l..l..',
       '........',
       '.c....c.',
       '..####..',
       '..####..',
       'c.####.c',
       '..####..',
       '..####..'],  # arch
      [('b2_arch', 'sign', 15), ('tickets', 'ticket', 15), ('b2_balloons', 'party', 14), ('b2_treats', 'b2_candy', 14),
       ('ice_cream', 'icecream', 14), ('lights', 'spotlight', 14), ('gates', 'key', 2)],
      [22000, 29000], 0.52,
      ('ENTRANCE ARCH', 'GİRİŞ KEMERİ'),
      ('Light up the funfair entrance.', 'Lunaparkın girişini ışıklandır.'),
      (0xFFFFE0F0, 0xFFFF8AB8, 0xFFB03A6A, 0xFFFFC93C),
      dict(backdrop=outdoor(0xFFA8A296, 0xFFE6D3C0, 150, 'stone', topR=0xFF6EC8FF), scenery='_fairBack', props=[
          ('b2_arch', [P('@fairArch', 118, 26, 164, 134, '_red', '_gold')]),
          ('gates', [P('gate', 150, 104, 100, 54, '_navy', '_gold')]),
          ('tickets', [P('@booth', 16, 92, 66, 78, '_cream', '_red')]),
          ('b2_balloons', [P('@balloons', 88, 108, 32, 64, '_red', '_pink'), P('@balloons', 284, 104, 34, 66, '_blue', '_gold')]),
          ('b2_treats', [P('@popcorn', 326, 112, 56, 70, '_red', '_gold')]),
          ('ice_cream', [P('@iceCart', 30, 176, 70, 54, '_white', '_pink')]),
          ('lights', [P('lamppost', 132, 152, 16, 78, '_navy', '_lampGlow'), P('lamppost', 254, 152, 16, 78, '_navy', '_lampGlow'),
                      P('@bunting', 0, 14, 400, 34, '_red', '_gold')]),
      ])),
    L('funfair_carousel', 87, 27, 'mediumHard',
      ['b2_wheel', 'b2_toy', 'juice', 'b2_candy', 'music', 'spotlight'],
      ['##....##',
       '#.l..l.#',
       '........',
       '.l.LL.l.',
       '........',
       '........',
       '#......#',
       '##....##'],  # octagon
      [('b2_carousel', 'b2_wheel', 15), ('b2_horses', 'b2_toy', 15), ('b2_organ', 'music', 14), ('lights', 'spotlight', 14),
       ('b2_treats', 'b2_candy', 14), ('chains', 'chain', 7)],
      [23000, 30000], 0.45,
      ('CAROUSEL', 'ATLIKARINCA'),
      ('Set the carousel horses prancing.', 'Atlıkarıncanın atlarını yeniden döndür.'),
      (0xFFFFE8C8, 0xFFFFA86B, 0xFF9A4A2E, 0xFFFF6B8B),
      dict(backdrop=outdoor(0xFFA8A296, 0xFFE8D8C4, 150, 'stone', topR=0xFF7CCBFF), scenery='_fairBack', props=[
          ('b2_carousel', [P('@carousel', 112, 36, 176, 158, '_red', '_gold')]),
          ('b2_horses', [P('@poleHorse', 128, 76, 40, 116, '_white', '_gold'), P('@poleHorse', 182, 78, 40, 118, '_pink', '_purple'),
                         P('@poleHorse', 236, 76, 40, 116, '_sky', '_gold')]),
          ('b2_organ', [P('@organ', 16, 118, 76, 74, '_purple', '_red')]),
          ('lights', [P('@bunting', 0, 12, 130, 34, '_red', '_gold'), P('@bunting', 270, 12, 130, 34, '_blue', '_gold'),
                      P('lamppost', 98, 130, 16, 90, '_navy', '_lampGlow')]),
          ('b2_treats', [P('@popcorn', 320, 132, 54, 66, '_pink', '_white'), P('@balloons', 372, 120, 26, 62, '_gold', '_red')]),
          ('chains', [P('fence', 0, 202, 110, 26, '_white', '_white'), P('fence', 290, 204, 110, 26, '_white', '_white')]),
      ])),
    L('funfair_wheel', 88, 27, 'mediumHard',
      ['b2_wheel', 'ticket', 'juice', 'b2_candy', 'music', 'b2_prize'],
      ['........',
       '.l....l.',
       '..#..#..',
       'l.####.l',
       '..####..',
       '..#..#..',
       '........',
       '........'],  # ring
      [('b2_ferris', 'b2_wheel', 14), ('tickets', 'ticket', 14), ('juice_bar', 'juice', 13), ('b2_treats', 'b2_candy', 13),
       ('b2_prizes', 'b2_prize', 13), ('chains', 'chain', 4), ('chests', 'key', 3)],
      [21000, 27500], 0.42,
      ('FERRIS WHEEL', 'DÖNME DOLAP'),
      ('Get the big wheel turning again.', 'Dev çarkı yeniden döndür.'),
      (0xFFD8EEFF, 0xFF7CB8F0, 0xFF2E4A8A, 0xFFFF6B8B),
      dict(backdrop=outdoor(0xFFA8A296, 0xFFDCE6D0, 150, 'sand', topR=0xFF5EB8FF), scenery='_fairBack', props=[
          ('b2_ferris', [P('@ferris', 112, 4, 176, 176, '_steel', '_red')]),
          ('tickets', [P('@booth', 300, 104, 58, 72, '_cream', '_blue')]),
          ('juice_bar', [P('@stall', 14, 104, 92, 72, '_gold', '_leaf')]),
          ('b2_treats', [P('@popcorn', 330, 166, 50, 60, '_pink', '_white'), P('@balloons', 274, 128, 28, 60, '_red', '_gold')]),
          ('b2_prizes', [P('@teddy', 40, 186, 32, 40, '_wood', '_red'), P('@teddy', 294, 196, 28, 34, '_pink', '_blue')]),
          ('chains', [P('bench', 148, 198, 104, 28, '_red', '_gold')]),
          ('chests', [P('crates', 90, 186, 50, 40, '_darkWood', '_gold')]),
      ])),
    L('funfair_stalls', 89, 27, 'mediumHard',
      ['party', 'b2_toy', 'b2_dice', 'b2_candy', 'b2_tent', 'b2_prize'],
      ['..c...##',
       '......##',
       '##...C..',
       '##......',
       '.c....##',
       '....c.##',
       '##......',
       '##......'],  # zigzag
      [('b2_stalls', 'b2_tent', 15), ('b2_prizes', 'b2_prize', 14), ('b2_games', 'b2_dice', 14), ('b2_toys', 'b2_toy', 14),
       ('b2_balloons', 'party', 13), ('crates', 'crate', 5), ('chests', 'key', 2)],
      [22000, 28500], 0.42,
      ('GAME STALLS', 'OYUN STANTLARI'),
      ('Win prizes at the game stalls.', 'Oyun stantlarında ödüller kazan.'),
      (0xFFFFF0C8, 0xFFFFB84A, 0xFFA05A1E, 0xFFE0533F),
      dict(backdrop=outdoor(0xFFA8A296, 0xFFE8D8B8, 150, 'stone', topR=0xFF7CCBFF), scenery='_fairBack', props=[
          ('b2_stalls', [P('@stall', 8, 70, 124, 98, '_red', '_wood'), P('@stall', 268, 70, 124, 98, '_blue', '_wood')]),
          ('b2_games', [P('@striker', 146, 36, 44, 134, '_red', '_gold'), P('champagneTower', 214, 98, 46, 34, '_aqua', '_gold')]),
          ('b2_toys', [P('table', 198, 132, 78, 40, '_wood', '_red'), P('@blocks', 96, 194, 44, 38, '_red', '_gold')]),
          ('b2_prizes', [P('@teddy', 30, 178, 36, 44, '_wood', '_red'), P('@teddy', 328, 182, 32, 40, '_pink', '_blue')]),
          ('b2_balloons', [P('@balloons', 124, 112, 30, 66, '_pink', '_red'), P('@balloons', 280, 150, 30, 64, '_gold', '_blue')]),
          ('crates', [P('crates', 214, 188, 52, 38, '_wood', '_gold'), P('barrel', 360, 200, 28, 30, '_darkWood', '_gold')]),
          ('chests', [P('crates', 150, 194, 52, 36, '_gold', '_red')]),
      ])),
    L('funfair_coaster', 90, 28, 'hard',
      ['b2_wheel', 'ticket', 'juice', 'b2_candy', 'b2_tent', 'spotlight'],
      ['....####',
       '.....###',
       '..l...##',
       '.....l.#',
       '.c..c...',
       '#....l..',
       '##..l...',
       '###.....'],  # staircase
      [('b2_coaster', 'b2_wheel', 15), ('tickets', 'ticket', 14), ('b2_treats', 'b2_candy', 14), ('lights', 'spotlight', 14),
       ('juice_bar', 'juice', 13), ('chains', 'chain', 4), ('gates', 'key', 2)],
      [22000, 28500], 0.33,
      ('ROLLER COASTER', 'HIZ TRENİ'),
      ('Send the coaster flying once more.', 'Hız trenini yeniden uçur.'),
      (0xFFFFD8C8, 0xFFE06A5A, 0xFF8A2E3A, 0xFFFFE066),
      dict(backdrop=outdoor(0xFFA8A296, 0xFFE0CDB8, 150, 'stone', topN=0xFFA0A4B8, topR=0xFFFF9A7A, bottomR=0xFFFFE0A8), scenery='_fairNight', props=[
          ('b2_coaster', [P('@coaster', 8, 14, 384, 154, '_red', '_blue')]),
          ('gates', [P('gate', 232, 132, 68, 44, '_navy', '_gold')]),
          ('tickets', [P('@booth', 156, 112, 60, 74, '_cream', '_red')]),
          ('juice_bar', [P('@stall', 14, 124, 96, 72, '_gold', '_leaf')]),
          ('b2_treats', [P('@popcorn', 326, 150, 54, 66, '_red', '_gold'), P('@balloons', 300, 140, 26, 60, '_pink', '_sky')]),
          ('lights', [P('lamppost', 124, 138, 16, 86, '_navy', '_lampGlow'), P('lamppost', 266, 144, 16, 86, '_navy', '_lampGlow'),
                      P('@bunting', 0, 4, 400, 30, '_gold', '_red')]),
          ('chains', [P('bench', 170, 202, 86, 26, '_red', '_gold'), P('fence', 0, 206, 120, 24, '_white', '_white')]),
      ])),
]

# ============================================================================= BOOKSHOP
BOOKSHOP = [
    L('bookshop_front', 91, 26, 'mediumHard',
      ['chair', 'b2_books', 'sign', 'book', 'awning', 'b2_shop'],
      ['.l....l.',
       '........',
       '...ll...',
       '##....##',
       '##....##',
       '##....##',
       '##....##',
       '##....##'],  # T
      [('b2_shopfront', 'b2_shop', 14), ('awning', 'awning', 14), ('sign', 'sign', 14), ('books', 'book', 13),
       ('b2_book_cart', 'b2_books', 13), ('bench', 'chair', 13), ('chains', 'chain', 4)],
      [20000, 26000], 0.52,
      ('SHOP FRONT', 'DÜKKAN ÖNÜ'),
      ('Polish the bookshop windows.', 'Kitapçının vitrinlerini parlat.'),
      (0xFFFFE8D0, 0xFFE0906A, 0xFF7A3A2A, 0xFF45A7F5),
      dict(backdrop=outdoor(0xFFA8A296, 0xFFD9D2C3, 152, 'stone', topR=0xFF8ED0FF), scenery='_shopFacade', props=[
          ('b2_shopfront', [P('@shopWindow', 34, 62, 116, 74, '_navy', '_red'), P('@shopWindow', 250, 62, 116, 74, '_navy', '_blue')]),
          ('awning', [P('awning', 26, 42, 132, 24, '_red', '_cream'), P('awning', 242, 42, 132, 24, '_red', '_cream')]),
          ('sign', [P('sign', 140, 6, 120, 26, '_navy', '_gold'), P('@hangSign', 228, 56, 46, 40, '_cream', '_red')]),
          ('chains', [P('door', 172, 70, 56, 82, '_navy', '_gold'), P('plant', 150, 118, 22, 36, '_terracotta', '_leaf'),
                      P('plant', 228, 118, 22, 36, '_terracotta', '_leaf')]),
          ('b2_book_cart', [P('@bookCart', 50, 160, 74, 56, '_wood', '_red'), P('@bookCart', 278, 162, 74, 56, '_wood', '_blue')]),
          ('books', [P('@bookStack', 130, 186, 30, 38, '_red', '_blue'), P('@bookStack', 244, 190, 28, 34, '_leaf', '_gold')]),
          ('bench', [P('bench', 166, 196, 70, 28, '_darkWood', '_gold'), P('lamppost', 364, 124, 16, 90, '_navy', '_lampGlow')]),
      ])),
    L('bookshop_nook', 92, 27, 'mediumHard',
      ['furniture', 'b2_books', 'b2_bookmark', 'book', 'window', 'lantern'],
      ['.l..####',
       '....####',
       '..L.####',
       'l...####',
       '....l...',
       '..l...L.',
       '........',
       '........'],  # L
      [('sofas', 'furniture', 14), ('shelves', 'b2_books', 14), ('books', 'book', 14), ('lamps', 'lantern', 13),
       ('decor', 'b2_bookmark', 13), ('windows', 'window', 13), ('chains', 'chain', 7)],
      [21000, 27500], 0.44,
      ('READING NOOK', 'OKUMA KÖŞESİ'),
      ('Make a cosy corner for readers.', 'Okurlar için sıcak bir köşe hazırla.'),
      (0xFFFFE6C8, 0xFFD9905A, 0xFF6E3A22, 0xFFFFB347),
      dict(backdrop=indoor(0xFFA59C8F, 0xFFF2D8B0, 0xFF8D7F6E, 0xFF9A3A3A, 0xFF7E7060, 0xFF7A2B2B, 'carpet'), scenery='_wallpaper', props=[
          ('shelves', [P('bookshelf', 6, 26, 90, 146, '_darkWood', '_red'), P('bookshelf', 304, 26, 90, 146, '_darkWood', '_blue')]),
          ('windows', [P('window', 150, 22, 100, 66, '_cream', '_gold'), P('curtains', 140, 16, 120, 80, '_red', '_gold')]),
          ('sofas', [P('@armchair', 116, 112, 74, 74, '_teal', '_gold'), P('@armchair', 222, 116, 70, 70, '_red', '_cream')]),
          ('lamps', [P('floorLamp', 96, 92, 22, 88, '_gold', '_cream'), P('@deskLamp', 196, 128, 26, 30, '_leaf', '_brass')]),
          ('books', [P('@bookStack', 196, 158, 26, 32, '_red', '_blue'), P('@bookStack', 300, 184, 30, 38, '_purple', '_gold')]),
          ('decor', [P('rug', 104, 196, 192, 34, '_red', '_gold'), P('plant', 56, 160, 32, 48, '_terracotta', '_leaf')]),
          ('chains', [P('@ladder', 78, 34, 40, 140, '_wood', '_brass'), P('clock', 262, 44, 24, 56, '_darkWood', '_gold')]),
      ])),
    L('bookshop_kids', 93, 27, 'mediumHard',
      ['b2_story', 'b2_toy', 'b2_dice', 'b2_pen', 'b2_puzzle', 'shelves'],
      ['..l...c.',
       '....####',
       '.c..####',
       '...l..l.',
       '.c......',
       '....####',
       '..l.####',
       '.....c..'],  # E
      [('b2_picture_books', 'b2_story', 14), ('b2_toys', 'b2_toy', 14), ('b2_crayons', 'b2_pen', 14), ('b2_puzzles', 'b2_puzzle', 13),
       ('shelves', 'shelves', 13), ('chains', 'chain', 4), ('crates', 'crate', 4)],
      [21000, 27500], 0.44,
      ("KIDS' CORNER", 'ÇOCUK KÖŞESİ'),
      ('Fill the kids corner with colour.', 'Çocuk köşesini renklerle doldur.'),
      (0xFFFFF0F8, 0xFFFFA8D0, 0xFF8A4AB0, 0xFF5BCB4B),
      dict(backdrop=indoor(0xFFA8A49C, 0xFFFFF4E6, 0xFF9A948A, 0xFF8ED0FF, 0xFF8A847A, 0xFF6FB8F0, 'carpet'), scenery='_kidsWall', props=[
          ('b2_crayons', [P('@rainbow', 132, 18, 136, 62, '_white', '_white'), P('roundTable', 156, 140, 88, 46, '_gold', '_red')]),
          ('b2_picture_books', [P('shelf', 16, 58, 96, 30, '_wood', '_pink'), P('shelf', 288, 58, 96, 30, '_wood', '_blue'),
                                P('@bookStack', 250, 188, 28, 34, '_pink', '_sky')]),
          ('shelves', [P('bookshelf', 300, 96, 86, 80, '_pink', '_blue'), P('bookshelf', 14, 96, 86, 80, '_sky', '_red')]),
          ('b2_toys', [P('@teddy', 116, 136, 34, 42, '_wood', '_red'), P('@blocks', 60, 190, 46, 40, '_red', '_gold')]),
          ('b2_puzzles', [P('rug', 100, 196, 200, 36, '_leaf', '_gold')]),
          ('chains', [P('@beanbag', 300, 180, 62, 46, '_purple', '_gold'), P('@bunting', 0, 4, 400, 26, '_pink', '_sky')]),
          ('crates', [P('crates', 248, 136, 46, 40, '_red', '_gold'), P('toolbox', 166, 202, 40, 28, '_blue', '_gold')]),
      ])),
    L('bookshop_cafe', 94, 27, 'mediumHard',
      ['menu', 'b2_books', 'juice', 'pie', 'b2_cafe', 'decor_cup'],
      ['####.l..',
       '###....l',
       '##.l....',
       '#.....l.',
       '.l..L...',
       '......l.',
       '..l.....',
       '........'],  # slope
      [('menu_board', 'menu', 15), ('b2_espresso', 'b2_cafe', 15), ('baking', 'pie', 14), ('b2_cups', 'decor_cup', 14),
       ('books', 'b2_books', 14), ('chains', 'chain', 7)],
      [22000, 28500], 0.40,
      ('CAFÉ COUNTER', 'KAFE TEZGÂHI'),
      ('Brew coffee among the books.', 'Kitapların arasında kahve demle.'),
      (0xFFF6E0C8, 0xFFB8805A, 0xFF5A3A2A, 0xFFFF9A3C),
      dict(backdrop=indoor(0xFFA0968C, 0xFFE8C8A8, 0xFF8D7F6E, 0xFFC98A52, 0xFF7E7060, 0xFFB9763F, 'planks'), scenery='_cafeWall', props=[
          ('menu_board', [P('menuBoard', 120, 22, 96, 62, '_wood', '_gold')]),
          ('b2_cups', [P('shelf', 248, 38, 128, 34, '_darkWood', '_cream'), P('shelf', 248, 76, 128, 30, '_darkWood', '_pink')]),
          ('b2_espresso', [P('counter', 212, 130, 180, 46, '_darkWood', '_cream'), P('@espresso', 300, 86, 56, 46, '_steel', '_red')]),
          ('baking', [P('@cakeStand', 228, 92, 38, 40, '_pink', '_red'), P('@cakeStand', 358, 96, 30, 36, '_cream', '_gold')]),
          ('books', [P('bookshelf', 8, 34, 86, 138, '_darkWood', '_red'), P('@bookStack', 100, 184, 30, 38, '_leaf', '_blue')]),
          ('chains', [P('roundTable', 128, 148, 70, 42, '_cream', '_red'), P('chair', 100, 150, 26, 44, '_wood', '_red'),
                      P('chair', 200, 152, 26, 44, '_wood', '_red')]),
      ])),
    L('bookshop_rare', 95, 27, 'hard',
      ['b2_story', 'b2_books', 'b2_bookmark', 'globe', 'scroll', 'hourglass'],
      ['.l....l.',
       '..L..L..',
       '........',
       '###..###',
       '###..###',
       '........',
       '.l....l.',
       '........'],  # two floors
      [('b2_rare_books', 'b2_books', 15), ('scrolls', 'scroll', 14), ('globes', 'globe', 14), ('clocks', 'hourglass', 14),
       ('display_cases', 'b2_bookmark', 14), ('chains', 'chain', 7), ('chests', 'key', 2)],
      [22000, 28500], 0.32,
      ('RARE BOOKS ROOM', 'NADİR KİTAPLAR'),
      ('Unlock the oldest books in town.', 'Şehrin en eski kitaplarının kilidini aç.'),
      (0xFFE8D8C0, 0xFF8A5A3A, 0xFF4A2A1A, 0xFFFFC93C),
      dict(backdrop=indoor(0xFF8E857A, 0xFFB8946A, 0xFF7D7064, 0xFF8A2B2B, 0xFF6E6254, 0xFF6E2020, 'carpet'), scenery='_rareWall', props=[
          ('b2_rare_books', [P('bookshelf', 6, 20, 96, 152, '_darkWood', '_red'), P('bookshelf', 298, 20, 96, 152, '_darkWood', '_gold')]),
          ('display_cases', [P('@rareCase', 150, 118, 100, 62, '_darkWood', '_gold')]),
          ('globes', [P('@globe', 106, 122, 42, 58, '_blue', '_brass')]),
          ('clocks', [P('clock', 258, 84, 30, 96, '_darkWood', '_gold'), P('painting', 168, 34, 64, 48, '_gold', '_navy')]),
          ('scrolls', [P('@scrolls', 304, 172, 40, 50, '_terracotta', '_red'), P('@scrolls', 52, 176, 36, 46, '_terracotta', '_gold')]),
          ('chains', [P('chandelier', 166, 0, 68, 34, '_gold', '_white'), P('@deskLamp', 260, 196, 30, 34, '_leaf', '_brass')]),
          ('chests', [P('crates', 120, 190, 56, 40, '_darkWood', '_gold')]),
      ])),
]

# ============================================================================= OBSERVATORY
_obsNightOut = dict(topN=0xFF6A6E86, topR=0xFF2A2F7A, bottomN=0xFF9A98A8, bottomR=0xFF8A6AC8, night=True)
OBSERVATORY = [
    L('observatory_path', 96, 26, 'mediumHard',
      ['b2_star', 'fence', 'bench', 'grass', 'b2_hike', 'tree'],
      ['###..###',
       '##....##',
       '##.jj.##',
       '#......#',
       '#.l..l.#',
       '........',
       '.c....c.',
       '........'],  # pyramid
      [('b2_path', 'b2_hike', 14), ('tree', 'tree', 14), ('fence', 'fence', 14), ('bench', 'bench', 13),
       ('grass', 'grass', 13), ('lights', 'b2_star', 13), ('chains', 'chain', 4)],
      [21000, 27500], 0.50,
      ('HILLTOP PATH', 'TEPE YOLU'),
      ('Light the path up to the stars.', 'Yıldızlara çıkan yolu aydınlat.'),
      (0xFF6A5AB8, 0xFF2A2468, 0xFF8A6AE6, 0xFFFFE066, True),
      dict(backdrop=outdoor(0xFF7E8470, 0xFF4E8A5A, 140, 'sand', **_obsNightOut), scenery='_hillNight', props=[
          ('tree', [P('tree', 0, 56, 62, 112, '_pine', '_white'), P('tree', 344, 74, 56, 96, '_pine', '_white')]),
          ('fence', [P('fence', 234, 150, 110, 26, '_wood', '_wood'), P('fence', 60, 144, 90, 26, '_wood', '_wood')]),
          ('b2_path', [P('path', 160, 168, 110, 70, '_stone', '_stone'), P('@signpost', 112, 132, 44, 70, '_wood', '_cream')]),
          ('lights', [P('lamppost', 148, 104, 16, 88, '_navy', '_lampGlow'), P('lamppost', 270, 96, 16, 84, '_navy', '_lampGlow'),
                      P('@comet', 40, 14, 70, 30, '_white', '_lampGlow')]),
          ('bench', [P('bench', 290, 190, 82, 30, '_wood', '_gold')]),
          ('grass', [P('bush', 70, 196, 64, 32, '_green', '_lampGlow'), P('flowerbed', 286, 222, 90, 16, '_lilac', '_white')]),
          ('chains', [P('@telescope', 20, 160, 52, 62, '_white', '_brass'), P('@rock', 210, 214, 50, 22, '_stone', '_leaf')]),
      ])),
    L('observatory_dome', 97, 27, 'mediumHard',
      ['b2_star', 'b2_moon', 'b2_satellite', 'globe', 'compass', 'b2_lens'],
      ['##....##',
       '#.j..j.#',
       '........',
       '.i.II.i.',
       '........',
       '..j..j..',
       '........',
       '........'],  # dome
      [('b2_telescope', 'b2_satellite', 16), ('b2_dome', 'b2_moon', 15), ('maps', 'compass', 15), ('globes', 'globe', 15),
       ('b2_lenses', 'b2_lens', 14), ('ice', 'ice', 8), ('chains', 'chain', 4)],
      [25000, 32500], 0.42,
      ('TELESCOPE DOME', 'TELESKOP KUBBESİ'),
      ('Aim the great telescope skyward.', 'Büyük teleskobu gökyüzüne çevir.'),
      (0xFF4A4A9A, 0xFF1E1E50, 0xFF6B6BD6, 0xFFFFC93C, True),
      dict(backdrop=indoor(0xFF5A5E68, 0xFF3A4A8A, 0xFF5E5A54, 0xFF6E6A80, 0xFF4E4A44, 0xFF56526A, 'tiles', night=True), scenery='_domeInterior', props=[
          ('b2_dome', [P('@moon', 184, 26, 32, 32, '_cream', '_lampGlow'), P('@planet', 76, 30, 64, 40, '_orange', '_gold'),
                       P('@planet', 268, 40, 56, 36, '_blue', '_aqua')]),
          ('maps', [P('@starChart', 16, 80, 58, 66, '_wood', '_gold'), P('@starChart', 326, 80, 58, 66, '_wood', '_gold')]),
          ('b2_telescope', [P('@bigScope', 136, 44, 128, 136, '_white', '_navy')]),
          ('globes', [P('@globe', 340, 148, 40, 58, '_blue', '_brass'), P('@orrery', 28, 160, 56, 56, '_brass', '_aqua')]),
          ('b2_lenses', [P('table', 86, 168, 70, 36, '_wood', '_aqua'), P('@telescope', 268, 160, 50, 56, '_steel', '_brass')]),
          ('ice', [P('rug', 120, 206, 160, 26, '_navy', '_gold')]),
          ('chains', [P('railing', 0, 150, 70, 22, '_steel', '_navy'), P('railing', 330, 150, 70, 22, '_steel', '_navy')]),
      ])),
    L('observatory_planetarium', 98, 27, 'mediumHard',
      ['b2_star', 'b2_moon', 'beacon', 'b2_rocket', 'b2_radar', 'b2_lens'],
      ['..i..i..',
       'i......i',
       '..#..#..',
       '..####..',
       '..####..',
       '..#..#..',
       '.i....i.',
       '........'],  # ring
      [('b2_projector', 'b2_lens', 14), ('b2_planets', 'b2_radar', 14), ('b2_stars', 'b2_star', 14), ('b2_rockets', 'b2_rocket', 13),
       ('seats', 'b2_moon', 13), ('ice', 'ice', 6), ('doors', 'key', 2)],
      [22000, 28500], 0.42,
      ('PLANETARIUM', 'PLANETARYUM'),
      ('Fill the dome with a sky of stars.', 'Kubbeyi yıldızlı bir gökle doldur.'),
      (0xFF3A2A7A, 0xFF120E30, 0xFF8A5CE6, 0xFF8ED8FF, True),
      dict(backdrop=indoor(0xFF4A4A54, 0xFF1E2050, 0xFF3E3E44, 0xFF2B2440, 0xFF34343A, 0xFF201A34, 'carpet', night=True), scenery='_planetariumSky', props=[
          ('b2_planets', [P('@planet', 36, 26, 70, 44, '_orange', '_gold'), P('@planet', 296, 34, 60, 40, '_blue', '_aqua'),
                          P('@moon', 230, 20, 24, 24, '_steel', '_white')]),
          ('b2_stars', [P('@starW', 128, 18, 18, 18, '_gold', '_lampGlow'), P('@starW', 268, 82, 14, 14, '_white', '_sky'),
                        P('@comet', 150, 60, 80, 30, '_white', '_sky')]),
          ('b2_projector', [P('@starProjector', 156, 96, 88, 84, '_steel', '_lampGlow')]),
          ('b2_rockets', [P('@rocket', 352, 92, 36, 88, '_white', '_red'), P('console', 66, 138, 64, 38, '_navy', '_aqua')]),
          ('seats', [P('cinemaSeats', 14, 184, 140, 40, '_purple', '_gold'), P('cinemaSeats', 246, 184, 140, 40, '_purple', '_gold')]),
          ('ice', [P('rug', 150, 200, 100, 30, '_navy', '_aqua')]),
          ('doors', [P('door', 14, 98, 40, 74, '_purple', '_gold')]),
      ])),
    L('observatory_library', 99, 27, 'mediumHard',
      ['b2_star', 'b2_moon', 'b2_bookmark', 'book', 'scroll', 'hourglass'],
      ['###..###',
       '##l..l##',
       '#..cc..#',
       '.l....l.',
       '.l....l.',
       '#..cc..#',
       '##....##',
       '###..###'],  # diamond
      [('maps', 'scroll', 13), ('books', 'book', 13), ('b2_constellations', 'b2_star', 13), ('clocks', 'hourglass', 13),
       ('globes', 'b2_moon', 12), ('chains', 'chain', 6), ('crates', 'crate', 4)],
      [20000, 26000], 0.40,
      ('STAR MAP LIBRARY', 'GÖK HARİTALARI'),
      ('Sort the old star charts.', 'Eski gök haritalarını düzenle.'),
      (0xFF4A5AA8, 0xFF1E2458, 0xFF8B5E3C, 0xFFFFC93C, True),
      dict(backdrop=indoor(0xFF6E6E78, 0xFF34407A, 0xFF7D7064, 0xFF8B5E3C, 0xFF6E6254, 0xFF6E4B3A, 'planks', night=True), scenery='_starLibrary', props=[
          ('books', [P('bookshelf', 6, 28, 88, 144, '_darkWood', '_gold'), P('bookshelf', 306, 28, 88, 144, '_darkWood', '_blue')]),
          ('maps', [P('@starChart', 98, 34, 46, 56, '_wood', '_gold'), P('@starChart', 256, 34, 46, 56, '_wood', '_sky')]),
          ('b2_constellations', [P('@starW', 196, 6, 14, 14, '_gold', '_lampGlow'), P('@starW', 118, 100, 12, 12, '_white', '_sky'),
                                 P('@starW', 276, 100, 12, 12, '_white', '_sky')]),
          ('clocks', [P('clock', 266, 110, 26, 70, '_darkWood', '_gold')]),
          ('globes', [P('@globe', 104, 124, 40, 56, '_navy', '_brass'), P('@orrery', 182, 112, 40, 40, '_brass', '_aqua')]),
          ('chains', [P('table', 150, 150, 100, 40, '_wood', '_cream'), P('@ladder', 70, 30, 36, 140, '_wood', '_brass')]),
          ('crates', [P('@scrolls', 40, 184, 38, 46, '_terracotta', '_gold'), P('crates', 316, 188, 56, 40, '_darkWood', '_gold')]),
      ])),
    L('observatory_roof', 100, 28, 'hard',
      ['b2_star', 'b2_moon', 'b2_satellite', 'b2_rocket', 'compass', 'lantern'],
      ['###..###',
       '##.jj.##',
       '#.i..i.#',
       '.c....c.',
       '..J..J..',
       '##....##',
       '##....##',
       '##....##'],  # arrow
      [('b2_telescope', 'b2_satellite', 14), ('b2_stars', 'b2_star', 14), ('b2_rockets', 'b2_rocket', 13), ('lights', 'lantern', 13),
       ('maps', 'compass', 13), ('ice', 'ice', 6), ('gates', 'key', 2)],
      [20000, 26000], 0.30,
      ('ROOFTOP DECK', 'ÇATI TERASI'),
      ('Watch the night sky from the roof.', 'Çatıdan gece gökyüzünü izle.'),
      (0xFF3A3A8A, 0xFF101030, 0xFF8A6AE6, 0xFFFFE066, True),
      dict(backdrop=outdoor(0xFF7E7A74, 0xFF8B6A52, 152, 'stone', skyline=True, **_obsNightOut), scenery='_roofDeck', props=[
          ('b2_stars', [P('@starW', 120, 16, 18, 18, '_gold', '_lampGlow'), P('@starW', 250, 40, 14, 14, '_white', '_sky'),
                        P('@comet', 150, 50, 86, 32, '_white', '_lampGlow')]),
          ('lights', [P('stringLights', 90, 28, 220, 34, '_gold', '_pink'), P('lantern', 96, 104, 24, 40, '_ink', '_lampGlow'),
                      P('lantern', 282, 104, 24, 40, '_ink', '_lampGlow')]),
          ('gates', [P('door', 30, 102, 30, 50, '_navy', '_gold')]),
          ('b2_telescope', [P('@telescope', 146, 104, 108, 104, '_white', '_brass'), P('@telescope', 60, 150, 56, 60, '_steel', '_brass')]),
          ('b2_rockets', [P('@rocket', 336, 118, 38, 92, '_white', '_red')]),
          ('maps', [P('table', 252, 176, 76, 36, '_wood', '_cream'), P('@orrery', 270, 140, 36, 38, '_brass', '_aqua')]),
          ('ice', [P('railing', 0, 154, 400, 24, '_steel', '_sky'), P('lounger', 92, 204, 70, 32, '_navy', '_lampGlow')]),
      ])),
]

CHAPTERS = [
    {'id': 'zoo', 'number': 16, 'icon': 'pets', 'name': ('ZOO', 'HAYVANAT BAHÇESİ'),
     'doc': 'CHAPTER 16 — ZOO. Crate-heavy chapter with shaped pens.', 'levels': ZOO},
    {'id': 'aquarium', 'number': 17, 'icon': 'scuba_diving', 'name': ('AQUARIUM', 'AKVARYUM'),
     'doc': 'CHAPTER 17 — AQUARIUM. Ice everywhere: frozen glass and chilly tanks.', 'levels': AQUARIUM},
    {'id': 'funfair', 'number': 18, 'icon': 'attractions', 'name': ('FUNFAIR', 'LUNAPARK'),
     'doc': 'CHAPTER 18 — FUNFAIR. Keys (prize chests) and chains on playful shapes.', 'levels': FUNFAIR},
    {'id': 'bookshop', 'number': 19, 'icon': 'local_library', 'name': ('BOOKSHOP', 'KİTAPÇI'),
     'doc': 'CHAPTER 19 — BOOKSHOP. A chain chapter: locked shelves and rare books.', 'levels': BOOKSHOP},
    {'id': 'observatory', 'number': 20, 'icon': 'nights_stay', 'name': ('OBSERVATORY', 'GÖZLEMEVİ'),
     'doc': 'CHAPTER 20 — OBSERVATORY. Night scenes; every mechanic at once.', 'levels': OBSERVATORY},
]
