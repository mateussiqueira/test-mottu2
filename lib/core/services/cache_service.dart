import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static const String _pokemonListKey = 'pokemon_list';
  static const String _pokemonDetailKey = 'pokemon_detail_';
  static const Duration _cacheDuration = Duration(hours: 24);

  final SharedPreferences _prefs;

  CacheService(this._prefs);

  Future<void> cachePokemonList(List<dynamic> pokemons) async {
    final data = {
      'timestamp': DateTime.now().toIso8601String(),
      'data': pokemons,
    };
    await _prefs.setString(_pokemonListKey, jsonEncode(data));
  }

  Future<List<dynamic>?> getCachedPokemonList() async {
    final jsonString = _prefs.getString(_pokemonListKey);
    if (jsonString == null) return null;

    final data = jsonDecode(jsonString);
    final timestamp = DateTime.parse(data['timestamp']);
    if (DateTime.now().difference(timestamp) > _cacheDuration) {
      await _prefs.remove(_pokemonListKey);
      return null;
    }

    return data['data'];
  }

  Future<void> cachePokemonDetail(
      String id, Map<String, dynamic> pokemon) async {
    final data = {
      'timestamp': DateTime.now().toIso8601String(),
      'data': pokemon,
    };
    await _prefs.setString('$_pokemonDetailKey$id', jsonEncode(data));
  }

  Future<Map<String, dynamic>?> getCachedPokemonDetail(String id) async {
    final jsonString = _prefs.getString('$_pokemonDetailKey$id');
    if (jsonString == null) return null;

    final data = jsonDecode(jsonString);
    final timestamp = DateTime.parse(data['timestamp']);
    if (DateTime.now().difference(timestamp) > _cacheDuration) {
      await _prefs.remove('$_pokemonDetailKey$id');
      return null;
    }

    return data['data'];
  }

  Future<void> clearCache() async {
    await _prefs.clear();
  }
}
