import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/cache_service.dart';
import '../../domain/entities/pokemon.dart';

class PokeApiAdapter {
  static const String _baseUrl = 'https://pokeapi.co/api/v2';
  final http.Client _client;
  final SharedPreferences _prefs;
  final CacheService _cacheService;

  PokeApiAdapter({
    required http.Client client,
    required SharedPreferences prefs,
  })  : _client = client,
        _prefs = prefs,
        _cacheService = CacheService(prefs);

  Future<List<Pokemon>> getPokemons({int offset = 0, int limit = 20}) async {
    try {
      // Tenta obter do cache primeiro
      final cachedData = await _cacheService.getCachedPokemonList();
      if (cachedData != null) {
        return cachedData.map((json) => Pokemon.fromJson(json)).toList();
      }

      final response = await _client.get(
        Uri.parse('$_baseUrl/pokemon?offset=$offset&limit=$limit'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        final pokemons = <Pokemon>[];

        for (var result in results) {
          final pokemon = await getPokemonById(result['name']);
          pokemons.add(pokemon);
        }

        // Salva no cache
        await _cacheService.cachePokemonList(
          pokemons.map((p) => p.toJson()).toList(),
        );

        return pokemons;
      } else {
        throw Exception('Failed to load pokemons');
      }
    } catch (e) {
      throw Exception('Error fetching pokemons: $e');
    }
  }

  Future<Pokemon> getPokemonById(String id) async {
    try {
      // Tenta obter do cache primeiro
      final cachedData = await _cacheService.getCachedPokemonDetail(id);
      if (cachedData != null) {
        return Pokemon.fromJson(cachedData);
      }

      final response = await _client.get(
        Uri.parse('$_baseUrl/pokemon/$id'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final pokemon = Pokemon(
          id: data['id'].toString(),
          name: data['name'],
          imageUrl: data['sprites']['front_default'],
          types: (data['types'] as List)
              .map((type) => type['type']['name'] as String)
              .toList(),
          abilities: (data['abilities'] as List)
              .map((ability) => ability['ability']['name'] as String)
              .toList(),
          stats: Map.fromEntries(
            (data['stats'] as List).map(
              (stat) => MapEntry(
                stat['stat']['name'] as String,
                stat['base_stat'] as int,
              ),
            ),
          ),
          height: data['height'] / 10, // Converte para metros
          weight: data['weight'] / 10, // Converte para kg
          evolutionChain: [], // Será preenchido em uma chamada separada
          locations: [], // Será preenchido em uma chamada separada
        );

        // Salva no cache
        await _cacheService.cachePokemonDetail(id, pokemon.toJson());

        return pokemon;
      } else {
        throw Exception('Failed to load pokemon');
      }
    } catch (e) {
      throw Exception('Error fetching pokemon: $e');
    }
  }

  Future<List<Pokemon>> searchPokemons(String query) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/pokemon?limit=1118'), // Limite máximo da API
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        final matches = results
            .where((result) => result['name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();

        final pokemons = <Pokemon>[];
        for (var match in matches) {
          final pokemon = await getPokemonById(match['name']);
          pokemons.add(pokemon);
        }

        return pokemons;
      } else {
        throw Exception('Failed to search pokemons');
      }
    } catch (e) {
      throw Exception('Error searching pokemons: $e');
    }
  }
}
