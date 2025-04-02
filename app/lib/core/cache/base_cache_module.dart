import 'package:shared_preferences/shared_preferences.dart';

import 'i_cache_module.dart';

class BaseCacheModule implements ICacheModule {
  final String _prefix;
  late SharedPreferences _prefs;

  BaseCacheModule(this._prefix);

  @override
  Future<void> setup() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> set(String key, dynamic value) async {
    if (value == null) {
      await _prefs.remove('$_prefix$key');
    } else if (value is String) {
      await _prefs.setString('$_prefix$key', value);
    } else if (value is int) {
      await _prefs.setInt('$_prefix$key', value);
    } else if (value is double) {
      await _prefs.setDouble('$_prefix$key', value);
    } else if (value is bool) {
      await _prefs.setBool('$_prefix$key', value);
    } else if (value is List<String>) {
      await _prefs.setStringList('$_prefix$key', value);
    } else {
      await _prefs.setString('$_prefix$key', value.toString());
    }
  }

  Future<dynamic> get(String key) async {
    return _prefs.get('$_prefix$key');
  }

  Future<String?> getString(String key) async {
    return _prefs.getString('$_prefix$key');
  }

  Future<int?> getInt(String key) async {
    return _prefs.getInt('$_prefix$key');
  }

  Future<double?> getDouble(String key) async {
    return _prefs.getDouble('$_prefix$key');
  }

  Future<bool?> getBool(String key) async {
    return _prefs.getBool('$_prefix$key');
  }

  Future<List<String>?> getStringList(String key) async {
    return _prefs.getStringList('$_prefix$key');
  }

  Future<void> remove(String key) async {
    await _prefs.remove('$_prefix$key');
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}
