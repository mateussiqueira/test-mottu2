import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'i_cache_manager.dart';

class SharedPreferencesCacheManager implements ICacheManager {
  final SharedPreferences _prefs;
  final String _prefix;
  final dynamic Function(dynamic) _fromJson;
  final dynamic Function(dynamic) _toJson;

  SharedPreferencesCacheManager({
    required SharedPreferences prefs,
    required String prefix,
    required dynamic Function(dynamic) fromJson,
    required dynamic Function(dynamic) toJson,
  })  : _prefs = prefs,
        _prefix = prefix,
        _fromJson = fromJson,
        _toJson = toJson;

  @override
  Future<dynamic> get(String key) async {
    final value = _prefs.getString('$_prefix$key');
    if (value == null) return null;
    return _fromJson(jsonDecode(value));
  }

  @override
  Future<void> set(String key, dynamic value) async {
    final jsonValue = jsonEncode(_toJson(value));
    await _prefs.setString('$_prefix$key', jsonValue);
  }

  @override
  Future<void> remove(String key) async {
    await _prefs.remove('$_prefix$key');
  }

  @override
  Future<void> clear() async {
    final keys = _prefs.getKeys();
    for (final key in keys) {
      if (key.startsWith(_prefix)) {
        await _prefs.remove(key);
      }
    }
  }

  @override
  Future<void> delete(String key) async {
    await remove(key);
  }

  @override
  Future<bool> has(String key) async {
    return _prefs.containsKey('$_prefix$key');
  }

  @override
  Future<void> save(String key, dynamic value) async {
    await set(key, value);
  }
}
