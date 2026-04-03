import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';

class LocaleService {
  final Map<String, Map<String, String>> _cache = {};

  Future<void> load(Locale locale) async {
    final code = locale.languageCode;
    if (_cache.containsKey(code)) return;
    final jsonString = await rootBundle.loadString('assets/l10n/$code.json');
    final Map<String, dynamic> data = json.decode(jsonString);
    _cache[code] = data.map((k, v) => MapEntry(k, v.toString()));
  }

  String translate(Locale locale, String key) {
    final map = _cache[locale.languageCode] ?? {};
    return map[key] ?? key;
  }
}
