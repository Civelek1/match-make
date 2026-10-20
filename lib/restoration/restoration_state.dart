import 'package:flutter/foundation.dart';

import '../data/models/level_data.dart';

/// Shared clock for all restoration animations (seconds).
class SceneClock {
  static final Stopwatch _sw = Stopwatch()..start();

  /// Replaces the real clock (frame-by-frame video capture in tools).
  static double Function()? debugTimeSource;
  static double get now => debugTimeSource?.call() ?? _sw.elapsedMicroseconds / 1e6;
}

/// Tracks the visual restoration stage of each objective and *when* each stage
/// was reached, so scenes can animate new pieces appearing.
class RestorationState extends ChangeNotifier {
  static const appearDuration = 0.8;

  final LevelData level;
  final Map<String, int> _amounts = {};
  final Map<String, List<double?>> _stageTimes = {};

  /// Called whenever an objective crosses a milestone.
  void Function(String objectiveId, int stage, bool completed)? onStage;

  RestorationState(this.level) {
    for (final o in level.objectives) {
      _amounts[o.id] = 0;
      _stageTimes[o.id] = List<double?>.filled(o.stageCount, null);
    }
  }

  /// Fully restored instantly (gallery "after", completed levels).
  factory RestorationState.completed(LevelData level) {
    final s = RestorationState(level);
    for (final o in level.objectives) {
      s._amounts[o.id] = o.target;
      s._stageTimes[o.id] = List<double?>.filled(o.stageCount, -100);
    }
    return s;
  }

  int amountOf(String id) => _amounts[id] ?? 0;

  void setAmount(String id, int amount) {
    final o = level.objectives.firstWhere((o) => o.id == id);
    final before = o.stageFor(_amounts[id] ?? 0);
    _amounts[id] = amount.clamp(0, o.target);
    final after = o.stageFor(_amounts[id]!);
    if (after > before) {
      final now = SceneClock.now;
      final times = _stageTimes[id]!;
      for (var s = before; s < after; s++) {
        // Stagger multiple stages crossed at once so each still animates.
        times[s] = now + (s - before) * 0.25;
      }
      onStage?.call(id, after, after == o.stageCount);
    }
    notifyListeners();
  }

  /// Jump everything to complete, animating the remaining stages.
  void completeAll() {
    for (final o in level.objectives) {
      setAmount(o.id, o.target);
    }
  }

  int stage(String id) {
    final times = _stageTimes[id];
    if (times == null) return 0;
    return times.where((t) => t != null).length;
  }

  /// 0..1 appear progress of stage [s] (1-based) of objective [id].
  double appear(String id, int s, [double? now]) {
    final times = _stageTimes[id];
    if (times == null || s < 1 || s > times.length) return 0;
    final t = times[s - 1];
    if (t == null) return 0;
    final p = ((now ?? SceneClock.now) - t) / appearDuration;
    return p.clamp(0.0, 1.0);
  }

  /// Smooth 0..1 progress of an objective (sum of stage appearances).
  double progress(String id, [double? now]) {
    final times = _stageTimes[id];
    if (times == null || times.isEmpty) return 0;
    var sum = 0.0;
    for (var s = 1; s <= times.length; s++) {
      sum += appear(id, s, now);
    }
    return sum / times.length;
  }

  /// Whole-scene restoration 0..1 (drives ambient colour / lighting).
  double overall([double? now]) {
    if (level.objectives.isEmpty) return 1;
    var sum = 0.0;
    for (final o in level.objectives) {
      sum += progress(o.id, now);
    }
    return sum / level.objectives.length;
  }

  /// True while any stage is still animating (scene needs repainting).
  bool get animating {
    final now = SceneClock.now;
    for (final times in _stageTimes.values) {
      for (final t in times) {
        if (t != null && now - t < appearDuration + 0.1) return true;
      }
    }
    return false;
  }
}
