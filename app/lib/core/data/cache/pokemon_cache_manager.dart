import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/domain/errors/pokemon_error.dart';
import '../../../features/pokemon/domain/entities/pokemon_entity.dart';

/// Classe para gerenciar o cache dos Pokemons
class PokemonCacheManager {
  static const String _pokemonListKey = 'pokemon_list';
  static const String _pokemonDetailKey = 'pokemon_detail_';
  static const Duration _cacheDuration = Duration(hours: 1);

  final SharedPreferences _prefs;

  PokemonCacheManager(this._prefs);

  /// Salva a lista de Pokemons no cache
  Future<void> savePokemonList(List<PokemonEntityImpl> pokemons) async {
    try {
      final jsonList = pokemons.map((pokemon) => pokemon.toJson()).toList();
      await _prefs.setString(_pokemonListKey, jsonEncode(jsonList));
      await _prefs.setString(
        '${_pokemonListKey}_timestamp',
        DateTime.now().toIso8601String(),
      );
    } catch (e) {
      throw CacheError();
    }
  }

  /// Recupera a lista de Pokemons do cache
  Future<List<PokemonEntityImpl>?> getPokemonList() async {
    try {
      final jsonString = _prefs.getString(_pokemonListKey);
      final timestampString = _prefs.getString('${_pokemonListKey}_timestamp');

      if (jsonString == null || timestampString == null) {
        return null;
      }

      final timestamp = DateTime.parse(timestampString);
      if (DateTime.now().difference(timestamp) > _cacheDuration) {
        await clearPokemonList();
        return null;
      }

      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => PokemonEntityImpl.fromJson(json)).toList();
    } catch (e) {
      throw CacheError();
    }
  }

  /// Salva os detalhes de um Pokemon no cache
  Future<void> savePokemonDetail(PokemonEntityImpl pokemon) async {
    try {
      final key = '$_pokemonDetailKey${pokemon.id}';
      await _prefs.setString(key, jsonEncode(pokemon.toJson()));
      await _prefs.setString(
        '${key}_timestamp',
        DateTime.now().toIso8601String(),
      );
    } catch (e) {
      throw CacheError();
    }
  }

  /// Recupera os detalhes de um Pokemon do cache
  Future<PokemonEntityImpl?> getPokemonDetail(int id) async {
    try {
      final key = '$_pokemonDetailKey$id';
      final jsonString = _prefs.getString(key);
      final timestampString = _prefs.getString('${key}_timestamp');

      if (jsonString == null || timestampString == null) {
        return null;
      }

      final timestamp = DateTime.parse(timestampString);
      if (DateTime.now().difference(timestamp) > _cacheDuration) {
        await clearPokemonDetail(id);
        return null;
      }

      final json = jsonDecode(jsonString);
      return PokemonEntityImpl.fromJson(json);
    } catch (e) {
      throw CacheError();
    }
  }

  /// Limpa a lista de Pokemons do cache
  Future<void> clearPokemonList() async {
    try {
      await _prefs.remove(_pokemonListKey);
      await _prefs.remove('${_pokemonListKey}_timestamp');
    } catch (e) {
      throw CacheError();
    }
  }

  /// Limpa os detalhes de um Pokemon do cache
  Future<void> clearPokemonDetail(int id) async {
    try {
      final key = '$_pokemonDetailKey$id';
      await _prefs.remove(key);
      await _prefs.remove('${key}_timestamp');
    } catch (e) {
      throw CacheError();
    }
  }

  /// Limpa todo o cache
  Future<void> clearAll() async {
    try {
      await _prefs.clear();
    } catch (e) {
      throw CacheError();
    }
  }
}
