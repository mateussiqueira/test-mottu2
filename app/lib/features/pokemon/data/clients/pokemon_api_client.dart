import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pokemon_model.dart';
import '../models/pokemon_response.dart';

/// Client for interacting with the Pokemon API
class PokemonApiClient {
  final http.Client _client;
  final String _baseUrl = 'https://pokeapi.co/api/v2';

  PokemonApiClient(this._client);

  /// Get a list of Pokemon with pagination
  Future<PokemonResponse> getPokemonList({
    int? offset,
    int? limit,
  }) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/pokemon?limit=${limit ?? 20}&offset=${offset ?? 0}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PokemonResponse.fromJson(data);
    } else {
      throw Exception('Failed to load pokemon list');
    }
  }

  /// Get a Pokemon by ID
  Future<PokemonModel> getPokemonById(int id) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/pokemon/$id'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PokemonModel.fromJson(data);
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  /// Search Pokemon by query
  Future<PokemonResponse> searchPokemon(String query) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/pokemon?limit=1000'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = (data['results'] as List)
          .where((pokemon) => pokemon['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      return PokemonResponse(results: results);
    } else {
      throw Exception('Failed to search pokemons');
    }
  }

  /// Get Pokemon by type
  Future<PokemonResponse> getPokemonsByType(String type) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/type/$type'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results =
          (data['pokemon'] as List).map((p) => p['pokemon']).toList();
      return PokemonResponse(results: results);
    } else {
      throw Exception('Failed to load pokemons by type');
    }
  }

  /// Get Pokemon by ability
  Future<PokemonResponse> getPokemonsByAbility(String ability) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/ability/$ability'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results =
          (data['pokemon'] as List).map((p) => p['pokemon']).toList();
      return PokemonResponse(results: results);
    } else {
      throw Exception('Failed to load pokemons by ability');
    }
  }

  /// Get Pokemon by move
  Future<PokemonResponse> getPokemonsByMove(String move) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/move/$move'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = (data['learned_by_pokemon'] as List).toList();
      return PokemonResponse(results: results);
    } else {
      throw Exception('Failed to load pokemons by move');
    }
  }

  /// Get Pokemon by evolution
  Future<PokemonResponse> getPokemonsByEvolution(String evolution) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/evolution-chain/$evolution'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = await _processEvolutionChain(data['chain']);
      return PokemonResponse(results: results);
    } else {
      throw Exception('Failed to load pokemons by evolution');
    }
  }

  /// Get Pokemon by stat
  Future<PokemonResponse> getPokemonsByStat(String stat, int value) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/pokemon?limit=1000'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = await _filterPokemonsByStat(data['results'], stat, value);
      return PokemonResponse(results: results);
    } else {
      throw Exception('Failed to load pokemons by stat');
    }
  }

  /// Get Pokemon by description
  Future<PokemonResponse> getPokemonsByDescription(String description) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/pokemon-species?limit=1000'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results =
          await _filterPokemonsByDescription(data['results'], description);
      return PokemonResponse(results: results);
    } else {
      throw Exception('Failed to load pokemons by description');
    }
  }

  /// Get Pokemon by name
  Future<PokemonModel> getPokemonByName(String name) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/pokemon/$name'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PokemonModel.fromJson(data);
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  Future<List<dynamic>> _processEvolutionChain(
      Map<String, dynamic> chain) async {
    final List<dynamic> results = [];
    final speciesUrl = chain['species']['url'];
    final speciesResponse = await _client.get(Uri.parse(speciesUrl));

    if (speciesResponse.statusCode == 200) {
      final speciesData = json.decode(speciesResponse.body);
      results.add(speciesData);
    }

    if (chain['evolves_to'] != null && chain['evolves_to'].isNotEmpty) {
      for (var evolution in chain['evolves_to']) {
        results.addAll(await _processEvolutionChain(evolution));
      }
    }

    return results;
  }

  Future<List<dynamic>> _filterPokemonsByStat(
    List<dynamic> pokemons,
    String stat,
    int value,
  ) async {
    final List<dynamic> results = [];

    for (var pokemon in pokemons) {
      final detailResponse = await _client.get(Uri.parse(pokemon['url']));
      if (detailResponse.statusCode == 200) {
        final pokemonData = json.decode(detailResponse.body);
        final stats = pokemonData['stats'];
        final matchingStat = stats.firstWhere(
          (s) => s['stat']['name'] == stat,
          orElse: () => null,
        );

        if (matchingStat != null && matchingStat['base_stat'] >= value) {
          results.add(pokemonData);
        }
      }
    }

    return results;
  }

  Future<List<dynamic>> _filterPokemonsByDescription(
    List<dynamic> species,
    String description,
  ) async {
    final List<dynamic> results = [];

    for (var s in species) {
      final speciesResponse = await _client.get(Uri.parse(s['url']));
      if (speciesResponse.statusCode == 200) {
        final speciesData = json.decode(speciesResponse.body);
        final flavorTextEntries = speciesData['flavor_text_entries'];
        final englishDescription = flavorTextEntries.firstWhere(
          (entry) => entry['language']['name'] == 'en',
          orElse: () => null,
        );

        if (englishDescription != null &&
            englishDescription['flavor_text']
                .toString()
                .toLowerCase()
                .contains(description.toLowerCase())) {
          final pokemonResponse = await _client.get(
            Uri.parse('$_baseUrl/pokemon/${speciesData['id']}'),
          );
          if (pokemonResponse.statusCode == 200) {
            final pokemonData = json.decode(pokemonResponse.body);
            results.add(pokemonData);
          }
        }
      }
    }

    return results;
  }
}
