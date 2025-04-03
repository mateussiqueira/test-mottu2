import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/domain/errors/pokemon_error.dart';
import '../../../features/pokemon/data/models/pokemon_model.dart';
import '../../../features/pokemon/domain/entities/i_pokemon_entity.dart';
import 'i_pokemon_cache_manager.dart';

class PokemonCacheManager implements IPokemonCacheManager {
  static const String _pokemonListKey = 'pokemon_list';
  static const String _pokemonDetailKey = 'pokemon_detail_';
  static const Duration _cacheDuration = Duration(hours: 1);

  final SharedPreferences _prefs;

  PokemonCacheManager(this._prefs);

  @override
  Future<void> savePokemonList(List<IPokemonEntity> pokemons) async {
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

  @override
  Future<List<IPokemonEntity>?> getPokemonList() async {
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
      return jsonList
          .map((json) => PokemonModel.fromJson(json) as IPokemonEntity)
          .toList();
    } catch (e) {
      throw CacheError();
    }
  }

  @override
  Future<void> savePokemonDetail(IPokemonEntity pokemon) async {
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

  @override
  Future<IPokemonEntity?> getPokemonDetail(int id) async {
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
      return PokemonModel.fromJson(json) as IPokemonEntity;
    } catch (e) {
      throw CacheError();
    }
  }

  @override
  Future<void> clearPokemonList() async {
    try {
      await _prefs.remove(_pokemonListKey);
      await _prefs.remove('${_pokemonListKey}_timestamp');
    } catch (e) {
      throw CacheError();
    }
  }

  @override
  Future<void> clearPokemonDetail(int id) async {
    try {
      final key = '$_pokemonDetailKey$id';
      await _prefs.remove(key);
      await _prefs.remove('${key}_timestamp');
    } catch (e) {
      throw CacheError();
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await _prefs.clear();
    } catch (e) {
      throw CacheError();
    }
  }
}
