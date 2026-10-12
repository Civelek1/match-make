import 'package:flutter/foundation.dart';

import '../save/save_data.dart';
import '../save/save_store.dart';

class SettingsService extends ChangeNotifier {
  final SaveStore _store;
  SettingsService(this._store);

  SettingsData get _s => _store.data.settings;

  bool get music => _s.music;
  bool get sfx => _s.sfx;
  bool get vibration => _s.vibration;
  String get language => _s.language;

  set music(bool v) => _update(() => _s.music = v);
  set sfx(bool v) => _update(() => _s.sfx = v);
  set vibration(bool v) => _update(() => _s.vibration = v);
  set language(String v) => _update(() => _s.language = v);

  void _update(void Function() change) {
    change();
    _store.commit();
    notifyListeners();
  }

  /// Call after the save store is replaced (e.g. reset) to refresh listeners.
  void reload() => notifyListeners();
}

class ProfileService extends ChangeNotifier {
  final SaveStore _store;
  ProfileService(this._store);

  ProfileData get _p => _store.data.profile;

  /// Empty = player never set a name; UI shows the localized default.
  String get name => _p.name;
  String get avatarId => _p.avatarId;

  set name(String v) {
    final trimmed = v.trim();
    _p.name = trimmed.length > 16 ? trimmed.substring(0, 16) : trimmed;
    _store.commit();
    notifyListeners();
  }

  set avatarId(String v) {
    _p.avatarId = v;
    _store.commit();
    notifyListeners();
  }
}
