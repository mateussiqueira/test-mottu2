import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';

class PokeApiAdapter implements PokemonRepository {
  final http.Client client;
  final SharedPreferences _prefs;
  static const String _baseUrl = 'https://pokeapi.co/api/v2';
  static const Duration _cacheDuration = Duration(hours: 24);

  PokeApiAdapter({
    required this.client,
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  @override
  Future<List<Pokemon>> getPokemons({int limit = 20, int offset = 0}) async {
    final cacheKey = 'pokemons_${limit}_$offset';
    final cachedData = _prefs.getString(cacheKey);
    final cachedTimestamp = _prefs.getInt('${cacheKey}_timestamp');

    if (cachedData != null &&
        cachedTimestamp != null &&
        DateTime.now().millisecondsSinceEpoch - cachedTimestamp <
            _cacheDuration.inMilliseconds) {
      final List<dynamic> data = json.decode(cachedData);
      return data.map((json) => Pokemon.fromJson(json)).toList();
    }

    final response = await client.get(
      Uri.parse('$_baseUrl/pokemon?limit=$limit&offset=$offset'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      final List<Pokemon> pokemons = [];

      for (var result in results) {
        final urlParts = result['url'].split('/');
        final id = int.parse(urlParts[urlParts.length - 2]);
        final pokemon = await getPokemonById(id);
        pokemons.add(pokemon);
      }

      await _prefs.setString(
          cacheKey, json.encode(pokemons.map((p) => p.toJson()).toList()));
      await _prefs.setInt(
          '${cacheKey}_timestamp', DateTime.now().millisecondsSinceEpoch);

      return pokemons;
    }

    throw Exception('Falha ao buscar Pokémon: ${response.statusCode}');
  }

  @override
  Future<Pokemon> getPokemonByName(String name) async {
    final cacheKey = 'pokemon_name_$name';
    final cachedData = _prefs.getString(cacheKey);
    final cachedTimestamp = _prefs.getInt('${cacheKey}_timestamp');

    if (cachedData != null &&
        cachedTimestamp != null &&
        DateTime.now().millisecondsSinceEpoch - cachedTimestamp <
            _cacheDuration.inMilliseconds) {
      return Pokemon.fromJson(json.decode(cachedData));
    }

    final response = await client.get(
      Uri.parse('$_baseUrl/pokemon/$name'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final pokemon = Pokemon.fromJson(data);

      await _prefs.setString(cacheKey, json.encode(pokemon.toJson()));
      await _prefs.setInt(
          '${cacheKey}_timestamp', DateTime.now().millisecondsSinceEpoch);

      return pokemon;
    }

    throw Exception('Falha ao buscar Pokémon: ${response.statusCode}');
  }

  @override
  Future<List<Pokemon>> getPokemonsByType(String type) async {
    final cacheKey = 'pokemons_type_$type';
    final cachedData = _prefs.getString(cacheKey);
    final cachedTimestamp = _prefs.getInt('${cacheKey}_timestamp');

    if (cachedData != null &&
        cachedTimestamp != null &&
        DateTime.now().millisecondsSinceEpoch - cachedTimestamp <
            _cacheDuration.inMilliseconds) {
      final List<dynamic> data = json.decode(cachedData);
      return data.map((json) => Pokemon.fromJson(json)).toList();
    }

    final response = await client.get(
      Uri.parse('$_baseUrl/type/$type'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> pokemons = data['pokemon'];
      final List<Pokemon> result = [];

      for (var pokemon in pokemons) {
        final urlParts = pokemon['pokemon']['url'].split('/');
        final id = int.parse(urlParts[urlParts.length - 2]);
        final pokemonData = await getPokemonById(id);
        result.add(pokemonData);
      }

      await _prefs.setString(
          cacheKey, json.encode(result.map((p) => p.toJson()).toList()));
      await _prefs.setInt(
          '${cacheKey}_timestamp', DateTime.now().millisecondsSinceEpoch);

      return result;
    }

    throw Exception('Falha ao buscar Pokémon: ${response.statusCode}');
  }

  @override
  Future<List<Pokemon>> getPokemonsByAbility(String ability) async {
    final cacheKey = 'pokemons_ability_$ability';
    final cachedData = _prefs.getString(cacheKey);
    final cachedTimestamp = _prefs.getInt('${cacheKey}_timestamp');

    if (cachedData != null &&
        cachedTimestamp != null &&
        DateTime.now().millisecondsSinceEpoch - cachedTimestamp <
            _cacheDuration.inMilliseconds) {
      final List<dynamic> data = json.decode(cachedData);
      return data.map((json) => Pokemon.fromJson(json)).toList();
    }

    final response = await client.get(
      Uri.parse('$_baseUrl/ability/$ability'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> pokemons = data['pokemon'];
      final List<Pokemon> result = [];

      for (var pokemon in pokemons) {
        final urlParts = pokemon['pokemon']['url'].split('/');
        final id = int.parse(urlParts[urlParts.length - 2]);
        final pokemonData = await getPokemonById(id);
        result.add(pokemonData);
      }

      await _prefs.setString(
          cacheKey, json.encode(result.map((p) => p.toJson()).toList()));
      await _prefs.setInt(
          '${cacheKey}_timestamp', DateTime.now().millisecondsSinceEpoch);

      return result;
    }

    throw Exception('Falha ao buscar Pokémon: ${response.statusCode}');
  }

  @override
  Future<void> clearCache() async {
    final keys = _prefs.getKeys();
    for (var key in keys) {
      if (key.startsWith('pokemon_') || key.endsWith('_timestamp')) {
        await _prefs.remove(key);
      }
    }
  }

  @override
  Future<Pokemon> getPokemonById(int id) async {
    final cacheKey = 'pokemon_$id';
    final cachedData = _prefs.getString(cacheKey);
    final cachedTimestamp = _prefs.getInt('${cacheKey}_timestamp');

    if (cachedData != null &&
        cachedTimestamp != null &&
        DateTime.now().millisecondsSinceEpoch - cachedTimestamp <
            _cacheDuration.inMilliseconds) {
      return Pokemon.fromJson(json.decode(cachedData));
    }

    final response = await client.get(
      Uri.parse('$_baseUrl/pokemon/$id'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final pokemon = Pokemon.fromJson(data);

      await _prefs.setString(cacheKey, json.encode(pokemon.toJson()));
      await _prefs.setInt(
          '${cacheKey}_timestamp', DateTime.now().millisecondsSinceEpoch);

      return pokemon;
    }

    throw Exception('Falha ao buscar Pokémon: ${response.statusCode}');
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
      evolutionChain: List<String>.from(
        (data['evolution_chain'] as List?)
                ?.map((chain) => chain['name'] as String) ??
            [],
      ),
      locations: List<String>.from(
        (data['locations'] as List?)
                ?.map((location) => location['name'] as String) ??
            [],
      ),
      height: (data['height'] as num) / 10,
      weight: (data['weight'] as num) / 10,
    );
  }

  static List<Pokemon> fromJsonList(List<Map<String, dynamic>> dataList) {
    return dataList.map((data) => fromJson(data)).toList();
  }

  @override
  Future<List<Pokemon>> searchPokemons(String query) async {
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/pokemon?limit=1118'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        final List<Pokemon> pokemons = [];

        for (var result in results) {
          if (result['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase())) {
            final urlParts = result['url'].split('/');
            final id = int.parse(urlParts[urlParts.length - 2]);
            final pokemon = await getPokemonById(id);
            pokemons.add(pokemon);
          }
        }

        return pokemons;
      }

      throw Exception('Falha ao buscar Pokémon: ${response.statusCode}');
    } catch (e) {
      throw Exception('Falha ao buscar Pokémon: $e');
    }
  }
}
