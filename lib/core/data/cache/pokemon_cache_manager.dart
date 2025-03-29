import 'dart:convert';

import 'package:pokeapi/core/domain/entities/pokemon_entity.dart';
import 'package:pokeapi/core/domain/errors/pokemon_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Classe para gerenciar o cache dos Pokemons
class PokemonCacheManager {
  static const String _pokemonListKey = 'pokemon_list';
  static const String _pokemonDetailKey = 'pokemon_detail_';
  static const Duration _cacheDuration = Duration(hours: 1);

  final SharedPreferences _prefs;

  PokemonCacheManager(this._prefs);

  /// Salva a lista de Pokemons no cache
  Future<void> savePokemonList(List<PokemonEntity> pokemons) async {
    try {
      final jsonList = pokemons.map((pokemon) => pokemon.toJson()).toList();
      await _prefs.setString(_pokemonListKey, jsonEncode(jsonList));
      await _prefs.setString(
        '${_pokemonListKey}_timestamp',
        DateTime.now().toIso8601String(),
      );
    } catch (e) {
      throw CacheError(
        message: 'Failed to save pokemon list to cache',
        code: 'SAVE_LIST_ERROR',
        originalError: e,
      );
    }
  }

  /// Recupera a lista de Pokemons do cache
  Future<List<PokemonEntity>?> getPokemonList() async {
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
      return jsonList.map((json) => PokemonEntity.fromJson(json)).toList();
    } catch (e) {
      throw CacheError(
        message: 'Failed to get pokemon list from cache',
        code: 'GET_LIST_ERROR',
        originalError: e,
      );
    }
  }

  /// Salva os detalhes de um Pokemon no cache
  Future<void> savePokemonDetail(PokemonEntity pokemon) async {
    try {
      final key = '$_pokemonDetailKey${pokemon.id}';
      await _prefs.setString(key, jsonEncode(pokemon.toJson()));
      await _prefs.setString(
        '${key}_timestamp',
        DateTime.now().toIso8601String(),
      );
    } catch (e) {
      throw CacheError(
        message: 'Failed to save pokemon detail to cache',
        code: 'SAVE_DETAIL_ERROR',
        originalError: e,
      );
    }
  }

  /// Recupera os detalhes de um Pokemon do cache
  Future<PokemonEntity?> getPokemonDetail(int id) async {
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
      return PokemonEntity.fromJson(json);
    } catch (e) {
      throw CacheError(
        message: 'Failed to get pokemon detail from cache',
        code: 'GET_DETAIL_ERROR',
        originalError: e,
      );
    }
  }

  /// Limpa a lista de Pokemons do cache
  Future<void> clearPokemonList() async {
    try {
      await _prefs.remove(_pokemonListKey);
      await _prefs.remove('${_pokemonListKey}_timestamp');
    } catch (e) {
      throw CacheError(
        message: 'Failed to clear pokemon list from cache',
        code: 'CLEAR_LIST_ERROR',
        originalError: e,
      );
    }
  }

  /// Limpa os detalhes de um Pokemon do cache
  Future<void> clearPokemonDetail(int id) async {
    try {
      final key = '$_pokemonDetailKey$id';
      await _prefs.remove(key);
      await _prefs.remove('${key}_timestamp');
    } catch (e) {
      throw CacheError(
        message: 'Failed to clear pokemon detail from cache',
        code: 'CLEAR_DETAIL_ERROR',
        originalError: e,
      );
    }
  }

  /// Limpa todo o cache
  Future<void> clearAll() async {
    try {
      await _prefs.clear();
    } catch (e) {
      throw CacheError(
        message: 'Failed to clear all cache',
        code: 'CLEAR_ALL_ERROR',
        originalError: e,
      );
    }
  }
}
