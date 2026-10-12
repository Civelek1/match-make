import 'package:flutter/foundation.dart';

import 'strings_en.dart';
import 'strings_tr.dart';

/// String lookup with `{param}` interpolation. Missing keys fall back to
/// English, then to the key itself (so a missing string is visible, not a crash).
class Localization extends ChangeNotifier {
  static const supported = <String, Map<String, String>>{'en': stringsEn, 'tr': stringsTr};

  String _lang = 'en';
  String get language => _lang;

  set language(String code) {
    final next = supported.containsKey(code) ? code : 'en';
    if (next == _lang) return;
    _lang = next;
    notifyListeners();
  }

  String t(String key, [Map<String, Object>? args]) {
    var s = supported[_lang]![key] ?? stringsEn[key] ?? key;
    if (args != null) {
      args.forEach((k, v) => s = s.replaceAll('{$k}', '$v'));
    }
    return s;
  }

  /// Upper-case helper that respects Turkish dotted/dotless i.
  String upper(String s) {
    if (_lang == 'tr') s = s.replaceAll('i', 'İ').replaceAll('ı', 'I');
    return s.toUpperCase();
  }
}
