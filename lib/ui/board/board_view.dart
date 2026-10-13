import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../data/models/level_data.dart';
import '../../match3/board.dart';
import '../../match3/board_steps.dart';
import '../../match3/match3_engine.dart';
import '../art/obstacle_art.dart';
import '../art/paint_kit.dart';
import '../art/tile_art.dart';
import '../theme/game_colors.dart';
import '../widgets/logo.dart';

/// Callbacks from the board to the gameplay layer during playback.
abstract class BoardListener {
  void onSwapRequested(Pos a, Pos b);
  void onSpecialTapped(Pos p);

  /// A cell was tapped while a targeting booster is armed.
  void onCellPicked(Pos p);
  void onSwapAnimated(bool reverted);
  void onClear(ClearStep step, Map<int, Offset> clearedCentersGlobal);
  void onShuffle();
}

/// Imperative handle used by the gameplay controller.
class BoardViewController {
  _BoardViewState? _state;

  bool get attached => _state != null;

  Future<void> play(List<BoardStep> steps) => _state?._play(steps) ?? Future.value();
  void reset(Board board) => _state?._reset(board);
  void showHint(Move? m) => _state?._setHint(m);
  void setHighlight(List<Pos>? cells) => _state?._setHighlight(cells);
  void celebrate() => _state?._celebrate();
  set timeScale(double v) => _state?._timeScale = v;

  Rect? cellRectGlobal(Pos p) => _state?._cellRectGlobal(p);
  Offset? cellCenterGlobal(Pos p) => _state?._cellRectGlobal(p)?.center;
}

class _Sprite {
  int id = 0;
  String typeId = '';
  SpecialKind special = SpecialKind.none;
  double fx = 0, fy = 0, tx = 0, ty = 0, t0 = 0, dur = 0;
  bool gravity = false;
  double bornAt = -10;
  double dieAt = -1;
  double flashAt = -10;
  int chain = 0;
  bool get dying => dieAt >= 0;
}

class _Particle {
  double x = 0, y = 0, vx = 0, vy = 0, born = -10, life = 0, size = 0;
  Color color = Colors.white;
  bool star = false;
}

class _Effect {
  EffectKind kind = EffectKind.area;
  Pos origin = const Pos(0, 0);
  int radius = 0;
  List<Pos> targets = const [];
  double born = -10;
}

class _FloatText {
  TextPainter? painter;
  double x = 0, y = 0, born = -10;
}

class BoardView extends StatefulWidget {
  final int width;
  final int height;
  final List<String> tileTypeIds;
  final EnvironmentTheme theme;
  final BoardViewController controller;
  final BoardListener listener;
  final bool Function() inputEnabled;

  /// True while taps should pick a booster target.
  final bool Function() pickMode;

  /// Draw exit arrows under each column (levels with keys).
  final bool showExits;

  const BoardView({
    super.key,
    required this.width,
    required this.height,
    required this.tileTypeIds,
    required this.theme,
    required this.controller,
    required this.listener,
    required this.inputEnabled,
    bool Function()? pickMode,
    this.showExits = false,
  }) : pickMode = pickMode ?? _never;

  static bool _never() => false;

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final _repaint = ValueNotifier<int>(0);
  double _now = 0;
  Duration _lastTick = Duration.zero;
  double _timeScale = 1;

  final Map<int, _Sprite> _sprites = {};
  final List<_Sprite> _dying = [];
  late List<int?> _grid;
  // Obstacle mirrors (kept in sync from ClearStep obstacle hits).
  List<int> _crates = const [];
  List<int> _ice = const [];
  List<int> _crateStart = const [];
  List<int> _iceStart = const [];
  final Map<int, double> _cellHitAt = {};
  final List<_Particle> _particles = List.generate(260, (_) => _Particle());
  int _pNext = 0;
  final List<_Effect> _effects = List.generate(24, (_) => _Effect());
  int _eNext = 0;
  final List<_FloatText> _texts = List.generate(8, (_) => _FloatText());
  int _tNext = 0;

  final TileArtCache _art = TileArtCache();
  final List<(double, Completer<void>)> _waits = [];
  bool _disposed = false;

  Pos? _selected;
  Move? _hint;
  double _hintSince = 0;
  List<Pos>? _highlight;
  double _shakeUntil = -1, _shakeStrength = 0;
  double _celebrateAt = -10;

  Pos? _panStart;
  bool _panConsumed = false;

  // Layout (local coordinates).
  double _cell = 40;
  Offset _origin = Offset.zero;
  double _dpr = 2;

  @override
  void initState() {
    super.initState();
    _grid = List<int?>.filled(widget.width * widget.height, null);
    widget.controller._state = this;
    _ticker = createTicker(_onTick)..start();
  }

  @override
  void dispose() {
    _disposed = true;
    for (final w in _waits) {
      if (!w.$2.isCompleted) w.$2.complete();
    }
    _waits.clear();
    if (widget.controller._state == this) widget.controller._state = null;
    _ticker.dispose();
    _art.clear();
    _repaint.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    final dt = (elapsed - _lastTick).inMicroseconds / 1e6;
    _lastTick = elapsed;
    _now += dt.clamp(0, 0.1) * _timeScale;
    if (_waits.isNotEmpty) {
      final done = _waits.where((w) => _now >= w.$1).toList();
      for (final w in done) {
        _waits.remove(w);
        if (!w.$2.isCompleted) w.$2.complete();
      }
    }
    _dying.removeWhere((s) => _now - s.dieAt > 0.4);
    _repaint.value++;
  }

  /// Waits in board time (respects slow motion).
  Future<void> _wait(double seconds) {
    if (_disposed) return Future.value();
    final c = Completer<void>();
    _waits.add((_now + seconds, c));
    return c.future;
  }

  int _idx(Pos p) => p.y * widget.width + p.x;

  // --------------------------------------------------------------------------
  // Controller API
  // --------------------------------------------------------------------------

  void _reset(Board board) {
    _sprites.clear();
    _dying.clear();
    _grid = List<int?>.filled(widget.width * widget.height, null);
    _selected = null;
    _hint = null;
    _crates = List<int>.of(board.crates);
    _ice = List<int>.of(board.ice);
    _crateStart = List<int>.of(board.crates);
    _iceStart = List<int>.of(board.ice);
    _cellHitAt.clear();
    for (final p in board.positions) {
      final t = board.atPos(p);
      if (t == null) continue;
      final s = _makeSprite(t.id, t.type, t.special, p.x.toDouble(), p.y.toDouble(), drop: t.drop)..chain = t.chain;
      // Drop-in intro animation, staggered by row.
      s.fy = p.y - widget.height - 1.0;
      s.t0 = _now + (widget.height - p.y) * 0.03 + p.x * 0.01;
      s.dur = 0.45;
      s.gravity = true;
      _grid[_idx(p)] = t.id;
    }
  }

  _Sprite _makeSprite(int id, int type, SpecialKind special, double x, double y, {bool drop = false}) {
    final s = _Sprite()
      ..id = id
      ..typeId = drop ? ObjectiveData.dropId : widget.tileTypeIds[type]
      ..special = special
      ..fx = x
      ..fy = y
      ..tx = x
      ..ty = y
      ..t0 = _now
      ..dur = 0
      ..bornAt = -10;
    _sprites[id] = s;
    return s;
  }

  void _setHint(Move? m) {
    _hint = m;
    _hintSince = _now;
  }

  void _setHighlight(List<Pos>? cells) => _highlight = cells;

  void _celebrate() {
    _celebrateAt = _now;
    for (final s in _sprites.values) {
      final c = _cellCenter(s.tx, s.ty);
      _burst(c, slotColors[visualOf(s.typeId).slot % 6], 3);
    }
  }

  Rect? _cellRectGlobal(Pos p) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return null;
    final local = Rect.fromLTWH(_origin.dx + p.x * _cell, _origin.dy + p.y * _cell, _cell, _cell);
    final tl = box.localToGlobal(local.topLeft);
    return tl & local.size;
  }

  Offset _cellCenter(double x, double y) => _origin + Offset((x + 0.5) * _cell, (y + 0.5) * _cell);

  // --------------------------------------------------------------------------
  // Playback
  // --------------------------------------------------------------------------

  Future<void> _play(List<BoardStep> steps) async {
    _selected = null;
    _hint = null;
    for (final step in steps) {
      if (_disposed) return;
      switch (step) {
        case SwapStep():
          await _playSwap(step);
        case ClearStep():
          await _playClear(step);
        case FallStep():
          await _playFall(step);
        case ShuffleStep():
          await _playShuffle(step);
        case SinkStep():
          await _playSink(step);
      }
    }
  }

  void _tween(_Sprite s, double x, double y, double dur, {bool gravity = false, double delay = 0}) {
    final cur = _spritePos(s);
    s
      ..fx = cur.dx
      ..fy = cur.dy
      ..tx = x
      ..ty = y
      ..t0 = _now + delay
      ..dur = dur
      ..gravity = gravity;
  }

  Future<void> _playSwap(SwapStep step) async {
    final ia = _grid[_idx(step.a)], ib = _grid[_idx(step.b)];
    final sa = _sprites[ia], sb = _sprites[ib];
    if (sa == null || sb == null) return;
    const d = 0.16;
    _tween(sa, step.b.x.toDouble(), step.b.y.toDouble(), d);
    _tween(sb, step.a.x.toDouble(), step.a.y.toDouble(), d);
    await _wait(d);
    if (step.reverted) {
      widget.listener.onSwapAnimated(true);
      _tween(sa, step.a.x.toDouble(), step.a.y.toDouble(), d);
      _tween(sb, step.b.x.toDouble(), step.b.y.toDouble(), d);
      await _wait(d);
    } else {
      _grid[_idx(step.a)] = ib;
      _grid[_idx(step.b)] = ia;
      widget.listener.onSwapAnimated(false);
    }
  }

  Future<void> _playClear(ClearStep step) async {
    final centers = <int, Offset>{};
    final box = context.findRenderObject() as RenderBox?;
    for (final c in step.cleared) {
      final s = _sprites.remove(c.id);
      if (_grid[_idx(c.pos)] == c.id) _grid[_idx(c.pos)] = null;
      if (s == null) continue;
      s.dieAt = _now;
      _dying.add(s);
      final center = _cellCenter(c.pos.x.toDouble(), c.pos.y.toDouble());
      if (box != null && box.attached) centers[c.id] = box.localToGlobal(center);
      if (c.drop) {
        _burst(center, const Color(0xFFFFD447), 14);
      } else {
        _burst(center, slotColors[visualOf(s.typeId).slot % 6], step.cleared.length > 12 ? 3 : 6);
      }
    }
    for (final cs in step.created) {
      final s = _makeSprite(cs.tileId, cs.type, cs.kind, cs.pos.x.toDouble(), cs.pos.y.toDouble())
        ..bornAt = _now
        ..flashAt = _now;
      _grid[_idx(cs.pos)] = s.id;
    }
    var strong = false;
    for (final e in step.effects) {
      final fx = _effects[_eNext];
      _eNext = (_eNext + 1) % _effects.length;
      fx
        ..kind = e.kind
        ..origin = e.origin
        ..radius = e.radius
        ..targets = e.targets
        ..born = _now;
      if (e.kind != EffectKind.row && e.kind != EffectKind.column) strong = true;
    }
    if (strong || step.effects.length > 1) {
      _shakeUntil = _now + 0.35;
      _shakeStrength = step.effects.any((e) => e.kind == EffectKind.fullBoard) ? 9 : 5;
    }
    // Floating score at the centre of the cleared tiles.
    if (step.cleared.isNotEmpty) {
      var sx = 0.0, sy = 0.0;
      for (final c in step.cleared) {
        sx += c.pos.x;
        sy += c.pos.y;
      }
      _floatText('+${step.score}', _cellCenter(sx / step.cleared.length, sy / step.cleared.length));
    }
    for (final h in step.obstacleHits) {
      final i = _idx(h.pos);
      _cellHitAt[i] = _now;
      final center = _cellCenter(h.pos.x.toDouble(), h.pos.y.toDouble());
      switch (h.kind) {
        case ObstacleKind.crate:
          if (i < _crates.length) _crates[i] = h.remaining;
          _burst(center, const Color(0xFFC98A52), h.remaining == 0 ? 10 : 5);
        case ObstacleKind.ice:
          if (i < _ice.length) _ice[i] = h.remaining;
          _burst(center, const Color(0xFFBDEFFF), 7);
        case ObstacleKind.chain:
          final sp = h.tileId == null ? null : _sprites[h.tileId];
          if (sp != null) sp.chain = h.remaining;
          _burst(center, const Color(0xFFC9CCD8), 6);
      }
    }
    if (step.obstacleHits.isNotEmpty && _shakeUntil < _now) {
      _shakeUntil = _now + 0.15;
      _shakeStrength = 2;
    }
    widget.listener.onClear(step, centers);
    await _wait(step.effects.isEmpty ? 0.22 : 0.36);
  }

  Future<void> _playFall(FallStep step) async {
    var maxT = 0.0;
    for (final m in step.moves) {
      final s = _sprites[m.id];
      if (s == null) continue;
      final dist = (m.to.y - m.from.y).abs().toDouble();
      final d = 0.12 + sqrt(dist) * 0.07;
      _tween(s, m.to.x.toDouble(), m.to.y.toDouble(), d, gravity: true);
      if (_grid[_idx(m.from)] == m.id) _grid[_idx(m.from)] = null;
      maxT = max(maxT, d);
    }
    for (final m in step.moves) {
      _grid[_idx(m.to)] = m.id;
    }
    for (final sp in step.spawns) {
      final s = _makeSprite(sp.id, sp.type, sp.special, sp.to.x.toDouble(), sp.fromY.toDouble(), drop: sp.drop);
      final dist = (sp.to.y - sp.fromY).toDouble();
      final d = 0.12 + sqrt(dist) * 0.07;
      _tween(s, sp.to.x.toDouble(), sp.to.y.toDouble(), d, gravity: true);
      _grid[_idx(sp.to)] = sp.id;
      maxT = max(maxT, d);
    }
    await _wait(maxT + 0.04);
  }

  /// Keys and the pieces under them trade places together.
  Future<void> _playSink(SinkStep step) async {
    const d = 0.2;
    for (final (a, b) in step.swaps) {
      final ia = _grid[_idx(a)], ib = _grid[_idx(b)];
      final sa = _sprites[ia], sb = _sprites[ib];
      if (sa == null || sb == null) continue;
      _tween(sa, b.x.toDouble(), b.y.toDouble(), d);
      _tween(sb, a.x.toDouble(), a.y.toDouble(), d);
      _grid[_idx(a)] = ib;
      _grid[_idx(b)] = ia;
    }
    await _wait(d + 0.02);
  }

  Future<void> _playShuffle(ShuffleStep step) async {
    widget.listener.onShuffle();
    await _wait(0.5);
    _grid = List<int?>.filled(widget.width * widget.height, null);
    for (final t in step.tiles) {
      var s = _sprites[t.id];
      if (s == null) {
        s = _makeSprite(t.id, t.type, t.special, t.pos.x.toDouble(), t.pos.y.toDouble(), drop: t.drop);
      } else {
        s
          ..typeId = t.drop ? ObjectiveData.dropId : widget.tileTypeIds[t.type]
          ..special = t.special
          ..chain = t.chain;
      }
      _tween(s, t.pos.x.toDouble(), t.pos.y.toDouble(), 0.45);
      _grid[_idx(t.pos)] = t.id;
    }
    await _wait(0.5);
  }

  void _burst(Offset at, Color color, int n) {
    final rng = Random(at.dx.toInt() * 31 + at.dy.toInt() + _pNext);
    for (var i = 0; i < n; i++) {
      final p = _particles[_pNext];
      _pNext = (_pNext + 1) % _particles.length;
      final a = rng.nextDouble() * pi * 2;
      final spd = _cell * (1.5 + rng.nextDouble() * 2.5);
      p
        ..x = at.dx
        ..y = at.dy
        ..vx = cos(a) * spd
        ..vy = sin(a) * spd - _cell
        ..born = _now
        ..life = 0.35 + rng.nextDouble() * 0.35
        ..size = _cell * (0.06 + rng.nextDouble() * 0.08)
        ..color = i % 3 == 0 ? Colors.white : color
        ..star = i.isEven;
    }
  }

  void _floatText(String text, Offset at) {
    final ft = _texts[_tNext];
    _tNext = (_tNext + 1) % _texts.length;
    ft.painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontFamily: kLogoFont,
          fontSize: _cell * 0.42,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          shadows: const [Shadow(color: GameColors.ink, offset: Offset(0, 2), blurRadius: 2)],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    ft
      ..x = at.dx
      ..y = at.dy
      ..born = _now;
  }

  // --------------------------------------------------------------------------
  // Geometry helpers
  // --------------------------------------------------------------------------

  Offset _spritePos(_Sprite s) {
    if (s.dur <= 0 || _now >= s.t0 + s.dur) return Offset(s.tx, s.ty);
    if (_now <= s.t0) return Offset(s.fx, s.fy);
    final k = (_now - s.t0) / s.dur;
    final e = s.gravity ? k * k : Curves.easeInOut.transform(k);
    return Offset(s.fx + (s.tx - s.fx) * e, s.fy + (s.ty - s.fy) * e);
  }

  /// Landing squash (x-scale, y-scale) right after a gravity move ends.
  (double, double) _squash(_Sprite s) {
    if (!s.gravity || s.dur <= 0) return (1, 1);
    final since = _now - (s.t0 + s.dur);
    if (since < 0 || since > 0.18) return (1, 1);
    final k = sin(since / 0.18 * pi) * 0.12;
    return (1 + k, 1 - k);
  }

  Pos? _cellAt(Offset local) {
    final p = local - _origin;
    final x = (p.dx / _cell).floor(), y = (p.dy / _cell).floor();
    if (x < 0 || y < 0 || x >= widget.width || y >= widget.height) return null;
    return Pos(x, y);
  }

  // --------------------------------------------------------------------------
  // Input
  // --------------------------------------------------------------------------

  void _onTapUp(TapUpDetails d) {
    if (!widget.inputEnabled()) return;
    final p = _cellAt(d.localPosition);
    if (p == null) return;
    if (widget.pickMode()) {
      _selected = null;
      widget.listener.onCellPicked(p);
      return;
    }
    if (_grid[_idx(p)] == null) return; // crate cell
    final sel = _selected;
    if (sel == null) {
      setState(() => _selected = p);
      return;
    }
    if (sel == p) {
      final id = _grid[_idx(p)];
      final s = id == null ? null : _sprites[id];
      _selected = null;
      if (s != null && s.special != SpecialKind.none) widget.listener.onSpecialTapped(p);
      return;
    }
    if (sel.isAdjacent(p)) {
      _selected = null;
      widget.listener.onSwapRequested(sel, p);
      return;
    }
    _selected = p;
  }

  void _onPanStart(DragStartDetails d) {
    _panConsumed = false;
    _panStart = widget.inputEnabled() && !widget.pickMode() ? _cellAt(d.localPosition) : null;
    if (_panStart != null && _grid[_idx(_panStart!)] == null) _panStart = null;
  }

  void _onPanUpdate(DragUpdateDetails d) {
    final start = _panStart;
    if (start == null || _panConsumed || !widget.inputEnabled()) return;
    final startCenter = _cellCenter(start.x.toDouble(), start.y.toDouble());
    final delta = d.localPosition - startCenter;
    if (delta.distance < _cell * 0.42) return;
    final Pos target = delta.dx.abs() > delta.dy.abs()
        ? Pos(start.x + delta.dx.sign.toInt(), start.y)
        : Pos(start.x, start.y + delta.dy.sign.toInt());
    _panConsumed = true;
    _selected = null;
    if (target.x < 0 || target.y < 0 || target.x >= widget.width || target.y >= widget.height) return;
    widget.listener.onSwapRequested(start, target);
  }

  @override
  Widget build(BuildContext context) {
    _dpr = MediaQuery.devicePixelRatioOf(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = min(constraints.maxWidth, constraints.maxHeight);
        const pad = 8.0;
        _cell = (size - pad * 2) / max(widget.width, widget.height);
        _origin = Offset((constraints.maxWidth - _cell * widget.width) / 2, (constraints.maxHeight - _cell * widget.height) / 2);
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapUp: _onTapUp,
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          onPanEnd: (_) => _panStart = null,
          child: CustomPaint(size: Size(constraints.maxWidth, constraints.maxHeight), painter: _BoardPainter(this)),
        );
      },
    );
  }
}

class _BoardPainter extends CustomPainter {
  final _BoardViewState s;
  _BoardPainter(this.s) : super(repaint: s._repaint);

  final Paint _imgPaint = Paint()..filterQuality = FilterQuality.medium;

  @override
  void paint(Canvas canvas, Size size) {
    final now = s._now;
    final cell = s._cell;
    final w = s.widget.width, h = s.widget.height;
    final theme = s.widget.theme;
    var shake = Offset.zero;
    if (now < s._shakeUntil) {
      final k = (s._shakeUntil - now) / 0.35;
      shake = Offset(sin(now * 90) * s._shakeStrength * k, cos(now * 77) * s._shakeStrength * k * 0.6);
    }
    canvas.save();
    canvas.translate(shake.dx, shake.dy);

    final boardRect = Rect.fromLTWH(s._origin.dx, s._origin.dy, cell * w, cell * h);
    final frame = RRect.fromRectAndRadius(boardRect.inflate(7), Radius.circular(cell * 0.4));
    canvas.drawRRect(frame.shift(const Offset(0, 5)), Paint()..color = Colors.black.withValues(alpha: 0.28));
    canvas.drawRRect(frame, Paint()..color = theme.boardFrame);
    canvas.drawRRect(
      RRect.fromRectAndRadius(boardRect.inflate(2), Radius.circular(cell * 0.3)),
      Paint()..color = Pk.dark(theme.boardFrame, 0.35).withValues(alpha: 0.85),
    );
    final a = Paint()..color = theme.cellA;
    final b = Paint()..color = theme.cellB;
    for (var y = 0; y < h; y++) {
      for (var x = 0; x < w; x++) {
        final r = Rect.fromLTWH(boardRect.left + x * cell, boardRect.top + y * cell, cell, cell).deflate(1);
        canvas.drawRRect(RRect.fromRectAndRadius(r, Radius.circular(cell * 0.18)), (x + y).isEven ? a : b);
      }
    }

    // Tutorial highlight.
    final hl = s._highlight;
    if (hl != null) {
      final pulse = 0.5 + 0.5 * sin(now * 5);
      for (final p in hl) {
        final r = Rect.fromLTWH(boardRect.left + p.x * cell, boardRect.top + p.y * cell, cell, cell);
        canvas.drawRRect(
          RRect.fromRectAndRadius(r.inflate(2), Radius.circular(cell * 0.22)),
          Paint()..color = Colors.white.withValues(alpha: 0.35 + 0.35 * pulse),
        );
      }
    }
    // Selection.
    final sel = s._selected;
    if (sel != null) {
      final r = Rect.fromLTWH(boardRect.left + sel.x * cell, boardRect.top + sel.y * cell, cell, cell);
      canvas.drawRRect(
        RRect.fromRectAndRadius(r.deflate(1), Radius.circular(cell * 0.22)),
        Paint()..color = Colors.white.withValues(alpha: 0.55),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r.deflate(1), Radius.circular(cell * 0.22)),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = GameColors.gold,
      );
    }

    // Targeting booster armed: pulsing gold frame.
    if (s.widget.pickMode()) {
      final pulse = 0.5 + 0.5 * sin(now * 6);
      canvas.drawRRect(
        frame,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4 + 3 * pulse
          ..color = GameColors.gold.withValues(alpha: 0.6 + 0.4 * pulse),
      );
    }

    canvas.save();
    canvas.clipRRect(RRect.fromRectAndRadius(boardRect, Radius.circular(cell * 0.3)));
    final imgSize = cell * s._dpr;
    void drawSprite(_Sprite sp, double scaleX, double scaleY, double alpha) {
      final pos = s._spritePos(sp);
      final c = s._cellCenter(pos.dx, pos.dy);
      final img = s._art.get(sp.typeId, sp.special, imgSize);
      final dw = cell * 0.96 * scaleX, dh = cell * 0.96 * scaleY;
      final dst = Rect.fromCenter(center: c, width: dw, height: dh);
      _imgPaint.color = Color.fromRGBO(255, 255, 255, alpha.clamp(0.0, 1.0));
      canvas.drawImageRect(img, Rect.fromLTWH(0, 0, img.width.toDouble(), img.height.toDouble()), dst, _imgPaint);
    }

    final hint = s._hint;
    final hintActive = hint != null && now - s._hintSince > 0;
    for (final sp in s._sprites.values) {
      var (sx, sy) = s._squash(sp);
      var scale = 1.0;
      if (sp.bornAt > -10 && now - sp.bornAt < 0.4) {
        scale = Pk.pop((now - sp.bornAt) / 0.4);
      }
      if (sp.special != SpecialKind.none) scale *= 1 + 0.05 * sin(now * 4 + sp.id);
      if (hintActive) {
        final pos = Offset(sp.tx, sp.ty);
        if (pos == Offset(hint.a.x.toDouble(), hint.a.y.toDouble()) || pos == Offset(hint.b.x.toDouble(), hint.b.y.toDouble())) {
          scale *= 1 + 0.1 * sin(now * 8).abs();
        }
      }
      if (now - s._celebrateAt < 1.2) {
        final wave = sin((now - s._celebrateAt) * 10 - sp.tx * 0.8 - sp.ty * 0.5);
        scale *= 1 + 0.08 * max(0, wave);
      }
      drawSprite(sp, sx * scale, sy * scale, 1);
      if (now - sp.flashAt < 0.35) {
        final pos = s._spritePos(sp);
        final c = s._cellCenter(pos.dx, pos.dy);
        canvas.drawCircle(c, cell * 0.6, Paint()..color = Colors.white.withValues(alpha: 0.8 * (1 - (now - sp.flashAt) / 0.35)));
      }
    }
    for (final sp in s._dying) {
      final k = ((now - sp.dieAt) / 0.3).clamp(0.0, 1.0);
      final scale = k < 0.3 ? 1 + k * 0.8 : (1.24 * (1 - (k - 0.3) / 0.7));
      if (scale > 0.02) drawSprite(sp, scale, scale, 1 - k * 0.6);
      if (k < 0.3) {
        final pos = s._spritePos(sp);
        canvas.drawCircle(
          s._cellCenter(pos.dx, pos.dy),
          cell * 0.45 * (1 + k),
          Paint()..color = Colors.white.withValues(alpha: 0.5 * (1 - k / 0.3)),
        );
      }
    }
    _paintObstacles(canvas, boardRect, now, cell);
    canvas.restore();

    if (s.widget.showExits) _paintExits(canvas, boardRect, now, cell);
    _paintEffects(canvas, boardRect, now, cell);

    // Particles.
    final pp = Paint();
    for (final p in s._particles) {
      final age = now - p.born;
      if (age < 0 || age > p.life) continue;
      final k = age / p.life;
      final x = p.x + p.vx * age, y = p.y + p.vy * age + cell * 6 * age * age;
      pp.color = p.color.withValues(alpha: 1 - k);
      if (p.star) {
        Pk.sparkle(canvas, Offset(x, y), p.size * 1.6 * (1 - k * 0.5), pp.color);
      } else {
        canvas.drawCircle(Offset(x, y), p.size * (1 - k * 0.5), pp);
      }
    }

    // Floating score text.
    for (final t in s._texts) {
      final age = now - t.born;
      if (t.painter == null || age < 0 || age > 0.8) continue;
      final k = age / 0.8;
      final tp = t.painter!;
      canvas.saveLayer(null, Paint()..color = Colors.white.withValues(alpha: (1 - k * k).clamp(0, 1)));
      tp.paint(canvas, Offset(t.x - tp.width / 2, t.y - tp.height / 2 - k * cell * 0.9));
      canvas.restore();
    }
    canvas.restore();
  }

  /// Ice over cells, chains over locked pieces, crates on top (falling pieces
  /// pass behind crates). Recently hit obstacles wobble.
  void _paintObstacles(Canvas canvas, Rect board, double now, double cell) {
    final w = s.widget.width;
    double wobble(int i) {
      final hit = s._cellHitAt[i];
      if (hit == null || now - hit > 0.3) return 1;
      return 1 + 0.12 * sin((now - hit) / 0.3 * pi);
    }

    Rect cellRect(int i, double scale) {
      final c = board.topLeft + Offset((i % w + 0.5) * cell, (i ~/ w + 0.5) * cell);
      return Rect.fromCenter(center: c, width: cell * scale, height: cell * scale);
    }

    for (var i = 0; i < s._ice.length; i++) {
      if (s._ice[i] > 0) ObstacleArt.ice(canvas, cellRect(i, wobble(i)), s._ice[i], now, damaged: s._ice[i] < s._iceStart[i]);
    }
    for (final sp in s._sprites.values) {
      if (sp.chain <= 0) continue;
      final pos = s._spritePos(sp);
      final c = s._cellCenter(pos.dx, pos.dy);
      final i = sp.ty.round() * w + sp.tx.round();
      final scale = wobble(i);
      ObstacleArt.chain(canvas, Rect.fromCenter(center: c, width: cell * scale, height: cell * scale), sp.chain);
    }
    for (var i = 0; i < s._crates.length; i++) {
      if (s._crates[i] > 0) ObstacleArt.crate(canvas, cellRect(i, wobble(i)), s._crates[i], damaged: s._crates[i] < s._crateStart[i]);
    }
  }

  /// Small gold chevrons under the lowest free cell of each column: where
  /// keys leave the board.
  void _paintExits(Canvas canvas, Rect board, double now, double cell) {
    final w = s.widget.width, h = s.widget.height;
    final bob = sin(now * 3) * cell * 0.04;
    final fill = Paint()..color = const Color(0xFFFFD447).withValues(alpha: 0.9);
    final edge = Paint()
      ..color = GameColors.ink.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = max(1.0, cell * 0.03)
      ..strokeJoin = StrokeJoin.round;
    for (var x = 0; x < w; x++) {
      var y = h - 1;
      while (y >= 0 && x + y * w < s._crates.length && s._crates[x + y * w] > 0) {
        y--;
      }
      if (y < 0) continue;
      final cx = board.left + (x + 0.5) * cell;
      final top = board.top + (y + 1) * cell - cell * 0.16 + bob;
      final a = Path()
        ..moveTo(cx - cell * 0.14, top)
        ..lineTo(cx + cell * 0.14, top)
        ..lineTo(cx, top + cell * 0.13)
        ..close();
      canvas.drawPath(a, fill);
      canvas.drawPath(a, edge);
    }
  }

  void _paintEffects(Canvas canvas, Rect board, double now, double cell) {
    for (final e in s._effects) {
      final age = now - e.born;
      if (age < 0 || age > 0.45) continue;
      final k = age / 0.45;
      final o = board.topLeft + Offset((e.origin.x + 0.5) * cell, (e.origin.y + 0.5) * cell);
      final alpha = (1 - k).clamp(0.0, 1.0);
      switch (e.kind) {
        case EffectKind.row:
        case EffectKind.column:
          final horizontal = e.kind == EffectKind.row;
          final len = (horizontal ? board.width : board.height) * Curves.easeOut.transform(min(1, k * 2.5));
          final thick = cell * 0.55 * (1 - k * 0.6);
          final rect = horizontal
              ? Rect.fromCenter(center: Offset(o.dx, o.dy), width: len * 2, height: thick)
              : Rect.fromCenter(center: Offset(o.dx, o.dy), width: thick, height: len * 2);
          final clipped = rect.intersect(board);
          canvas.drawRRect(
            RRect.fromRectAndRadius(clipped.inflate(4), Radius.circular(thick)),
            Paint()..color = const Color(0xFFFFE066).withValues(alpha: 0.45 * alpha),
          );
          canvas.drawRRect(
            RRect.fromRectAndRadius(clipped, Radius.circular(thick)),
            Paint()..color = Colors.white.withValues(alpha: 0.9 * alpha),
          );
        case EffectKind.area:
          final r = cell * (e.radius + 0.6) * Curves.easeOut.transform(k);
          canvas.drawCircle(o, r, Paint()..color = const Color(0xFFFFB347).withValues(alpha: 0.35 * alpha));
          canvas.drawCircle(
            o,
            r,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = cell * 0.25 * alpha
              ..color = Colors.white.withValues(alpha: alpha),
          );
        case EffectKind.colorBurst:
          final lp = Paint()
            ..strokeWidth = 3
            ..strokeCap = StrokeCap.round
            ..color = Colors.white.withValues(alpha: alpha);
          final glow = Paint()
            ..strokeWidth = 8
            ..strokeCap = StrokeCap.round
            ..color = Pk.hue(now * 400).withValues(alpha: 0.5 * alpha);
          for (final t in e.targets) {
            final tp = board.topLeft + Offset((t.x + 0.5) * cell, (t.y + 0.5) * cell);
            final mid = Offset.lerp(o, tp, 0.5)! + Offset(sin(now * 40 + t.x) * 6, cos(now * 37 + t.y) * 6);
            canvas.drawLine(o, mid, glow);
            canvas.drawLine(mid, tp, glow);
            canvas.drawLine(o, mid, lp);
            canvas.drawLine(mid, tp, lp);
          }
          canvas.drawCircle(o, cell * 0.7, Paint()..color = Colors.white.withValues(alpha: alpha));
        case EffectKind.fullBoard:
          canvas.drawRect(board, Paint()..color = Colors.white.withValues(alpha: 0.8 * alpha));
        case EffectKind.hammer:
          // Mallet swings down onto the cell, then a star-shaped impact.
          final swing = Curves.easeIn.transform(min(1, k * 3));
          if (k < 0.4) {
            canvas.save();
            canvas.translate(o.dx + cell * 0.5, o.dy - cell * 0.4);
            canvas.rotate(-1.1 + swing * 1.1);
            final head = Rect.fromCenter(center: Offset(-cell * 0.55, 0), width: cell * 0.5, height: cell * 0.34);
            canvas.drawRect(Rect.fromLTWH(-cell * 0.5, -cell * 0.05, cell * 0.6, cell * 0.1), Paint()..color = const Color(0xFF8B5E3C));
            canvas.drawRRect(RRect.fromRectAndRadius(head, Radius.circular(cell * 0.06)), Paint()..color = const Color(0xFFFF9A3C));
            canvas.drawRRect(
              RRect.fromRectAndRadius(head, Radius.circular(cell * 0.06)),
              Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2
                ..color = GameColors.ink,
            );
            canvas.restore();
          } else {
            final kk = (k - 0.3) / 0.7;
            Pk.sparkle(canvas, o, cell * (0.4 + kk * 0.9), Colors.white.withValues(alpha: 1 - kk));
            canvas.drawCircle(
              o,
              cell * (0.3 + kk * 0.7),
              Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = cell * 0.12 * (1 - kk)
                ..color = const Color(0xFFFFE066).withValues(alpha: 1 - kk),
            );
          }
      }
    }
  }

  @override
  bool shouldRepaint(_BoardPainter old) => false;
}
