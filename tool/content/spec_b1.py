# Content batch 1: chapters 11-15 (levels 51-75).
# Generate with: python3 tool/content/gen_batch.py 1

BATCH = 1
FIRST_NUMBER = 51
PREV_CHAPTER = 'theater'

NEW_TILES = {
    # Bakery
    'b1_bread': ('breakfast_dining', 0),
    'b1_croissant': ('bakery_dining', 1),
    'b1_cookie': ('cookie', 2),
    'b1_mixer': ('blender', 3),
    'b1_shop': ('storefront', 3),
    'b1_oven': ('microwave', 4),
    'b1_coffee': ('local_cafe', 4),
    'b1_cake': ('cake', 5),
    # Greenhouse
    'b1_compost': ('compost', 1),
    'b1_thermo': ('thermostat', 1),
    'b1_bee': ('hive', 2),
    'b1_seedling': ('eco', 3),
    'b1_orchid': ('filter_vintage', 5),
    # Vineyard
    'b1_bottle': ('liquor', 0),
    'b1_cask': ('oil_barrel', 1),
    'b1_sunset': ('wb_twilight', 1),
    'b1_vine': ('energy_savings_leaf', 3),
    'b1_basket': ('shopping_basket', 4),
    'b1_grape': ('bubble_chart', 5),
    # Train station
    'b1_seat': ('event_seat', 0),
    'b1_tram': ('tram', 0),
    'b1_clock': ('schedule', 2),
    'b1_paper': ('newspaper', 3),
    'b1_train': ('train', 4),
    'b1_route': ('signpost', 5),
    # School
    'b1_ball': ('sports_soccer', 0),
    'b1_bolt': ('bolt', 0),
    'b1_bell': ('notifications', 0),
    'b1_bag': ('backpack', 1),
    'b1_ruler': ('straighten', 1),
    'b1_hoop': ('sports_basketball', 1),
    'b1_record': ('album', 1),
    'b1_pencil': ('edit', 2),
    'b1_dumbbell': ('fitness_center', 3),
    'b1_calc': ('calculate', 4),
    'b1_bus': ('directions_bus', 4),
    'b1_school': ('school', 5),
    'b1_flask': ('biotech', 5),
    'b1_volley': ('sports_volleyball', 5),
}

NEW_OBJECTIVES = {
    'b1_breads': ('Bread', 'Ekmekler'),
    'b1_pastries': ('Pastries', 'Hamur İşleri'),
    'b1_ovens': ('Ovens', 'Fırınlar'),
    'b1_dough': ('Dough', 'Hamur'),
    'b1_cakes': ('Cakes', 'Pastalar'),
    'b1_cookies': ('Cookies', 'Kurabiyeler'),
    'b1_mixers': ('Mixers', 'Mikserler'),
    'b1_flour': ('Flour Sacks', 'Un Çuvalları'),
    'b1_beans': ('Coffee Beans', 'Kahve Çekirdeği'),
    'b1_coffee': ('Coffee', 'Kahve'),
    'b1_seedlings': ('Seedlings', 'Fideler'),
    'b1_compost': ('Compost', 'Kompost'),
    'b1_orchids': ('Orchids', 'Orkideler'),
    'b1_misters': ('Misters', 'Nemlendiriciler'),
    'b1_heaters': ('Heaters', 'Isıtıcılar'),
    'b1_bees': ('Bees', 'Arılar'),
    'b1_watering': ('Watering Cans', 'Sulama Kapları'),
    'b1_lilies': ('Water Lilies', 'Nilüferler'),
    'b1_vines': ('Grapevines', 'Asmalar'),
    'b1_grapes': ('Grapes', 'Üzümler'),
    'b1_baskets': ('Baskets', 'Sepetler'),
    'b1_tractor': ('Tractor', 'Traktör'),
    'b1_press': ('Grape Press', 'Üzüm Cenderesi'),
    'b1_bottles': ('Bottles', 'Şişeler'),
    'b1_casks': ('Casks', 'Fıçılar'),
    'b1_sunset': ('Sunset View', 'Gün Batımı'),
    'b1_trains': ('Trains', 'Trenler'),
    'b1_timetable': ('Timetables', 'Tarifeler'),
    'b1_papers': ('Newspapers', 'Gazeteler'),
    'b1_locomotive': ('Locomotive', 'Lokomotif'),
    'b1_balls': ('Balls', 'Toplar'),
    'b1_backpacks': ('Backpacks', 'Sırt Çantaları'),
    'b1_bus': ('School Bus', 'Okul Servisi'),
    'b1_desks': ('Desks', 'Sıralar'),
    'b1_pencils': ('Pencils', 'Kalemler'),
    'b1_board': ('Blackboard', 'Yazı Tahtası'),
    'b1_beakers': ('Beakers', 'Deney Kapları'),
    'b1_microscopes': ('Microscopes', 'Mikroskoplar'),
    'b1_circuits': ('Circuits', 'Devreler'),
    'b1_hoops': ('Hoops', 'Potalar'),
    'b1_weights': ('Weights', 'Ağırlıklar'),
    'b1_records': ('Records', 'Plaklar'),
}

# ============================================================================ DART
DART_COMMON = r'''
const _wood = Color(0xFFC98A52);
const _darkWood = Color(0xFF8B5E3C);
const _cream = Color(0xFFFFF1DA);
const _gold = Color(0xFFFFC93C);
const _red = Color(0xFFE0533F);
const _leaf = Color(0xFF55C04A);
const _green = Color(0xFF4FB548);
const _pink = Color(0xFFFF7AB6);
const _rose = Color(0xFFFFB3C7);
const _blue = Color(0xFF45A7F5);
const _aqua = Color(0xFF4FD6E8);
const _teal = Color(0xFF2EA59A);
const _white = Color(0xFFFFFFFF);
const _lampGlow = Color(0xFFFFE9A0);
const _navy = Color(0xFF2B3A67);
const _orange = Color(0xFFFF9A3C);
const _flame = Color(0xFFFFB347);
const _steel = Color(0xFFC9CCD8);
const _terracotta = Color(0xFFE07A4F);
const _straw = Color(0xFFE8C66B);
const _purple = Color(0xFF8A5CE6);
const _lilac = Color(0xFFC9A0FF);
const _brick = Color(0xFFB5523B);
const _crust = Color(0xFFD9963E);
const _flour = Color(0xFFF5EBDD);
const _burlap = Color(0xFFC8A878);
const _choc = Color(0xFF6B3E26);
const _mint = Color(0xFF9FE3C9);
const _grape = Color(0xFF6A3D8F);
const _wine = Color(0xFF8E2442);
const _olive = Color(0xFF7C8B3A);
const _pine = Color(0xFF2E7D4F);
const _cypress = Color(0xFF2F6B3F);
const _yellow = Color(0xFFFFD447);
const _coal = Color(0xFF3B3452);
const _ebony = Color(0xFF2B2440);
const _sky = Color(0xFF8ED8FF);
const _board = Color(0xFF2F5D4A);
const _copper = Color(0xFFD9824A);
const _cardboard = Color(0xFFD2A86E);

const _ink = Color(0xFF3B3452);
const _iron = Color(0xFF4A4458);
const _soil = Color(0xFF6B4A2E);
const _leafDark = Color(0xFF3E9A3A);
const _glassTint = Color(0xFFDDF4FF);

Offset _at(Rect r, double fx, double fy) => Offset(r.left + r.width * fx, r.top + r.height * fy);
Rect _in(Rect r, double fx, double fy, double fw, double fh) =>
    Rect.fromLTWH(r.left + r.width * fx, r.top + r.height * fy, r.width * fw, r.height * fh);

void _leafAt(Canvas c, Offset o, double s, double ang, Color col) {
  c.save();
  c.translate(o.dx, o.dy);
  c.rotate(ang);
  c.drawOval(Rect.fromCenter(center: Offset(0, -s), width: s * 1.1, height: s * 2.2), Pk.fill(col));
  c.restore();
}

/// A bunch of grapes hanging from [top].
void _bunch(Canvas c, Offset top, double s, Color col) {
  c.drawLine(top + Offset(0, -s), top + Offset(s * 0.8, -s * 2.2), Pk.stroke(const Color(0xFF6B4A2A), max(1.0, s * 0.45)));
  for (var row = 0; row < 4; row++) {
    final n = 4 - row;
    for (var i = 0; i < n; i++) {
      final o = top + Offset((i - (n - 1) / 2) * s * 1.6, row * s * 1.45);
      c.drawCircle(o, s, Pk.fill(row.isEven ? col : Pk.dark(col, 0.12)));
      c.drawCircle(o + Offset(-s * 0.3, -s * 0.3), s * 0.32, Pk.fill(Pk.light(col, 0.4)));
    }
  }
}

/// A scored loaf of bread filling [r].
void _loaf(Canvas c, Rect r, Color col) {
  c.drawOval(r, Pk.fill(col));
  c.drawOval(Rect.fromLTWH(r.left + r.width * 0.15, r.top + 1, r.width * 0.5, r.height * 0.35), Pk.fill(Pk.light(col, 0.3)));
  for (var k = 0; k < 3; k++) {
    final x = r.left + r.width * (0.28 + k * 0.2);
    c.drawLine(Offset(x, r.top + r.height * 0.22), Offset(x + r.width * 0.08, r.top + r.height * 0.58), Pk.stroke(Pk.dark(col, 0.28), 1.1));
  }
}

void _blossom(Canvas c, Offset o, double s, Color col, [Color heart = const Color(0xFFFFE066)]) {
  for (var i = 0; i < 5; i++) {
    final a = i * 2 * pi / 5 - pi / 2;
    c.drawCircle(o + Offset(cos(a), sin(a)) * s * 0.75, s * 0.6, Pk.fill(i.isEven ? col : Pk.dark(col, 0.08)));
  }
  c.drawCircle(o, s * 0.38, Pk.fill(heart));
}

/// Simple trestle legs under a slab table top at [top] (height [th]).
void _tableLegs(Canvas c, Rect r, double top, Color col) {
  final leg = Pk.fill(Pk.dark(col, 0.3));
  c.drawRect(Rect.fromLTWH(r.left + r.width * 0.06, top, r.width * 0.05, r.bottom - top), leg);
  c.drawRect(Rect.fromLTWH(r.right - r.width * 0.11, top, r.width * 0.05, r.bottom - top), leg);
}

/// A potted sprout or herb.
void _sprout(Canvas c, Offset base, double s, Color leafCol, double t, int i) {
  final sway = sin(t * 1.5 + i) * s * 0.08;
  c.drawLine(base, base + Offset(sway, -s), Pk.stroke(_leafDark, max(1.0, s * 0.1)));
  _leafAt(c, base + Offset(sway, -s), s * 0.32, -0.9, leafCol);
  _leafAt(c, base + Offset(sway, -s), s * 0.32, 0.9, Pk.dark(leafCol, 0.12));
}
'''

DART_BAKERY = r'''
// ============================================================ BAKERY
void _paintBreadShelf(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, r, a, radius: 3);
  c.drawRect(r.deflate(4), Pk.fill(Pk.dark(a, 0.42)));
  for (var s = 0; s < 2; s++) {
    final y = r.top + h * (0.47 + s * 0.47);
    final n = max(3, (w / 20).floor());
    for (var i = 0; i < n; i++) {
      final cx = r.left + 4 + (w - 8) * (i + 0.5) / n;
      final lw = (w - 8) / n * 0.9;
      final col = (i + s).isEven ? b : Pk.light(b, 0.18);
      if ((i + s) % 3 == 1) {
        for (var k = -1; k <= 1; k++) {
          c.save();
          c.translate(cx + k * lw * 0.2, y - h * 0.2);
          c.rotate(k * 0.2);
          _loaf(c, Rect.fromCenter(center: Offset.zero, width: lw * 0.28, height: h * 0.34), Pk.dark(col, 0.06));
          c.restore();
        }
      } else {
        _loaf(c, Rect.fromCenter(center: Offset(cx, y - h * 0.1), width: lw, height: h * 0.2), col);
      }
    }
    Pk.box(c, Rect.fromLTWH(r.left - 2, y - 1, w + 4, 4), Pk.light(a, 0.1), radius: 1);
  }
}

const _breadShelf = CustomProp(_paintBreadShelf, wall: true);

void _paintOven(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, _in(r, 0.42, 0.0, 0.16, 0.2), Pk.dark(a, 0.25), radius: 1);
  final dome = Path()
    ..moveTo(r.left + w * 0.05, r.top + h * 0.56)
    ..quadraticBezierTo(r.left + w * 0.05, r.top + h * 0.12, r.center.dx, r.top + h * 0.12)
    ..quadraticBezierTo(r.right - w * 0.05, r.top + h * 0.12, r.right - w * 0.05, r.top + h * 0.56)
    ..close();
  c.drawPath(dome, Pk.fill(a));
  c.drawPath(dome, Pk.stroke(Pk.dark(a, 0.3), 1.2));
  Pk.box(c, _in(r, 0.0, 0.52, 1.0, 0.48), Pk.dark(a, 0.08), radius: 3);
  final mortar = Pk.stroke(Pk.light(a, 0.3).withValues(alpha: 0.7), 1);
  for (var row = 0; row < 3; row++) {
    final y = r.top + h * (0.64 + row * 0.12);
    c.drawLine(Offset(r.left + 3, y), Offset(r.right - 3, y), mortar);
    for (var i = 0; i < 6; i++) {
      final x = r.left + w * (i + (row.isEven ? 0.5 : 0.0)) / 6;
      if (x > r.left + 3 && x < r.right - 3) {
        c.drawLine(Offset(x, y), Offset(x, y + h * 0.12), mortar);
      }
    }
  }
  final mouth = _in(r, 0.28, 0.3, 0.44, 0.3);
  c.drawRRect(
    RRect.fromRectAndCorners(mouth, topLeft: Radius.circular(mouth.width / 2), topRight: Radius.circular(mouth.width / 2)),
    Pk.fill(const Color(0xFF2A1A14)),
  );
  Pk.glow(c, mouth.center + Offset(0, h * 0.05), w * 0.4, b, 0.55);
  for (var i = 0; i < 3; i++) {
    final fx = mouth.left + mouth.width * (0.25 + i * 0.25);
    final fh = mouth.height * (0.45 + 0.15 * sin(t * 7 + i * 2));
    Pk.poly(c, [Offset(fx - mouth.width * 0.13, mouth.bottom), Offset(fx, mouth.bottom - fh), Offset(fx + mouth.width * 0.13, mouth.bottom)],
        Pk.fill(i == 1 ? Pk.light(b, 0.35) : b));
  }
  c.drawRect(Rect.fromLTWH(mouth.left - 4, mouth.bottom, mouth.width + 8, 3), Pk.fill(_ink));
}

const _oven = CustomProp(_paintOven);

void _paintCake(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width;
  c.drawRect(_in(r, 0.45, 0.86, 0.1, 0.1), Pk.fill(const Color(0xFFD9D2C3)));
  c.drawOval(_in(r, 0.26, 0.93, 0.48, 0.07), Pk.fill(const Color(0xFFD9D2C3)));
  c.drawOval(_in(r, 0.02, 0.8, 0.96, 0.09), Pk.fill(const Color(0xFFF4EFE6)));
  final tiers = [_in(r, 0.08, 0.58, 0.84, 0.25), _in(r, 0.2, 0.36, 0.6, 0.24), _in(r, 0.31, 0.16, 0.38, 0.22)];
  for (var i = 0; i < 3; i++) {
    final tr = tiers[i];
    Pk.box(c, tr, i.isEven ? a : Pk.light(a, 0.12), radius: 3);
    // Icing drips.
    final n = max(3, (tr.width / 7).floor());
    for (var k = 0; k < n; k++) {
      final x = tr.left + tr.width * (k + 0.5) / n;
      c.drawOval(Rect.fromCenter(center: Offset(x, tr.top + tr.height * 0.2), width: tr.width / n * 0.9, height: tr.height * (0.3 + 0.2 * Pk.rand(k + i * 7))),
          Pk.fill(Colors.white.withValues(alpha: 0.9)));
    }
    c.drawRect(Rect.fromLTWH(tr.left, tr.top + tr.height * 0.66, tr.width, tr.height * 0.12), Pk.fill(b));
    for (var k = 0; k < 3; k++) {
      c.drawCircle(Offset(tr.left + tr.width * (0.2 + k * 0.3), tr.top + tr.height * 0.45), w * 0.025, Pk.fill(Pk.light(b, 0.2)));
    }
  }
  c.drawCircle(_at(r, 0.5, 0.11), w * 0.06, Pk.fill(const Color(0xFFE0293F)));
  c.drawLine(_at(r, 0.5, 0.07), _at(r, 0.56, 0.0), Pk.stroke(_leafDark, 1.2));
}

const _cake = CustomProp(_paintCake);

void _paintVitrine(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width;
  Pk.box(c, _in(r, 0, 0.55, 1, 0.45), a, radius: 3);
  c.drawRect(_in(r, 0.04, 0.7, 0.92, 0.05), Pk.fill(b));
  final glass = _in(r, 0.02, 0.04, 0.96, 0.53);
  final rr = RRect.fromRectAndRadius(glass, const Radius.circular(4));
  c.drawRRect(rr, Pk.fill(_glassTint.withValues(alpha: 0.6)));
  for (var s = 0; s < 2; s++) {
    final y = glass.top + glass.height * (0.46 + s * 0.46);
    c.drawLine(Offset(glass.left + 2, y), Offset(glass.right - 2, y), Pk.stroke(Colors.white, 1.5));
    final n = max(4, (w / 15).floor());
    for (var i = 0; i < n; i++) {
      final cx = glass.left + glass.width * (i + 0.5) / n;
      final col = [b, const Color(0xFFE8B05A), const Color(0xFFFF9EC4), const Color(0xFF8B5E3C), const Color(0xFF9FE3C9)][(i + s * 2) % 5];
      final pr = glass.height * 0.15;
      if ((i + s) % 3 == 0) {
        c.drawArc(Rect.fromCenter(center: Offset(cx, y - 1), width: pr * 2.4, height: pr * 2.2), pi, pi, true, Pk.fill(col));
      } else if ((i + s) % 3 == 1) {
        c.drawCircle(Offset(cx, y - pr * 0.85), pr * 0.85, Pk.fill(col));
        c.drawCircle(Offset(cx - pr * 0.3, y - pr * 1.1), pr * 0.25, Pk.fill(Colors.white.withValues(alpha: 0.6)));
      } else {
        // A croissant.
        c.drawArc(Rect.fromCenter(center: Offset(cx, y - 1), width: pr * 2.4, height: pr * 1.6), pi, pi, true, Pk.fill(const Color(0xFFE8A048)));
        c.drawLine(Offset(cx, y - pr * 0.8), Offset(cx, y - 1), Pk.stroke(const Color(0xFFB8762E), 1));
      }
    }
  }
  c.drawRRect(rr, Pk.stroke(Pk.dark(a, 0.2), 2));
  c.drawLine(glass.topLeft + Offset(w * 0.12, 4), glass.topLeft + Offset(w * 0.05, glass.height * 0.6), Pk.stroke(Colors.white.withValues(alpha: 0.75), 2));
}

const _vitrine = CustomProp(_paintVitrine);

void _paintSack(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final body = Path()
    ..moveTo(r.left + w * 0.26, r.top + h * 0.2)
    ..quadraticBezierTo(r.left, r.top + h * 0.42, r.left + w * 0.05, r.bottom - h * 0.07)
    ..quadraticBezierTo(r.center.dx, r.bottom + h * 0.03, r.right - w * 0.05, r.bottom - h * 0.07)
    ..quadraticBezierTo(r.right, r.top + h * 0.42, r.right - w * 0.26, r.top + h * 0.2)
    ..close();
  c.drawPath(body, Pk.fill(a));
  Pk.poly(c, [_at(r, 0.3, 0.02), _at(r, 0.7, 0.02), _at(r, 0.62, 0.21), _at(r, 0.38, 0.21)], Pk.fill(Pk.light(a, 0.12)));
  c.drawLine(_at(r, 0.34, 0.21), _at(r, 0.66, 0.21), Pk.stroke(Pk.dark(a, 0.45), 2));
  final lc = _at(r, 0.5, 0.6);
  c.drawCircle(lc, w * 0.2, Pk.stroke(b, 1.6));
  c.drawLine(lc + Offset(0, w * 0.13), lc - Offset(0, w * 0.13), Pk.stroke(b, 1.3));
  for (var k = 0; k < 3; k++) {
    final y = lc.dy - w * 0.08 + k * w * 0.07;
    c.drawOval(Rect.fromCenter(center: Offset(lc.dx - w * 0.05, y), width: w * 0.07, height: w * 0.04), Pk.fill(b));
    c.drawOval(Rect.fromCenter(center: Offset(lc.dx + w * 0.05, y), width: w * 0.07, height: w * 0.04), Pk.fill(b));
  }
  c.drawOval(_in(r, 0.3, 0.0, 0.4, 0.09), Pk.fill(Colors.white.withValues(alpha: 0.85)));
}

const _sack = CustomProp(_paintSack);

void _paintMixer(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, _in(r, 0.05, 0.84, 0.9, 0.16), a, radius: 3);
  Pk.box(c, _in(r, 0.1, 0.22, 0.24, 0.66), a, radius: 4);
  Pk.box(c, _in(r, 0.1, 0.06, 0.84, 0.26), a, radius: 6);
  c.drawCircle(_at(r, 0.86, 0.19), r.width * 0.05, Pk.fill(Pk.dark(a, 0.2)));
  c.drawLine(_at(r, 0.62, 0.32), _at(r, 0.62, 0.62), Pk.stroke(_steel, 2));
  final bowl = Path()
    ..moveTo(r.left + r.width * 0.38, r.top + r.height * 0.5)
    ..lineTo(r.left + r.width * 0.88, r.top + r.height * 0.5)
    ..quadraticBezierTo(r.left + r.width * 0.86, r.top + r.height * 0.86, r.left + r.width * 0.63, r.top + r.height * 0.86)
    ..quadraticBezierTo(r.left + r.width * 0.4, r.top + r.height * 0.86, r.left + r.width * 0.38, r.top + r.height * 0.5)
    ..close();
  c.drawPath(bowl, Pk.fill(b));
  c.drawOval(_in(r, 0.38, 0.45, 0.5, 0.1), Pk.fill(_flour));
  c.drawLine(_at(r, 0.47, 0.58), _at(r, 0.52, 0.76), Pk.stroke(Colors.white.withValues(alpha: 0.7), 1.5));
}

const _mixer = CustomProp(_paintMixer);

void _paintCoffeeMachine(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, _in(r, 0.04, 0.12, 0.92, 0.88), a, radius: 4);
  // Cups warming on top.
  for (var i = 0; i < 3; i++) {
    final cr = _in(r, 0.14 + i * 0.26, 0.0, 0.18, 0.12);
    c.drawRRect(RRect.fromRectAndCorners(cr, bottomLeft: Radius.circular(cr.width * 0.4), bottomRight: Radius.circular(cr.width * 0.4)), Pk.fill(Colors.white));
  }
  Pk.box(c, _in(r, 0.1, 0.2, 0.8, 0.18), Pk.light(a, 0.2), radius: 2);
  c.drawCircle(_at(r, 0.3, 0.29), h * 0.05, Pk.fill(b));
  c.drawCircle(_at(r, 0.5, 0.29), h * 0.05, Pk.fill(_steel));
  c.drawCircle(_at(r, 0.7, 0.29), h * 0.05, Pk.fill(b));
  for (final fx in [0.3, 0.7]) {
    Pk.box(c, Rect.fromCenter(center: _at(r, fx, 0.5), width: w * 0.2, height: h * 0.08), _ink, radius: 2);
    c.drawRect(Rect.fromCenter(center: _at(r, fx, 0.58), width: w * 0.04, height: h * 0.06), Pk.fill(_ink));
    final cup = Rect.fromCenter(center: _at(r, fx, 0.76), width: w * 0.16, height: h * 0.12);
    c.drawRRect(RRect.fromRectAndCorners(cup, bottomLeft: Radius.circular(cup.width * 0.4), bottomRight: Radius.circular(cup.width * 0.4)), Pk.fill(Colors.white));
    for (var k = 0; k < 2; k++) {
      final ph = (t * 0.6 + k * 0.5 + fx) % 1;
      c.drawCircle(Offset(cup.center.dx + sin(ph * 6) * 2, cup.top - ph * h * 0.12), 1.6 + ph * 1.5, Pk.fill(Colors.white.withValues(alpha: 0.6 * (1 - ph))));
    }
  }
  c.drawRect(_in(r, 0.08, 0.84, 0.84, 0.05), Pk.fill(Pk.dark(a, 0.3)));
  c.drawLine(_at(r, 0.92, 0.42), _at(r, 0.98, 0.7), Pk.stroke(_steel, 2));
}

const _coffeeMachine = CustomProp(_paintCoffeeMachine);

void _paintCupcakes(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawRRect(RRect.fromRectAndRadius(_in(r, 0, 0.86, 1, 0.14), const Radius.circular(2)), Pk.fill(_steel));
  for (var i = 0; i < 3; i++) {
    final cx = r.left + r.width * (0.18 + i * 0.32);
    final cw = r.width * 0.28;
    final base = r.top + r.height * 0.86;
    Pk.poly(c, [Offset(cx - cw * 0.5, base - r.height * 0.36), Offset(cx + cw * 0.5, base - r.height * 0.36), Offset(cx + cw * 0.38, base), Offset(cx - cw * 0.38, base)],
        Pk.fill(i == 1 ? b : Pk.light(b, 0.25)));
    final col = [a, Pk.light(a, 0.25), const Color(0xFFFFF4E0)][i];
    c.drawOval(Rect.fromCenter(center: Offset(cx, base - r.height * 0.42), width: cw * 1.15, height: r.height * 0.22), Pk.fill(col));
    c.drawOval(Rect.fromCenter(center: Offset(cx, base - r.height * 0.56), width: cw * 0.8, height: r.height * 0.18), Pk.fill(Pk.light(col, 0.1)));
    c.drawOval(Rect.fromCenter(center: Offset(cx, base - r.height * 0.68), width: cw * 0.45, height: r.height * 0.13), Pk.fill(Pk.light(col, 0.2)));
    c.drawCircle(Offset(cx, base - r.height * 0.8), r.height * 0.06, Pk.fill(const Color(0xFFE0293F)));
  }
}

const _cupcakes = CustomProp(_paintCupcakes);

void _paintPretzelSign(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawRect(_in(r, 0, 0.0, 0.9, 0.06), Pk.fill(_iron));
  c.drawLine(_at(r, 0.0, 0.0), _at(r, 0.3, 0.06), Pk.stroke(_iron, 1.5));
  final sway = sin(t * 1.3) * 0.05;
  c.save();
  c.translate(r.left + w * 0.55, r.top + h * 0.06);
  c.rotate(sway);
  final p = Pk.stroke(_iron, 1);
  c.drawLine(Offset(-w * 0.2, 0), Offset(-w * 0.25, h * 0.16), p);
  c.drawLine(Offset(w * 0.2, 0), Offset(w * 0.25, h * 0.16), p);
  final board = Rect.fromLTWH(-w * 0.42, h * 0.16, w * 0.84, h * 0.78);
  Pk.box(c, board, a, radius: w * 0.25, outline: Pk.dark(a, 0.35));
  // A pretzel.
  final pz = Pk.stroke(b, max(2.0, w * 0.09));
  final cc = board.center;
  final s = board.width * 0.28;
  c.drawArc(Rect.fromCircle(center: cc + Offset(-s * 0.55, -s * 0.15), radius: s * 0.62), pi * 0.7, pi * 1.7, false, pz);
  c.drawArc(Rect.fromCircle(center: cc + Offset(s * 0.55, -s * 0.15), radius: s * 0.62), -pi * 0.4, pi * 1.7, false, pz);
  c.drawLine(cc + Offset(-s * 0.7, s * 0.55), cc + Offset(s * 0.4, -s * 0.3), pz);
  c.drawLine(cc + Offset(s * 0.7, s * 0.55), cc + Offset(-s * 0.4, -s * 0.3), pz);
  c.restore();
}

const _pretzelSign = CustomProp(_paintPretzelSign, wall: true);

void _paintBreadBasket(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  // Baguettes standing up in the basket.
  for (var i = 0; i < 4; i++) {
    c.save();
    c.translate(r.left + w * (0.28 + i * 0.15), r.top + h * 0.42);
    c.rotate((i - 1.5) * 0.18);
    _loaf(c, Rect.fromCenter(center: Offset.zero, width: w * 0.16, height: h * 0.8), i.isEven ? b : Pk.light(b, 0.15));
    c.restore();
  }
  final basket = Path()
    ..moveTo(r.left, r.top + h * 0.48)
    ..lineTo(r.right, r.top + h * 0.48)
    ..lineTo(r.right - w * 0.1, r.bottom)
    ..lineTo(r.left + w * 0.1, r.bottom)
    ..close();
  c.drawPath(basket, Pk.fill(a));
  for (var k = 0; k < 3; k++) {
    final y = r.top + h * (0.6 + k * 0.13);
    c.drawLine(Offset(r.left + w * 0.05, y), Offset(r.right - w * 0.05, y), Pk.stroke(Pk.dark(a, 0.25), 1.2));
  }
  for (var k = 1; k < 6; k++) {
    final x = r.left + w * k / 6;
    c.drawLine(Offset(x, r.top + h * 0.5), Offset(x + (x < r.center.dx ? 2 : -2), r.bottom - 1), Pk.stroke(Pk.dark(a, 0.18), 1));
  }
  c.drawRect(Rect.fromLTWH(r.left - 1, r.top + h * 0.46, w + 2, h * 0.06), Pk.fill(Pk.dark(a, 0.15)));
}

const _breadBasket = CustomProp(_paintBreadBasket);

void _paintSandwichBoard(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawLine(_at(r, 0.2, 0.05), _at(r, 0.04, 1), Pk.stroke(Pk.dark(a, 0.2), 2.5));
  c.drawLine(_at(r, 0.8, 0.05), _at(r, 0.96, 1), Pk.stroke(Pk.dark(a, 0.2), 2.5));
  final face = Path()
    ..moveTo(r.left + w * 0.22, r.top)
    ..lineTo(r.right - w * 0.22, r.top)
    ..lineTo(r.right - w * 0.08, r.top + h * 0.8)
    ..lineTo(r.left + w * 0.08, r.top + h * 0.8)
    ..close();
  c.drawPath(face, Pk.fill(a));
  final board = Path()
    ..moveTo(r.left + w * 0.28, r.top + h * 0.07)
    ..lineTo(r.right - w * 0.28, r.top + h * 0.07)
    ..lineTo(r.right - w * 0.16, r.top + h * 0.72)
    ..lineTo(r.left + w * 0.16, r.top + h * 0.72)
    ..close();
  c.drawPath(board, Pk.fill(_board));
  c.drawLine(_at(r, 0.36, 0.18), _at(r, 0.64, 0.18), Pk.stroke(b, 1.6));
  for (var i = 0; i < 3; i++) {
    final y = 0.32 + i * 0.12;
    c.drawLine(_at(r, 0.3, y), _at(r, 0.3 + 0.25 + Pk.rand(i) * 0.15, y), Pk.stroke(Colors.white.withValues(alpha: 0.85), 1.1));
  }
  c.drawCircle(_at(r, 0.7, 0.55), w * 0.06, Pk.fill(_pink));
}

const _sandwichBoard = CustomProp(_paintSandwichBoard);

void _paintShopWindow(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, r.inflate(3), a, radius: 3);
  Pk.gradientRect(c, r, const Color(0xFF5C7FA8), const Color(0xFFA9D2EE));
  // Display steps with bread and cakes.
  for (var s = 0; s < 2; s++) {
    final y = r.top + h * (0.55 + s * 0.38);
    c.drawRect(Rect.fromLTWH(r.left + w * (0.1 - s * 0.1), y, w * (0.8 + s * 0.2), h * 0.06), Pk.fill(Colors.white));
    final n = max(3, (w / 24).floor()) + s;
    for (var i = 0; i < n; i++) {
      final cx = r.left + w * (0.14 - s * 0.08 + (0.72 + s * 0.16) * (i + 0.5) / n);
      if ((i + s).isEven) {
        _loaf(c, Rect.fromCenter(center: Offset(cx, y - h * 0.1), width: w * 0.14, height: h * 0.2), b);
      } else {
        Pk.box(c, Rect.fromCenter(center: Offset(cx, y - h * 0.12), width: w * 0.1, height: h * 0.22), const Color(0xFFFFB3C7), radius: 2);
        c.drawCircle(Offset(cx, y - h * 0.26), h * 0.04, Pk.fill(const Color(0xFFE0293F)));
      }
    }
  }
  c.drawLine(r.topLeft + Offset(w * 0.06, h * 0.45), r.topLeft + Offset(w * 0.2, h * 0.06), Pk.stroke(Colors.white.withValues(alpha: 0.55), 3));
  c.drawLine(r.topLeft + Offset(w * 0.14, h * 0.4), r.topLeft + Offset(w * 0.24, h * 0.12), Pk.stroke(Colors.white.withValues(alpha: 0.4), 1.5));
  // Gold lettering arc.
  for (var i = 0; i < 9; i++) {
    final k = i / 8;
    c.drawCircle(Offset(r.left + w * (0.3 + k * 0.4), r.top + h * (0.2 - sin(k * pi) * 0.08)), 1.6, Pk.fill(_gold));
  }
}

const _shopWindow = CustomProp(_paintShopWindow, wall: true);

void _paintKneadTable(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  _tableLegs(c, r, r.top + h * 0.2, a);
  c.drawRect(Rect.fromLTWH(r.left + w * 0.06, r.top + h * 0.72, w * 0.88, h * 0.08), Pk.fill(Pk.dark(a, 0.3)));
  Pk.box(c, _in(r, 0, 0, 1, 0.24), a, radius: 2);
  // Flour dust on the top.
  c.drawOval(_in(r, 0.25, 0.02, 0.45, 0.12), Pk.fill(b.withValues(alpha: 0.85)));
  c.drawCircle(_at(r, 0.8, 0.07), h * 0.04, Pk.fill(b.withValues(alpha: 0.7)));
}

const _kneadTable = CustomProp(_paintKneadTable);

void _paintDough(Canvas c, Rect r, Color a, Color b, double t) {
  // Dough ball and a rolling pin (sits on a table top).
  final w = r.width, h = r.height;
  c.drawOval(_in(r, 0.0, 0.25, 0.48, 0.75), Pk.fill(a));
  c.drawOval(_in(r, 0.08, 0.32, 0.18, 0.2), Pk.fill(Pk.light(a, 0.4)));
  Pk.box(c, _in(r, 0.58, 0.55, 0.36, 0.35), b, radius: h * 0.15);
  c.drawLine(_at(r, 0.52, 0.72), _at(r, 0.6, 0.72), Pk.stroke(Pk.dark(b, 0.3), h * 0.12));
  c.drawLine(_at(r, 0.92, 0.72), _at(r, 1.0, 0.72), Pk.stroke(Pk.dark(b, 0.3), h * 0.12));
  c.drawCircle(Offset(r.left + w * 0.3, r.top + h * 0.55), 0.8, Pk.fill(Pk.dark(a, 0.2)));
}

const _dough = CustomProp(_paintDough);

void _paintEggBowl(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (var i = 0; i < 4; i++) {
    c.drawOval(Rect.fromCenter(center: Offset(r.left + w * (0.25 + i * 0.17), r.top + h * (i.isEven ? 0.38 : 0.3)), width: w * 0.2, height: h * 0.45),
        Pk.fill(i.isEven ? const Color(0xFFFFF4E0) : const Color(0xFFE8C9A0)));
  }
  c.drawArc(Rect.fromLTWH(r.left, r.top + h * 0.05, w, h * 1.9), 0, pi, true, Pk.fill(a));
  c.drawArc(Rect.fromLTWH(r.left, r.top + h * 0.05, w, h * 1.9), 0, pi, false, Pk.stroke(b, 1.5));
  c.drawRect(Rect.fromLTWH(r.left - 1, r.top + h * 0.48, w + 2, 2), Pk.fill(Pk.light(a, 0.2)));
}

const _eggBowl = CustomProp(_paintEggBowl);

void _paintPlateRack(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, _in(r, 0, 0.82, 1, 0.18), a, radius: 2);
  c.drawRect(_in(r, 0.02, 0.0, 0.05, 0.9), Pk.fill(a));
  c.drawRect(_in(r, 0.93, 0.0, 0.05, 0.9), Pk.fill(a));
  c.drawRect(_in(r, 0, 0.0, 1, 0.08), Pk.fill(Pk.dark(a, 0.1)));
  final n = max(4, (w / 12).floor());
  for (var i = 0; i < n; i++) {
    final cx = r.left + w * (0.12 + 0.76 * (i + 0.5) / n);
    final rad = min(w / n * 0.62, h * 0.36);
    c.drawCircle(Offset(cx, r.top + h * 0.82 - rad), rad, Pk.fill(Colors.white));
    c.drawCircle(Offset(cx, r.top + h * 0.82 - rad), rad * 0.72, Pk.stroke(i.isEven ? b : Pk.light(b, 0.3), 1.5));
  }
  for (var i = 0; i < 5; i++) {
    c.drawLine(Offset(r.left + w * (0.1 + i * 0.2), r.top + h * 0.82), Offset(r.left + w * (0.1 + i * 0.2), r.top + h * 0.55), Pk.stroke(Pk.dark(a, 0.2), 1.2));
  }
}

const _plateRack = CustomProp(_paintPlateRack, wall: true);

void _paintDecoTable(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  _tableLegs(c, r, r.top + h * 0.5, _darkWood);
  final cloth = Path()
    ..moveTo(r.left, r.top)
    ..lineTo(r.right, r.top)
    ..lineTo(r.right + 2, r.top + h * 0.55)
    ..lineTo(r.left - 2, r.top + h * 0.55)
    ..close();
  c.drawPath(cloth, Pk.fill(a));
  final n = max(5, (w / 12).floor());
  for (var i = 0; i < n; i++) {
    c.drawArc(Rect.fromLTWH(r.left - 2 + (w + 4) * i / n, r.top + h * 0.45, (w + 4) / n, h * 0.2), 0, pi, true, Pk.fill(b));
  }
  c.drawRect(Rect.fromLTWH(r.left, r.top, w, 3), Pk.fill(Pk.light(a, 0.3)));
}

const _decoTable = CustomProp(_paintDecoTable);

void _paintCookieJar(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, _in(r, 0.25, 0.0, 0.5, 0.16), b, radius: 3);
  c.drawCircle(_at(r, 0.5, 0.02), w * 0.08, Pk.fill(b));
  final jar = RRect.fromRectAndRadius(_in(r, 0.05, 0.14, 0.9, 0.86), Radius.circular(w * 0.25));
  c.drawRRect(jar, Pk.fill(_glassTint.withValues(alpha: 0.7)));
  for (var i = 0; i < 6; i++) {
    final o = Offset(r.left + w * (0.28 + (i % 3) * 0.22), r.top + h * (0.82 - (i ~/ 3) * 0.24));
    c.drawCircle(o, w * 0.13, Pk.fill(a));
    for (var k = 0; k < 3; k++) {
      c.drawCircle(o + Offset((Pk.rand(i * 3 + k) - 0.5) * w * 0.14, (Pk.rand(i * 5 + k) - 0.5) * w * 0.14), w * 0.025, Pk.fill(_choc));
    }
  }
  c.drawRRect(jar, Pk.stroke(Colors.white, 1.5));
  c.drawLine(_at(r, 0.2, 0.3), _at(r, 0.2, 0.6), Pk.stroke(Colors.white.withValues(alpha: 0.8), 2));
}

const _cookieJar = CustomProp(_paintCookieJar);

void _paintIceCreamCart(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  // Umbrella.
  c.drawLine(_at(r, 0.5, 0.1), _at(r, 0.5, 0.5), Pk.stroke(_steel, 2));
  final canopy = Path()
    ..moveTo(r.left + w * 0.05, r.top + h * 0.24)
    ..quadraticBezierTo(r.center.dx, r.top - h * 0.06, r.right - w * 0.05, r.top + h * 0.24)
    ..close();
  c.drawPath(canopy, Pk.fill(b));
  for (var i = 0; i < 3; i++) {
    final x0 = r.left + w * (0.18 + i * 0.32);
    Pk.poly(c, [Offset(r.center.dx, r.top + h * 0.03), Offset(x0 - w * 0.07, r.top + h * 0.24), Offset(x0 + w * 0.07, r.top + h * 0.24)], Pk.fill(Colors.white));
  }
  // Cart body with scoops.
  Pk.box(c, _in(r, 0.05, 0.5, 0.9, 0.36), a, radius: 4);
  for (var i = 0; i < 4; i++) {
    c.drawCircle(Offset(r.left + w * (0.2 + i * 0.2), r.top + h * 0.5), h * 0.07, Pk.fill([_rose, _mint, _choc, _yellow][i]));
  }
  c.drawRect(_in(r, 0.05, 0.62, 0.9, 0.06), Pk.fill(b));
  for (final fx in [0.2, 0.8]) {
    c.drawCircle(_at(r, fx, 0.9), h * 0.09, Pk.fill(_ink));
    c.drawCircle(_at(r, fx, 0.9), h * 0.035, Pk.fill(_steel));
  }
}

const _iceCreamCart = CustomProp(_paintIceCreamCart);

void _paintGiftBoxes(Canvas c, Rect r, Color a, Color b, double t) {
  final boxes = [(0.0, 0.42, 0.56, 0.58, a), (0.5, 0.52, 0.5, 0.48, b), (0.14, 0.0, 0.4, 0.44, Pk.light(b, 0.3))];
  for (final (x, y, bw, bh, col) in boxes) {
    final br = _in(r, x, y, bw, bh);
    Pk.box(c, br, col, radius: 2);
    final rib = col == a ? b : a;
    c.drawRect(Rect.fromCenter(center: br.center, width: br.width * 0.14, height: br.height), Pk.fill(rib));
    c.drawRect(Rect.fromCenter(center: br.center, width: br.width, height: br.height * 0.12), Pk.fill(rib));
    c.drawOval(Rect.fromCenter(center: br.topCenter + Offset(-br.width * 0.12, -2), width: br.width * 0.24, height: br.height * 0.18), Pk.stroke(rib, 2));
    c.drawOval(Rect.fromCenter(center: br.topCenter + Offset(br.width * 0.12, -2), width: br.width * 0.24, height: br.height * 0.18), Pk.stroke(rib, 2));
  }
}

const _giftBoxes = CustomProp(_paintGiftBoxes);

void _paintBreadRack(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final rail = Pk.fill(a);
  c.drawRect(_in(r, 0.04, 0.0, 0.06, 0.9), rail);
  c.drawRect(_in(r, 0.9, 0.0, 0.06, 0.9), rail);
  for (var s = 0; s < 4; s++) {
    final y = r.top + h * (0.2 + s * 0.22);
    c.drawRect(Rect.fromLTWH(r.left + w * 0.04, y, w * 0.92, 3), Pk.fill(Pk.dark(a, 0.15)));
    for (var i = 0; i < 3; i++) {
      _loaf(c, Rect.fromLTWH(r.left + w * (0.12 + i * 0.27), y - h * 0.11, w * 0.24, h * 0.11), (i + s).isEven ? b : Pk.light(b, 0.15));
    }
  }
  for (final fx in [0.1, 0.9]) {
    c.drawCircle(_at(r, fx, 0.95), w * 0.05, Pk.fill(_ink));
  }
}

const _breadRack = CustomProp(_paintBreadRack);

void _paintCafeTable(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawRect(_in(r, 0.47, 0.3, 0.06, 0.62), Pk.fill(_iron));
  c.drawOval(_in(r, 0.25, 0.9, 0.5, 0.1), Pk.fill(_iron));
  c.drawOval(_in(r, 0.0, 0.22, 1.0, 0.16), Pk.fill(Pk.dark(a, 0.2)));
  c.drawOval(_in(r, 0.0, 0.18, 1.0, 0.16), Pk.fill(a));
  // Cup and a croissant on top.
  final cup = _in(r, 0.18, 0.0, 0.18, 0.22);
  c.drawRRect(RRect.fromRectAndCorners(cup, bottomLeft: Radius.circular(cup.width * 0.4), bottomRight: Radius.circular(cup.width * 0.4)), Pk.fill(Colors.white));
  c.drawArc(Rect.fromLTWH(cup.right - 2, cup.top + cup.height * 0.2, cup.width * 0.5, cup.height * 0.5), -pi / 2, pi, false, Pk.stroke(Colors.white, 1.5));
  c.drawArc(Rect.fromCenter(center: _at(r, 0.66, 0.22), width: w * 0.32, height: h * 0.24), pi, pi, true, Pk.fill(b));
  c.drawLine(_at(r, 0.66, 0.11), _at(r, 0.66, 0.22), Pk.stroke(Pk.dark(b, 0.3), 1));
}

const _cafeTable = CustomProp(_paintCafeTable);
'''

DART_GREEN = r'''
// ============================================================ GREENHOUSE
void _paintGlassPane(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final top = Path()
    ..moveTo(r.left, r.bottom)
    ..lineTo(r.left, r.top + h * 0.22)
    ..quadraticBezierTo(r.center.dx, r.top - h * 0.12, r.right, r.top + h * 0.22)
    ..lineTo(r.right, r.bottom)
    ..close();
  c.drawPath(top, Pk.fill(b.withValues(alpha: 0.55)));
  c.save();
  c.clipPath(top);
  for (var i = 0; i < 3; i++) {
    final x = r.left + w * (0.15 + i * 0.3) + sin(t * 0.4 + i) * 3;
    c.drawLine(Offset(x, r.bottom), Offset(x + w * 0.3, r.top), Pk.stroke(Colors.white.withValues(alpha: 0.35), 4));
  }
  c.restore();
  final frame = Pk.stroke(a, 2.5);
  c.drawPath(top, frame);
  for (var i = 1; i < 4; i++) {
    final x = r.left + w * i / 4;
    c.drawLine(Offset(x, r.bottom), Offset(x, r.top + h * 0.12), frame);
  }
  for (final fy in [0.45, 0.72]) {
    c.drawLine(_at(r, 0, fy), _at(r, 1, fy), frame);
  }
}

const _glassPane = CustomProp(_paintGlassPane, wall: true);

void _paintOrchid(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  _leafAt(c, _at(r, 0.46, 0.74), w * 0.16, -1.15, _leafDark);
  _leafAt(c, _at(r, 0.54, 0.74), w * 0.16, 1.15, _leaf);
  final sway = sin(t * 1.2 + r.left) * w * 0.02;
  final p0 = _at(r, 0.5, 0.72), p1 = _at(r, 0.36, 0.18), p2 = Offset(r.left + w * 0.8 + sway, r.top + h * 0.14);
  final stem = Path()
    ..moveTo(p0.dx, p0.dy)
    ..quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
  c.drawPath(stem, Pk.stroke(const Color(0xFF5E8A3A), max(1.2, w * 0.035)));
  for (var i = 0; i < 5; i++) {
    final k = 0.38 + i * 0.15;
    final pt = p0 * ((1 - k) * (1 - k)) + p1 * (2 * k * (1 - k)) + p2 * (k * k);
    _blossom(c, pt, w * (0.12 - i * 0.012), i.isEven ? b : Pk.light(b, 0.25), const Color(0xFFFFE9A0));
  }
  Pk.poly(c, [_at(r, 0.22, 0.74), _at(r, 0.78, 0.74), _at(r, 0.7, 1), _at(r, 0.3, 1)], Pk.fill(a));
  c.drawRect(_in(r, 0.18, 0.71, 0.64, 0.06), Pk.fill(Pk.dark(a, 0.1)));
}

const _orchid = CustomProp(_paintOrchid);

void _paintSeedTray(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final n = max(4, (w / 9).floor());
  for (var i = 0; i < n; i++) {
    final x = r.left + w * (i + 0.5) / n;
    _sprout(c, Offset(x, r.top + h * 0.58), h * (0.35 + 0.18 * Pk.rand(i + r.left.toInt())), b, t, i);
  }
  Pk.box(c, _in(r, 0, 0.55, 1, 0.45), a, radius: 2);
  c.drawRect(_in(r, 0.02, 0.55, 0.96, 0.1), Pk.fill(_soil));
  for (var i = 1; i < 4; i++) {
    c.drawLine(_at(r, i / 4, 0.62), _at(r, i / 4, 0.98), Pk.stroke(Pk.dark(a, 0.2), 1));
  }
}

const _seedTray = CustomProp(_paintSeedTray);

void _paintWateringCan(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawLine(_at(r, 0.68, 0.62), _at(r, 0.98, 0.18), Pk.stroke(a, max(2.0, h * 0.09)));
  Pk.box(c, Rect.fromCenter(center: _at(r, 0.97, 0.16), width: w * 0.12, height: h * 0.14), Pk.dark(a, 0.1), radius: 2);
  c.drawArc(_in(r, 0.12, 0.08, 0.5, 0.6), pi, pi, false, Pk.stroke(Pk.dark(a, 0.15), max(2.0, h * 0.07)));
  Pk.box(c, _in(r, 0.05, 0.36, 0.66, 0.64), a, radius: h * 0.12);
  c.drawRect(_in(r, 0.05, 0.52, 0.66, 0.08), Pk.fill(b));
  final drop = (t * 1.5) % 1;
  c.drawCircle(Offset(r.left + w * 1.0, r.top + h * (0.28 + drop * 0.5)), 1.4, Pk.fill(_sky.withValues(alpha: 1 - drop)));
}

const _wateringCan = CustomProp(_paintWateringCan);

void _paintFlowerPots(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (var i = 0; i < 3; i++) {
    final cx = r.left + w * (0.18 + i * 0.32);
    final pw = w * 0.26;
    final top = r.top + h * (i == 1 ? 0.5 : 0.56);
    for (var k = 0; k < 3; k++) {
      final fx = cx + (k - 1) * pw * 0.32;
      final fy = top - h * (0.22 + Pk.rand(i * 3 + k) * 0.2);
      c.drawLine(Offset(fx, top), Offset(fx, fy), Pk.stroke(_leafDark, 1.2));
      _blossom(c, Offset(fx, fy), h * 0.08, [b, _pink, _yellow][(i + k) % 3]);
    }
    _leafAt(c, Offset(cx - pw * 0.15, top), h * 0.1, -0.8, _leaf);
    _leafAt(c, Offset(cx + pw * 0.15, top), h * 0.1, 0.8, _leafDark);
    Pk.poly(c, [Offset(cx - pw / 2, top), Offset(cx + pw / 2, top), Offset(cx + pw * 0.38, r.bottom), Offset(cx - pw * 0.38, r.bottom)], Pk.fill(a));
    c.drawRect(Rect.fromLTWH(cx - pw * 0.55, top - 1, pw * 1.1, h * 0.08), Pk.fill(Pk.dark(a, 0.1)));
  }
}

const _flowerPots = CustomProp(_paintFlowerPots);

void _paintCactus(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final g = Pk.fill(const Color(0xFF4FA35A));
  c.drawRRect(RRect.fromRectAndRadius(_in(r, 0.36, 0.08, 0.28, 0.66), Radius.circular(w * 0.14)), g);
  c.drawRRect(RRect.fromRectAndRadius(_in(r, 0.1, 0.3, 0.18, 0.3), Radius.circular(w * 0.09)), g);
  c.drawRect(_in(r, 0.18, 0.5, 0.2, 0.08), g);
  c.drawRRect(RRect.fromRectAndRadius(_in(r, 0.72, 0.22, 0.18, 0.28), Radius.circular(w * 0.09)), g);
  c.drawRect(_in(r, 0.62, 0.42, 0.18, 0.08), g);
  c.drawLine(_at(r, 0.5, 0.14), _at(r, 0.5, 0.7), Pk.stroke(const Color(0xFF3E8A48), 1));
  _blossom(c, _at(r, 0.5, 0.08), w * 0.1, b);
  Pk.poly(c, [_at(r, 0.2, 0.72), _at(r, 0.8, 0.72), _at(r, 0.72, 1), _at(r, 0.28, 1)], Pk.fill(a));
}

const _cactus = CustomProp(_paintCactus);

void _paintThermo(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, r, a, radius: w * 0.4, outline: Pk.dark(a, 0.3));
  c.drawRRect(RRect.fromRectAndRadius(_in(r, 0.38, 0.1, 0.24, 0.66), Radius.circular(w * 0.12)), Pk.fill(Colors.white));
  final lvl = 0.42 + 0.06 * sin(t * 0.7);
  c.drawRect(_in(r, 0.42, lvl, 0.16, 0.76 - lvl), Pk.fill(b));
  c.drawCircle(_at(r, 0.5, 0.82), w * 0.2, Pk.fill(b));
  for (var i = 0; i < 5; i++) {
    c.drawLine(_at(r, 0.66, 0.18 + i * 0.12), _at(r, 0.8, 0.18 + i * 0.12), Pk.stroke(Pk.dark(a, 0.4), 1));
  }
  c.drawCircle(_at(r, 0.5, 0.06), 1.5, Pk.fill(_ink));
}

const _thermo = CustomProp(_paintThermo, wall: true);

void _paintLilyPond(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawOval(r, Pk.fill(const Color(0xFFB8AE9A)));
  c.drawOval(r.deflate(min(w, h) * 0.08), Pk.fill(a));
  final inner = r.deflate(min(w, h) * 0.08);
  c.save();
  c.clipPath(Path()..addOval(inner));
  for (var i = 0; i < 3; i++) {
    final ph = (t * 0.25 + i / 3) % 1;
    final fx = inner.left + inner.width * ((0.2 + i * 0.3 + ph * 0.3) % 1);
    final fy = inner.top + inner.height * (0.35 + 0.3 * sin(ph * 2 * pi + i));
    c.drawOval(Rect.fromCenter(center: Offset(fx, fy), width: w * 0.07, height: h * 0.07), Pk.fill(i == 1 ? Colors.white : _orange));
    Pk.poly(c, [Offset(fx - w * 0.035, fy), Offset(fx - w * 0.06, fy - h * 0.04), Offset(fx - w * 0.06, fy + h * 0.04)], Pk.fill(i == 1 ? Colors.white : _orange));
  }
  c.drawLine(inner.centerLeft + Offset(w * 0.5, -h * 0.18), inner.centerLeft + Offset(w * 0.68, -h * 0.18), Pk.stroke(Colors.white.withValues(alpha: 0.5), 1.5));
  c.restore();
  for (final (fx, fy, s) in [(0.22, 0.42, 1.0), (0.42, 0.68, 0.8), (0.7, 0.5, 1.1), (0.84, 0.72, 0.7)]) {
    final o = _at(r, fx, fy);
    c.drawArc(Rect.fromCenter(center: o, width: w * 0.16 * s, height: h * 0.2 * s), 0.5, 2 * pi - 0.7, true, Pk.fill(_leafDark));
    c.drawArc(Rect.fromCenter(center: o + const Offset(0, -1), width: w * 0.15 * s, height: h * 0.18 * s), 0.5, 2 * pi - 0.7, true, Pk.fill(_leaf));
  }
  _blossom(c, _at(r, 0.24, 0.36), h * 0.08, b, Colors.white);
  _blossom(c, _at(r, 0.7, 0.44), h * 0.09, b, Colors.white);
}

const _lilyPond = CustomProp(_paintLilyPond, emissive: true);

void _paintBirdbath(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, _in(r, 0.28, 0.86, 0.44, 0.14), Pk.dark(a, 0.08), radius: 2);
  Pk.poly(c, [_at(r, 0.4, 0.88), _at(r, 0.6, 0.88), _at(r, 0.56, 0.4), _at(r, 0.44, 0.4)], Pk.fill(a));
  c.drawArc(_in(r, 0.0, 0.18, 1.0, 0.4), 0, pi, true, Pk.fill(a));
  c.drawOval(_in(r, 0.0, 0.3, 1.0, 0.14), Pk.fill(Pk.light(a, 0.1)));
  c.drawOval(_in(r, 0.08, 0.32, 0.84, 0.09), Pk.fill(b));
  // A little bird.
  final bob = sin(t * 3) * h * 0.02;
  c.drawOval(Rect.fromLTWH(r.left + w * 0.56, r.top + h * 0.14 + bob, w * 0.24, h * 0.16), Pk.fill(const Color(0xFF6E8AC9)));
  c.drawCircle(Offset(r.left + w * 0.76, r.top + h * 0.13 + bob), h * 0.06, Pk.fill(const Color(0xFF6E8AC9)));
  Pk.poly(c, [Offset(r.left + w * 0.81, r.top + h * 0.12 + bob), Offset(r.left + w * 0.9, r.top + h * 0.14 + bob), Offset(r.left + w * 0.81, r.top + h * 0.16 + bob)], Pk.fill(_orange));
}

const _birdbath = CustomProp(_paintBirdbath);

void _paintHangingPlant(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final sway = sin(t * 0.9 + r.left) * w * 0.03;
  final base = Offset(r.center.dx + sway, r.top + h * 0.45);
  c.drawLine(r.topCenter, base + Offset(-w * 0.3, 0), Pk.stroke(_ink, 0.8));
  c.drawLine(r.topCenter, base + Offset(w * 0.3, 0), Pk.stroke(_ink, 0.8));
  for (var k = 0; k < 5; k++) {
    final x = base.dx + (k - 2) * w * 0.15;
    final len = h * (0.35 + 0.15 * Pk.rand(k + 3));
    for (var j = 0; j < 4; j++) {
      _leafAt(c, Offset(x + sin(j + k) * 2, base.dy + h * 0.08 + len * j / 4), w * 0.08, j.isEven ? 2.6 : 3.6, j.isEven ? _leaf : _leafDark);
    }
  }
  c.drawArc(Rect.fromCenter(center: base, width: w * 0.66, height: h * 0.3), 0, pi, true, Pk.fill(a));
  for (var k = 0; k < 4; k++) {
    _leafAt(c, base + Offset((k - 1.5) * w * 0.14, 0), w * 0.1, (k - 1.5) * 0.4, k.isEven ? _leaf : _leafDark);
  }
  if (b != a) {
    _blossom(c, base + Offset(-w * 0.12, -h * 0.08), w * 0.07, b);
    _blossom(c, base + Offset(w * 0.15, -h * 0.05), w * 0.06, b);
  }
}

const _hangingPlant = CustomProp(_paintHangingPlant, wall: true);

void _paintMistPipe(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawRect(_in(r, 0, 0.0, 1, 0.22), Pk.fill(a));
  c.drawRect(_in(r, 0, 0.0, 1, 0.07), Pk.fill(Pk.light(a, 0.3)));
  final n = max(3, (w / 50).floor());
  for (var i = 0; i < n; i++) {
    final x = r.left + w * (i + 0.5) / n;
    c.drawRect(Rect.fromCenter(center: Offset(x, r.top + h * 0.28), width: 4, height: h * 0.14), Pk.fill(Pk.dark(a, 0.2)));
    for (var k = 0; k < 4; k++) {
      final ph = (t * 0.5 + k / 4 + i * 0.13) % 1;
      c.drawCircle(Offset(x + (k - 1.5) * ph * w / n * 0.25, r.top + h * (0.38 + ph * 0.55)), 2 + ph * 5, Pk.fill(b.withValues(alpha: 0.5 * (1 - ph))));
    }
  }
}

const _mistPipe = CustomProp(_paintMistPipe, wall: true);

void _paintRadiator(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final n = max(4, (w / 8).floor());
  for (var i = 0; i < n; i++) {
    final fin = Rect.fromLTWH(r.left + w * i / n + 1, r.top + h * 0.06, w / n - 2, h * 0.84);
    c.drawRRect(RRect.fromRectAndRadius(fin, Radius.circular(fin.width * 0.45)), Pk.fill(i.isEven ? a : Pk.dark(a, 0.06)));
  }
  c.drawRect(_in(r, 0, 0.18, 1, 0.06), Pk.fill(Pk.dark(a, 0.15)));
  c.drawRect(_in(r, 0, 0.76, 1, 0.06), Pk.fill(Pk.dark(a, 0.15)));
  c.drawCircle(_at(r, 0.95, 0.12), h * 0.07, Pk.fill(b));
  c.drawRect(_in(r, 0.06, 0.9, 0.06, 0.1), Pk.fill(Pk.dark(a, 0.3)));
  c.drawRect(_in(r, 0.88, 0.9, 0.06, 0.1), Pk.fill(Pk.dark(a, 0.3)));
  for (var k = 0; k < 3; k++) {
    final ph = (t * 0.4 + k / 3) % 1;
    c.drawLine(Offset(r.left + w * (0.25 + k * 0.25), r.top - ph * 4), Offset(r.left + w * (0.25 + k * 0.25) + 2, r.top - 3 - ph * 4), Pk.stroke(b.withValues(alpha: 0.4 * (1 - ph)), 1.5));
  }
}

const _radiator = CustomProp(_paintRadiator);

void _paintBenchTable(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  _tableLegs(c, r, r.top + h * 0.16, a);
  Pk.box(c, _in(r, 0.04, 0.64, 0.92, 0.1), Pk.dark(a, 0.1), radius: 1);
  // Clay pots on the lower shelf.
  final n = max(3, (w / 22).floor());
  for (var i = 0; i < n; i++) {
    final cx = r.left + w * (0.14 + 0.72 * (i + 0.5) / n);
    final pw = w * 0.07;
    Pk.poly(c, [Offset(cx - pw, r.top + h * 0.46), Offset(cx + pw, r.top + h * 0.46), Offset(cx + pw * 0.7, r.top + h * 0.64), Offset(cx - pw * 0.7, r.top + h * 0.64)], Pk.fill(b));
  }
  Pk.box(c, _in(r, 0, 0, 1, 0.18), a, radius: 2);
}

const _benchTable = CustomProp(_paintBenchTable);

void _paintBeehive(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawRect(_in(r, 0.2, 0.78, 0.08, 0.22), Pk.fill(_darkWood));
  c.drawRect(_in(r, 0.72, 0.78, 0.08, 0.22), Pk.fill(_darkWood));
  Pk.box(c, _in(r, 0.1, 0.74, 0.8, 0.08), _darkWood, radius: 1);
  for (var i = 0; i < 4; i++) {
    final fw = 0.86 - i * 0.16;
    c.drawRRect(RRect.fromRectAndRadius(_in(r, (1 - fw) / 2, 0.58 - i * 0.16, fw, 0.2), Radius.circular(h * 0.1)), Pk.fill(i.isEven ? a : Pk.dark(a, 0.08)));
  }
  c.drawOval(_in(r, 0.42, 0.6, 0.16, 0.1), Pk.fill(const Color(0xFF3B2A1A)));
  for (var i = 0; i < 3; i++) {
    final ang = t * 2 + i * 2.1;
    final o = Offset(r.center.dx + cos(ang) * w * 0.45, r.top + h * 0.35 + sin(ang * 1.3) * h * 0.25);
    c.drawOval(Rect.fromCenter(center: o, width: 5, height: 3.6), Pk.fill(b));
    c.drawLine(o + const Offset(-0.5, -1.8), o + const Offset(-0.5, 1.8), Pk.stroke(_ink, 0.9));
    c.drawOval(Rect.fromCenter(center: o + const Offset(0.5, -2.4), width: 3, height: 2), Pk.fill(Colors.white.withValues(alpha: 0.8)));
  }
}

const _beehive = CustomProp(_paintBeehive);

void _paintCompostBin(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawRect(_in(r, 0.04, 0.2, 0.92, 0.8), Pk.fill(Pk.dark(a, 0.35)));
  c.drawOval(_in(r, 0.08, 0.1, 0.84, 0.3), Pk.fill(b));
  for (var i = 0; i < 4; i++) {
    _sprout(c, _at(r, 0.25 + i * 0.17, 0.2), h * 0.18, _leaf, t, i);
  }
  for (var k = 0; k < 4; k++) {
    Pk.box(c, Rect.fromLTWH(r.left, r.top + h * (0.3 + k * 0.18), w, h * 0.12), a, radius: 1);
  }
  c.drawRect(_in(r, 0.02, 0.2, 0.07, 0.8), Pk.fill(Pk.dark(a, 0.2)));
  c.drawRect(_in(r, 0.91, 0.2, 0.07, 0.8), Pk.fill(Pk.dark(a, 0.2)));
}

const _compostBin = CustomProp(_paintCompostBin);

void _paintWheelbarrow(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawLine(_at(r, 0.5, 0.6), _at(r, 1.0, 0.3), Pk.stroke(_darkWood, 2.5));
  c.drawLine(_at(r, 0.55, 0.62), _at(r, 0.6, 1.0), Pk.stroke(_iron, 2));
  c.drawOval(_in(r, 0.12, 0.2, 0.66, 0.26), Pk.fill(b));
  Pk.poly(c, [_at(r, 0.08, 0.3), _at(r, 0.82, 0.3), _at(r, 0.68, 0.68), _at(r, 0.2, 0.68)], Pk.fill(a));
  c.drawLine(_at(r, 0.08, 0.3), _at(r, 0.82, 0.3), Pk.stroke(Pk.dark(a, 0.25), 2));
  c.drawCircle(_at(r, 0.22, 0.8), h * 0.18, Pk.fill(_ink));
  c.drawCircle(_at(r, 0.22, 0.8), h * 0.07, Pk.fill(_steel));
  c.drawCircle(Offset(r.left + w * 0.22, r.top + h * 0.8), 1, Pk.fill(_ink));
}

const _wheelbarrow = CustomProp(_paintWheelbarrow);

void _paintArbor(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final p = Pk.stroke(a, max(2.5, w * 0.05));
  c.drawLine(_at(r, 0.08, 1), _at(r, 0.08, 0.35), p);
  c.drawLine(_at(r, 0.92, 1), _at(r, 0.92, 0.35), p);
  c.drawArc(_in(r, 0.08, 0.05, 0.84, 0.6), pi, pi, false, p);
  for (var i = 0; i < 14; i++) {
    final k = i / 13;
    final ang = pi + k * pi;
    final o = Offset(r.center.dx + cos(ang) * w * 0.42, r.top + h * 0.35 + sin(ang) * h * 0.3);
    c.drawCircle(o, w * 0.07, Pk.fill(i.isEven ? _leaf : _leafDark));
    if (i % 3 == 0) {
      _blossom(c, o, w * 0.05, b);
    }
  }
  for (final fx in [0.08, 0.92]) {
    for (var k = 0; k < 4; k++) {
      _leafAt(c, _at(r, fx, 0.45 + k * 0.14), w * 0.06, k.isEven ? -0.8 : 0.8, k.isEven ? _leaf : _leafDark);
    }
    _blossom(c, _at(r, fx, 0.62), w * 0.05, b);
  }
}

const _arbor = CustomProp(_paintArbor);
'''

DART_VINE = r'''
// ============================================================ VINEYARD
void _paintVineRow(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final post = Pk.fill(const Color(0xFF8B5E3C));
  for (final fx in [0.01, 0.49, 0.97]) {
    c.drawRect(Rect.fromLTWH(r.left + w * fx, r.top + h * 0.12, max(2.5, w * 0.02), h * 0.88), post);
  }
  for (final fy in [0.28, 0.58]) {
    c.drawLine(_at(r, 0, fy), _at(r, 1, fy), Pk.stroke(const Color(0xFF6E6A78), 0.8));
  }
  final n = max(4, (w / 16).floor());
  for (var i = 0; i < n; i++) {
    final x = r.left + w * (i + 0.5) / n;
    c.drawLine(Offset(x, r.bottom), Offset(x + 2, r.top + h * 0.45), Pk.stroke(const Color(0xFF6B4A2A), 2));
  }
  for (var i = 0; i < n; i++) {
    final x = r.left + w * (i + 0.5) / n;
    final sway = sin(t + i) * 1.2;
    final cw = w / n;
    c.drawCircle(Offset(x - cw * 0.3 + sway, r.top + h * 0.38), h * 0.17, Pk.fill(Pk.dark(a, 0.14)));
    c.drawCircle(Offset(x + cw * 0.3 + sway, r.top + h * 0.42), h * 0.16, Pk.fill(Pk.dark(a, 0.14)));
    c.drawCircle(Offset(x + sway, r.top + h * 0.26), h * 0.2, Pk.fill(a));
    c.drawCircle(Offset(x - cw * 0.1 + sway, r.top + h * 0.18), h * 0.07, Pk.fill(Pk.light(a, 0.25)));
    if (i.isEven || n < 6) {
      _bunch(c, Offset(x + sway * 0.5 + cw * 0.15, r.top + h * 0.52), max(1.4, h * 0.045), b);
    }
  }
}

const _vineRow = CustomProp(_paintVineRow);

void _paintPress(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawRect(_in(r, 0.46, 0.0, 0.08, 0.42), Pk.fill(_iron));
  for (var k = 0; k < 5; k++) {
    c.drawLine(_at(r, 0.46, 0.06 + k * 0.07), _at(r, 0.54, 0.1 + k * 0.07), Pk.stroke(Pk.light(_iron, 0.4), 1.2));
  }
  final ang = sin(t * 0.8) * 0.4;
  c.drawLine(_at(r, 0.5, 0.12) + Offset(-cos(ang) * w * 0.32, sin(ang) * 3), _at(r, 0.5, 0.12) + Offset(cos(ang) * w * 0.32, -sin(ang) * 3),
      Pk.stroke(_darkWood, 3));
  c.drawRect(_in(r, 0.12, 0.2, 0.06, 0.62), Pk.fill(Pk.dark(a, 0.25)));
  c.drawRect(_in(r, 0.82, 0.2, 0.06, 0.62), Pk.fill(Pk.dark(a, 0.25)));
  Pk.box(c, _in(r, 0.08, 0.16, 0.84, 0.08), Pk.dark(a, 0.15), radius: 2);
  final basket = _in(r, 0.22, 0.38, 0.56, 0.42);
  c.drawOval(Rect.fromLTWH(basket.left, basket.top - h * 0.05, basket.width, h * 0.1), Pk.fill(b));
  for (var i = 0; i < 6; i++) {
    final sx = basket.left + basket.width * i / 6;
    c.drawRect(Rect.fromLTWH(sx + 1, basket.top, basket.width / 6 - 2, basket.height), Pk.fill(i.isEven ? a : Pk.dark(a, 0.08)));
  }
  for (final fy in [0.2, 0.8]) {
    c.drawRect(Rect.fromLTWH(basket.left - 1, basket.top + basket.height * fy - 1.5, basket.width + 2, 3), Pk.fill(_iron));
  }
  Pk.box(c, _in(r, 0.04, 0.8, 0.92, 0.12), Pk.dark(a, 0.1), radius: 2);
  c.drawRect(_in(r, 0.88, 0.84, 0.1, 0.04), Pk.fill(Pk.dark(a, 0.2)));
  final drip = (t * 1.2) % 1;
  c.drawCircle(Offset(r.left + w * 0.96, r.top + h * (0.88 + drip * 0.1)), 1.5, Pk.fill(b));
  c.drawRect(_in(r, 0.1, 0.92, 0.06, 0.08), Pk.fill(Pk.dark(a, 0.3)));
  c.drawRect(_in(r, 0.84, 0.92, 0.06, 0.08), Pk.fill(Pk.dark(a, 0.3)));
}

const _press = CustomProp(_paintPress);

void _paintCask(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawLine(_at(r, 0.1, 1), _at(r, 0.4, 0.7), Pk.stroke(_darkWood, 3));
  c.drawLine(_at(r, 0.9, 1), _at(r, 0.6, 0.7), Pk.stroke(_darkWood, 3));
  final face = Rect.fromCenter(center: _at(r, 0.5, 0.46), width: min(w, h) * 0.9, height: min(w, h) * 0.9);
  c.drawOval(face, Pk.fill(Pk.dark(a, 0.1)));
  for (var i = 0; i < 4; i++) {
    c.drawOval(face.deflate(face.width * (0.06 + i * 0.1)), Pk.stroke(Pk.dark(a, 0.25).withValues(alpha: 0.5), 1));
  }
  for (var i = -2; i <= 2; i++) {
    final x = face.center.dx + i * face.width * 0.17;
    final hh = sqrt(max(0.0, 1 - (i * 0.34) * (i * 0.34))) * face.height * 0.44;
    c.drawLine(Offset(x, face.center.dy - hh), Offset(x, face.center.dy + hh), Pk.stroke(Pk.dark(a, 0.2).withValues(alpha: 0.6), 1));
  }
  c.drawOval(face, Pk.stroke(b, max(2.0, w * 0.05)));
  c.drawRect(Rect.fromCenter(center: face.center + Offset(0, face.height * 0.28), width: w * 0.08, height: h * 0.08), Pk.fill(_steel));
  c.drawRect(Rect.fromCenter(center: face.center + Offset(0, face.height * 0.22), width: w * 0.16, height: h * 0.03), Pk.fill(_steel));
}

const _cask = CustomProp(_paintCask);

void _paintGrapeBasket(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (var i = 0; i < 6; i++) {
    final o = _at(r, 0.2 + (i % 3) * 0.3, 0.32 - (i ~/ 3) * 0.14);
    c.drawCircle(o, h * 0.16, Pk.fill(i.isEven ? b : Pk.dark(b, 0.12)));
    c.drawCircle(o + Offset(-h * 0.05, -h * 0.05), h * 0.05, Pk.fill(Pk.light(b, 0.4)));
  }
  _leafAt(c, _at(r, 0.12, 0.36), h * 0.14, -1.0, _leaf);
  _leafAt(c, _at(r, 0.88, 0.34), h * 0.14, 1.0, _leafDark);
  final basket = Path()
    ..moveTo(r.left, r.top + h * 0.38)
    ..lineTo(r.right, r.top + h * 0.38)
    ..quadraticBezierTo(r.right - w * 0.04, r.bottom, r.center.dx, r.bottom)
    ..quadraticBezierTo(r.left + w * 0.04, r.bottom, r.left, r.top + h * 0.38)
    ..close();
  c.drawPath(basket, Pk.fill(a));
  for (var k = 0; k < 3; k++) {
    c.drawLine(_at(r, 0.06, 0.52 + k * 0.14), _at(r, 0.94, 0.52 + k * 0.14), Pk.stroke(Pk.dark(a, 0.22), 1.2));
  }
  c.drawRect(Rect.fromLTWH(r.left - 1, r.top + h * 0.36, w + 2, h * 0.07), Pk.fill(Pk.dark(a, 0.12)));
}

const _grapeBasket = CustomProp(_paintGrapeBasket);

void _paintCypress(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawRect(_in(r, 0.44, 0.86, 0.12, 0.14), Pk.fill(_darkWood));
  final sway = sin(t * 0.7 + r.left) * w * 0.04;
  final tree = Path()
    ..moveTo(r.center.dx + sway, r.top)
    ..quadraticBezierTo(r.right + w * 0.05, r.top + h * 0.5, r.center.dx + w * 0.3, r.top + h * 0.9)
    ..lineTo(r.center.dx - w * 0.3, r.top + h * 0.9)
    ..quadraticBezierTo(r.left - w * 0.05, r.top + h * 0.5, r.center.dx + sway, r.top)
    ..close();
  c.drawPath(tree, Pk.fill(a));
  c.save();
  c.clipPath(tree);
  c.drawRect(Rect.fromLTWH(r.center.dx, r.top, w, h), Pk.fill(Pk.dark(a, 0.15)));
  for (var i = 0; i < 6; i++) {
    c.drawLine(_at(r, 0.3, 0.15 + i * 0.13), _at(r, 0.55, 0.1 + i * 0.13), Pk.stroke(Pk.light(a, 0.15), 1.2));
  }
  c.restore();
}

const _cypressTree = CustomProp(_paintCypress);

void _paintPergola(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, _in(r, 0, 0.0, 1, 0.22), a, radius: 2);
  final n = max(5, (w / 40).floor());
  for (var i = 0; i <= n; i++) {
    c.drawRect(Rect.fromLTWH(r.left + (w - 6) * i / n, r.top + h * 0.18, 6, h * 0.14), Pk.fill(Pk.dark(a, 0.2)));
  }
  for (var i = 0; i < n * 3; i++) {
    final x = r.left + w * (i + 0.5) / (n * 3);
    final sway = sin(t * 0.9 + i) * 1.5;
    final len = h * (0.35 + 0.25 * Pk.rand(i + 11));
    for (var j = 0; j < 3; j++) {
      _leafAt(c, Offset(x + sway * j / 3, r.top + h * 0.2 + len * j / 3), h * 0.12, j.isEven ? 2.7 : 3.5, (i + j).isEven ? _leaf : _leafDark);
    }
    if (i % 4 == 1) {
      _bunch(c, Offset(x + sway, r.top + h * 0.3 + len * 0.6), max(1.5, h * 0.06), b);
    }
  }
}

const _pergola = CustomProp(_paintPergola, wall: true);

void _paintTub(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  for (var i = 0; i < 9; i++) {
    final o = _at(r, 0.12 + (i % 5) * 0.19, 0.3 - (i ~/ 5) * 0.12);
    c.drawCircle(o, h * 0.12, Pk.fill(i.isEven ? b : Pk.dark(b, 0.12)));
    c.drawCircle(o + Offset(-h * 0.04, -h * 0.04), h * 0.035, Pk.fill(Pk.light(b, 0.4)));
  }
  final tub = Path()
    ..moveTo(r.left, r.top + h * 0.3)
    ..lineTo(r.right, r.top + h * 0.3)
    ..lineTo(r.right - w * 0.06, r.bottom)
    ..lineTo(r.left + w * 0.06, r.bottom)
    ..close();
  c.drawPath(tub, Pk.fill(a));
  for (var i = 1; i < 8; i++) {
    final x = r.left + w * i / 8;
    c.drawLine(Offset(x, r.top + h * 0.32), Offset(x + (x < r.center.dx ? 1.5 : -1.5), r.bottom - 1), Pk.stroke(Pk.dark(a, 0.18), 1));
  }
  for (final fy in [0.42, 0.85]) {
    c.drawRect(Rect.fromLTWH(r.left + w * 0.02, r.top + h * fy - 1.5, w * 0.96, 3), Pk.fill(_iron));
  }
}

const _tub = CustomProp(_paintTub);

void _paintTastingTable(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  _tableLegs(c, r, r.top + h * 0.5, a);
  Pk.box(c, _in(r, 0, 0.44, 1, 0.12), a, radius: 2);
  final bot = _in(r, 0.18, 0.0, 0.1, 0.44);
  c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(bot.left, bot.top + bot.height * 0.35, bot.width, bot.height * 0.65), const Radius.circular(3)), Pk.fill(b));
  c.drawRect(Rect.fromLTWH(bot.left + bot.width * 0.3, bot.top, bot.width * 0.4, bot.height * 0.4), Pk.fill(b));
  c.drawRect(Rect.fromLTWH(bot.left, bot.top + bot.height * 0.6, bot.width, bot.height * 0.18), Pk.fill(_cream));
  for (final fx in [0.4, 0.52]) {
    final gx = r.left + w * fx;
    c.drawArc(Rect.fromCenter(center: Offset(gx, r.top + h * 0.2), width: w * 0.08, height: h * 0.2), 0, pi, true, Pk.fill(b.withValues(alpha: 0.85)));
    c.drawLine(Offset(gx - w * 0.04, r.top + h * 0.2), Offset(gx + w * 0.04, r.top + h * 0.2), Pk.stroke(Colors.white.withValues(alpha: 0.8), 1));
    c.drawLine(Offset(gx, r.top + h * 0.3), Offset(gx, r.top + h * 0.44), Pk.stroke(Colors.white, 1));
  }
  Pk.box(c, _in(r, 0.62, 0.34, 0.3, 0.1), _darkWood, radius: 2);
  Pk.poly(c, [_at(r, 0.66, 0.34), _at(r, 0.78, 0.34), _at(r, 0.66, 0.2)], Pk.fill(_yellow));
  _bunch(c, _at(r, 0.84, 0.2), max(1.2, h * 0.035), _grape);
}

const _tastingTable = CustomProp(_paintTastingTable);

void _paintPotRack(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawRect(_in(r, 0, 0.0, 1, 0.1), Pk.fill(a));
  final n = max(3, (w / 26).floor());
  for (var i = 0; i < n; i++) {
    final cx = r.left + w * (i + 0.5) / n;
    final pw = w / n * 0.7;
    final ph = h * (0.4 + 0.25 * Pk.rand(i + 4));
    c.drawLine(Offset(cx, r.top + h * 0.1), Offset(cx, r.top + h * 0.28), Pk.stroke(_iron, 1));
    final pot = Rect.fromLTWH(cx - pw / 2, r.top + h * 0.28, pw, ph);
    if (i.isEven) {
      c.drawRRect(RRect.fromRectAndCorners(pot, bottomLeft: Radius.circular(pw * 0.3), bottomRight: Radius.circular(pw * 0.3)), Pk.fill(b));
      c.drawRect(Rect.fromLTWH(pot.left - 2, pot.top, pot.width + 4, 3), Pk.fill(Pk.dark(b, 0.2)));
      c.drawLine(Offset(pot.left + 3, pot.top + 4), Offset(pot.left + 3, pot.top + ph * 0.6), Pk.stroke(Colors.white.withValues(alpha: 0.4), 1.2));
    } else {
      c.drawLine(Offset(cx, pot.top), Offset(cx, pot.top + ph * 0.4), Pk.stroke(Pk.dark(b, 0.3), 2.5));
      c.drawCircle(Offset(cx, pot.top + ph * 0.4 + pw * 0.4), pw * 0.4, Pk.fill(b));
      c.drawCircle(Offset(cx, pot.top + ph * 0.4 + pw * 0.4), pw * 0.28, Pk.fill(Pk.dark(b, 0.15)));
    }
  }
}

const _potRack = CustomProp(_paintPotRack, wall: true);

void _paintOliveTree(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width;
  c.drawLine(_at(r, 0.5, 0.72), _at(r, 0.44, 0.4), Pk.stroke(const Color(0xFF8A7A5E), max(2.0, w * 0.07)));
  c.drawLine(_at(r, 0.47, 0.5), _at(r, 0.66, 0.32), Pk.stroke(const Color(0xFF8A7A5E), max(1.5, w * 0.05)));
  final sway = sin(t * 0.8 + r.left) * w * 0.02;
  for (final (fx, fy, s) in [(0.3, 0.3, 0.22), (0.66, 0.26, 0.22), (0.48, 0.16, 0.26), (0.5, 0.34, 0.2)]) {
    c.drawCircle(_at(r, fx, fy) + Offset(sway, 0), w * s, Pk.fill(fx == 0.48 ? a : Pk.dark(a, 0.1)));
  }
  for (var i = 0; i < 6; i++) {
    c.drawCircle(_at(r, 0.25 + Pk.rand(i + 9) * 0.5, 0.12 + Pk.rand(i + 2) * 0.28) + Offset(sway, 0), w * 0.03, Pk.fill(Pk.light(a, 0.35)));
  }
  Pk.poly(c, [_at(r, 0.2, 0.7), _at(r, 0.8, 0.7), _at(r, 0.7, 1), _at(r, 0.3, 1)], Pk.fill(b));
  c.drawRect(_in(r, 0.17, 0.68, 0.66, 0.07), Pk.fill(Pk.dark(b, 0.1)));
}

const _oliveTree = CustomProp(_paintOliveTree);

void _paintIceBucket(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawLine(_at(r, 0.5, 0.56), _at(r, 0.5, 0.95), Pk.stroke(_iron, 2));
  c.drawLine(_at(r, 0.25, 1), _at(r, 0.5, 0.88), Pk.stroke(_iron, 1.5));
  c.drawLine(_at(r, 0.75, 1), _at(r, 0.5, 0.88), Pk.stroke(_iron, 1.5));
  c.save();
  c.translate(r.left + w * 0.56, r.top + h * 0.2);
  c.rotate(0.3);
  c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(-w * 0.09, 0, w * 0.18, h * 0.3), const Radius.circular(2)), Pk.fill(b));
  c.drawRect(Rect.fromLTWH(-w * 0.05, -h * 0.14, w * 0.1, h * 0.16), Pk.fill(b));
  c.drawRect(Rect.fromLTWH(-w * 0.055, -h * 0.16, w * 0.11, h * 0.05), Pk.fill(_gold));
  c.restore();
  final bucket = _in(r, 0.12, 0.28, 0.76, 0.3);
  c.drawRRect(RRect.fromRectAndCorners(bucket, bottomLeft: Radius.circular(w * 0.12), bottomRight: Radius.circular(w * 0.12)), Pk.fill(a));
  for (var i = 0; i < 4; i++) {
    c.drawRect(Rect.fromLTWH(bucket.left + bucket.width * (0.1 + i * 0.2), bucket.top - h * 0.03, bucket.width * 0.16, h * 0.06), Pk.fill(Colors.white.withValues(alpha: 0.9)));
  }
  c.drawLine(Offset(bucket.left + 3, bucket.top + 4), Offset(bucket.left + 3, bucket.bottom - 4), Pk.stroke(Colors.white.withValues(alpha: 0.6), 1.5));
}

const _iceBucket = CustomProp(_paintIceBucket);

void _paintScarecrow(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawLine(_at(r, 0.5, 1), _at(r, 0.5, 0.15), Pk.stroke(_darkWood, max(2.0, w * 0.06)));
  final sway = sin(t * 1.1) * 0.06;
  c.save();
  c.translate(r.left + w * 0.5, r.top + h * 0.36);
  c.rotate(sway);
  c.drawLine(Offset(-w * 0.48, 0), Offset(w * 0.48, 0), Pk.stroke(_darkWood, max(2.0, w * 0.05)));
  Pk.poly(c, [Offset(-w * 0.42, -h * 0.03), Offset(w * 0.42, -h * 0.03), Offset(w * 0.26, h * 0.36), Offset(-w * 0.26, h * 0.36)], Pk.fill(a));
  c.drawRect(Rect.fromLTWH(-w * 0.1, h * 0.05, w * 0.2, h * 0.2), Pk.fill(Pk.light(a, 0.3)));
  for (final d in [-1.0, 1.0]) {
    Pk.poly(c, [Offset(d * w * 0.42, -h * 0.03), Offset(d * w * 0.5, h * 0.06), Offset(d * w * 0.38, h * 0.08)], Pk.fill(_straw));
  }
  c.drawCircle(Offset(0, -h * 0.13), w * 0.15, Pk.fill(const Color(0xFFE8D2A0)));
  c.drawCircle(Offset(-w * 0.05, -h * 0.14), 1.2, Pk.fill(_ink));
  c.drawCircle(Offset(w * 0.05, -h * 0.14), 1.2, Pk.fill(_ink));
  Pk.poly(c, [Offset(-w * 0.3, -h * 0.2), Offset(w * 0.3, -h * 0.2), Offset(0, -h * 0.34)], Pk.fill(b));
  c.drawRect(Rect.fromLTWH(-w * 0.32, -h * 0.21, w * 0.64, h * 0.03), Pk.fill(Pk.dark(b, 0.2)));
  c.restore();
}

const _scarecrow = CustomProp(_paintScarecrow);
'''

DART_TRAIN = r'''
// ============================================================ TRAIN STATION
void _paintLoco(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final wy = r.top + h * 0.84, wr = h * 0.15;
  c.drawRect(_in(r, 0.05, 0.66, 0.92, 0.07), Pk.fill(_ink));
  Pk.box(c, _in(r, 0.1, 0.36, 0.56, 0.31), a, radius: h * 0.15);
  for (final fx in [0.24, 0.4, 0.56]) {
    c.drawRect(Rect.fromLTWH(r.left + w * fx, r.top + h * 0.36, w * 0.025, h * 0.31), Pk.fill(b));
  }
  c.drawRect(_in(r, 0.06, 0.38, 0.07, 0.29), Pk.fill(Pk.dark(a, 0.35)));
  Pk.poly(c, [_at(r, 0.14, 0.14), _at(r, 0.26, 0.14), _at(r, 0.23, 0.37), _at(r, 0.17, 0.37)], Pk.fill(Pk.dark(a, 0.4)));
  c.drawRect(_in(r, 0.13, 0.12, 0.14, 0.04), Pk.fill(b));
  c.drawArc(Rect.fromCenter(center: _at(r, 0.46, 0.37), width: w * 0.1, height: h * 0.16), pi, pi, true, Pk.fill(b));
  Pk.box(c, _in(r, 0.64, 0.16, 0.32, 0.52), b, radius: 3);
  c.drawRect(_in(r, 0.61, 0.11, 0.38, 0.06), Pk.fill(Pk.dark(a, 0.25)));
  Pk.box(c, _in(r, 0.7, 0.24, 0.2, 0.18), const Color(0xFFBFEFFA), radius: 2);
  Pk.poly(c, [_at(r, 0.0, 0.95), _at(r, 0.07, 0.68), _at(r, 0.12, 0.68), _at(r, 0.12, 0.95)], Pk.fill(b));
  c.drawCircle(_at(r, 0.08, 0.46), h * 0.05, Pk.fill(const Color(0xFFFFE9A0)));
  Pk.glow(c, _at(r, 0.06, 0.46), w * 0.08, const Color(0xFFFFE9A0), 0.5);
  for (final fx in [0.26, 0.44, 0.62]) {
    c.drawCircle(Offset(r.left + w * fx, wy), wr, Pk.fill(const Color(0xFF2A2440)));
    c.drawCircle(Offset(r.left + w * fx, wy), wr * 0.55, Pk.fill(b));
    c.drawCircle(Offset(r.left + w * fx, wy), wr * 0.18, Pk.fill(_ink));
  }
  c.drawCircle(Offset(r.left + w * 0.86, r.top + h * 0.88), wr * 0.7, Pk.fill(const Color(0xFF2A2440)));
  c.drawCircle(Offset(r.left + w * 0.86, r.top + h * 0.88), wr * 0.35, Pk.fill(b));
  final ang = t * 3;
  final off = Offset(cos(ang), sin(ang)) * wr * 0.5;
  c.drawLine(Offset(r.left + w * 0.26, wy) + off, Offset(r.left + w * 0.62, wy) + off, Pk.stroke(_steel, 2.2));
  for (var i = 0; i < 3; i++) {
    final k = (t * 0.4 + i / 3) % 1;
    c.drawCircle(Offset(r.left + w * (0.2 + k * 0.1), r.top + h * (0.1 - k * 0.04)), h * (0.03 + k * 0.05), Pk.fill(Colors.white.withValues(alpha: 0.75 * (1 - k))));
  }
}

const _loco = CustomProp(_paintLoco);

void _paintCarriage(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawRect(_in(r, 0.03, 0.78, 0.94, 0.06), Pk.fill(_ink));
  for (final fx in [0.12, 0.24, 0.76, 0.88]) {
    c.drawCircle(_at(r, fx, 0.9), h * 0.1, Pk.fill(const Color(0xFF2A2440)));
    c.drawCircle(_at(r, fx, 0.9), h * 0.04, Pk.fill(_steel));
  }
  Pk.box(c, _in(r, 0.0, 0.14, 1.0, 0.66), a, radius: 5);
  final roof = Path()
    ..moveTo(r.left, r.top + h * 0.18)
    ..quadraticBezierTo(r.center.dx, r.top - h * 0.02, r.right, r.top + h * 0.18)
    ..close();
  c.drawPath(roof, Pk.fill(Pk.dark(a, 0.35)));
  c.drawRect(_in(r, 0.0, 0.6, 1.0, 0.06), Pk.fill(b));
  final n = max(4, (w / 26).floor());
  for (var i = 0; i < n; i++) {
    final wr = Rect.fromLTWH(r.left + w * (0.06 + 0.88 * i / n) + 2, r.top + h * 0.26, w * 0.88 / n - 6, h * 0.24);
    if (i == n ~/ 2) {
      Pk.box(c, Rect.fromLTWH(wr.left + wr.width * 0.15, r.top + h * 0.24, wr.width * 0.7, h * 0.52), Pk.dark(a, 0.15), radius: 2);
      c.drawRect(Rect.fromLTWH(wr.left + wr.width * 0.25, r.top + h * 0.28, wr.width * 0.5, h * 0.16), Pk.fill(const Color(0xFFBFEFFA)));
      continue;
    }
    c.drawRRect(RRect.fromRectAndRadius(wr, const Radius.circular(3)), Pk.fill(const Color(0xFFBFEFFA)));
    c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(wr.left, wr.top, wr.width, wr.height * 0.35), const Radius.circular(3)), Pk.fill(Pk.light(b, 0.3)));
    c.drawLine(wr.topLeft + Offset(wr.width * 0.2, wr.height * 0.9), wr.topLeft + Offset(wr.width * 0.5, wr.height * 0.4), Pk.stroke(Colors.white.withValues(alpha: 0.6), 1.5));
  }
}

const _carriage = CustomProp(_paintCarriage);

void _paintStationClock(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawLine(r.topCenter, _at(r, 0.5, 0.18), Pk.stroke(a, 2.5));
  c.drawRect(_in(r, 0.3, 0.0, 0.4, 0.05), Pk.fill(a));
  final cc = _at(r, 0.5, 0.58);
  final rad = min(w, h * 0.82) * 0.5;
  c.drawCircle(cc, rad, Pk.fill(a));
  c.drawCircle(cc, rad * 0.82, Pk.fill(Colors.white));
  for (var i = 0; i < 12; i++) {
    final ang = i * pi / 6;
    c.drawLine(cc + Offset(sin(ang), -cos(ang)) * rad * 0.66, cc + Offset(sin(ang), -cos(ang)) * rad * 0.76, Pk.stroke(_ink, i % 3 == 0 ? 1.6 : 0.8));
  }
  final m = t * 0.4, hr = t * 0.04 + 1.2;
  c.drawLine(cc, cc + Offset(sin(hr), -cos(hr)) * rad * 0.42, Pk.stroke(_ink, 2));
  c.drawLine(cc, cc + Offset(sin(m), -cos(m)) * rad * 0.62, Pk.stroke(_ink, 1.3));
  c.drawCircle(cc, 1.8, Pk.fill(b));
}

const _stationClock = CustomProp(_paintStationClock, wall: true);

void _paintDepartures(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, r, a, radius: 3);
  c.drawRect(r.deflate(4), Pk.fill(const Color(0xFF1E1A2E)));
  c.drawRect(Rect.fromLTWH(r.left + 4, r.top + 4, w - 8, h * 0.18), Pk.fill(b));
  final rows = max(3, (h / 14).floor() - 1);
  for (var i = 0; i < rows; i++) {
    final y = r.top + h * 0.3 + (h * 0.62) * i / rows;
    final flip = ((t * 0.5 + i * 0.37) % 4) < 0.15;
    c.drawLine(Offset(r.left + w * 0.08, y + 3), Offset(r.left + w * 0.2, y + 3), Pk.stroke(const Color(0xFFFFD447), 2.2));
    c.drawLine(Offset(r.left + w * 0.27, y + 3), Offset(r.left + w * (0.55 + Pk.rand(i) * 0.15), y + 3), Pk.stroke(flip ? Colors.white : const Color(0xFFFFB347), 2.2));
    c.drawLine(Offset(r.left + w * 0.8, y + 3), Offset(r.left + w * 0.92, y + 3), Pk.stroke(const Color(0xFF7CE07A), 2.2));
  }
}

const _departures = CustomProp(_paintDepartures, wall: true);

void _paintTicketBooth(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, _in(r, 0.04, 0.22, 0.92, 0.78), a, radius: 3);
  final roof = Path()
    ..moveTo(r.left, r.top + h * 0.24)
    ..quadraticBezierTo(r.center.dx, r.top - h * 0.04, r.right, r.top + h * 0.24)
    ..close();
  c.drawPath(roof, Pk.fill(Pk.dark(a, 0.3)));
  Pk.box(c, _in(r, 0.2, 0.06, 0.6, 0.12), b, radius: 2);
  c.drawLine(_at(r, 0.3, 0.12), _at(r, 0.7, 0.12), Pk.stroke(Pk.dark(b, 0.45), 1.5));
  final win = _in(r, 0.16, 0.32, 0.68, 0.34);
  c.drawRRect(RRect.fromRectAndCorners(win, topLeft: Radius.circular(win.width * 0.3), topRight: Radius.circular(win.width * 0.3)), Pk.fill(const Color(0xFFFFE9B8)));
  Pk.glow(c, win.center, win.width * 0.6, const Color(0xFFFFE9A0), 0.35);
  for (var i = 1; i < 4; i++) {
    c.drawLine(Offset(win.left + win.width * i / 4, win.top + 3), Offset(win.left + win.width * i / 4, win.bottom), Pk.stroke(_iron.withValues(alpha: 0.7), 1));
  }
  Pk.box(c, _in(r, 0.1, 0.66, 0.8, 0.07), Pk.light(a, 0.2), radius: 1);
  for (var i = 0; i < 3; i++) {
    c.drawRect(_in(r, 0.12 + i * 0.28, 0.76, 0.2, 0.2), Pk.fill(Pk.dark(a, 0.1)));
  }
}

const _ticketBooth = CustomProp(_paintTicketBooth);

void _paintSignal(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawRect(_in(r, 0.44, 0.2, 0.12, 0.8), Pk.fill(a));
  for (var k = 0; k < 6; k++) {
    c.drawLine(_at(r, 0.3, 0.42 + k * 0.09), _at(r, 0.44, 0.42 + k * 0.09), Pk.stroke(Pk.dark(a, 0.2), 1));
  }
  c.drawLine(_at(r, 0.3, 0.38), _at(r, 0.3, 0.98), Pk.stroke(Pk.dark(a, 0.2), 1));
  Pk.box(c, _in(r, 0.14, 0.0, 0.72, 0.4), _ink, radius: w * 0.3);
  final on = (t * 0.5).floor() % 3;
  final cols = [const Color(0xFFFF4A4A), const Color(0xFFFFC23C), const Color(0xFF4AE06A)];
  for (var i = 0; i < 3; i++) {
    final o = _at(r, 0.5, 0.08 + i * 0.12);
    c.drawCircle(o, w * 0.15, Pk.fill(i == on ? cols[i] : Pk.dark(cols[i], 0.6)));
    if (i == on) Pk.glow(c, o, w * 0.6, cols[i], 0.5);
  }
  Pk.box(c, _in(r, 0.2, 0.94, 0.6, 0.06), Pk.dark(a, 0.3), radius: 1);
}

const _signal = CustomProp(_paintSignal);

void _paintLuggageCart(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawLine(_at(r, 0.95, 0.72), _at(r, 1.0, 0.2), Pk.stroke(_iron, 2));
  Pk.box(c, _in(r, 0.0, 0.7, 1.0, 0.1), a, radius: 2);
  for (final fx in [0.15, 0.85]) {
    c.drawCircle(_at(r, fx, 0.9), h * 0.1, Pk.fill(_ink));
  }
  final cases = [(0.04, 0.38, 0.4, 0.32, b), (0.46, 0.44, 0.42, 0.26, const Color(0xFF45A7F5)), (0.1, 0.12, 0.3, 0.26, const Color(0xFFFFC93C)), (0.5, 0.2, 0.32, 0.24, const Color(0xFF7CC46A))];
  for (final (x, y, cw, ch, col) in cases) {
    final cr = _in(r, x, y, cw, ch);
    Pk.box(c, cr, col, radius: 3);
    c.drawRect(Rect.fromLTWH(cr.left + cr.width * 0.42, cr.top - 3, cr.width * 0.16, 3), Pk.fill(_ink));
    c.drawLine(Offset(cr.left + cr.width * 0.2, cr.top + 2), Offset(cr.left + cr.width * 0.2, cr.bottom - 2), Pk.stroke(Pk.dark(col, 0.25), 1));
    c.drawLine(Offset(cr.right - cr.width * 0.2, cr.top + 2), Offset(cr.right - cr.width * 0.2, cr.bottom - 2), Pk.stroke(Pk.dark(col, 0.25), 1));
  }
}

const _luggageCart = CustomProp(_paintLuggageCart);

void _paintNewsStand(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, _in(r, 0.06, 0.3, 0.88, 0.7), a, radius: 3);
  final n = 6;
  for (var i = 0; i < n; i++) {
    final x = r.left + w * i / n;
    Pk.poly(c, [Offset(x, r.top + h * 0.06), Offset(x + w / n, r.top + h * 0.06), Offset(x + w / n, r.top + h * 0.22), Offset(x + w / n / 2, r.top + h * 0.28), Offset(x, r.top + h * 0.22)],
        Pk.fill(i.isEven ? b : Colors.white));
  }
  c.drawRect(_in(r, 0, 0.0, 1, 0.07), Pk.fill(Pk.dark(b, 0.2)));
  for (var row = 0; row < 2; row++) {
    for (var i = 0; i < 4; i++) {
      final mr = _in(r, 0.12 + i * 0.2, 0.36 + row * 0.26, 0.16, 0.22);
      final col = [const Color(0xFFFF7AB6), const Color(0xFF45A7F5), const Color(0xFFFFD447), const Color(0xFF7CC46A)][(i + row) % 4];
      c.drawRect(mr, Pk.fill(Colors.white));
      c.drawRect(Rect.fromLTWH(mr.left, mr.top, mr.width, mr.height * 0.4), Pk.fill(col));
      c.drawLine(Offset(mr.left + 2, mr.top + mr.height * 0.6), Offset(mr.right - 2, mr.top + mr.height * 0.6), Pk.stroke(_ink.withValues(alpha: 0.5), 1));
    }
  }
  Pk.box(c, _in(r, 0.04, 0.86, 0.92, 0.06), Pk.dark(a, 0.15), radius: 1);
}

const _newsStand = CustomProp(_paintNewsStand);

void _paintLockers(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final n = max(2, (w / 18).floor());
  for (var i = 0; i < n; i++) {
    final lr = Rect.fromLTWH(r.left + w * i / n + 0.5, r.top, w / n - 1, h);
    Pk.box(c, lr, i.isEven ? a : Pk.dark(a, 0.06), radius: 2);
    for (var k = 0; k < 3; k++) {
      c.drawLine(Offset(lr.left + lr.width * 0.25, lr.top + h * (0.1 + k * 0.05)), Offset(lr.right - lr.width * 0.25, lr.top + h * (0.1 + k * 0.05)), Pk.stroke(Pk.dark(a, 0.35), 1.2));
    }
    c.drawRect(Rect.fromLTWH(lr.right - lr.width * 0.28, lr.top + h * 0.45, lr.width * 0.1, h * 0.12), Pk.fill(b));
    c.drawRect(Rect.fromLTWH(lr.left + lr.width * 0.25, lr.top + h * 0.7, lr.width * 0.5, h * 0.06), Pk.fill(Colors.white.withValues(alpha: 0.7)));
  }
}

const _lockers = CustomProp(_paintLockers);

void _paintGateLine(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final n = max(2, (w / 34).floor());
  for (var i = 0; i <= n; i++) {
    final x = r.left + (w - w * 0.12) * i / n;
    Pk.box(c, Rect.fromLTWH(x, r.top + h * 0.2, w * 0.12, h * 0.8), a, radius: 3);
    c.drawRect(Rect.fromLTWH(x + w * 0.02, r.top + h * 0.28, w * 0.08, h * 0.1), Pk.fill(const Color(0xFF1E1A2E)));
    c.drawCircle(Offset(x + w * 0.06, r.top + h * 0.5), h * 0.05, Pk.fill(i.isEven ? const Color(0xFF4AE06A) : b));
    if (i < n) {
      final open = (sin(t * 1.5 + i) + 1) / 2;
      final gx = x + w * 0.12;
      final gw = (w - w * 0.12) / n - w * 0.12;
      c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(gx, r.top + h * 0.42, gw * (0.5 - open * 0.3), h * 0.22), const Radius.circular(3)), Pk.fill(b.withValues(alpha: 0.85)));
      c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(gx + gw * (0.5 + open * 0.3), r.top + h * 0.42, gw * (0.5 - open * 0.3), h * 0.22), const Radius.circular(3)), Pk.fill(b.withValues(alpha: 0.85)));
    }
  }
}

const _gateLine = CustomProp(_paintGateLine);

void _paintArchWindow(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final shape = Path()
    ..moveTo(r.left, r.bottom)
    ..lineTo(r.left, r.top + w / 2)
    ..arcToPoint(Offset(r.right, r.top + w / 2), radius: Radius.circular(w / 2))
    ..lineTo(r.right, r.bottom)
    ..close();
  c.drawPath(shape, Pk.fill(a));
  final inner = shape.shift(Offset.zero);
  c.save();
  c.clipPath(inner);
  Pk.gradientRect(c, r.deflate(3), const Color(0xFF8ED8FF), Pk.light(b, 0.5));
  c.drawLine(_at(r, 0.2, 0.9), _at(r, 0.6, 0.2), Pk.stroke(Colors.white.withValues(alpha: 0.4), 4));
  c.restore();
  final frame = Pk.stroke(a, 2.5);
  c.drawPath(shape, Pk.stroke(a, 4));
  c.drawLine(Offset(r.center.dx, r.top), Offset(r.center.dx, r.bottom), frame);
  for (final fy in [0.5, 0.75]) {
    c.drawLine(_at(r, 0, fy), _at(r, 1, fy), frame);
  }
  for (var i = 0; i < 5; i++) {
    final ang = pi + i * pi / 4;
    c.drawLine(Offset(r.center.dx, r.top + w / 2), Offset(r.center.dx, r.top + w / 2) + Offset(cos(ang), sin(ang)) * w / 2, Pk.stroke(a, 1.5));
  }
  c.drawLine(Offset(r.left, r.top + w / 2), Offset(r.right, r.top + w / 2), frame);
  Pk.box(c, Rect.fromLTWH(r.left - 3, r.bottom - 3, w + 6, 5), Pk.light(a, 0.1), radius: 1);
}

const _archWindow = CustomProp(_paintArchWindow, wall: true);
'''
