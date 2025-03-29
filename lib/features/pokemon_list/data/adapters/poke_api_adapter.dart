import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/pokemon_model.dart';

class PokeApiAdapter {
  final http.Client client;
  final SharedPreferences _prefs;
  static const String _baseUrl = 'https://pokeapi.co/api/v2';
  static const Duration _cacheDuration = Duration(hours: 24);

  PokeApiAdapter({
    required this.client,
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  Future<List<PokemonModel>> getPokemons(
      {int limit = 20, int offset = 0}) async {
    final cacheKey = 'pokemons_${limit}_$offset';
    final cachedData = _prefs.getString(cacheKey);
    final cachedTimestamp = _prefs.getInt('${cacheKey}_timestamp');

    if (cachedData != null &&
        cachedTimestamp != null &&
        DateTime.now().millisecondsSinceEpoch - cachedTimestamp <
            _cacheDuration.inMilliseconds) {
      final List<dynamic> data = json.decode(cachedData);
      return data.map((json) => PokemonModel.fromJson(json)).toList();
    }

    final response = await client.get(
      Uri.parse('$_baseUrl/pokemon?limit=$limit&offset=$offset'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      final List<PokemonModel> pokemons = [];

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

  Future<PokemonModel> getPokemonById(int id) async {
    final cacheKey = 'pokemon_$id';
    final cachedData = _prefs.getString(cacheKey);
    final cachedTimestamp = _prefs.getInt('${cacheKey}_timestamp');

    if (cachedData != null &&
        cachedTimestamp != null &&
        DateTime.now().millisecondsSinceEpoch - cachedTimestamp <
            _cacheDuration.inMilliseconds) {
      return PokemonModel.fromJson(json.decode(cachedData));
    }

    final response = await client.get(
      Uri.parse('$_baseUrl/pokemon/$id'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final pokemon = PokemonModel.fromJson(data);

      await _prefs.setString(cacheKey, json.encode(pokemon.toJson()));
      await _prefs.setInt(
          '${cacheKey}_timestamp', DateTime.now().millisecondsSinceEpoch);

      return pokemon;
    }

    throw Exception('Falha ao buscar Pokémon: ${response.statusCode}');
  }

  Future<List<PokemonModel>> searchPokemons(String query) async {
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/pokemon?limit=1118'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        final List<PokemonModel> pokemons = [];

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
