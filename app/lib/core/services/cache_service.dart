import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_lifecycle_observer.dart';

class CacheService {
  final SharedPreferences preferences;
  static const _pokemonsKey = 'pokemons';
  static const _pokemonsTimestampKey = 'pokemons_timestamp';
  static const _cacheExpirationHours = 1;

  CacheService({required this.preferences});

  Future<void> savePokemons(List<Map<String, dynamic>> pokemons) async {
    await preferences.setString(_pokemonsKey, jsonEncode(pokemons));
    await preferences.setInt(
      _pokemonsTimestampKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<List<Map<String, dynamic>>?> getPokemons() async {
    final timestamp = preferences.getInt(_pokemonsTimestampKey);
    if (timestamp == null) return null;

    final expirationDate = DateTime.fromMillisecondsSinceEpoch(timestamp)
        .add(const Duration(hours: _cacheExpirationHours));
    if (DateTime.now().isAfter(expirationDate)) return null;

    final data = preferences.getString(_pokemonsKey);
    if (data == null) return null;

    try {
      final List<dynamic> decodedData = jsonDecode(data);
      return decodedData.cast<Map<String, dynamic>>();
    } catch (e) {
      return null;
    }
  }

  Future<void> clearPokemons() async {
    await preferences.remove(_pokemonsKey);
    await preferences.remove(_pokemonsTimestampKey);
  }

  Future<void> clearCache() async {
    final keys = preferences.getKeys();
    for (final key in keys) {
      if (key.startsWith('pokemon_') || key.startsWith('pokemons_')) {
        await preferences.remove(key);
      }
    }
  }

  Future<void> clearAll() async {
    await preferences.clear();
  }
  
  Future<void> setupCacheClearOnAppClose() async {
    WidgetsBinding.instance.addObserver(AppLifecycleObserver(
      onDetach: () async => await clearCache(),
      onHidden: () async => await clearCache(),
    ));
  }
}
