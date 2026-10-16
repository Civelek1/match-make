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
  final w = r.width;
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
  final w = r.width;
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
  final h = r.height;
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
  final w = r.width;
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
    if (i == on) {
      Pk.glow(c, o, w * 0.6, cols[i], 0.5);
    }
  }
  Pk.box(c, _in(r, 0.2, 0.94, 0.6, 0.06), Pk.dark(a, 0.3), radius: 1);
}

const _signal = CustomProp(_paintSignal);

void _paintLuggageCart(Canvas c, Rect r, Color a, Color b, double t) {
  final h = r.height;
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
  final w = r.width;
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

DART_SCHOOL = r'''
// ============================================================ SCHOOL
void _paintChalkboard(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, r, a, radius: 2);
  c.drawRect(r.deflate(5), Pk.fill(b));
  final chalk = Pk.stroke(Colors.white.withValues(alpha: 0.85), 1.4);
  // A + B = C written in strokes, a little house doodle and a sum.
  final o = _at(r, 0.1, 0.2);
  final s = h * 0.22;
  c.drawLine(o + Offset(0, s), o + Offset(s * 0.4, 0), chalk);
  c.drawLine(o + Offset(s * 0.4, 0), o + Offset(s * 0.8, s), chalk);
  c.drawLine(o + Offset(s * 0.2, s * 0.55), o + Offset(s * 0.6, s * 0.55), chalk);
  final o2 = o + Offset(s * 1.2, 0);
  c.drawLine(o2, o2 + Offset(0, s), chalk);
  c.drawArc(Rect.fromLTWH(o2.dx - s * 0.3, o2.dy, s * 0.7, s * 0.5), -pi / 2, pi, false, chalk);
  c.drawArc(Rect.fromLTWH(o2.dx - s * 0.35, o2.dy + s * 0.5, s * 0.8, s * 0.5), -pi / 2, pi, false, chalk);
  final o3 = o2 + Offset(s * 1.0, 0);
  c.drawArc(Rect.fromLTWH(o3.dx, o3.dy, s * 0.8, s), pi * 0.3, pi * 1.4, false, chalk);
  for (var i = 0; i < 3; i++) {
    c.drawLine(_at(r, 0.1, 0.55 + i * 0.12), _at(r, 0.1 + 0.25 + Pk.rand(i + 3) * 0.2, 0.55 + i * 0.12), chalk);
  }
  final hc = _at(r, 0.78, 0.5);
  c.drawRect(Rect.fromCenter(center: hc + Offset(0, h * 0.08), width: w * 0.14, height: h * 0.2), chalk);
  c.drawLine(hc + Offset(-w * 0.09, -h * 0.02), hc + Offset(0, -h * 0.16), chalk);
  c.drawLine(hc + Offset(w * 0.09, -h * 0.02), hc + Offset(0, -h * 0.16), chalk);
  c.drawCircle(_at(r, 0.9, 0.18), h * 0.06, Pk.stroke(const Color(0xFFFFE066).withValues(alpha: 0.85), 1.4));
  Pk.box(c, Rect.fromLTWH(r.left + 4, r.bottom - 4, w - 8, 5), Pk.dark(a, 0.15), radius: 1);
  c.drawRect(Rect.fromLTWH(r.left + w * 0.2, r.bottom - 6, w * 0.05, 2.5), Pk.fill(Colors.white));
  c.drawRect(Rect.fromLTWH(r.left + w * 0.3, r.bottom - 6, w * 0.05, 2.5), Pk.fill(const Color(0xFFFF9EC4)));
}

const _chalkboard = CustomProp(_paintChalkboard, wall: true);

void _paintDesk(Canvas c, Rect r, Color a, Color b, double t) {
  final metal = Pk.fill(_iron);
  // Chair behind the desk.
  Pk.box(c, _in(r, 0.62, 0.0, 0.32, 0.36), b, radius: 3);
  c.drawRect(_in(r, 0.66, 0.36, 0.04, 0.64), metal);
  c.drawRect(_in(r, 0.86, 0.36, 0.04, 0.64), metal);
  // Desk.
  c.drawRect(_in(r, 0.06, 0.42, 0.04, 0.58), metal);
  c.drawRect(_in(r, 0.62, 0.42, 0.04, 0.58), metal);
  Pk.box(c, _in(r, 0.02, 0.36, 0.7, 0.1), a, radius: 2);
  c.drawRect(_in(r, 0.06, 0.46, 0.6, 0.12), Pk.fill(Pk.dark(a, 0.25)));
  // An open book and a pencil.
  final bk = _in(r, 0.14, 0.28, 0.3, 0.08);
  c.drawRect(bk, Pk.fill(Colors.white));
  c.drawLine(bk.topCenter, bk.bottomCenter, Pk.stroke(_ink.withValues(alpha: 0.4), 1));
  c.drawLine(_at(r, 0.5, 0.34), _at(r, 0.64, 0.3), Pk.stroke(const Color(0xFFFFC93C), 2));
}

const _desk = CustomProp(_paintDesk);

void _paintTeacherDesk(Canvas c, Rect r, Color a, Color b, double t) {
  final h = r.height;
  Pk.box(c, _in(r, 0, 0.3, 1, 0.7), a, radius: 3);
  Pk.box(c, _in(r, 0.06, 0.42, 0.3, 0.5), Pk.light(a, 0.1), radius: 2);
  c.drawRect(_in(r, 0.17, 0.52, 0.08, 0.03), Pk.fill(b));
  c.drawRect(_in(r, 0.17, 0.74, 0.08, 0.03), Pk.fill(b));
  c.drawRect(_in(r, 0.0, 0.28, 1.0, 0.06), Pk.fill(Pk.dark(a, 0.2)));
  // Apple, pencil cup and a stack of papers on top.
  c.drawCircle(_at(r, 0.2, 0.2), h * 0.09, Pk.fill(const Color(0xFFE0293F)));
  c.drawLine(_at(r, 0.2, 0.11), _at(r, 0.22, 0.05), Pk.stroke(_choc, 1.2));
  _leafAt(c, _at(r, 0.22, 0.1), h * 0.04, 0.9, _leaf);
  Pk.box(c, _in(r, 0.44, 0.1, 0.1, 0.18), b, radius: 2);
  for (var i = 0; i < 3; i++) {
    c.drawLine(_at(r, 0.46 + i * 0.03, 0.12), _at(r, 0.45 + i * 0.04, 0.0), Pk.stroke([const Color(0xFFFFC93C), const Color(0xFF45A7F5), const Color(0xFFE0533F)][i], 1.6));
  }
  for (var i = 0; i < 3; i++) {
    c.drawRect(_in(r, 0.66, 0.2 - i * 0.04, 0.24, 0.04), Pk.fill(i.isEven ? Colors.white : const Color(0xFFF4EFE6)));
  }
}

const _teacherDesk = CustomProp(_paintTeacherDesk);

void _paintGlobe(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, _in(r, 0.25, 0.9, 0.5, 0.1), a, radius: 2);
  c.drawRect(_in(r, 0.46, 0.7, 0.08, 0.22), Pk.fill(a));
  final cc = _at(r, 0.5, 0.4);
  final rad = min(w, h) * 0.36;
  c.drawCircle(cc, rad, Pk.fill(b));
  c.save();
  c.clipPath(Path()..addOval(Rect.fromCircle(center: cc, radius: rad)));
  final spin = (t * 0.15) % 1;
  for (var i = 0; i < 3; i++) {
    final x = cc.dx - rad + ((spin + i * 0.38) % 1.2) * rad * 2;
    c.drawOval(Rect.fromCenter(center: Offset(x, cc.dy - rad * (0.3 - i * 0.25)), width: rad * 0.7, height: rad * 0.5), Pk.fill(const Color(0xFF7CC46A)));
  }
  c.restore();
  c.drawArc(Rect.fromCircle(center: cc, radius: rad * 1.18), -pi * 0.15, pi * 1.3, false, Pk.stroke(a, 2));
  c.drawCircle(cc + Offset(-rad * 0.35, -rad * 0.35), rad * 0.15, Pk.fill(Colors.white.withValues(alpha: 0.5)));
}

const _globe = CustomProp(_paintGlobe);

void _paintMicroscope(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, _in(r, 0.1, 0.86, 0.8, 0.14), a, radius: 3);
  c.drawArc(_in(r, 0.35, 0.3, 0.6, 0.66), -pi / 2, pi, false, Pk.stroke(a, max(3.0, w * 0.12)));
  Pk.box(c, _in(r, 0.12, 0.6, 0.5, 0.06), _ink, radius: 1);
  c.save();
  c.translate(r.left + w * 0.45, r.top + h * 0.32);
  c.rotate(-0.4);
  Pk.box(c, Rect.fromLTWH(-w * 0.1, -h * 0.28, w * 0.2, h * 0.5), b, radius: 3);
  c.drawRect(Rect.fromLTWH(-w * 0.07, -h * 0.36, w * 0.14, h * 0.1), Pk.fill(_ink));
  c.drawRect(Rect.fromLTWH(-w * 0.05, h * 0.22, w * 0.1, h * 0.08), Pk.fill(_steel));
  c.restore();
  c.drawCircle(_at(r, 0.78, 0.6), w * 0.07, Pk.fill(_steel));
}

const _microscope = CustomProp(_paintMicroscope);

void _paintBeakers(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final glass = Pk.fill(_glassTint.withValues(alpha: 0.75));
  // Conical flask.
  final f1 = Path()
    ..moveTo(r.left + w * 0.1, r.top + h * 0.15)
    ..lineTo(r.left + w * 0.2, r.top + h * 0.15)
    ..lineTo(r.left + w * 0.34, r.bottom)
    ..lineTo(r.left - w * 0.04 + w * 0.04, r.bottom)
    ..close();
  c.drawPath(f1, glass);
  Pk.poly(c, [_at(r, 0.05, 0.62), _at(r, 0.25, 0.62), _at(r, 0.32, 1.0), _at(r, 0.0, 1.0)], Pk.fill(a));
  // Round flask.
  c.drawRect(_in(r, 0.46, 0.2, 0.08, 0.35), glass);
  c.drawCircle(_at(r, 0.5, 0.75), w * 0.16, glass);
  c.drawArc(Rect.fromCircle(center: _at(r, 0.5, 0.75), radius: w * 0.16), 0.15, pi - 0.3, false, Pk.fill(b));
  // Test tubes in a rack.
  for (var i = 0; i < 3; i++) {
    final tx = r.left + w * (0.72 + i * 0.09);
    c.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(tx, r.top + h * 0.35, w * 0.06, h * 0.55), bottomLeft: Radius.circular(w * 0.03), bottomRight: Radius.circular(w * 0.03)), glass);
    c.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(tx, r.top + h * 0.65, w * 0.06, h * 0.25), bottomLeft: Radius.circular(w * 0.03), bottomRight: Radius.circular(w * 0.03)),
        Pk.fill([a, b, const Color(0xFFFF7AB6)][i]));
  }
  c.drawRect(_in(r, 0.68, 0.5, 0.32, 0.06), Pk.fill(_darkWood));
  for (var k = 0; k < 3; k++) {
    final ph = (t * 0.7 + k / 3) % 1;
    c.drawCircle(Offset(r.left + w * 0.2 + sin(ph * 5) * 2, r.top + h * (0.12 - ph * 0.12)), 1.5 + ph * 2, Pk.fill(a.withValues(alpha: 0.6 * (1 - ph))));
  }
}

const _beakers = CustomProp(_paintBeakers);

void _paintLabBench(Canvas c, Rect r, Color a, Color b, double t) {
  Pk.box(c, _in(r, 0.02, 0.16, 0.96, 0.84), a, radius: 2);
  for (var i = 0; i < 3; i++) {
    Pk.box(c, _in(r, 0.06 + i * 0.31, 0.28, 0.27, 0.62), Pk.light(a, 0.1), radius: 2);
    c.drawRect(_in(r, 0.16 + i * 0.31, 0.36, 0.07, 0.04), Pk.fill(_steel));
  }
  Pk.box(c, _in(r, 0, 0, 1, 0.18), b, radius: 2);
}

const _labBench = CustomProp(_paintLabBench);

void _paintPeriodicTable(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, r, a, radius: 2);
  final cols = [const Color(0xFFFF9EC4), const Color(0xFFFFD447), const Color(0xFF7CC46A), const Color(0xFF8ED8FF), const Color(0xFFC9A0FF)];
  for (var y = 0; y < 5; y++) {
    for (var x = 0; x < 12; x++) {
      if (y == 0 && x > 0 && x < 11) continue;
      if (y < 3 && x > 1 && x < 7) continue;
      c.drawRect(Rect.fromLTWH(r.left + 4 + (w - 8) * x / 12 + 0.5, r.top + 4 + (h - 8) * y / 5 + 0.5, (w - 8) / 12 - 1, (h - 8) / 5 - 1), Pk.fill(cols[(x ~/ 3 + y) % 5]));
    }
  }
}

const _periodicTable = CustomProp(_paintPeriodicTable, wall: true);

void _paintCircuitBoard(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  Pk.box(c, r, a, radius: 2);
  final wire = Pk.stroke(const Color(0xFFFFC93C), 1.5);
  final path = Path()
    ..moveTo(r.left + w * 0.15, r.top + h * 0.3)
    ..lineTo(r.left + w * 0.85, r.top + h * 0.3)
    ..lineTo(r.left + w * 0.85, r.top + h * 0.75)
    ..lineTo(r.left + w * 0.15, r.top + h * 0.75)
    ..close();
  c.drawPath(path, wire);
  Pk.box(c, _in(r, 0.08, 0.42, 0.14, 0.24), _ink, radius: 2);
  c.drawRect(_in(r, 0.12, 0.38, 0.06, 0.05), Pk.fill(_steel));
  final on = sin(t * 3) > -0.3;
  for (final fx in [0.42, 0.66]) {
    final o = _at(r, fx, 0.3);
    if (on) {
      Pk.glow(c, o, w * 0.14, b, 0.6);
    }
    c.drawCircle(o, h * 0.08, Pk.fill(on ? b : Pk.dark(b, 0.4)));
  }
  c.drawLine(_at(r, 0.5, 0.75), _at(r, 0.58, 0.68), Pk.stroke(_ink, 2));
  c.drawCircle(_at(r, 0.5, 0.75), 2, Pk.fill(_ink));
}

const _circuitBoard = CustomProp(_paintCircuitBoard, wall: true);

void _paintHoop(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawRect(_in(r, 0.44, 0.5, 0.12, 0.08), Pk.fill(_iron));
  Pk.box(c, _in(r, 0.0, 0.0, 1.0, 0.56), a, radius: 3, outline: Pk.dark(a, 0.2));
  c.drawRect(_in(r, 0.32, 0.18, 0.36, 0.26), Pk.stroke(b, 2));
  final rim = Rect.fromCenter(center: _at(r, 0.5, 0.6), width: w * 0.5, height: h * 0.08);
  for (var i = 0; i < 5; i++) {
    final x0 = rim.left + rim.width * i / 4;
    c.drawLine(Offset(x0, rim.center.dy), Offset(rim.left + rim.width * (0.15 + i * 0.175), r.bottom), Pk.stroke(Colors.white.withValues(alpha: 0.85), 1));
  }
  c.drawLine(Offset(rim.left + rim.width * 0.12, r.top + h * 0.8), Offset(rim.right - rim.width * 0.12, r.top + h * 0.8), Pk.stroke(Colors.white.withValues(alpha: 0.7), 1));
  c.drawOval(rim, Pk.stroke(const Color(0xFFFF6A2A), 2.5));
}

const _hoop = CustomProp(_paintHoop, wall: true);

void _paintVaultBox(Canvas c, Rect r, Color a, Color b, double t) {
  final h = r.height;
  for (var i = 0; i < 4; i++) {
    final inset = 0.04 * (3 - i);
    final y = 0.25 + i * 0.19;
    Pk.poly(c, [_at(r, inset + 0.04, y), _at(r, 1 - inset - 0.04, y), _at(r, 1 - inset, y + 0.19), _at(r, inset, y + 0.19)], Pk.fill(i.isEven ? a : Pk.dark(a, 0.08)));
    c.drawLine(_at(r, inset, y + 0.19), _at(r, 1 - inset, y + 0.19), Pk.stroke(Pk.dark(a, 0.3), 1));
  }
  Pk.box(c, _in(r, 0.12, 0.08, 0.76, 0.2), b, radius: h * 0.08);
  for (var k = 1; k < 4; k++) {
    c.drawLine(_at(r, 0.12 + k * 0.19, 0.1), _at(r, 0.12 + k * 0.19, 0.26), Pk.stroke(Pk.dark(b, 0.2), 1));
  }
  c.drawRect(_in(r, 0.4, 0.4, 0.2, 0.08), Pk.fill(Pk.dark(a, 0.4)));
}

const _vaultBox = CustomProp(_paintVaultBox);

void _paintBallBin(Canvas c, Rect r, Color a, Color b, double t) {
  final h = r.height;
  final cols = [const Color(0xFFFF6A2A), Colors.white, b, const Color(0xFFFFD447), const Color(0xFF45A7F5), const Color(0xFFFF6A2A)];
  for (var i = 0; i < 6; i++) {
    final o = _at(r, 0.2 + (i % 3) * 0.3, 0.32 - (i ~/ 3) * 0.16);
    c.drawCircle(o, h * 0.17, Pk.fill(cols[i]));
    if (i == 0 || i == 5) {
      c.drawLine(o - Offset(h * 0.17, 0), o + Offset(h * 0.17, 0), Pk.stroke(_ink, 0.8));
      c.drawArc(Rect.fromCircle(center: o, radius: h * 0.12), -pi / 2, pi, false, Pk.stroke(_ink, 0.8));
    }
  }
  Pk.box(c, _in(r, 0.0, 0.38, 1.0, 0.54), a, radius: 3);
  for (var k = 1; k < 5; k++) {
    c.drawLine(_at(r, k / 5, 0.42), _at(r, k / 5, 0.88), Pk.stroke(Pk.dark(a, 0.25), 1.2));
  }
  for (final fx in [0.12, 0.88]) {
    c.drawCircle(_at(r, fx, 0.95), h * 0.05, Pk.fill(_ink));
  }
}

const _ballBin = CustomProp(_paintBallBin);

void _paintMats(Canvas c, Rect r, Color a, Color b, double t) {
  final h = r.height;
  for (var i = 0; i < 3; i++) {
    final mr = _in(r, 0.0 + i * 0.03, 1 - (i + 1) * 0.32, 1 - i * 0.06, 0.3);
    Pk.box(c, mr, i.isEven ? a : b, radius: h * 0.08);
    c.drawLine(mr.centerLeft + Offset(4, 0), mr.centerRight - const Offset(4, 0), Pk.stroke(Colors.white.withValues(alpha: 0.35), 1));
  }
}

const _mats = CustomProp(_paintMats);

void _paintRopes(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawRect(_in(r, 0, 0.0, 1, 0.06), Pk.fill(_iron));
  final n = max(2, (w / 22).floor());
  for (var i = 0; i < n; i++) {
    final x = r.left + w * (i + 0.5) / n;
    final sway = sin(t * 0.9 + i) * w * 0.02;
    c.drawLine(Offset(x, r.top + h * 0.05), Offset(x + sway, r.bottom - h * 0.04), Pk.stroke(a, max(2.5, w * 0.03)));
    for (var k = 0; k < 4; k++) {
      final y = r.top + h * (0.3 + k * 0.18);
      c.drawCircle(Offset(x + sway * (y - r.top) / h, y), max(2.5, w * 0.025), Pk.fill(Pk.dark(a, 0.15)));
    }
    c.drawCircle(Offset(x + sway, r.bottom - h * 0.04), max(3.0, w * 0.03), Pk.fill(b));
  }
}

const _ropes = CustomProp(_paintRopes, wall: true);

void _paintWallBars(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final n = max(2, (w / 26).floor());
  for (var i = 0; i <= n; i++) {
    c.drawRect(Rect.fromLTWH(r.left + (w - 5) * i / n, r.top, 5, h), Pk.fill(Pk.dark(a, 0.15)));
  }
  for (var k = 0; k < 10; k++) {
    final y = r.top + h * (0.05 + k * 0.1);
    c.drawRect(Rect.fromLTWH(r.left, y, w, 3), Pk.fill(a));
  }
}

const _wallBars = CustomProp(_paintWallBars);

void _paintDumbbellRack(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawRect(_in(r, 0.06, 0.2, 0.06, 0.8), Pk.fill(_iron));
  c.drawRect(_in(r, 0.88, 0.2, 0.06, 0.8), Pk.fill(_iron));
  for (var s = 0; s < 2; s++) {
    final y = r.top + h * (0.4 + s * 0.4);
    c.drawRect(Rect.fromLTWH(r.left + w * 0.04, y, w * 0.92, 3), Pk.fill(_iron));
    for (var i = 0; i < 3; i++) {
      final cx = r.left + w * (0.22 + i * 0.28);
      final sz = h * (0.08 + i * 0.02 + s * 0.02);
      c.drawRect(Rect.fromLTWH(cx - w * 0.08, y - sz - 1, w * 0.16, 2), Pk.fill(_steel));
      for (final d in [-1.0, 1.0]) {
        c.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(cx + d * w * 0.08, y - sz), width: w * 0.06, height: sz * 2), const Radius.circular(2)), Pk.fill(i.isEven ? a : b));
      }
    }
  }
}

const _dumbbellRack = CustomProp(_paintDumbbellRack);

void _paintDrums(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  // Cymbal on a stand.
  c.drawLine(_at(r, 0.88, 1), _at(r, 0.88, 0.12), Pk.stroke(_steel, 1.5));
  final wob = sin(t * 4) * 0.06;
  c.save();
  c.translate(r.left + w * 0.88, r.top + h * 0.12);
  c.rotate(wob);
  c.drawOval(Rect.fromCenter(center: Offset.zero, width: w * 0.3, height: h * 0.07), Pk.fill(const Color(0xFFFFD447)));
  c.restore();
  // Toms.
  for (final fx in [0.3, 0.56]) {
    final tr = Rect.fromCenter(center: _at(r, fx, 0.3), width: w * 0.22, height: h * 0.2);
    Pk.box(c, tr, a, radius: 3);
    c.drawOval(Rect.fromLTWH(tr.left, tr.top - h * 0.03, tr.width, h * 0.06), Pk.fill(Colors.white));
  }
  // Bass drum.
  final cc = _at(r, 0.44, 0.68);
  final rad = h * 0.3;
  c.drawCircle(cc, rad, Pk.fill(b));
  c.drawCircle(cc, rad * 0.82, Pk.fill(Colors.white));
  c.drawCircle(cc, rad * 0.4, Pk.fill(a));
  c.drawCircle(cc, rad, Pk.stroke(Pk.dark(b, 0.2), 2));
  // Snare.
  final sn = _in(r, 0.02, 0.52, 0.2, 0.16);
  Pk.box(c, sn, _steel, radius: 3);
  c.drawLine(_at(r, 0.12, 0.68), _at(r, 0.04, 1), Pk.stroke(_steel, 1.2));
  c.drawLine(_at(r, 0.12, 0.68), _at(r, 0.2, 1), Pk.stroke(_steel, 1.2));
}

const _drums = CustomProp(_paintDrums);

void _paintGuitar(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width;
  c.drawLine(_at(r, 0.5, 0.85), _at(r, 0.2, 1), Pk.stroke(_iron, 1.5));
  c.drawLine(_at(r, 0.5, 0.85), _at(r, 0.8, 1), Pk.stroke(_iron, 1.5));
  Pk.box(c, _in(r, 0.42, 0.0, 0.16, 0.1), Pk.dark(a, 0.4), radius: 2);
  c.drawRect(_in(r, 0.45, 0.08, 0.1, 0.42), Pk.fill(_darkWood));
  c.drawCircle(_at(r, 0.5, 0.56), w * 0.3, Pk.fill(a));
  c.drawCircle(_at(r, 0.5, 0.78), w * 0.4, Pk.fill(a));
  c.drawCircle(_at(r, 0.5, 0.62), w * 0.12, Pk.fill(Pk.dark(a, 0.5)));
  c.drawRect(_in(r, 0.36, 0.8, 0.28, 0.04), Pk.fill(b));
  for (var i = 0; i < 3; i++) {
    c.drawLine(_at(r, 0.47 + i * 0.03, 0.08), _at(r, 0.47 + i * 0.03, 0.82), Pk.stroke(Colors.white.withValues(alpha: 0.6), 0.6));
  }
}

const _guitar = CustomProp(_paintGuitar);

void _paintMusicStand(Canvas c, Rect r, Color a, Color b, double t) {
  c.drawLine(_at(r, 0.5, 0.45), _at(r, 0.5, 0.95), Pk.stroke(a, 2));
  c.drawLine(_at(r, 0.5, 0.95), _at(r, 0.15, 1), Pk.stroke(a, 1.5));
  c.drawLine(_at(r, 0.5, 0.95), _at(r, 0.85, 1), Pk.stroke(a, 1.5));
  Pk.poly(c, [_at(r, 0.0, 0.05), _at(r, 1.0, 0.05), _at(r, 0.94, 0.48), _at(r, 0.06, 0.48)], Pk.fill(a));
  final sheet = _in(r, 0.1, 0.0, 0.8, 0.42);
  c.drawRect(sheet, Pk.fill(Colors.white));
  for (var k = 0; k < 2; k++) {
    for (var l = 0; l < 4; l++) {
      final y = sheet.top + sheet.height * (0.18 + k * 0.42 + l * 0.07);
      c.drawLine(Offset(sheet.left + 3, y), Offset(sheet.right - 3, y), Pk.stroke(_ink.withValues(alpha: 0.4), 0.6));
    }
    for (var n = 0; n < 4; n++) {
      final o = Offset(sheet.left + sheet.width * (0.2 + n * 0.2), sheet.top + sheet.height * (0.28 + k * 0.42 - (n % 2) * 0.06));
      c.drawCircle(o, 1.6, Pk.fill(b));
      c.drawLine(o + const Offset(1.4, 0), o + Offset(1.4, -sheet.height * 0.14), Pk.stroke(b, 0.8));
    }
  }
}

const _musicStand = CustomProp(_paintMusicStand);

void _paintRecordPlayer(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  // Gramophone horn.
  final horn = Path()
    ..moveTo(r.left + w * 0.5, r.top + h * 0.5)
    ..quadraticBezierTo(r.left + w * 0.5, r.top + h * 0.2, r.left + w * 0.95, r.top)
    ..lineTo(r.left + w * 0.98, r.top + h * 0.42)
    ..quadraticBezierTo(r.left + w * 0.62, r.top + h * 0.34, r.left + w * 0.56, r.top + h * 0.52)
    ..close();
  c.drawPath(horn, Pk.fill(b));
  c.drawOval(Rect.fromLTWH(r.left + w * 0.88, r.top, w * 0.12, h * 0.42), Pk.fill(Pk.dark(b, 0.3)));
  Pk.box(c, _in(r, 0.04, 0.6, 0.86, 0.4), a, radius: 3);
  final rec = Rect.fromCenter(center: _at(r, 0.4, 0.58), width: w * 0.6, height: h * 0.12);
  c.drawOval(rec, Pk.fill(const Color(0xFF1E1A2E)));
  c.drawOval(Rect.fromCenter(center: rec.center, width: rec.width * 0.3, height: rec.height * 0.4), Pk.fill(const Color(0xFFE0533F)));
  c.drawCircle(_at(r, 0.85, 0.82), w * 0.04, Pk.fill(_gold));
}

const _recordPlayer = CustomProp(_paintRecordPlayer);

void _paintSwing(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final frame = Pk.stroke(a, max(2.5, w * 0.03));
  c.drawLine(_at(r, 0.02, 1), _at(r, 0.1, 0.04), frame);
  c.drawLine(_at(r, 0.18, 1), _at(r, 0.1, 0.04), frame);
  c.drawLine(_at(r, 0.82, 1), _at(r, 0.9, 0.04), frame);
  c.drawLine(_at(r, 0.98, 1), _at(r, 0.9, 0.04), frame);
  c.drawLine(_at(r, 0.06, 0.04), _at(r, 0.94, 0.04), frame);
  for (var i = 0; i < 2; i++) {
    final px = r.left + w * (0.35 + i * 0.3);
    final ang = sin(t * 1.6 + i * 1.7) * 0.25;
    final len = h * 0.72;
    final seat = Offset(px + sin(ang) * len, r.top + h * 0.04 + cos(ang) * len);
    c.drawLine(Offset(px - w * 0.05, r.top + h * 0.04), seat - Offset(w * 0.05, 0), Pk.stroke(_steel, 1));
    c.drawLine(Offset(px + w * 0.05, r.top + h * 0.04), seat + Offset(w * 0.05, 0), Pk.stroke(_steel, 1));
    Pk.box(c, Rect.fromCenter(center: seat, width: w * 0.14, height: h * 0.06), i.isEven ? b : const Color(0xFF45A7F5), radius: 2);
  }
}

const _swing = CustomProp(_paintSwing);

void _paintSlide(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final rail = Pk.stroke(_steel, 2);
  c.drawLine(_at(r, 0.08, 1), _at(r, 0.14, 0.1), rail);
  c.drawLine(_at(r, 0.3, 1), _at(r, 0.36, 0.1), rail);
  for (var k = 0; k < 6; k++) {
    final fy = 0.25 + k * 0.14;
    c.drawLine(_at(r, 0.1 + (1 - fy) * 0.06, fy), _at(r, 0.32 + (1 - fy) * 0.06, fy), Pk.stroke(_steel, 1.5));
  }
  Pk.box(c, _in(r, 0.1, 0.12, 0.3, 0.08), a, radius: 2);
  final chute = Path()
    ..moveTo(r.left + w * 0.36, r.top + h * 0.12)
    ..quadraticBezierTo(r.left + w * 0.6, r.top + h * 0.2, r.left + w * 0.72, r.top + h * 0.7)
    ..quadraticBezierTo(r.left + w * 0.8, r.top + h * 0.92, r.right, r.top + h * 0.94)
    ..lineTo(r.right, r.bottom)
    ..quadraticBezierTo(r.left + w * 0.72, r.bottom, r.left + w * 0.62, r.top + h * 0.72)
    ..quadraticBezierTo(r.left + w * 0.52, r.top + h * 0.3, r.left + w * 0.36, r.top + h * 0.24)
    ..close();
  c.drawPath(chute, Pk.fill(b));
  c.drawPath(chute, Pk.stroke(Pk.dark(b, 0.2), 1));
  Pk.poly(c, [_at(r, 0.08, 0.12), _at(r, 0.25, 0.0), _at(r, 0.42, 0.12)], Pk.fill(a));
}

const _slide = CustomProp(_paintSlide);

void _paintFlagpole(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  c.drawLine(_at(r, 0.1, 1), _at(r, 0.1, 0.02), Pk.stroke(_steel, 2));
  c.drawCircle(_at(r, 0.1, 0.02), 2.2, Pk.fill(_gold));
  final path = Path()..moveTo(r.left + w * 0.12, r.top + h * 0.05);
  for (var i = 0; i <= 8; i++) {
    final k = i / 8;
    path.lineTo(r.left + w * (0.12 + k * 0.86), r.top + h * (0.05 + sin(t * 3 + k * 5) * 0.02 * k));
  }
  for (var i = 8; i >= 0; i--) {
    final k = i / 8;
    path.lineTo(r.left + w * (0.12 + k * 0.86), r.top + h * (0.3 + sin(t * 3 + k * 5) * 0.02 * k));
  }
  path.close();
  c.drawPath(path, Pk.fill(a));
  c.drawCircle(_at(r, 0.45, 0.17), h * 0.06, Pk.fill(b));
  Pk.box(c, _in(r, 0.0, 0.94, 0.2, 0.06), _steel, radius: 1);
}

const _flagpole = CustomProp(_paintFlagpole);

void _paintSchoolBus(Canvas c, Rect r, Color a, Color b, double t) {
  final h = r.height;
  Pk.box(c, _in(r, 0.0, 0.08, 0.82, 0.72), a, radius: 6);
  Pk.box(c, _in(r, 0.76, 0.34, 0.24, 0.46), a, radius: 5);
  c.drawRect(_in(r, 0.0, 0.52, 1.0, 0.05), Pk.fill(_ink));
  c.drawRect(_in(r, 0.0, 0.64, 1.0, 0.03), Pk.fill(_ink));
  for (var i = 0; i < 5; i++) {
    Pk.box(c, _in(r, 0.05 + i * 0.145, 0.18, 0.12, 0.26), const Color(0xFFBFEFFA), radius: 2);
  }
  Pk.box(c, _in(r, 0.78, 0.18, 0.04, 0.3), const Color(0xFFBFEFFA), radius: 1);
  c.drawRect(_in(r, 0.94, 0.62, 0.06, 0.08), Pk.fill(const Color(0xFFFFE9A0)));
  c.drawRect(_in(r, 0.68, 0.58, 0.04, 0.2), Pk.fill(b));
  for (final fx in [0.18, 0.74]) {
    c.drawCircle(_at(r, fx, 0.82), h * 0.14, Pk.fill(_ink));
    c.drawCircle(_at(r, fx, 0.82), h * 0.06, Pk.fill(_steel));
  }
  c.drawRect(_in(r, 0.0, 0.08, 0.82, 0.05), Pk.fill(Pk.light(a, 0.25)));
}

const _schoolBus = CustomProp(_paintSchoolBus);

void _paintBunting(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width, h = r.height;
  final p = Path()..moveTo(r.left, r.top);
  p.quadraticBezierTo(r.center.dx, r.top + h * 0.5, r.right, r.top);
  c.drawPath(p, Pk.stroke(_ink, 0.8));
  final n = max(5, (w / 22).floor());
  final cols = [a, b, const Color(0xFFFFD447), const Color(0xFF7CC46A), const Color(0xFF45A7F5)];
  for (var i = 0; i < n; i++) {
    final k = (i + 0.5) / n;
    final x = r.left + w * k;
    final y = r.top + h * 4 * k * (1 - k) * 0.25;
    final sway = sin(t * 1.5 + i) * 1.2;
    Pk.poly(c, [Offset(x - w / n * 0.38, y), Offset(x + w / n * 0.38, y), Offset(x + sway, y + h * 0.55)], Pk.fill(cols[i % 5]));
  }
}

const _bunting = CustomProp(_paintBunting, wall: true);

void _paintBackpack(Canvas c, Rect r, Color a, Color b, double t) {
  final w = r.width;
  c.drawArc(_in(r, 0.3, 0.0, 0.4, 0.3), pi, pi, false, Pk.stroke(Pk.dark(a, 0.3), 2));
  Pk.box(c, _in(r, 0.08, 0.12, 0.84, 0.88), a, radius: w * 0.25);
  Pk.box(c, _in(r, 0.2, 0.52, 0.6, 0.36), Pk.light(a, 0.12), radius: w * 0.12);
  c.drawLine(_at(r, 0.25, 0.6), _at(r, 0.75, 0.6), Pk.stroke(b, 1.5));
  c.drawCircle(_at(r, 0.5, 0.36), w * 0.06, Pk.fill(b));
}

const _backpack = CustomProp(_paintBackpack);
'''

DART_SCENERY = r'''
// ============================================================ SCENERY
void _bricks(Canvas c, Rect area, Color mortar, {double bw = 24, double bh = 10}) {
  final p = Pk.stroke(mortar, 0.8);
  var row = 0;
  for (var y = area.top; y < area.bottom; y += bh) {
    c.drawLine(Offset(area.left, y), Offset(area.right, y), p);
    for (var x = area.left + (row.isEven ? 0 : bw / 2); x < area.right; x += bw) {
      c.drawLine(Offset(x, y), Offset(x, min(y + bh, area.bottom)), p);
    }
    row++;
  }
}

void _wainscot(Canvas c, double top, Color col) {
  c.drawRect(Rect.fromLTWH(0, top, 400, 172 - top), Pk.fill(col));
  c.drawRect(Rect.fromLTWH(0, top, 400, 4), Pk.fill(Pk.dark(col, 0.2)));
  for (var x = 10.0; x < 400; x += 50) {
    c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(x, top + 10, 36, 172 - top - 18), const Radius.circular(2)), Pk.stroke(Pk.dark(col, 0.15), 1.2));
  }
}

void _bakeryFacade(Canvas c, double ov, double t) {
  final wall = Pk.mix(const Color(0xFFB8AFA4), const Color(0xFFFFE3D2), ov);
  Pk.box(c, const Rect.fromLTWH(26, 16, 348, 136), wall, radius: 2);
  c.drawRect(const Rect.fromLTWH(20, 10, 360, 12), Pk.fill(Pk.mix(const Color(0xFF7D6B5E), const Color(0xFF7A3E2E), ov)));
  c.drawRect(const Rect.fromLTWH(26, 22, 348, 26), Pk.fill(Pk.mix(const Color(0xFF8C7E6C), const Color(0xFF5E3A2A), ov)));
  final base = Pk.mix(const Color(0xFF8A7A6A), const Color(0xFFB5523B), ov);
  c.drawRect(const Rect.fromLTWH(26, 132, 348, 20), Pk.fill(base));
  _bricks(c, const Rect.fromLTWH(26, 132, 348, 20), Pk.light(base, 0.3), bw: 18, bh: 7);
  // Neighbouring houses at the edges.
  c.drawRect(const Rect.fromLTWH(0, 40, 26, 112), Pk.fill(Pk.mix(const Color(0xFF9E9A92), const Color(0xFFB8E0D2), ov)));
  c.drawRect(const Rect.fromLTWH(374, 30, 26, 122), Pk.fill(Pk.mix(const Color(0xFF9E9A92), const Color(0xFFFFE08A), ov)));
}

void _kitchenTiles(Canvas c, double ov, double t) {
  final tile = Pk.mix(const Color(0xFFB9B2A6), const Color(0xFFF4FAF8), ov);
  c.drawRect(const Rect.fromLTWH(0, 92, 400, 80), Pk.fill(tile));
  final g = Pk.stroke(Pk.dark(tile, 0.12), 0.8);
  for (var x = 0.0; x <= 400; x += 16) {
    c.drawLine(Offset(x, 92), Offset(x, 172), g);
  }
  for (var y = 92.0; y <= 172; y += 16) {
    c.drawLine(Offset(0, y), Offset(400, y), g);
  }
  c.drawRect(const Rect.fromLTWH(0, 88, 400, 5), Pk.fill(Pk.mix(const Color(0xFF7E8A88), const Color(0xFF2EA59A), ov)));
}

void _cakeStripes(Canvas c, double ov, double t) {
  final s = Pk.mix(const Color(0x00FFFFFF), const Color(0x55FFFFFF), ov);
  for (var x = 0.0; x < 400; x += 28) {
    c.drawRect(Rect.fromLTWH(x, 0, 12, 120), Pk.fill(s));
  }
  _wainscot(c, 120, Pk.mix(const Color(0xFFA59C94), const Color(0xFFFFFFFF), ov));
}

void _storeroomWall(Canvas c, double ov, double t) {
  final brick = Pk.mix(const Color(0xFF8E8278), const Color(0xFFC9765A), ov);
  c.drawRect(const Rect.fromLTWH(0, 110, 400, 62), Pk.fill(brick));
  _bricks(c, const Rect.fromLTWH(0, 110, 400, 62), Pk.light(brick, 0.3));
  final beam = Pk.mix(const Color(0xFF6E6258), const Color(0xFF7A4E30), ov);
  c.drawRect(const Rect.fromLTWH(0, 0, 400, 12), Pk.fill(beam));
  for (final x in [60.0, 200.0, 340.0]) {
    c.drawRect(Rect.fromLTWH(x - 7, 0, 14, 172), Pk.fill(beam));
    c.drawRect(Rect.fromLTWH(x - 7, 0, 3, 172), Pk.fill(Pk.light(beam, 0.15)));
  }
}

void _cafeFacade(Canvas c, double ov, double t) {
  final wall = Pk.mix(const Color(0xFFAFA79C), const Color(0xFFF2E1C4), ov);
  Pk.box(c, const Rect.fromLTWH(0, 24, 400, 128), wall, radius: 1);
  c.drawRect(const Rect.fromLTWH(0, 18, 400, 10), Pk.fill(Pk.mix(const Color(0xFF6E6258), const Color(0xFF2E6E5A), ov)));
  for (final x in [24.0, 290.0]) {
    final r = Rect.fromLTWH(x, 50, 86, 80);
    Pk.box(c, r.inflate(3), Pk.mix(const Color(0xFF6E6258), const Color(0xFF2E6E5A), ov), radius: 3);
    Pk.gradientRect(c, r, Pk.mix(const Color(0xFF5C6670), const Color(0xFF5C7FA8), ov), Pk.mix(const Color(0xFF8E9298), const Color(0xFFFFD9A0), ov));
    c.drawLine(r.topCenter, r.bottomCenter, Pk.stroke(Pk.mix(const Color(0xFF6E6258), const Color(0xFF2E6E5A), ov), 2));
  }
  final door = const Rect.fromLTWH(176, 70, 48, 82);
  Pk.box(c, door.inflate(3), Pk.mix(const Color(0xFF6E6258), const Color(0xFF2E6E5A), ov), radius: 3);
  Pk.gradientRect(c, door, Pk.mix(const Color(0xFF5C6670), const Color(0xFF5C7FA8), ov), Pk.mix(const Color(0xFF8E9298), const Color(0xFFFFE3B0), ov));
}

void _greenhouseFront(Canvas c, double ov, double t) {
  final frame = Pk.mix(const Color(0xFF9A9A92), const Color(0xFFFFFFFF), ov);
  final glass = Pk.mix(const Color(0xFF9AA8A6), const Color(0xFFCFF3FF), ov);
  final body = Path()
    ..moveTo(60, 146)
    ..lineTo(60, 70)
    ..lineTo(200, 22)
    ..lineTo(340, 70)
    ..lineTo(340, 146)
    ..close();
  c.drawPath(body, Pk.fill(glass.withValues(alpha: 0.8)));
  c.save();
  c.clipPath(body);
  for (var i = 0; i < 4; i++) {
    final x = 60 + i * 80.0 + sin(t * 0.3 + i) * 4;
    c.drawLine(Offset(x, 146), Offset(x + 50, 20), Pk.stroke(Colors.white.withValues(alpha: 0.3), 6));
  }
  // Plants inside.
  for (var i = 0; i < 7; i++) {
    c.drawCircle(Offset(80 + i * 40.0, 136 - Pk.rand(i) * 16), 14 + Pk.rand(i + 3) * 8, Pk.fill(Pk.mix(const Color(0xFF8A9478), const Color(0xFF5DB848), ov).withValues(alpha: 0.7)));
  }
  c.restore();
  final p = Pk.stroke(frame, 2.5);
  c.drawPath(body, p);
  for (var x = 80.0; x < 340; x += 20) {
    final top = x < 200 ? 70 - (x - 60) / 140 * 48 : 22 + (x - 200) / 140 * 48;
    c.drawLine(Offset(x, 146), Offset(x, top), Pk.stroke(frame, 1.2));
  }
  c.drawLine(const Offset(60, 70), const Offset(340, 70), p);
  c.drawLine(const Offset(60, 108), const Offset(340, 108), Pk.stroke(frame, 1.5));
}

void _glassWall(Canvas c, double ov, double t) {
  final frame = Pk.mix(const Color(0xFF8E8E86), const Color(0xFFFFFFFF), ov);
  final sky = Pk.mix(const Color(0xFFA6B2B0), const Color(0xFFBFEFFF), ov);
  c.drawRect(const Rect.fromLTWH(0, 0, 400, 132), Pk.fill(sky));
  for (var i = 0; i < 5; i++) {
    c.drawCircle(Offset(30 + i * 90.0, 140), 40 + Pk.rand(i) * 16, Pk.fill(Pk.mix(const Color(0xFF8A9478), const Color(0xFF9ED67A), ov).withValues(alpha: 0.55)));
  }
  for (var i = 0; i < 3; i++) {
    final x = 40 + i * 140.0 + sin(t * 0.3 + i) * 5;
    c.drawLine(Offset(x, 132), Offset(x + 60, 0), Pk.stroke(Colors.white.withValues(alpha: 0.25), 10));
  }
  final p = Pk.stroke(frame, 3);
  for (var x = 0.0; x <= 400; x += 50) {
    c.drawLine(Offset(x, 0), Offset(x, 132), p);
  }
  for (final y in [44.0, 88.0]) {
    c.drawLine(Offset(0, y), Offset(400, y), Pk.stroke(frame, 2));
  }
  c.drawRect(const Rect.fromLTWH(0, 128, 400, 44), Pk.fill(Pk.mix(const Color(0xFF8E8678), const Color(0xFFE6DCCB), ov)));
  c.drawRect(const Rect.fromLTWH(0, 128, 400, 4), Pk.fill(frame));
}

void _palmDome(Canvas c, double ov, double t) {
  final frame = Pk.mix(const Color(0xFF8E8E86), const Color(0xFFFFFFFF), ov);
  final sky = Pk.mix(const Color(0xFFA6B2B0), const Color(0xFFBFEFFF), ov);
  final dome = Path()
    ..moveTo(0, 172)
    ..lineTo(0, 90)
    ..quadraticBezierTo(200, -70, 400, 90)
    ..lineTo(400, 172)
    ..close();
  c.drawPath(dome, Pk.fill(sky));
  c.save();
  c.clipPath(dome);
  for (var i = 0; i < 6; i++) {
    c.drawCircle(Offset(Pk.rand(i + 30) * 400, 160), 30 + Pk.rand(i) * 20, Pk.fill(Pk.mix(const Color(0xFF8A9478), const Color(0xFF7CCB5A), ov).withValues(alpha: 0.5)));
  }
  final p = Pk.stroke(frame, 2.5);
  for (var i = -4; i <= 4; i++) {
    c.drawLine(Offset(200 + i * 52.0, 172), Offset(200 + i * 14.0, 10), p);
  }
  for (final k in [0.35, 0.6, 0.82]) {
    final pth = Path()
      ..moveTo(0, 90 + (172 - 90) * (1 - k))
      ..quadraticBezierTo(200, -70 + 230 * (1 - k), 400, 90 + (172 - 90) * (1 - k));
    c.drawPath(pth, Pk.stroke(frame, 1.6));
  }
  c.restore();
  c.drawPath(dome, Pk.stroke(frame, 4));
}

void _pondGarden(Canvas c, double ov, double t) {
  final hedge = Pk.mix(const Color(0xFF7E8A6A), const Color(0xFF3F9A48), ov);
  // A small greenhouse in the distance.
  final frame = Pk.mix(const Color(0xFF9A9A92), const Color(0xFFFFFFFF), ov);
  final gh = Path()
    ..moveTo(250, 120)
    ..lineTo(250, 80)
    ..lineTo(300, 56)
    ..lineTo(350, 80)
    ..lineTo(350, 120)
    ..close();
  c.drawPath(gh, Pk.fill(Pk.mix(const Color(0xFF9AA8A6), const Color(0xFFCFF3FF), ov)));
  c.drawPath(gh, Pk.stroke(frame, 2));
  for (var x = 262.0; x < 350; x += 12) {
    c.drawLine(Offset(x, 120), Offset(x, x < 300 ? 80 - (x - 250) / 50 * 24 : 56 + (x - 300) / 50 * 24), Pk.stroke(frame, 1));
  }
  for (var i = 0; i < 14; i++) {
    c.drawCircle(Offset(i * 30.0 + 10, 124 - Pk.rand(i) * 6), 16, Pk.fill(i.isEven ? hedge : Pk.dark(hedge, 0.08)));
  }
  c.drawRect(const Rect.fromLTWH(0, 124, 400, 22), Pk.fill(hedge));
}

void _vineHills(Canvas c, double ov, double t) {
  final far = Pk.mix(const Color(0xFFA8A88E), const Color(0xFF8CC86A), ov);
  final near = Pk.mix(const Color(0xFF9C9A80), const Color(0xFF6DB84E), ov);
  final h1 = Path()
    ..moveTo(0, 110)
    ..quadraticBezierTo(120, 60, 250, 96)
    ..quadraticBezierTo(330, 116, 400, 84)
    ..lineTo(400, 150)
    ..lineTo(0, 150)
    ..close();
  c.drawPath(h1, Pk.fill(far));
  // Farmhouse on the hill.
  final wall = Pk.mix(const Color(0xFFB8AFA4), const Color(0xFFF4E2C4), ov);
  Pk.box(c, const Rect.fromLTWH(300, 70, 50, 32), wall, radius: 1);
  Pk.poly(c, const [Offset(294, 72), Offset(325, 54), Offset(356, 72)], Pk.fill(Pk.mix(const Color(0xFF8C7A70), const Color(0xFFC8552F), ov)));
  c.drawRect(const Rect.fromLTWH(312, 80, 8, 8), Pk.fill(Pk.mix(const Color(0xFF6E6A70), const Color(0xFF5C7FA8), ov)));
  c.drawRect(const Rect.fromLTWH(330, 84, 9, 18), Pk.fill(Pk.mix(const Color(0xFF6E6A70), const Color(0xFF7A4E30), ov)));
  final h2 = Path()
    ..moveTo(0, 130)
    ..quadraticBezierTo(150, 100, 260, 124)
    ..quadraticBezierTo(340, 140, 400, 120)
    ..lineTo(400, 150)
    ..lineTo(0, 150)
    ..close();
  c.drawPath(h2, Pk.fill(near));
  final row = Pk.stroke(Pk.dark(near, 0.2), 2);
  for (var i = 0; i < 4; i++) {
    final y = 128 + i * 6.0;
    c.drawLine(Offset(0, y + 4), Offset(400, y - 4), row);
  }
}

void _barnWall(Canvas c, double ov, double t) {
  final plank = Pk.mix(const Color(0xFF8E8070), const Color(0xFFB98352), ov);
  c.drawRect(const Rect.fromLTWH(0, 0, 400, 172), Pk.fill(plank));
  for (var x = 0.0; x < 400; x += 22) {
    c.drawLine(Offset(x, 0), Offset(x, 172), Pk.stroke(Pk.dark(plank, 0.2), 1.2));
  }
  final beam = Pk.dark(plank, 0.3);
  c.drawRect(const Rect.fromLTWH(0, 10, 400, 12), Pk.fill(beam));
  Pk.poly(c, const [Offset(0, 22), Offset(30, 22), Offset(0, 60)], Pk.fill(beam));
  Pk.poly(c, const [Offset(400, 22), Offset(370, 22), Offset(400, 60)], Pk.fill(beam));
  // A small window with daylight.
  final win = const Rect.fromLTWH(176, 40, 48, 38);
  Pk.box(c, win.inflate(3), beam, radius: 2);
  Pk.gradientRect(c, win, Pk.mix(const Color(0xFF9AA8B0), const Color(0xFF8ED8FF), ov), Pk.mix(const Color(0xFFB8B8A8), const Color(0xFFFFF0C8), ov));
  c.drawLine(win.topCenter, win.bottomCenter, Pk.stroke(beam, 2));
}

void _cellarVault(Canvas c, double ov, double t) {
  final stone = Pk.mix(const Color(0xFF5E5850), const Color(0xFF9A7E62), ov);
  c.drawRect(const Rect.fromLTWH(0, 0, 400, 172), Pk.fill(stone));
  _bricks(c, const Rect.fromLTWH(0, 0, 400, 172), Pk.dark(stone, 0.25), bw: 30, bh: 14);
  final dark = Pk.dark(stone, 0.45);
  for (final x in [-40.0, 120.0, 280.0]) {
    final arch = Path()
      ..moveTo(x + 20, 172)
      ..lineTo(x + 20, 90)
      ..quadraticBezierTo(x + 80, 20, x + 140, 90)
      ..lineTo(x + 140, 172)
      ..close();
    c.drawPath(arch, Pk.fill(dark));
    c.drawPath(arch, Pk.stroke(Pk.light(stone, 0.15), 5));
  }
  Pk.glow(c, const Offset(200, 90), 160, const Color(0xFFFFB347), 0.25 * ov);
}

void _rusticKitchen(Canvas c, double ov, double t) {
  final stone = Pk.mix(const Color(0xFF8E8678), const Color(0xFFD8C4A2), ov);
  c.drawRect(const Rect.fromLTWH(0, 100, 400, 72), Pk.fill(stone));
  _bricks(c, const Rect.fromLTWH(0, 100, 400, 72), Pk.dark(stone, 0.18), bw: 28, bh: 12);
  final beam = Pk.mix(const Color(0xFF6E6258), const Color(0xFF6B4226), ov);
  c.drawRect(const Rect.fromLTWH(0, 0, 400, 10), Pk.fill(beam));
  c.drawRect(const Rect.fromLTWH(0, 96, 400, 6), Pk.fill(beam));
  final win = const Rect.fromLTWH(170, 28, 60, 48);
  Pk.box(c, win.inflate(4), beam, radius: 2);
  Pk.gradientRect(c, win, Pk.mix(const Color(0xFF9AA8B0), const Color(0xFF8ED8FF), ov), Pk.mix(const Color(0xFFB8B8A8), const Color(0xFF9ED67A), ov));
  c.drawLine(win.topCenter, win.bottomCenter, Pk.stroke(beam, 2.5));
  c.drawLine(win.centerLeft, win.centerRight, Pk.stroke(beam, 2.5));
}

void _sunsetHills(Canvas c, double ov, double t) {
  final glow = Pk.mix(const Color(0x00FFFFFF), const Color(0x88FF7A4A), ov);
  Pk.glow(c, const Offset(200, 130), 220, glow, 0.8);
  final far = Pk.mix(const Color(0xFF9A9488), const Color(0xFF9A5E8A), ov);
  final near = Pk.mix(const Color(0xFF8E8A7A), const Color(0xFF6E4A7A), ov);
  final h1 = Path()
    ..moveTo(0, 116)
    ..quadraticBezierTo(100, 84, 210, 108)
    ..quadraticBezierTo(320, 130, 400, 100)
    ..lineTo(400, 150)
    ..lineTo(0, 150)
    ..close();
  c.drawPath(h1, Pk.fill(far));
  final h2 = Path()
    ..moveTo(0, 134)
    ..quadraticBezierTo(140, 112, 260, 132)
    ..quadraticBezierTo(330, 142, 400, 128)
    ..lineTo(400, 150)
    ..lineTo(0, 150)
    ..close();
  c.drawPath(h2, Pk.fill(near));
  for (final x in [70.0, 84.0, 300.0]) {
    Pk.poly(c, [Offset(x, 132), Offset(x + 5, 104), Offset(x + 10, 132)], Pk.fill(Pk.dark(near, 0.3)));
  }
}

void _platformCanopy(Canvas c, double ov, double t) {
  final iron = Pk.mix(const Color(0xFF6E6A70), const Color(0xFF2E5E4A), ov);
  // Far wall of the station across the tracks.
  final wall = Pk.mix(const Color(0xFF9E968C), const Color(0xFFE8C9A0), ov);
  c.drawRect(const Rect.fromLTWH(0, 36, 400, 80), Pk.fill(wall));
  _bricks(c, const Rect.fromLTWH(0, 36, 400, 80), Pk.dark(wall, 0.12), bw: 26, bh: 10);
  for (var i = 0; i < 5; i++) {
    final r = Rect.fromLTWH(20 + i * 80.0, 52, 40, 40);
    c.drawRRect(RRect.fromRectAndCorners(r, topLeft: const Radius.circular(20), topRight: const Radius.circular(20)), Pk.fill(Pk.mix(const Color(0xFF6E6A70), const Color(0xFF5C7FA8), ov)));
  }
  // Track bed in front of the far wall.
  c.drawRect(const Rect.fromLTWH(0, 116, 400, 34), Pk.fill(Pk.mix(const Color(0xFF7A746C), const Color(0xFF8A7E70), ov)));
  for (var x = 0.0; x < 400; x += 14) {
    c.drawRect(Rect.fromLTWH(x, 140, 8, 6), Pk.fill(Pk.mix(const Color(0xFF5E5650), const Color(0xFF6B4A2E), ov)));
  }
  c.drawLine(const Offset(0, 141), const Offset(400, 141), Pk.stroke(const Color(0xFFB8B4C0), 2));
  c.drawLine(const Offset(0, 146), const Offset(400, 146), Pk.stroke(const Color(0xFFB8B4C0), 2));
  // Canopy roof and columns.
  c.drawRect(const Rect.fromLTWH(0, 0, 400, 22), Pk.fill(iron));
  for (var x = 0.0; x < 400; x += 20) {
    Pk.poly(c, [Offset(x, 22), Offset(x + 20, 22), Offset(x + 10, 30)], Pk.fill(iron));
  }
  // Platform edge.
  c.drawRect(const Rect.fromLTWH(0, 150, 400, 6), Pk.fill(Pk.mix(const Color(0xFFB8B0A0), const Color(0xFFFFD447), ov)));
}

void _ticketHallWall(Canvas c, double ov, double t) {
  final marble = Pk.mix(const Color(0xFFA8A296), const Color(0xFFF2E8D8), ov);
  c.drawRect(const Rect.fromLTWH(0, 120, 400, 52), Pk.fill(Pk.dark(marble, 0.08)));
  for (var x = 0.0; x < 400; x += 40) {
    c.drawLine(Offset(x, 120), Offset(x, 172), Pk.stroke(Pk.dark(marble, 0.18), 1));
  }
  c.drawRect(const Rect.fromLTWH(0, 118, 400, 4), Pk.fill(Pk.mix(const Color(0xFF8A847A), const Color(0xFFC9A04A), ov)));
  for (final x in [96.0, 304.0]) {
    Pk.box(c, Rect.fromLTWH(x - 9, 0, 18, 172), Pk.light(marble, 0.1), radius: 2);
    c.drawRect(Rect.fromLTWH(x - 12, 0, 24, 8), Pk.fill(Pk.dark(marble, 0.1)));
  }
}

void _waitingWall(Canvas c, double ov, double t) {
  _wainscot(c, 112, Pk.mix(const Color(0xFF7E7266), const Color(0xFF8B5E3C), ov));
  final win = const Rect.fromLTWH(150, 24, 100, 64);
  final fr = Pk.mix(const Color(0xFF6E6258), const Color(0xFF6B4226), ov);
  Pk.box(c, win.inflate(4), fr, radius: 3);
  Pk.gradientRect(c, win, Pk.mix(const Color(0xFF9AA8B0), const Color(0xFF8ED8FF), ov), Pk.mix(const Color(0xFFB8B8A8), const Color(0xFFFFF0C8), ov));
  // A passing train outside.
  final x = (t * 30) % 260 - 80;
  c.save();
  c.clipRect(win);
  Pk.box(c, Rect.fromLTWH(win.left + x, win.top + 30, 90, 26), Pk.mix(const Color(0xFF8A847A), const Color(0xFFE0533F), ov), radius: 4);
  for (var i = 0; i < 4; i++) {
    c.drawRect(Rect.fromLTWH(win.left + x + 8 + i * 20, win.top + 35, 12, 8), Pk.fill(const Color(0xFFFFF0C8)));
  }
  c.restore();
  c.drawLine(win.topCenter, win.bottomCenter, Pk.stroke(fr, 2.5));
  c.drawLine(win.centerLeft, win.centerRight, Pk.stroke(fr, 2.5));
}

void _stationCafeWall(Canvas c, double ov, double t) {
  final tile = Pk.mix(const Color(0xFFA8A296), const Color(0xFFE8F4EE), ov);
  c.drawRect(const Rect.fromLTWH(0, 100, 400, 72), Pk.fill(tile));
  for (var y = 100.0; y < 172; y += 9) {
    for (var x = (y ~/ 9).isEven ? 0.0 : 9.0; x < 400; x += 18) {
      c.drawRect(Rect.fromLTWH(x, y, 17, 8), Pk.stroke(Pk.dark(tile, 0.1), 0.6));
    }
  }
  c.drawRect(const Rect.fromLTWH(0, 96, 400, 5), Pk.fill(Pk.mix(const Color(0xFF6E6A70), const Color(0xFF2E5E4A), ov)));
}

void _shedInterior(Canvas c, double ov, double t) {
  final brick = Pk.mix(const Color(0xFF7E746C), const Color(0xFFB0644A), ov);
  c.drawRect(const Rect.fromLTWH(0, 0, 400, 172), Pk.fill(brick));
  _bricks(c, const Rect.fromLTWH(0, 30, 400, 142), Pk.light(brick, 0.2));
  // Big arched doorway with daylight.
  final door = Path()
    ..moveTo(130, 172)
    ..lineTo(130, 80)
    ..quadraticBezierTo(200, 20, 270, 80)
    ..lineTo(270, 172)
    ..close();
  c.drawPath(door, Pk.fill(Pk.mix(const Color(0xFFB8B4A8), const Color(0xFFFFF0C8), ov)));
  c.drawPath(door, Pk.stroke(Pk.dark(brick, 0.25), 6));
  final iron = Pk.mix(const Color(0xFF4A4458), const Color(0xFF2E3A5A), ov);
  c.drawRect(const Rect.fromLTWH(0, 0, 400, 14), Pk.fill(iron));
  for (var x = 0.0; x < 400; x += 80) {
    c.drawLine(Offset(x, 14), Offset(x + 40, 34), Pk.stroke(iron, 3));
    c.drawLine(Offset(x + 80, 14), Offset(x + 40, 34), Pk.stroke(iron, 3));
  }
  c.drawLine(const Offset(0, 34), const Offset(400, 34), Pk.stroke(iron, 3));
  // Tracks on the floor.
  for (var x = 0.0; x < 400; x += 16) {
    c.drawRect(Rect.fromLTWH(x, 192, 9, 8), Pk.fill(Pk.mix(const Color(0xFF5E5650), const Color(0xFF6B4A2E), ov)));
  }
  c.drawLine(const Offset(0, 193), const Offset(400, 193), Pk.stroke(const Color(0xFFB8B4C0), 2.5));
  c.drawLine(const Offset(0, 199), const Offset(400, 199), Pk.stroke(const Color(0xFFB8B4C0), 2.5));
}

void _schoolFacade(Canvas c, double ov, double t) {
  final brick = Pk.mix(const Color(0xFF9A8E84), const Color(0xFFD0704E), ov);
  Pk.box(c, const Rect.fromLTWH(40, 30, 320, 116), brick, radius: 2);
  _bricks(c, const Rect.fromLTWH(40, 30, 320, 116), Pk.light(brick, 0.25), bw: 20, bh: 8);
  Pk.poly(c, const [Offset(150, 34), Offset(200, 6), Offset(250, 34)], Pk.fill(Pk.mix(const Color(0xFF7D6B5E), const Color(0xFF3E4A6A), ov)));
  c.drawRect(const Rect.fromLTWH(34, 26, 332, 8), Pk.fill(Pk.mix(const Color(0xFFB0AA9E), const Color(0xFFF4EFE6), ov)));
  final glass = Pk.mix(const Color(0xFF7A848C), const Color(0xFF8ED8FF), ov);
  for (var row = 0; row < 2; row++) {
    for (var i = 0; i < 6; i++) {
      if (i == 2 || i == 3) continue;
      final r = Rect.fromLTWH(56 + i * 50.0, 44 + row * 46.0, 34, 30);
      c.drawRect(r.inflate(2), Pk.fill(Colors.white));
      c.drawRect(r, Pk.fill(glass));
      c.drawLine(r.topCenter, r.bottomCenter, Pk.stroke(Colors.white, 1.5));
    }
  }
  // Entrance and a round clock.
  final door = const Rect.fromLTWH(176, 92, 48, 54);
  c.drawRRect(RRect.fromRectAndCorners(door, topLeft: const Radius.circular(24), topRight: const Radius.circular(24)), Pk.fill(Pk.mix(const Color(0xFF6E6258), const Color(0xFF2E5E86), ov)));
  c.drawCircle(const Offset(200, 62), 14, Pk.fill(Colors.white));
  c.drawCircle(const Offset(200, 62), 14, Pk.stroke(Pk.dark(brick, 0.3), 2));
  c.drawLine(const Offset(200, 62), const Offset(200, 53), Pk.stroke(_ink, 1.5));
  c.drawLine(const Offset(200, 62), const Offset(207, 64), Pk.stroke(_ink, 1.5));
}

void _classroomWall(Canvas c, double ov, double t) {
  _wainscot(c, 126, Pk.mix(const Color(0xFF8E8678), const Color(0xFFC98A52), ov));
}

void _labWall(Canvas c, double ov, double t) {
  final tile = Pk.mix(const Color(0xFFA8AAA6), const Color(0xFFEAF7F6), ov);
  c.drawRect(const Rect.fromLTWH(0, 0, 400, 172), Pk.fill(tile));
  for (var x = 0.0; x <= 400; x += 20) {
    c.drawLine(Offset(x, 0), Offset(x, 172), Pk.stroke(Pk.dark(tile, 0.08), 0.8));
  }
  for (var y = 0.0; y <= 172; y += 20) {
    c.drawLine(Offset(0, y), Offset(400, y), Pk.stroke(Pk.dark(tile, 0.08), 0.8));
  }
  c.drawRect(const Rect.fromLTWH(0, 100, 400, 6), Pk.fill(Pk.mix(const Color(0xFF7E8A88), const Color(0xFF2EA59A), ov)));
}

void _gymWall(Canvas c, double ov, double t) {
  final low = Pk.mix(const Color(0xFF8E8A84), const Color(0xFF3E6AB0), ov);
  c.drawRect(const Rect.fromLTWH(0, 110, 400, 62), Pk.fill(low));
  c.drawRect(const Rect.fromLTWH(0, 106, 400, 5), Pk.fill(Pk.mix(const Color(0xFFB8B0A0), const Color(0xFFFFD447), ov)));
  final glass = Pk.mix(const Color(0xFF9AA8B0), const Color(0xFFBFEFFF), ov);
  for (var i = 0; i < 6; i++) {
    final r = Rect.fromLTWH(14 + i * 66.0, 10, 50, 22);
    c.drawRect(r.inflate(2), Pk.fill(Colors.white));
    c.drawRect(r, Pk.fill(glass));
  }
  // Court lines on the floor.
  final line = Pk.stroke(Colors.white.withValues(alpha: 0.5 + 0.3 * ov), 2);
  c.drawLine(const Offset(0, 196), const Offset(400, 196), line);
  c.drawOval(const Rect.fromLTWH(150, 182, 100, 28), line);
  c.drawLine(const Offset(200, 172), const Offset(200, 240), line);
}

void _musicWall(Canvas c, double ov, double t) {
  final panel = Pk.mix(const Color(0xFF8E8698), const Color(0xFFE8D2F0), ov);
  for (var y = 0; y < 3; y++) {
    for (var x = 0; x < 8; x++) {
      c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(4 + x * 50.0, 4 + y * 40.0, 44, 34), const Radius.circular(6)), Pk.fill((x + y).isEven ? panel : Pk.dark(panel, 0.06)));
    }
  }
  final riser = Pk.mix(const Color(0xFF7E7266), const Color(0xFF8B5E3C), ov);
  c.drawRect(const Rect.fromLTWH(0, 124, 400, 48), Pk.fill(Pk.dark(panel, 0.12)));
  c.drawRect(const Rect.fromLTWH(0, 124, 400, 4), Pk.fill(riser));
}
'''

DART = DART_COMMON + DART_BAKERY + DART_GREEN + DART_VINE + DART_TRAIN + DART_SCHOOL + DART_SCENERY

# ============================================================================ helpers
SHAPES = {
    'rect': ['........'] * 8,
    'pyramid': ['###..###', '##....##', '#......#'] + ['........'] * 5,
    'L': ['....####'] * 4 + ['........'] * 4,
    'heart': ['#..##..#', '........', '........', '........', '#......#', '##....##', '###..###', '########'],
    'octagon': ['##....##', '#......#'] + ['........'] * 4 + ['#......#', '##....##'],
    'plus': ['##....##'] * 2 + ['........'] * 4 + ['##....##'] * 2,
    'diamond': ['###..###', '##....##', '#......#', '........', '........', '#......#', '##....##', '###..###'],
    'twin': ['...##...'] * 3 + ['........'] * 2 + ['...##...'] * 3,
    'T': ['........'] * 3 + ['##....##'] * 5,
    'donut': ['........'] * 2 + ['..####..'] * 4 + ['........'] * 2,
    'zigzag': ['.....###'] * 2 + ['........'] + ['###.....'] * 2 + ['........'] + ['.....###'] * 2,
    'funnel': ['........'] * 5 + ['#......#', '##....##', '###..###'],
    'arch': ['........'] * 5 + ['..####..'] * 3,
    'cup': ['..####..'] * 3 + ['........'] * 5,
    'goblet': ['........'] * 3 + ['#......#', '##....##', '###..###', '###..###', '##....##'],
    'U': ['##....##'] * 3 + ['........'] * 5,
    'H': ['..####..'] * 3 + ['........'] * 2 + ['..####..'] * 3,
    'hourglass': ['........', '#......#', '##....##', '###..###', '###..###', '##....##', '#......#', '........'],
    'train': ['#.###...', '#.###...'] + ['........'] * 5 + ['#..##..#'],
    'bottle': ['###..###'] * 2 + ['##....##'] + ['........'] * 5,
    'diagonal': ['.....###', '......##', '.......#', '........', '........', '#.......', '##......', '###.....'],
    'pillars': ['........'] + ['..#..#..'] * 6 + ['........'],
}


def lay(name, overlay):
    """Board layout: the named shape with obstacles from [overlay] ('.' = none)."""
    sh = SHAPES[name]
    assert len(overlay) == 8, name
    out = []
    for y in range(8):
        row = ''
        for x in range(8):
            o = overlay[y][x]
            if sh[y][x] == '#':
                assert o == '.', f'{name}: obstacle on a gap at ({x},{y})'
                row += '#'
            else:
                row += o
        out.append(row)
    return out


def C(v):
    return f'Color(0x{v:08X})'


def indoor(topN, topR, gN, gR, aN, aR, floor='planks', night=False):
    s = (f'const Backdrop.indoor(topN: {C(topN)}, topR: {C(topR)}, groundN: {C(gN)}, groundR: {C(gR)}, '
         f'floorAltN: {C(aN)}, floorAltR: {C(aR)}, floor: FloorStyle.{floor}')
    if night:
        s += ', night: true'
    return s + ')'


def outdoor(gN, gR, horizon=146, floor='sand', topR=None, bottomR=None, night=False):
    s = f'const Backdrop.outdoor(groundN: {C(gN)}, groundR: {C(gR)}, horizon: {horizon}, floor: FloorStyle.{floor}'
    if topR:
        s += f', topR: {C(topR)}'
    if bottomR:
        s += f', bottomR: {C(bottomR)}'
    if night:
        s += ', night: true'
    return s + ')'


def P(kind, l, t, w, h, a, b='_gold'):
    return (kind, l, t, w, h, a, b)


def level(id, name, desc, moves, shape, overlay, tiles, objectives, theme, floor, scene, stars=(20000, 28000), diff='hard'):
    return dict(id=id, name=name, desc=desc, moves=moves, diff=diff, tiles=tiles, obstacles=lay(shape, overlay),
                objectives=objectives, stars=list(stars), floor=floor, theme=theme, scene=scene, shape=shape)


E = ['........'] * 8  # no obstacles

# ============================================================================ CHAPTER 11 — BAKERY (crates)
BAKERY = [
    level('bakery_front', ('BAKERY FRONT', 'PASTANE ÖNÜ'),
          ('Open the shutters of the old corner bakery.', 'Köşedeki eski pastanenin kepenklerini aç.'),
          26, 'pyramid',
          ['........', '........', '........', '.c....c.', '........', '..c..c..', 'c......c', '........'],
          ['b1_bread', 'b1_croissant', 'sign', 'b1_shop', 'awning', 'b1_cake'],
          [('b1_breads', 'b1_bread', 15), ('b1_pastries', 'b1_croissant', 15), ('sign', 'sign', 15),
           ('windows', 'b1_shop', 15), ('awning', 'awning', 15), ('crates', 'crate', 6)],
          (0xFFFFE8D6, 0xFFE8A878, 0xFF8B4A2E, 0xFFE0533F), 0.54,
          dict(backdrop=outdoor(0xFFA8A296, 0xFFE6DCCB, 150, 'stone'), scenery='_bakeryFacade', props=[
              ('sign', [P('sign', 130, 23, 140, 24, '_darkWood', '_gold'), P('@pretzelSign', 2, 46, 40, 46, '_gold', '_crust')]),
              ('awning', [P('awning', 52, 52, 140, 22, '_red', '_white'), P('awning', 250, 52, 112, 22, '_red', '_white')]),
              ('windows', [P('@shopWindow', 58, 78, 130, 50, '_darkWood', '_crust'), P('door', 206, 82, 34, 70, '_teal', '_gold'),
                           P('window', 262, 78, 92, 48, '_white', '_gold')]),
              ('b1_breads', [P('@breadBasket', 66, 150, 42, 40, '_straw', '_crust'), P('bench', 262, 168, 70, 30, '_teal', '_teal')]),
              ('b1_pastries', [P('cart', 128, 168, 76, 46, '_pink', '_cream'), P('@sandwichBoard', 220, 160, 28, 40, '_darkWood', '_gold')]),
              ('crates', [P('crates', 334, 186, 56, 44, '_wood', '_flour'), P('@sack', 18, 190, 32, 40, '_flour', '_red')]),
          ])),
    level('bakery_kitchen', ('BAKERY KITCHEN', 'PASTANE MUTFAĞI'),
          ('Fire up the brick oven for the morning bread.', 'Sabah ekmeği için taş fırını yak.'),
          26, 'L',
          ['........', '..C.....', '........', '.c......', '........', '.C....C.', '...cc...', '........'],
          ['b1_bread', 'b1_croissant', 'egg', 'b1_mixer', 'b1_oven', 'plate'],
          [('b1_ovens', 'b1_oven', 15), ('b1_breads', 'b1_bread', 15), ('b1_dough', 'b1_mixer', 15),
           ('eggs', 'egg', 15), ('dishes', 'plate', 15), ('crates', 'crate', 8)],
          (0xFFFFF0DC, 0xFFE8B888, 0xFF8B4A2E, 0xFFFF9A3C), 0.46,
          dict(backdrop=indoor(0xFFA59C8F, 0xFFFFE8CC, 0xFF8D877D, 0xFFF2E6D8, 0xFF7E7060, 0xFFD9A57A, 'tiles'),
               scenery='_kitchenTiles', props=[
              ('b1_ovens', [P('@oven', 8, 72, 100, 102, '_brick', '_flame'), P('pendant', 160, 0, 24, 30, '_navy', '_gold')]),
              ('b1_breads', [P('@breadShelf', 124, 22, 118, 58, '_darkWood', '_crust'), P('@breadBasket', 186, 190, 40, 40, '_straw', '_crust')]),
              ('b1_dough', [P('@kneadTable', 114, 136, 160, 40, '_wood', '_flour'), P('@dough', 146, 116, 50, 20, '_flour', '_wood'),
                            P('@mixer', 300, 88, 34, 32, '_mint', '_steel')]),
              ('eggs', [P('@eggBowl', 214, 122, 30, 14, '_white', '_blue'), P('shelf', 262, 40, 110, 24, '_darkWood', '_cream')]),
              ('dishes', [P('@plateRack', 14, 18, 92, 46, '_wood', '_blue'), P('counter', 284, 120, 108, 52, '_cream', '_wood')]),
              ('crates', [P('@sack', 112, 180, 30, 40, '_burlap', '_red'), P('crates', 330, 184, 58, 46, '_wood', '_flour'),
                          P('@sack', 16, 188, 30, 40, '_flour', '_blue')]),
          ])),
    level('bakery_cakes', ('CAKE STUDIO', 'PASTA ATÖLYESİ'),
          ('Ice the towering wedding cake.', 'Kocaman düğün pastasını süsle.'),
          26, 'heart',
          ['........', '.c....c.', '...CC...', '..i..i..', '.I....I.', '........', '........', '........'],
          ['party', 'b1_croissant', 'b1_cookie', 'b1_mixer', 'icecream', 'b1_cake'],
          [('b1_cakes', 'b1_cake', 13), ('b1_cookies', 'b1_cookie', 13), ('b1_mixers', 'b1_mixer', 13),
           ('ice_cream', 'icecream', 13), ('crates', 'crate', 6), ('ice', 'ice', 6)],
          (0xFFFFE6F0, 0xFFF0A8C8, 0xFFA0406A, 0xFFFF7AB6), 0.44,
          dict(backdrop=indoor(0xFFA59CA0, 0xFFFFE0EC, 0xFF8D877D, 0xFFFFFFFF, 0xFF7E7868, 0xFFFFB3C7, 'checker'),
               scenery='_cakeStripes', props=[
              ('b1_cakes', [P('@decoTable', 132, 140, 136, 36, '_white', '_pink'), P('@cake', 168, 64, 64, 76, '_rose', '_red'),
                            P('@cupcakes', 234, 124, 32, 16, '_cream', '_pink')]),
              ('b1_cookies', [P('shelf', 22, 42, 100, 24, '_white', '_pink'), P('@cookieJar', 28, 90, 24, 30, '_crust', '_pink')]),
              ('b1_mixers', [P('counter', 14, 120, 104, 52, '_mint', '_white'), P('@mixer', 72, 88, 34, 32, '_pink', '_steel')]),
              ('ice_cream', [P('@iceCreamCart', 290, 104, 88, 74, '_white', '_pink')]),
              ('crates', [P('@giftBoxes', 22, 184, 56, 44, '_purple', '_gold'), P('@giftBoxes', 326, 188, 52, 40, '_aqua', '_pink')]),
              ('ice', [P('@bunting', 0, 0, 400, 26, '_pink', '_aqua'), P('window', 264, 30, 76, 52, '_white', '_pink')]),
          ])),
    level('bakery_store', ('FLOUR STORE', 'UN DEPOSU'),
          ('Stack the flour sacks before the delivery.', 'Teslimattan önce un çuvallarını diz.'),
          27, 'rect',
          ['........', '.B....B.', '........', '..cCCc..', '........', 'c......c', '...BB...', '........'],
          ['b1_bread', 'boxes', 'grain', 'herbs', 'b1_coffee', 'shelves'],
          [('b1_flour', 'grain', 15), ('boxes', 'boxes', 15), ('b1_breads', 'b1_bread', 15), ('shelves', 'shelves', 15),
           ('b1_beans', 'b1_coffee', 15), ('crates', 'crate', 16)],
          (0xFFF4E6D0, 0xFFC8A070, 0xFF7A4E30, 0xFFD9963E), 0.42,
          dict(backdrop=indoor(0xFF9E958A, 0xFFF0DCC0, 0xFF7D7064, 0xFFB9824A, 0xFF6E6254, 0xFFA06A3A, 'planks'),
               scenery='_storeroomWall', props=[
              ('b1_flour', [P('@sack', 14, 126, 40, 50, '_flour', '_blue'), P('@sack', 46, 136, 40, 46, '_flour', '_red'),
                            P('@sack', 148, 170, 38, 48, '_flour', '_blue')]),
              ('boxes', [P('crates', 94, 124, 56, 50, '_cardboard', '_red'), P('crates', 262, 190, 50, 40, '_cardboard', '_blue')]),
              ('b1_breads', [P('@breadShelf', 76, 22, 110, 56, '_darkWood', '_crust'), P('@breadRack', 214, 92, 58, 82, '_steel', '_crust')]),
              ('shelves', [P('shelf', 224, 32, 100, 24, '_darkWood', '_gold'), P('shelf', 224, 62, 100, 22, '_darkWood', '_red'),
                           P('lantern', 160, 84, 22, 40, '_coal', '_lampGlow')]),
              ('b1_beans', [P('@sack', 290, 128, 40, 48, '_burlap', '_choc'), P('@sack', 324, 134, 40, 44, '_burlap', '_choc')]),
              ('crates', [P('crates', 330, 176, 60, 54, '_wood', '_flour'), P('barrel', 196, 180, 30, 40, '_darkWood', '_steel'),
                          P('crates', 58, 184, 54, 44, '_wood', '_flour')]),
          ])),
    level('bakery_cafe', ('CAFÉ TERRACE', 'KAFE TERASI'),
          ('Serve coffee and croissants under the parasols.', 'Şemsiyelerin altında kahve ve kruvasan servis et.'),
          28, 'octagon',
          ['........', '.l....l.', '...CC...', '..c..c..', '..c..c..', '........', '.l....l.', '........'],
          ['umbrella', 'b1_croissant', 'b1_cookie', 'plants', 'b1_coffee', 'b1_cake'],
          [('parasols', 'umbrella', 14), ('b1_pastries', 'b1_croissant', 14), ('b1_cookies', 'b1_cookie', 14),
           ('plants', 'plants', 14), ('b1_coffee', 'b1_coffee', 14), ('crates', 'crate', 8), ('chains', 'chain', 4)],
          (0xFFFFF0D8, 0xFFE8B070, 0xFF2E6E5A, 0xFFFF9A3C), 0.34,
          dict(backdrop=outdoor(0xFFA8A296, 0xFFE6D2B4, 150, 'stone'), scenery='_cafeFacade', props=[
              ('b1_coffee', [P('barCounter', 122, 112, 156, 44, '_wood', '_teal'), P('@coffeeMachine', 138, 77, 46, 40, '_red', '_gold')]),
              ('parasols', [P('umbrella', 8, 96, 112, 70, '_red', '_white'), P('umbrella', 280, 96, 112, 70, '_teal', '_white'),
                            P('chair', 102, 158, 24, 40, '_teal', '_darkWood')]),
              ('b1_pastries', [P('@cafeTable', 32, 150, 64, 44, '_white', '_crust'), P('@cafeTable', 304, 150, 64, 44, '_white', '_crust'),
                               P('chair', 276, 158, 24, 40, '_red', '_darkWood')]),
              ('b1_cookies', [P('@cupcakes', 212, 103, 44, 14, '_rose', '_pink'), P('@sandwichBoard', 186, 164, 28, 40, '_darkWood', '_gold')]),
              ('plants', [P('planter', 128, 174, 50, 34, '_terracotta', '_leaf'), P('planter', 226, 174, 50, 34, '_terracotta', '_leaf')]),
              ('crates', [P('crates', 338, 196, 52, 40, '_wood', '_flour'), P('@sack', 8, 198, 30, 36, '_burlap', '_choc')]),
              ('chains', [P('stringLights', 0, 30, 200, 22, '_gold', '_pink'), P('stringLights', 200, 30, 200, 22, '_gold', '_aqua')]),
          ])),
]

# ============================================================================ CHAPTER 12 — GREENHOUSE (ice)
_glass = (0xFFA8A69A, 0xFFE3F6EE, 0xFF8D8A80, 0xFFE6DCCB, 0xFF6E6B62, 0xFFB8AE9A)

GREENHOUSE = [
    level('greenhouse_glass', ('GLASS HOUSE', 'CAM SERA'),
          ('Wipe the frost off the old glass house.', 'Eski camlı seranın buzlu camlarını sil.'),
          26, 'plus',
          ['........', '........', 'i......i', '..i..i..', '..i..i..', 'i......i', '........', '........'],
          ['flower', 'b1_compost', 'sun', 'b1_seedling', 'window', 'houseplant'],
          [('windows', 'window', 15), ('flowers', 'flower', 15), ('b1_seedlings', 'b1_seedling', 15),
           ('b1_compost', 'b1_compost', 15), ('plants', 'houseplant', 15), ('ice', 'ice', 8)],
          (0xFFE6F8EC, 0xFF9ED6A8, 0xFF2E7D4F, 0xFF4FB548), 0.54,
          dict(backdrop=outdoor(0xFFA8A28E, 0xFF9ED67A, 146, 'sand'), scenery='_greenhouseFront', props=[
              ('windows', [P('@glassPane', 84, 80, 80, 64, '_white', '_sky'), P('door', 182, 96, 36, 50, '_white', '_gold'),
                           P('@glassPane', 236, 80, 80, 64, '_white', '_sky')]),
              ('flowers', [P('flowerbed', 8, 202, 120, 30, '_pink', '_gold'), P('flowerbed', 272, 202, 120, 30, '_purple', '_gold')]),
              ('b1_seedlings', [P('@benchTable', 20, 148, 96, 44, '_wood', '_terracotta'), P('@seedTray', 26, 128, 84, 20, '_terracotta', '_leaf')]),
              ('b1_compost', [P('@compostBin', 300, 146, 62, 46, '_wood', '_soil'), P('@wheelbarrow', 196, 176, 64, 40, '_green', '_soil')]),
              ('plants', [P('tree', 2, 40, 62, 110, '_leaf', '_pink'), P('bush', 344, 108, 56, 42, '_leaf', '_pink'),
                          P('planter', 254, 154, 40, 34, '_terracotta', '_leaf')]),
              ('ice', [P('path', 150, 148, 80, 50, '_flour', '_flour'), P('@wateringCan', 136, 200, 38, 28, '_blue', '_steel')]),
          ])),
    level('greenhouse_orchids', ('ORCHID ROOM', 'ORKİDE ODASI'),
          ('Warm the misty room where the orchids bloom.', 'Orkidelerin açtığı buğulu odayı ısıt.'),
          26, 'diamond',
          ['........', '........', '.I....I.', '...ii...', '...ii...', '.I....I.', '........', '........'],
          ['flower', 'b1_thermo', 'b1_bee', 'herbs', 'shower', 'b1_orchid'],
          [('b1_orchids', 'b1_orchid', 13), ('b1_misters', 'shower', 13), ('b1_heaters', 'b1_thermo', 13),
           ('herbs', 'herbs', 13), ('ice', 'ice', 10)],
          (0xFFF2E6FA, 0xFFC0A0E0, 0xFF6A3D8F, 0xFFC9A0FF), 0.46,
          dict(backdrop=indoor(*_glass, 'tiles'), scenery='_glassWall', props=[
              ('b1_orchids', [P('@orchid', 14, 100, 46, 74, '_white', '_purple'), P('@orchid', 172, 96, 50, 78, '_white', '_pink'),
                              P('@orchid', 338, 98, 48, 76, '_white', '_lilac')]),
              ('b1_misters', [P('@mistPipe', 0, 0, 400, 40, '_steel', '_white')]),
              ('b1_heaters', [P('@radiator', 66, 132, 72, 40, '_white', '_red'), P('@thermo', 236, 44, 16, 46, '_white', '_red')]),
              ('herbs', [P('@hangingPlant', 70, 34, 46, 60, '_terracotta', '_terracotta'), P('@hangingPlant', 284, 34, 46, 60, '_terracotta', '_pink'),
                         P('planter', 250, 140, 64, 34, '_white', '_leaf')]),
              ('ice', [P('@flowerPots', 132, 182, 96, 42, '_terracotta', '_purple'), P('@wateringCan', 250, 198, 42, 30, '_aqua', '_steel')]),
          ])),
    level('greenhouse_seedlings', ('SEEDLING TABLES', 'FİDE MASALARI'),
          ('Sow new seedlings along the potting tables.', 'Saksı masalarına yeni fideler ek.'),
          26, 'twin',
          ['c......c', '.i....i.', '........', '..i..i..', '..i..i..', '........', '.i....i.', 'c......c'],
          ['flower', 'b1_compost', 'b1_bee', 'b1_seedling', 'water', 'b1_orchid'],
          [('b1_seedlings', 'b1_seedling', 14), ('flowers', 'flower', 14), ('b1_bees', 'b1_bee', 14),
           ('b1_watering', 'water', 14), ('ice', 'ice', 8), ('crates', 'crate', 4)],
          (0xFFEFF8E0, 0xFFB8D890, 0xFF5E7A2E, 0xFF8CC63F), 0.44,
          dict(backdrop=indoor(0xFFA8A69A, 0xFFE8F6DC, 0xFF8D8A80, 0xFFC9A57A, 0xFF6E6B62, 0xFFA8845A, 'planks'),
               scenery='_glassWall', props=[
              ('b1_seedlings', [P('@benchTable', 14, 132, 372, 42, '_wood', '_terracotta'), P('@seedTray', 30, 110, 160, 22, '_terracotta', '_leaf'),
                                P('@seedTray', 210, 110, 160, 22, '_terracotta', '_green')]),
              ('flowers', [P('@flowerPots', 32, 182, 96, 44, '_terracotta', '_pink'), P('@flowerPots', 270, 182, 96, 44, '_terracotta', '_yellow')]),
              ('b1_bees', [P('@beehive', 162, 176, 40, 52, '_straw', '_yellow'), P('@hangingPlant', 172, 34, 56, 66, '_terracotta', '_pink')]),
              ('b1_watering', [P('@wateringCan', 210, 196, 44, 32, '_green', '_yellow'), P('@wateringCan', 126, 206, 34, 24, '_blue', '_steel')]),
              ('ice', [P('@mistPipe', 0, 0, 400, 34, '_steel', '_white')]),
              ('crates', [P('@sack', 368, 190, 30, 40, '_burlap', '_green'), P('@sack', 2, 192, 28, 40, '_burlap', '_green')]),
          ])),
    level('greenhouse_palms', ('PALM HOUSE', 'PALMİYE EVİ'),
          ('Bring the tropical palm dome back to life.', 'Tropik palmiye kubbesine yeniden hayat ver.'),
          27, 'T',
          ['........', 'i.i..i.i', '........', '........', '..I..I..', '........', '..i..i..', '........'],
          ['flower', 'b1_thermo', 'sun', 'palm', 'shower', 'tree'],
          [('palms', 'palm', 14), ('b1_heaters', 'b1_thermo', 14), ('b1_misters', 'shower', 14),
           ('tree', 'tree', 14), ('ice', 'ice', 10), ('doors', 'key', 2)],
          (0xFFE0F6E8, 0xFF7CC89A, 0xFF1E6E4A, 0xFF4FD6A8), 0.44,
          dict(backdrop=indoor(0xFFA8A69A, 0xFFD6F2E8, 0xFF8D8A80, 0xFFD9CDB0, 0xFF7E7868, 0xFFBFB290, 'tiles'),
               scenery='_palmDome', props=[
              ('palms', [P('palm', 8, 30, 104, 144, '_leaf', '_gold'), P('palm', 290, 24, 106, 150, '_green', '_gold')]),
              ('doors', [P('door', 176, 104, 48, 68, '_white', '_gold')]),
              ('tree', [P('tree', 100, 72, 70, 102, '_green', '_pink'), P('tree', 232, 76, 66, 98, '_leaf', '_orange')]),
              ('b1_heaters', [P('@radiator', 14, 180, 66, 36, '_white', '_red'), P('@thermo', 252, 22, 16, 44, '_white', '_red')]),
              ('b1_misters', [P('@mistPipe', 60, 0, 280, 34, '_steel', '_white')]),
              ('ice', [P('pond', 124, 186, 150, 42, '_aqua', '_white'), P('bench', 300, 182, 80, 30, '_wood', '_wood')]),
          ])),
    level('greenhouse_pond', ('POND GARDEN', 'GÖLETLİ BAHÇE'),
          ('Thaw the lily pond and let the koi swim.', 'Nilüferli göleti çöz, balıklar yüzsün.'),
          28, 'donut',
          ['........', 'I......I', 'j......j', '.i....i.', '.i....i.', 'j......j', 'I......I', '........'],
          ['hen', 'fence', 'fish', 'grass', 'fountain', 'blossom'],
          [('pond', 'fish', 14), ('b1_lilies', 'blossom', 14), ('fountain', 'fountain', 14), ('fence', 'fence', 14),
           ('ice', 'ice', 14), ('chains', 'chain', 4)],
          (0xFFE2F4F8, 0xFF8ACBD8, 0xFF2E6E8A, 0xFFFF7AB6), 0.34,
          dict(backdrop=outdoor(0xFFA8A28E, 0xFF8CCB6A, 146, 'sand'), scenery='_pondGarden', props=[
              ('pond', [P('@lilyPond', 110, 166, 190, 58, '_aqua', '_pink')]),
              ('b1_lilies', [P('flowerbed', 8, 206, 100, 28, '_pink', '_white'), P('flowerbed', 296, 206, 100, 28, '_pink', '_white')]),
              ('fountain', [P('fountain', 172, 104, 56, 50, '_white', '_aqua')]),
              ('fence', [P('fence', 0, 130, 90, 24, '_white', '_white'), P('fence', 310, 130, 90, 24, '_white', '_white')]),
              ('ice', [P('@birdbath', 40, 140, 40, 54, '_steel', '_aqua'), P('bush', 126, 128, 46, 30, '_leaf', '_pink')]),
              ('chains', [P('@arbor', 316, 84, 72, 92, '_white', '_pink'), P('lamppost', 96, 102, 18, 90, '_navy', '_lampGlow')]),
          ])),
]

# ============================================================================ CHAPTER 13 — VINEYARD (chains)
VINEYARD = [
    level('vineyard_rows', ('VINE ROWS', 'ASMA SIRALARI'),
          ('Untangle the vines before the harvest.', 'Hasattan önce asmaların düğümünü çöz.'),
          26, 'zigzag',
          ['.l..l...', '........', 'l......l', '...l..l.', '........', 'l......l', '........', '.l..l...'],
          ['tractor', 'fence', 'sun', 'b1_vine', 'b1_basket', 'b1_grape'],
          [('b1_vines', 'b1_vine', 15), ('b1_grapes', 'b1_grape', 15), ('b1_baskets', 'b1_basket', 15),
           ('b1_tractor', 'tractor', 15), ('chains', 'chain', 10)],
          (0xFFEEF4DC, 0xFFB8C880, 0xFF5E6A2E, 0xFF8A5CE6), 0.54,
          dict(backdrop=outdoor(0xFFA8A08A, 0xFFD9B98A, 150, 'sand'), scenery='_vineHills', props=[
              ('b1_vines', [P('@vineRow', 8, 100, 180, 56, '_leaf', '_grape'), P('@vineRow', 212, 100, 180, 56, '_leaf', '_grape'),
                            P('@scarecrow', 176, 92, 48, 68, '_red', '_straw')]),
              ('b1_grapes', [P('@grapeBasket', 128, 186, 52, 40, '_straw', '_grape'), P('@grapeBasket', 228, 192, 48, 36, '_straw', '_purple')]),
              ('b1_baskets', [P('cart', 18, 168, 92, 54, '_wood', '_grape'), P('fence', 0, 140, 64, 22, '_wood', '_wood')]),
              ('b1_tractor', [P('tractor', 296, 160, 96, 66, '_red', '_gold')]),
              ('chains', [P('@cypressTree', 4, 46, 26, 96, '_cypress', '_cypress'), P('@cypressTree', 370, 42, 26, 100, '_cypress', '_cypress'),
                          P('fence', 336, 140, 64, 22, '_wood', '_wood')]),
          ])),
    level('vineyard_press', ('GRAPE PRESS', 'ÜZÜM CENDERESİ'),
          ('Turn the old wooden press once more.', 'Eski ahşap cendereyi yeniden çevir.'),
          26, 'funnel',
          ['........', '.l.cc.l.', '........', 'l.L..L.l', 'c......c', '........', '..l..l..', '........'],
          ['b1_bottle', 'boxes', 'wine', 'b1_vine', 'b1_basket', 'b1_grape'],
          [('b1_press', 'wine', 14), ('b1_grapes', 'b1_grape', 14), ('b1_baskets', 'b1_basket', 14),
           ('b1_bottles', 'b1_bottle', 14), ('chains', 'chain', 9), ('crates', 'crate', 4)],
          (0xFFF2E6F4, 0xFFC898C8, 0xFF5E2E5A, 0xFFB86ADF), 0.46,
          dict(backdrop=indoor(0xFF9E958A, 0xFFF0DCC0, 0xFF7D7064, 0xFFB9824A, 0xFF6E6254, 0xFFA06A3A, 'planks'),
               scenery='_barnWall', props=[
              ('b1_press', [P('@press', 140, 70, 120, 104, '_wood', '_grape')]),
              ('b1_grapes', [P('@tub', 16, 138, 96, 40, '_wood', '_grape'), P('@tub', 150, 196, 100, 40, '_wood', '_purple')]),
              ('b1_baskets', [P('@grapeBasket', 280, 146, 48, 30, '_straw', '_grape'), P('@grapeBasket', 108, 194, 40, 30, '_straw', '_purple')]),
              ('b1_bottles', [P('bottleShelf', 262, 40, 120, 46, '_darkWood', '_wine'), P('wineRack', 330, 104, 60, 72, '_darkWood', '_wine')]),
              ('chains', [P('lantern', 40, 22, 26, 44, '_coal', '_lampGlow'), P('lantern', 232, 18, 24, 44, '_coal', '_lampGlow')]),
              ('crates', [P('crates', 8, 184, 64, 50, '_wood', '_flour'), P('barrel', 262, 186, 32, 44, '_darkWood', '_steel'),
                          P('barrel', 300, 190, 30, 40, '_darkWood', '_steel')]),
          ])),
    level('vineyard_cellar', ('WINE CELLAR', 'ŞARAP MAHZENİ'),
          ('Light the lanterns in the vaulted cellar.', 'Kemerli mahzende fenerleri yak.'),
          27, 'arch',
          ['........', 'L......L', '..J..J..', '........', '.l.ll.l.', '........', 'l......l', '........'],
          ['b1_bottle', 'b1_cask', 'wine', 'b1_vine', 'glass', 'lantern'],
          [('b1_casks', 'b1_cask', 15), ('wine_rack', 'wine', 15), ('b1_bottles', 'b1_bottle', 15),
           ('lamps', 'lantern', 15), ('chains', 'chain', 10), ('ice', 'ice', 4)],
          (0xFFEAD8D0, 0xFF9A6A5A, 0xFF4A2A2A, 0xFFE0533F, True), 0.44,
          dict(backdrop=indoor(0xFF5E5868, 0xFF9A7E62, 0xFF6E6878, 0xFF8E6A4A, 0xFF5E5868, 0xFF6E5038, 'tiles'),
               scenery='_cellarVault', props=[
              ('b1_casks', [P('@cask', 18, 120, 62, 56, '_wood', '_iron'), P('@cask', 76, 124, 58, 52, '_wood', '_iron'),
                            P('@cask', 46, 80, 54, 48, '_wood', '_iron')]),
              ('wine_rack', [P('wineRack', 300, 70, 90, 102, '_darkWood', '_wine')]),
              ('b1_bottles', [P('bottleShelf', 150, 40, 100, 40, '_darkWood', '_wine'), P('@tastingTable', 150, 120, 100, 56, '_darkWood', '_wine')]),
              ('lamps', [P('lantern', 116, 8, 24, 44, '_coal', '_lampGlow'), P('lantern', 262, 8, 24, 44, '_coal', '_lampGlow')]),
              ('chains', [P('chandelier', 170, 0, 60, 34, '_flame', '_coal')]),
              ('ice', [P('barrel', 150, 186, 34, 46, '_darkWood', '_steel'), P('barrel', 246, 190, 30, 42, '_darkWood', '_steel'),
                       P('barrel', 340, 182, 34, 48, '_darkWood', '_steel')]),
          ])),
    level('vineyard_kitchen', ('FARM KITCHEN', 'ÇİFTLİK MUTFAĞI'),
          ('Cook a harvest supper in the farmhouse.', 'Çiftlik evinde hasat yemeği pişir.'),
          26, 'cup',
          ['........', '........', '.c....c.', '.l....l.', '..l..l..', 'l..cc..l', '........', '.l....l.'],
          ['pot', 'hearth', 'cutlery', 'pie', 'glass', 'b1_grape'],
          [('pots', 'pot', 15), ('fireplace', 'hearth', 15), ('cutlery', 'cutlery', 15), ('baking', 'pie', 15),
           ('chains', 'chain', 8), ('crates', 'crate', 4)],
          (0xFFFFEEDC, 0xFFE0A070, 0xFF7A3E2E, 0xFFFF9A3C), 0.44,
          dict(backdrop=indoor(0xFFA59C8F, 0xFFF2E2C8, 0xFF8D7F6E, 0xFFD9825A, 0xFF7E7060, 0xFFB8663E, 'checker'),
               scenery='_rusticKitchen', props=[
              ('fireplace', [P('fireplace', 20, 76, 110, 96, '_cream', '_flame')]),
              ('pots', [P('@potRack', 250, 12, 130, 58, '_darkWood', '_copper'), P('stove', 304, 118, 60, 54, '_coal', '_copper')]),
              ('cutlery', [P('shelf', 140, 82, 120, 18, '_darkWood', '_white'), P('cabinet', 372, 104, 26, 68, '_wood', '_gold')]),
              ('baking', [P('@kneadTable', 128, 148, 150, 40, '_wood', '_flour'), P('@breadBasket', 150, 118, 40, 30, '_straw', '_crust'),
                          P('@dough', 220, 128, 44, 20, '_flour', '_wood')]),
              ('chains', [P('pendant', 140, 0, 24, 30, '_coal', '_gold'), P('pendant', 96, 0, 24, 30, '_coal', '_gold')]),
              ('crates', [P('@grapeBasket', 18, 190, 52, 40, '_straw', '_grape'), P('crates', 282, 190, 50, 40, '_wood', '_flour'),
                          P('barrel', 340, 184, 34, 46, '_darkWood', '_steel')]),
          ])),
    level('vineyard_terrace', ('SUNSET TERRACE', 'GURUP TERASI'),
          ('Set the tables for a sunset tasting.', 'Gün batımı tadımı için masaları kur.'),
          28, 'goblet',
          ['j......j', '..l..l..', 'J......J', '........', '...jj...', '........', '........', '..l..l..'],
          ['table', 'b1_sunset', 'wine', 'b1_vine', 'glass', 'lantern'],
          [('tables', 'table', 14), ('lamps', 'lantern', 14), ('b1_vines', 'b1_vine', 14), ('glassware', 'glass', 14),
           ('b1_sunset', 'b1_sunset', 14), ('chains', 'chain', 8), ('ice', 'ice', 6)],
          (0xFFFFE0C8, 0xFFE8806A, 0xFF6E2E4A, 0xFFFF9A3C), 0.32,
          dict(backdrop=outdoor(0xFF9A9488, 0xFFD9B48A, 150, 'stone', topR=0xFFFF9A6B, bottomR=0xFFFFD6A0), scenery='_sunsetHills', props=[
              ('b1_vines', [P('@pergola', 0, 0, 400, 46, '_darkWood', '_grape')]),
              ('lamps', [P('stringLights', 10, 46, 190, 20, '_gold', '_orange'), P('stringLights', 200, 46, 190, 20, '_gold', '_pink')]),
              ('tables', [P('roundTable', 58, 160, 84, 40, '_white', '_wine'), P('roundTable', 232, 166, 84, 40, '_white', '_wine'),
                          P('chair', 146, 160, 24, 42, '_darkWood', '_cream')]),
              ('glassware', [P('@tastingTable', 326, 140, 70, 50, '_darkWood', '_wine')]),
              ('b1_sunset', [P('railing', 0, 124, 400, 26, '_cream', '_cream'), P('@cypressTree', 178, 56, 28, 80, '_cypress', '_cypress')]),
              ('chains', [P('@oliveTree', 4, 176, 50, 60, '_olive', '_terracotta'), P('planter', 352, 196, 44, 40, '_terracotta', '_olive')]),
              ('ice', [P('@iceBucket', 186, 186, 30, 46, '_steel', '_wine')]),
          ])),
]

# ============================================================================ CHAPTER 14 — TRAIN STATION (keys)
STATION = [
    level('station_platform', ('PLATFORM', 'PERON'),
          ('Get the old steam train ready to depart.', 'Eski buharlı treni yola çıkmaya hazırla.'),
          26, 'U',
          E[:4] + ['.c....c.', '........', '..c..c..', '........'],
          ['b1_seat', 'ticket', 'b1_clock', 'b1_paper', 'b1_train', 'lantern'],
          [('b1_trains', 'b1_train', 15), ('seats', 'b1_seat', 15), ('clocks', 'b1_clock', 15), ('lights', 'lantern', 15),
           ('luggage', 'key', 3), ('crates', 'crate', 4)],
          (0xFFE6EEF4, 0xFF9AB4C8, 0xFF2E5E4A, 0xFFE0533F), 0.54,
          dict(backdrop=outdoor(0xFFA8A296, 0xFFD9D2C3, 150, 'stone'), scenery='_platformCanopy', props=[
              ('b1_trains', [P('@loco', 8, 62, 150, 88, '_coal', '_red'), P('@carriage', 160, 70, 176, 80, '_teal', '_gold')]),
              ('seats', [P('bench', 40, 186, 84, 30, '_darkWood', '_darkWood'), P('bench', 262, 190, 74, 30, '_darkWood', '_darkWood')]),
              ('clocks', [P('@stationClock', 178, 26, 44, 48, '_coal', '_red')]),
              ('lights', [P('lamppost', 150, 140, 18, 90, '_navy', '_lampGlow'), P('@signal', 354, 68, 24, 82, '_coal', '_red')]),
              ('luggage', [P('@luggageCart', 184, 170, 70, 54, '_steel', '_red')]),
              ('crates', [P('crates', 340, 184, 54, 46, '_wood', '_flour'), P('@sack', 8, 194, 30, 38, '_steel', '_navy')]),
          ])),
    level('station_tickets', ('TICKET HALL', 'BİLET SALONU'),
          ('Reopen the ticket windows of the grand hall.', 'Büyük salonun bilet gişelerini yeniden aç.'),
          26, 'arch',
          ['.i....i.', '........', 'i..ii..i', '........', '.I....I.', '........', 'i......i', '........'],
          ['b1_seat', 'ticket', 'b1_clock', 'b1_paper', 'window', 'b1_route'],
          [('tickets', 'ticket', 14), ('clocks', 'b1_clock', 14), ('b1_timetable', 'b1_route', 14), ('windows', 'window', 14),
           ('ice', 'ice', 10), ('gates', 'key', 3)],
          (0xFFF4EEE2, 0xFFC8B898, 0xFF5E4A2E, 0xFFC9A04A), 0.46,
          dict(backdrop=indoor(0xFFA8A296, 0xFFF2E8D8, 0xFF8D877D, 0xFFFFFFFF, 0xFF6E6B62, 0xFF2E5E4A, 'checker'),
               scenery='_ticketHallWall', props=[
              ('windows', [P('@archWindow', 20, 20, 60, 96, '_white', '_gold'), P('@archWindow', 320, 20, 60, 96, '_white', '_gold')]),
              ('b1_timetable', [P('@departures', 130, 24, 140, 58, '_coal', '_gold')]),
              ('clocks', [P('@stationClock', 184, 86, 32, 36, '_gold', '_red'), P('clock', 112, 100, 22, 72, '_darkWood', '_gold')]),
              ('tickets', [P('@ticketBooth', 8, 100, 80, 74, '_darkWood', '_gold'), P('@ticketBooth', 312, 100, 80, 74, '_darkWood', '_gold')]),
              ('ice', [P('pendant', 108, 0, 22, 30, '_navy', '_gold'), P('pendant', 270, 0, 22, 30, '_navy', '_gold'),
                       P('plant', 268, 132, 26, 42, '_terracotta', '_terracotta')]),
              ('gates', [P('@gateLine', 100, 170, 200, 44, '_steel', '_red')]),
          ])),
    level('station_waiting', ('WAITING ROOM', 'BEKLEME SALONU'),
          ('Polish the benches for the evening travellers.', 'Akşam yolcuları için bankları parlat.'),
          27, 'H',
          ['........', 'l......l', '........', '.l....l.', '...ll...', '........', 'l......l', '........'],
          ['b1_seat', 'luggage', 'b1_clock', 'b1_paper', 'window', 'houseplant'],
          [('seats', 'b1_seat', 13), ('b1_papers', 'b1_paper', 13), ('clocks', 'b1_clock', 13), ('plants', 'houseplant', 13),
           ('chains', 'chain', 7), ('lockers', 'key', 2)],
          (0xFFF2E6D8, 0xFFC89A70, 0xFF6B4226, 0xFF2EA59A), 0.44,
          dict(backdrop=indoor(0xFFA59C8F, 0xFFF0E2CC, 0xFF7D7064, 0xFFB9824A, 0xFF6E6254, 0xFFA06A3A, 'planks'),
               scenery='_waitingWall', props=[
              ('lockers', [P('@lockers', 8, 90, 74, 84, '_teal', '_gold')]),
              ('seats', [P('bench', 88, 140, 100, 34, '_darkWood', '_darkWood'), P('bench', 130, 198, 120, 32, '_darkWood', '_darkWood')]),
              ('clocks', [P('@stationClock', 26, 26, 36, 46, '_coal', '_red'), P('clock', 228, 98, 22, 76, '_darkWood', '_gold')]),
              ('plants', [P('plant', 192, 128, 26, 46, '_terracotta', '_terracotta'), P('plant', 258, 128, 26, 46, '_terracotta', '_terracotta')]),
              ('b1_papers', [P('@newsStand', 292, 104, 98, 70, '_darkWood', '_red'), P('@sack', 352, 192, 32, 40, '_steel', '_navy')]),
              ('chains', [P('pendant', 104, 0, 24, 30, '_navy', '_gold'), P('pendant', 300, 0, 24, 30, '_navy', '_gold')]),
          ])),
    level('station_cafe', ('STATION CAFÉ', 'GAR KAFESİ'),
          ('Brew coffee for the morning commuters.', 'Sabah yolcuları için kahve demle.'),
          28, 'hourglass',
          ['c......c', '.C....C.', '........', '........', '........', '........', '........', '.c....c.'],
          ['menu', 'b1_croissant', 'b1_cookie', 'b1_paper', 'b1_coffee', 'b1_cake'],
          [('b1_coffee', 'b1_coffee', 13), ('b1_pastries', 'b1_croissant', 13), ('menu_board', 'menu', 13), ('b1_papers', 'b1_paper', 13),
           ('crates', 'crate', 8), ('doors', 'key', 3)],
          (0xFFF4EEE0, 0xFFB8C8A8, 0xFF2E5E4A, 0xFFE0533F), 0.42,
          dict(backdrop=indoor(0xFFA59C8F, 0xFFF7E5CF, 0xFF8D8A80, 0xFFFFFFFF, 0xFF6E6B62, 0xFF2E5E4A, 'tiles'),
               scenery='_stationCafeWall', props=[
              ('b1_coffee', [P('barCounter', 220, 118, 170, 56, '_darkWood', '_cream'), P('@coffeeMachine', 300, 79, 50, 46, '_red', '_gold')]),
              ('b1_pastries', [P('@vitrine', 122, 122, 88, 52, '_darkWood', '_pink'), P('@cupcakes', 350, 110, 38, 15, '_cream', '_pink')]),
              ('menu_board', [P('menuBoard', 240, 30, 90, 50, '_darkWood', '_gold'), P('@sandwichBoard', 116, 188, 30, 42, '_darkWood', '_gold')]),
              ('b1_papers', [P('@cafeTable', 28, 170, 70, 46, '_white', '_crust'), P('@cafeTable', 168, 186, 70, 46, '_white', '_crust')]),
              ('crates', [P('@sack', 350, 186, 36, 44, '_burlap', '_choc'), P('crates', 290, 190, 52, 40, '_wood', '_flour')]),
              ('doors', [P('door', 30, 92, 44, 80, '_teal', '_gold'), P('window', 100, 30, 100, 56, '_white', '_white')]),
          ])),
    level('station_shed', ('ENGINE SHED', 'MAKİNE HANGARI'),
          ('Restore the old locomotive in its shed.', 'Hangardaki eski lokomotifi onar.'),
          28, 'train',
          ['........', '........', '........', '.c....c.', '........', '..l..l..', '........', '.c....c.'],
          ['b1_tram', 'hammer', 'construction', 'wrench', 'b1_train', 'bulb'],
          [('b1_locomotive', 'b1_train', 14), ('tools', 'wrench', 14), ('repairs', 'hammer', 14), ('lights', 'bulb', 14),
           ('gates', 'key', 4), ('crates', 'crate', 4)],
          (0xFFE8E2DC, 0xFF9A8478, 0xFF3B3452, 0xFFFF9A3C), 0.34,
          dict(backdrop=indoor(0xFF7E746C, 0xFFB0644A, 0xFF6E6A64, 0xFF9A9080, 0xFF5E5A54, 0xFF7E7466, 'stone'),
               scenery='_shedInterior', props=[
              ('b1_locomotive', [P('@loco', 90, 92, 220, 108, '_coal', '_red')]),
              ('tools', [P('pegboard', 10, 44, 90, 56, '_cream', '_red'), P('toolbox', 20, 148, 44, 30, '_red', '_steel')]),
              ('repairs', [P('workbench', 300, 128, 94, 48, '_wood', '_red')]),
              ('lights', [P('pendant', 60, 34, 26, 34, '_coal', '_lampGlow'), P('pendant', 312, 34, 26, 34, '_coal', '_lampGlow')]),
              ('gates', [P('gate', 300, 184, 96, 50, '_coal', '_gold')]),
              ('crates', [P('crates', 8, 184, 60, 48, '_wood', '_flour'), P('barrel', 74, 192, 30, 40, '_darkWood', '_steel'),
                          P('cart', 184, 200, 72, 36, '_coal', '_coal')]),
          ])),
]

# ============================================================================ CHAPTER 15 — SCHOOL (mixed)
SCHOOL = [
    level('school_yard', ('SCHOOLYARD', 'OKUL BAHÇESİ'),
          ('Ring the bell on the first day of school.', 'Okulun ilk gününde zili çal.'),
          26, 'plus',
          ['........', '........', 'c......c', '...cc...', '........', 'c......c', '........', '........'],
          ['b1_ball', 'b1_bag', 'sun', 'grass', 'b1_bus', 'b1_school'],
          [('b1_balls', 'b1_ball', 15), ('b1_backpacks', 'b1_bag', 15), ('grass', 'grass', 15), ('b1_bus', 'b1_bus', 15),
           ('crates', 'crate', 6), ('gates', 'key', 2)],
          (0xFFE8F4FF, 0xFFA8D0F0, 0xFF2E5E86, 0xFFFFC93C), 0.54,
          dict(backdrop=outdoor(0xFFA8A296, 0xFFD9C9A8, 146, 'stone'), scenery='_schoolFacade', props=[
              ('b1_bus', [P('@schoolBus', 4, 104, 130, 62, '_yellow', '_red')]),
              ('gates', [P('@flagpole', 140, 30, 44, 118, '_blue', '_yellow')]),
              ('grass', [P('tree', 352, 36, 48, 104, '_leaf', '_pink'), P('hedge', 238, 128, 56, 22, '_leaf', '_pink'),
                         P('flowerbed', 300, 210, 96, 24, '_pink', '_gold')]),
              ('crates', [P('@swing', 294, 130, 100, 70, '_red', '_yellow'), P('@slide', 8, 172, 96, 62, '_blue', '_red')]),
              ('b1_backpacks', [P('bench', 170, 168, 78, 28, '_wood', '_wood'), P('@backpack', 148, 182, 20, 24, '_blue', '_yellow'),
                                P('@backpack', 254, 180, 22, 26, '_red', '_yellow')]),
              ('b1_balls', [P('beachball', 126, 212, 20, 20, '_red', '_white'), P('beachball', 236, 214, 18, 18, '_blue', '_yellow')]),
          ])),
    level('school_class', ('CLASSROOM', 'SINIF'),
          ('Get the classroom ready for the first lesson.', 'Sınıfı ilk derse hazırla.'),
          26, 'rect',
          ['........', '.j.jj.j.', '........', '.l.ll.l.', '........', '.j.jj.j.', '........', '.i.ii.i.'],
          ['chair', 'b1_ruler', 'b1_pencil', 'book', 'b1_calc', 'b1_school'],
          [('b1_desks', 'chair', 15), ('b1_pencils', 'b1_pencil', 15), ('books', 'book', 15), ('b1_board', 'b1_calc', 15),
           ('ice', 'ice', 10), ('chains', 'chain', 10)],
          (0xFFFFF4E0, 0xFFE8C890, 0xFF6B4226, 0xFF4FB548), 0.44,
          dict(backdrop=indoor(0xFFA59C8F, 0xFFFFF0D6, 0xFF7D7064, 0xFFC98A52, 0xFF6E6254, 0xFFB9763F, 'planks'),
               scenery='_classroomWall', props=[
              ('b1_board', [P('@chalkboard', 110, 22, 180, 72, '_darkWood', '_board')]),
              ('b1_desks', [P('@desk', 76, 136, 70, 46, '_wood', '_blue'), P('@desk', 184, 136, 70, 46, '_wood', '_red'),
                            P('@desk', 60, 184, 84, 52, '_wood', '_green')]),
              ('books', [P('bookshelf', 4, 60, 56, 112, '_darkWood', '_red'), P('@globe', 12, 26, 34, 34, '_darkWood', '_blue')]),
              ('b1_pencils', [P('@teacherDesk', 276, 166, 116, 62, '_darkWood', '_red')]),
              ('ice', [P('window', 316, 30, 70, 58, '_white', '_white'), P('@bunting', 0, 0, 400, 20, '_red', '_blue')]),
              ('chains', [P('@stationClock', 66, 22, 34, 40, '_red', '_red'), P('plant', 160, 196, 26, 40, '_terracotta', '_terracotta')]),
          ])),
    level('school_lab', ('SCIENCE LAB', 'FEN LABORATUVARI'),
          ('Spark the experiments back to life.', 'Deneyleri yeniden canlandır.'),
          27, 'bottle',
          ['........', '...ii...', '........', 'I......I', '..c..c..', '........', '.c.ii.c.', '........'],
          ['b1_bolt', 'b1_ruler', 'science', 'globe', 'b1_calc', 'b1_flask'],
          [('b1_beakers', 'science', 14), ('b1_microscopes', 'b1_flask', 14), ('globes', 'globe', 14), ('b1_circuits', 'b1_bolt', 14),
           ('ice', 'ice', 8), ('crates', 'crate', 4)],
          (0xFFE6FAF6, 0xFF8AD8C8, 0xFF1E5E6A, 0xFF4FD6E8), 0.44,
          dict(backdrop=indoor(0xFFA8AAA6, 0xFFEAF7F6, 0xFF8D8A80, 0xFFFFFFFF, 0xFF6E6B62, 0xFF9FE3C9, 'tiles'),
               scenery='_labWall', props=[
              ('b1_beakers', [P('@labBench', 110, 128, 190, 46, '_white', '_navy'), P('@beakers', 128, 96, 62, 32, '_green', '_pink')]),
              ('b1_microscopes', [P('@microscope', 214, 94, 30, 34, '_white', '_navy'), P('@microscope', 256, 96, 28, 32, '_white', '_purple')]),
              ('globes', [P('@periodicTable', 120, 20, 160, 64, '_white', '_white'), P('@globe', 336, 72, 36, 38, '_darkWood', '_blue')]),
              ('b1_circuits', [P('@circuitBoard', 18, 28, 82, 56, '_teal', '_yellow'), P('machine', 18, 120, 78, 54, '_steel', '_gold')]),
              ('ice', [P('cabinet', 322, 110, 68, 62, '_white', '_aqua'), P('plant', 106, 192, 26, 40, '_terracotta', '_terracotta')]),
              ('crates', [P('crates', 26, 186, 56, 44, '_cardboard', '_blue'), P('toolbox', 300, 196, 46, 32, '_red', '_steel')]),
          ])),
    level('school_gym', ('GYM', 'SPOR SALONU'),
          ('Pump up the balls for the big match.', 'Büyük maç için topları şişir.'),
          27, 'diagonal',
          ['c...c...', '........', '..l...l.', '.C....C.', '...ll...', '.l...l..', '........', '...c.c..'],
          ['b1_ball', 'b1_hoop', 'trophy', 'b1_dumbbell', 'medal', 'b1_volley'],
          [('b1_hoops', 'b1_hoop', 15), ('b1_balls', 'b1_ball', 15), ('b1_weights', 'b1_dumbbell', 15), ('medals', 'medal', 15),
           ('chains', 'chain', 6), ('crates', 'crate', 8)],
          (0xFFE8F0FF, 0xFF98B8E8, 0xFF2E4A86, 0xFFFF6A2A), 0.42,
          dict(backdrop=indoor(0xFF9EA4AA, 0xFFE8EEF8, 0xFF8D7F6E, 0xFFE8A35A, 0xFF7E7060, 0xFFD08C48, 'planks'),
               scenery='_gymWall', props=[
              ('b1_hoops', [P('@hoop', 20, 40, 70, 60, '_white', '_red'), P('@hoop', 310, 40, 70, 60, '_white', '_red')]),
              ('medals', [P('trophyCase', 156, 104, 88, 68, '_darkWood', '_gold'), P('banner', 124, 30, 34, 50, '_red', '_gold'),
                          P('banner', 242, 30, 34, 50, '_blue', '_gold')]),
              ('chains', [P('@wallBars', 4, 104, 70, 68, '_wood', '_wood'), P('@ropes', 94, 36, 26, 110, '_straw', '_red')]),
              ('b1_weights', [P('@dumbbellRack', 300, 120, 80, 54, '_coal', '_red')]),
              ('b1_balls', [P('@ballBin', 150, 186, 64, 44, '_steel', '_pink'), P('beachball', 226, 212, 18, 18, '_orange', '_white')]),
              ('crates', [P('@vaultBox', 40, 170, 80, 50, '_wood', '_red'), P('@mats', 250, 198, 100, 30, '_blue', '_navy')]),
          ])),
    level('school_music', ('MUSIC ROOM', 'MÜZİK SINIFI'),
          ('Tune the instruments for the school concert.', 'Okul konseri için enstrümanları akort et.'),
          28, 'pillars',
          ['........', '.i....i.', '........', 'i..ii..i', '........', '.j.jj.j.', '........', '........'],
          ['b1_bell', 'b1_record', 'trophy', 'piano', 'music', 'speaker'],
          [('piano', 'piano', 14), ('sheet_music', 'music', 14), ('b1_records', 'b1_record', 14), ('speakers', 'speaker', 14),
           ('ice', 'ice', 10), ('lockers', 'key', 3)],
          (0xFFF4E6FA, 0xFFC8A0E0, 0xFF5E2E7A, 0xFFFF7AD9), 0.32,
          dict(backdrop=indoor(0xFF8E8698, 0xFFF4E6FA, 0xFF6E6878, 0xFF8A3B6A, 0xFF5E5868, 0xFF6E2B55, 'carpet'),
               scenery='_musicWall', props=[
              ('piano', [P('piano', 18, 110, 120, 64, '_ebony', '_white')]),
              ('sheet_music', [P('@musicStand', 148, 124, 30, 50, '_coal', '_ink'), P('@musicStand', 118, 182, 32, 52, '_coal', '_red'),
                               P('painting', 40, 34, 60, 44, '_gold', '_purple')]),
              ('b1_records', [P('@recordPlayer', 330, 118, 62, 56, '_darkWood', '_gold'), P('shelf', 250, 38, 110, 24, '_darkWood', '_pink')]),
              ('speakers', [P('speaker', 6, 176, 34, 56, '_coal', '_gold'), P('speaker', 360, 180, 34, 54, '_coal', '_gold')]),
              ('ice', [P('@drums', 190, 128, 90, 62, '_red', '_white'), P('@guitar', 60, 176, 30, 58, '_orange', '_coal')]),
              ('lockers', [P('@lockers', 286, 98, 40, 76, '_teal', '_gold')]),
          ])),
]

CHAPTERS = [
    {'id': 'bakery', 'number': 11, 'icon': 'bakery_dining', 'name': ('BAKERY', 'PASTANE'),
     'doc': 'CHAPTER 11 — BAKERY: shop front, kitchen, cake studio, flour store, café terrace (crates).', 'levels': BAKERY},
    {'id': 'greenhouse', 'number': 12, 'icon': 'local_florist', 'name': ('GREENHOUSE', 'SERA'),
     'doc': 'CHAPTER 12 — GREENHOUSE: glass house, orchids, seedlings, palm house, pond garden (ice).', 'levels': GREENHOUSE},
    {'id': 'vineyard', 'number': 13, 'icon': 'wine_bar', 'name': ('VINEYARD', 'BAĞ EVİ'),
     'doc': 'CHAPTER 13 — VINEYARD: vine rows, grape press, cellar, farm kitchen, sunset terrace (chains).', 'levels': VINEYARD},
    {'id': 'train_station', 'number': 14, 'icon': 'train', 'name': ('TRAIN STATION', 'TREN GARI'),
     'doc': 'CHAPTER 14 — TRAIN STATION: platform, ticket hall, waiting room, café, engine shed (keys).', 'levels': STATION},
    {'id': 'school', 'number': 15, 'icon': 'school', 'name': ('SCHOOL', 'OKUL'),
     'doc': 'CHAPTER 15 — SCHOOL: schoolyard, classroom, science lab, gym, music room (mixed obstacles).', 'levels': SCHOOL},
]

# Balance pass (level_balance_test): moves, tile-objective target, per-objective overrides, stars.
TUNE = {
    'bakery_front': dict(moves=28, stars=(22500, 34000)),
    'bakery_kitchen': dict(stars=(20500, 25500)),
    'bakery_cakes': dict(moves=27, tiles=12, obj={'crates': 4, 'ice': 4}, stars=(21500, 26000)),
    'bakery_store': dict(moves=22, obj={'crates': 18}, stars=(23500, 29000)),
    'bakery_cafe': dict(moves=26, tiles=13, obj={'crates': 6, 'chains': 3}, stars=(22500, 30500)),
    'greenhouse_glass': dict(moves=27, tiles=13, obj={'ice': 6}, stars=(21500, 31000)),
    'greenhouse_orchids': dict(moves=26, obj={'ice': 8}, stars=(20000, 28000)),
    'greenhouse_seedlings': dict(moves=27, tiles=13, obj={'ice': 6, 'crates': 3}, stars=(19000, 23500)),
    'greenhouse_palms': dict(moves=27, tiles=13, obj={'ice': 8}, stars=(23500, 32500)),
    'greenhouse_pond': dict(moves=30, tiles=12, obj={'ice': 10, 'chains': 3}, stars=(19000, 24000)),
    'vineyard_rows': dict(moves=30, tiles=14, obj={'chains': 7}, stars=(21500, 28000)),
    'vineyard_press': dict(moves=27, tiles=13, obj={'chains': 7, 'crates': 3}, stars=(22500, 30000)),
    'vineyard_cellar': dict(moves=29, tiles=13, obj={'chains': 8, 'ice': 3}, stars=(21000, 31000)),
    'vineyard_kitchen': dict(moves=28, obj={'chains': 6, 'crates': 3}, stars=(21000, 28000)),
    'vineyard_terrace': dict(moves=34, tiles=12, obj={'chains': 6, 'ice': 5}, stars=(26000, 35500)),
    'station_platform': dict(moves=25, stars=(23500, 31000)),
    'station_tickets': dict(moves=26, obj={'ice': 8}, stars=(23500, 29000)),
    'station_waiting': dict(moves=31, tiles=12, obj={'chains': 6}, stars=(18500, 24500)),
    'station_cafe': dict(moves=27, obj={'crates': 6}, stars=(22000, 27500)),
    'station_shed': dict(moves=27, stars=(27000, 33500)),
    'school_yard': dict(moves=26, obj={'crates': 4}, stars=(23000, 30500)),
    'school_class': dict(moves=31, tiles=14, obj={'ice': 8, 'chains': 8}, stars=(31500, 39000)),
    'school_lab': dict(moves=29, tiles=13, obj={'ice': 6, 'crates': 3}, stars=(23500, 30000)),
    'school_gym': dict(moves=27, obj={'crates': 6, 'chains': 5}, stars=(22500, 31000)),
    'school_music': dict(moves=32, tiles=12, obj={'ice': 8}, stars=(23000, 29500)),
}

_OBST = {'crate', 'ice', 'chain', 'key'}
for _ch in CHAPTERS:
    for _lv in _ch['levels']:
        _t = TUNE.get(_lv['id'], {})
        _lv['moves'] = _t.get('moves', _lv['moves'])
        _objs = []
        for _oid, _tile, _n in _lv['objectives']:
            if _tile not in _OBST and 'tiles' in _t:
                _n = _t['tiles']
            _n = _t.get('obj', {}).get(_oid, _n)
            _objs.append((_oid, _tile, _n))
        _lv['objectives'] = _objs
        if 'stars' in _t:
            _lv['stars'] = list(_t['stars'])

# Release pass: levels 51-75 played easier than 41-50, so trim moves to keep
# the difficulty curve rising into the mid game.
HARDEN = {
    'bakery_front': 1, 'bakery_kitchen': 1, 'bakery_cakes': 5, 'bakery_store': 0, 'bakery_cafe': 3,
    'greenhouse_glass': 1, 'greenhouse_orchids': 3, 'greenhouse_seedlings': 2, 'greenhouse_palms': 4, 'greenhouse_pond': 3,
    'vineyard_rows': 1, 'vineyard_press': 4, 'vineyard_cellar': 1, 'vineyard_kitchen': 2, 'vineyard_terrace': 1,
    'station_platform': 2, 'station_tickets': 3, 'station_waiting': 2, 'station_cafe': 4, 'station_shed': 1,
    'school_yard': 3, 'school_class': 2, 'school_lab': 5, 'school_gym': 3, 'school_music': 1,
}
for _ch in CHAPTERS:
    for _lv in _ch['levels']:
        _lv['moves'] -= HARDEN.get(_lv['id'], 0)

# Measured after HARDEN (bot, 100 runs): floor = win rate - 0.06; stars = p50/p90.
RETUNE = {
    'bakery_front': (0.48, (21500, 33500)),
    'bakery_kitchen': (0.44, (20000, 24500)),
    'bakery_cakes': (0.38, (17000, 23500)),
    'bakery_store': (0.42, (23500, 29000)),
    'bakery_cafe': (0.30, (21000, 27500)),
    'greenhouse_glass': (0.52, (21500, 30000)),
    'greenhouse_orchids': (0.38, (19000, 25500)),
    'greenhouse_seedlings': (0.34, (18000, 22000)),
    'greenhouse_palms': (0.36, (20000, 29000)),
    'greenhouse_pond': (0.26, (18000, 22000)),
    'vineyard_rows': (0.44, (21500, 27000)),
    'vineyard_press': (0.40, (20000, 27000)),
    'vineyard_cellar': (0.42, (20000, 30000)),
    'vineyard_kitchen': (0.34, (20000, 26500)),
    'vineyard_terrace': (0.28, (25500, 35000)),
    'station_platform': (0.50, (22500, 29500)),
    'station_tickets': (0.40, (21500, 30000)),
    'station_waiting': (0.36, (18000, 24500)),
    'station_cafe': (0.32, (20000, 26500)),
    'station_shed': (0.32, (26500, 32500)),
    'school_yard': (0.50, (20500, 28500)),
    'school_class': (0.44, (30000, 37500)),
    'school_lab': (0.42, (20000, 25000)),
    'school_gym': (0.36, (22500, 32000)),
    'school_music': (0.30, (22000, 28500)),
}
for _ch in CHAPTERS:
    for _lv in _ch['levels']:
        _lv['floor'], _lv['stars'] = RETUNE[_lv['id']][0], list(RETUNE[_lv['id']][1])

# Openers ease in, finales are the hardest of each chapter.
for _ch in CHAPTERS:
    _ch['levels'][0]['diff'] = 'mediumHard'

# Shape variety check: no shape more than 3 times; 4+ shaped boards per chapter.
_counts = {}
for _ch in CHAPTERS:
    assert sum(lv['shape'] != 'rect' for lv in _ch['levels']) >= 4, _ch['id']
    for lv in _ch['levels']:
        _counts[lv['shape']] = _counts.get(lv['shape'], 0) + 1
assert max(_counts.values()) <= 3, _counts

