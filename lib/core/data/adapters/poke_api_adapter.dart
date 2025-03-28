import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';

class PokeApiAdapter implements PokemonRepository {
  static const String _baseUrl = 'https://pokeapi.co/api/v2';
  static const String _cacheKey = 'pokemon_cache';
  static const Duration _cacheDuration = Duration(hours: 1);

  @override
  Future<List<Pokemon>> getPokemons({int limit = 20, int offset = 0}) async {
    final cacheKey = '${_cacheKey}_list_${limit}_$offset';
    final cachedData = await _getCachedData(cacheKey);
    if (cachedData != null) {
      return _parsePokemonList(cachedData);
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/pokemon?limit=$limit&offset=$offset'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      await _cacheData(cacheKey, data);
      return _parsePokemonList(data);
    }

    throw Exception('Failed to load pokemons');
  }

  @override
  Future<Pokemon> getPokemonByName(String name) async {
    final cacheKey = '${_cacheKey}_$name';
    final cachedData = await _getCachedData(cacheKey);
    if (cachedData != null) {
      return _parsePokemon(cachedData);
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/pokemon/$name'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      await _cacheData(cacheKey, data);
      return _parsePokemon(data);
    }

    throw Exception('Failed to load pokemon');
  }

  @override
  Future<List<Pokemon>> getPokemonsByType(String type) async {
    final cacheKey = '${_cacheKey}_type_$type';
    final cachedData = await _getCachedData(cacheKey);
    if (cachedData != null) {
      return _parsePokemonList(cachedData);
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/type/$type'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      await _cacheData(cacheKey, data);
      return _parsePokemonList(data);
    }

    throw Exception('Failed to load pokemons by type');
  }

  @override
  Future<List<Pokemon>> getPokemonsByAbility(String ability) async {
    final cacheKey = '${_cacheKey}_ability_$ability';
    final cachedData = await _getCachedData(cacheKey);
    if (cachedData != null) {
      return _parsePokemonList(cachedData);
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/ability/$ability'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      await _cacheData(cacheKey, data);
      return _parsePokemonList(data);
    }

    throw Exception('Failed to load pokemons by ability');
  }

  @override
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    for (final key in keys) {
      if (key.startsWith(_cacheKey)) {
        await prefs.remove(key);
      }
    }
  }

  Future<Map<String, dynamic>?> _getCachedData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedJson = prefs.getString(key);
    if (cachedJson != null) {
      final cachedData = json.decode(cachedJson);
      final timestamp = DateTime.parse(cachedData['timestamp']);
      if (DateTime.now().difference(timestamp) < _cacheDuration) {
        return cachedData['data'];
      }
    }
    return null;
  }

  Future<void> _cacheData(String key, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheData = {
      'timestamp': DateTime.now().toIso8601String(),
      'data': data,
    };
    await prefs.setString(key, json.encode(cacheData));
  }

  List<Pokemon> _parsePokemonList(Map<String, dynamic> data) {
    final results = data['results'] as List;
    return results.map((result) {
      final id = int.parse(result['url'].split('/').reversed.elementAt(1));
      return Pokemon(
        id: id,
        name: result['name'],
        types: const [],
        abilities: const [],
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
      );
    }).toList();
  }

  Pokemon _parsePokemon(Map<String, dynamic> data) {
    return Pokemon(
      id: data['id'],
      name: data['name'],
      types: (data['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      abilities: (data['abilities'] as List)
          .map((ability) => ability['ability']['name'] as String)
          .toList(),
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${data['id']}.png',
    );
  }

  static Pokemon fromJson(Map<String, dynamic> data) {
    return Pokemon(
      id: data['id'],
      name: data['name'],
      imageUrl: data['sprites']['other']['official-artwork']['front_default'],
      types: List<String>.from(
        (data['types'] as List).map((type) => type['type']['name'] as String),
      ),
      stats: List<Map<String, dynamic>>.from(
        (data['stats'] as List).map(
          (stat) => {
            'name': stat['stat']['name'],
            'value': stat['base_stat'],
          },
        ),
      ),
      abilities: List<String>.from(
        (data['abilities'] as List)
            .map((ability) => ability['ability']['name'] as String),
      ),
      moves: List<String>.from(
        (data['moves'] as List).map((move) => move['move']['name'] as String),
      ),
      evolutionChain:
          List<Map<String, dynamic>>.from(data['evolution_chain'] ?? []),
      locations: List<Map<String, dynamic>>.from(data['locations'] ?? []),
      height: (data['height'] as num) / 10,
      weight: (data['weight'] as num) / 10,
    );
  }

  static List<Pokemon> fromJsonList(List<Map<String, dynamic>> dataList) {
    return dataList.map((data) => fromJson(data)).toList();
  }
}
