import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/config/app_config.dart';
import '../../domain/entities/pokemon_entity.dart';
import 'i_pokemon_remote_datasource.dart';
import 'pokemon_api_response.dart';
import 'pokemon_api_urls.dart';

/// Implementation of the Pokemon remote data source using HTTP client
class PokemonRemoteDataSource implements IPokemonRemoteDataSource {
  final http.Client _client;

  PokemonRemoteDataSource({required http.Client client}) : _client = client;

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
  Future<List<PokemonEntity>> searchPokemons(String query) async {
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
  Future<List<PokemonEntity>> getPokemonsByMove(String move) async {
    try {
      final response = await _client.get(
        Uri.parse('${PokemonApiUrls.baseUrl}/move/$move'),
      );
      final apiResponse = PokemonApiResponse(response);

      if (apiResponse.isSuccess) {
        final pokemonList = apiResponse.data['learned_by_pokemon'] as List;
        final pokemons = await Future.wait(
          pokemonList.map((pokemon) => getPokemonById(pokemon['name'])),
        );
        return pokemons.whereType<PokemonEntity>().toList();
      }
      throw Exception(
          'Failed to fetch pokemon by move: ${response.statusCode}');
    } catch (e) {
      throw Exception('Network error while fetching pokemon by move: $e');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByEvolution(String evolution) async {
    try {
      final response = await _client.get(
        Uri.parse('${PokemonApiUrls.baseUrl}/evolution-chain/$evolution'),
      );
      final apiResponse = PokemonApiResponse(response);

      if (apiResponse.isSuccess) {
        final pokemonList = apiResponse.data['chain']['evolves_to'] as List;
        final pokemons = await Future.wait(
          pokemonList
              .map((pokemon) => getPokemonById(pokemon['species']['name'])),
        );
        return pokemons.whereType<PokemonEntity>().toList();
      }
      throw Exception(
          'Failed to fetch pokemon by evolution: ${response.statusCode}');
    } catch (e) {
      throw Exception('Network error while fetching pokemon by evolution: $e');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByStat(String stat, int value) async {
    try {
      final response = await _client.get(
        Uri.parse(PokemonApiUrls.getPokemonListUrl()),
      );
      final apiResponse = PokemonApiResponse(response);

      if (apiResponse.isSuccess) {
        final pokemons = await Future.wait(
          apiResponse.results.map((result) => getPokemonById(result['name'])),
        );
        return pokemons
            .whereType<PokemonEntity>()
            .where((pokemon) => pokemon.stats[stat] == value)
            .toList();
      }
      throw Exception(
          'Failed to fetch pokemon by stat: ${response.statusCode}');
    } catch (e) {
      throw Exception('Network error while fetching pokemon by stat: $e');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByDescription(
      String description) async {
    try {
      final response = await _client.get(
        Uri.parse('${PokemonApiUrls.baseUrl}/pokemon-species'),
      );
      final apiResponse = PokemonApiResponse(response);

      if (apiResponse.isSuccess) {
        final pokemons = await Future.wait(
          apiResponse.results.map((result) => getPokemonById(result['name'])),
        );
        return pokemons
            .whereType<PokemonEntity>()
            .where((pokemon) => pokemon.description
                .toLowerCase()
                .contains(description.toLowerCase()))
            .toList();
      }
      throw Exception(
          'Failed to fetch pokemon by description: ${response.statusCode}');
    } catch (e) {
      throw Exception(
          'Network error while fetching pokemon by description: $e');
    }
  }
}
