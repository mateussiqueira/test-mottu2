import 'package:shared_preferences/shared_preferences.dart';

import 'i_resource_manager.dart';

class SharedPreferencesResourceManager implements IResourceManager {
  final SharedPreferences _prefs;
  final String _prefix;

  SharedPreferencesResourceManager({
    required SharedPreferences prefs,
    required String prefix,
  })  : _prefs = prefs,
        _prefix = prefix;

  @override
  Future<void> saveString(String key, String value) async {
    await _prefs.setString('$_prefix$key', value);
  }

  @override
  Future<String?> getString(String key) async {
    return _prefs.getString('$_prefix$key');
  }

  @override
  Future<void> saveInt(String key, int value) async {
    await _prefs.setInt('$_prefix$key', value);
  }

  @override
  Future<int?> getInt(String key) async {
    return _prefs.getInt('$_prefix$key');
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool('$_prefix$key', value);
  }

  @override
  Future<bool?> getBool(String key) async {
    return _prefs.getBool('$_prefix$key');
  }

  @override
  Future<void> saveDouble(String key, double value) async {
    await _prefs.setDouble('$_prefix$key', value);
  }

  @override
  Future<double?> getDouble(String key) async {
    return _prefs.getDouble('$_prefix$key');
  }

  @override
  Future<void> saveStringList(String key, List<String> value) async {
    await _prefs.setStringList('$_prefix$key', value);
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    return _prefs.getStringList('$_prefix$key');
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
  Future<bool> containsKey(String key) async {
    return _prefs.containsKey('$_prefix$key');
  }
}
