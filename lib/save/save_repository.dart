import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'save_data.dart';

class LoadResult {
  final SaveData data;

  /// True when the primary save was unreadable and a backup/default was used.
  final bool recovered;

  /// True when no save existed at all (a brand-new install).
  final bool firstLaunch;
  const LoadResult(this.data, {this.recovered = false, this.firstLaunch = false});
}

/// Storage abstraction. A CloudSaveRepository can implement the same contract
/// later (e.g. sync after local load) without touching game code.
abstract class SaveRepository {
  Future<LoadResult> load();
  Future<void> save(SaveData data);
  Future<void> clear();
}

/// Local persistence via shared_preferences with a rolling backup copy.
class LocalSaveRepository implements SaveRepository {
  static const _key = 'match_make.save';
  static const _backupKey = 'match_make.save.bak';

  SharedPreferences? _prefs;

  Future<SharedPreferences> get _p async => _prefs ??= await SharedPreferences.getInstance();

  @override
  Future<LoadResult> load() async {
    final SharedPreferences prefs;
    try {
      prefs = await _p;
    } catch (_) {
      return LoadResult(SaveData(), recovered: false);
    }
    final primary = _decode(prefs.getString(_key));
    if (primary != null) return LoadResult(primary);
    final hadPrimary = prefs.containsKey(_key);
    final backup = _decode(prefs.getString(_backupKey));
    if (backup != null) return LoadResult(backup, recovered: true);
    return LoadResult(SaveData(), recovered: hadPrimary, firstLaunch: !hadPrimary);
  }

  SaveData? _decode(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      return SaveData.fromJson(jsonDecode(raw));
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> save(SaveData data) async {
    try {
      final prefs = await _p;
      final encoded = jsonEncode(data.toJson());
      final previous = prefs.getString(_key);
      if (previous != null && _decode(previous) != null) {
        await prefs.setString(_backupKey, previous);
      }
      await prefs.setString(_key, encoded);
    } catch (_) {
      // Storage failures must never crash gameplay.
    }
  }

  @override
  Future<void> clear() async {
    try {
      final prefs = await _p;
      await prefs.remove(_key);
      await prefs.remove(_backupKey);
    } catch (_) {}
  }
}

/// In-memory repository for tests and as a last-resort fallback.
class MemorySaveRepository implements SaveRepository {
  String? raw;
  MemorySaveRepository([this.raw]);

  @override
  Future<LoadResult> load() async {
    if (raw == null) return LoadResult(SaveData(), firstLaunch: true);
    try {
      return LoadResult(SaveData.fromJson(jsonDecode(raw!)));
    } catch (_) {
      return LoadResult(SaveData(), recovered: true);
    }
  }

  @override
  Future<void> save(SaveData data) async => raw = jsonEncode(data.toJson());

  @override
  Future<void> clear() async => raw = null;
}
