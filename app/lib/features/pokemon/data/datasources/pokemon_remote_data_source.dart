import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/config/app_config.dart';
import '../../domain/entities/pokemon_entity.dart';

/// Interface for Pokemon remote data source
abstract class PokemonRemoteDataSource {
  /// Get a list of Pokemon
  Future<List<PokemonEntity>> getPokemonList({
    int? limit,
    int? offset,
  });

  /// Get a Pokemon by ID
  Future<PokemonEntity> getPokemonById(int id);

  /// Search Pokemon by name
  Future<List<PokemonEntity>> searchPokemon(String query);

  /// Get Pokemon by type
  Future<List<PokemonEntity>> getPokemonsByType(String type);

  /// Get Pokemon by ability
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability);

  /// Get Pokemon by move
  Future<List<PokemonEntity>> getPokemonsByMove(String move);

  /// Get Pokemon by evolution
  Future<List<PokemonEntity>> getPokemonsByEvolution(String evolution);

  /// Get Pokemon by stat
  Future<List<PokemonEntity>> getPokemonsByStat(String stat, int value);

  /// Get Pokemon by description
  Future<List<PokemonEntity>> getPokemonsByDescription(String description);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client _client;

  PokemonRemoteDataSourceImpl({required http.Client client}) : _client = client;

  @override
  Future<List<PokemonEntity>> getPokemonList({int? limit, int? offset}) async {
    try {
      final response = await _client.get(
        Uri.parse(
            '${AppConfig.baseUrl}/pokemon?limit=${limit ?? AppConfig.defaultLimit}&offset=${offset ?? AppConfig.defaultOffset}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body)['results'];
        final List<PokemonEntity> pokemons = [];

        for (var pokemon in jsonList) {
          final id = int.parse(pokemon['url'].toString().split('/')[6]);
          final detail = await getPokemonById(id);
          pokemons.add(detail);
        }

        return pokemons;
      }
      throw Exception('Failed to load pokemons: ${response.statusCode}');
    } catch (e) {
      throw Exception('Network error while fetching pokemon list: $e');
    }
  }

  @override
  Future<PokemonEntity> getPokemonById(int id) async {
    try {
      final response = await _client.get(
        Uri.parse('${AppConfig.baseUrl}/pokemon/$id'),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return PokemonEntity.fromJson(json);
      }
      throw Exception('Failed to load pokemon details: ${response.statusCode}');
    } catch (e) {
      throw Exception('Network error while fetching pokemon details: $e');
    }
  }

  @override
  Future<List<PokemonEntity>> searchPokemon(String query) async {
    try {
      final response = await _client.get(
        Uri.parse('${AppConfig.baseUrl}/pokemon/$query'),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return [PokemonEntity.fromJson(json)];
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByType(String type) async {
    try {
      final response = await _client.get(
        Uri.parse('${AppConfig.baseUrl}/type/$type'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body)['pokemon'];
        final List<PokemonEntity> pokemons = [];

        for (var pokemon in jsonList) {
          final id =
              int.parse(pokemon['pokemon']['url'].toString().split('/')[6]);
          final detail = await getPokemonById(id);
          pokemons.add(detail);
        }

        return pokemons;
      }
      throw Exception(
          'Failed to load pokemons by type: ${response.statusCode}');
    } catch (e) {
      throw Exception('Network error while fetching pokemon by type: $e');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability) async {
    try {
      final response = await _client.get(
        Uri.parse('${AppConfig.baseUrl}/ability/$ability'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body)['pokemon'];
        final List<PokemonEntity> pokemons = [];

        for (var pokemon in jsonList) {
          final id =
              int.parse(pokemon['pokemon']['url'].toString().split('/')[6]);
          final detail = await getPokemonById(id);
          pokemons.add(detail);
        }

        return pokemons;
      }
      throw Exception(
          'Failed to load pokemons by ability: ${response.statusCode}');
    } catch (e) {
      throw Exception('Network error while fetching pokemon by ability: $e');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByMove(String move) async {
    final response = await _client.get(
      Uri.parse('${AppConfig.baseUrl}/move/$move'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
          json.decode(response.body)['learned_by_pokemon'];
      final List<PokemonEntity> pokemons = [];

      for (var pokemon in jsonList) {
        final id = int.parse(pokemon['url'].toString().split('/')[6]);
        final detail = await getPokemonById(id);
        pokemons.add(detail);
      }

      return pokemons;
    } else {
      throw Exception('Failed to load pokemons by move');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByEvolution(String evolution) async {
    final response = await _client.get(
      Uri.parse('${AppConfig.baseUrl}/evolution-chain/$evolution'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
          json.decode(response.body)['chain']['evolves_to'];
      final List<PokemonEntity> pokemons = [];

      for (var pokemon in jsonList) {
        final id =
            int.parse(pokemon['species']['url'].toString().split('/')[6]);
        final detail = await getPokemonById(id);
        pokemons.add(detail);
      }

      return pokemons;
    } else {
      throw Exception('Failed to load pokemons by evolution');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByStat(String stat, int value) async {
    final response = await _client.get(
      Uri.parse('${AppConfig.baseUrl}/pokemon?limit=1118'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['results'];
      final List<PokemonEntity> pokemons = [];

      for (var pokemon in jsonList) {
        final id = int.parse(pokemon['url'].toString().split('/')[6]);
        final detail = await getPokemonById(id);
        if (detail.stats[stat] == value) {
          pokemons.add(detail);
        }
      }

      return pokemons;
    } else {
      throw Exception('Failed to load pokemons by stat');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByDescription(
      String description) async {
    final response = await _client.get(
      Uri.parse('${AppConfig.baseUrl}/pokemon-species?limit=1118'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['results'];
      final List<PokemonEntity> pokemons = [];

      for (var species in jsonList) {
        final id = int.parse(species['url'].toString().split('/')[6]);
        final detail = await getPokemonById(id);
        if (detail.description
            .toLowerCase()
            .contains(description.toLowerCase())) {
          pokemons.add(detail);
        }
      }

      return pokemons;
    } else {
      throw Exception('Failed to load pokemons by description');
    }
  }
}
