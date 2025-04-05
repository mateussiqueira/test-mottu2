import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  final SharedPreferences _prefs;
  final Duration _cacheDuration = const Duration(hours: 24);

  CacheService(this._prefs);

  Future<bool> saveData(String key, Map<String, dynamic> data) async {
    final cacheData = {
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
    return await _prefs.setString(key, json.encode(cacheData));
  }

  Future<Map<String, dynamic>?> getData(String key) async {
    final cachedData = _prefs.getString(key);
    if (cachedData == null) {
      return null;
    }

    final Map<String, dynamic> decodedCache = json.decode(cachedData);
    final timestamp = decodedCache['timestamp'] as int;
    final cacheDateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    if (DateTime.now().difference(cacheDateTime) > _cacheDuration) {
      // Cache expirado
      await _prefs.remove(key);
      return null;
    }

    return decodedCache['data'];
  }

  Future<bool> clearCache() async {
    return await _prefs.clear();
  }
}