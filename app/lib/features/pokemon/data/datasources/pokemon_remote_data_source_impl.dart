import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/entities/pokemon_entity.dart';
import 'i_pokemon_remote_datasource.dart';

/// Implementation of Pokemon remote data source
class PokemonRemoteDataSourceImpl implements IPokemonRemoteDataSource {
  final http.Client _client;

  PokemonRemoteDataSourceImpl({required http.Client client}) : _client = client;

  @override
  Future<List<PokemonEntity>> getPokemonList({
    int? limit,
    int? offset,
  }) async {
    try {
      final response = await _client.get(
        Uri.parse(
            'https://pokeapi.co/api/v2/pokemon?limit=${limit ?? 20}&offset=${offset ?? 0}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = json.decode(response.body)['results'];
        final List<PokemonEntity> pokemons = [];

        for (var pokemon in results) {
          final id = int.parse(pokemon['url'].toString().split('/')[6]);
          final detail = await getPokemonById(id);
          pokemons.add(detail);
        }

        return pokemons;
      }
      throw Exception('Failed to load Pokemon list');
    } catch (e) {
      throw Exception('Failed to load Pokemon list: $e');
    }
  }

  @override
  Future<PokemonEntity> getPokemonById(int id) async {
    try {
      final response = await _client.get(
        Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return PokemonEntity.fromJson(json);
      }
      throw Exception('Failed to load Pokemon');
    } catch (e) {
      throw Exception('Failed to load Pokemon: $e');
    }
  }

  @override
  Future<List<PokemonEntity>> searchPokemons(String query) async {
    try {
      final response = await _client.get(
        Uri.parse('https://pokeapi.co/api/v2/pokemon/$query'),
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
        Uri.parse('https://pokeapi.co/api/v2/type/$type'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> pokemonList = json.decode(response.body)['pokemon'];
        final List<PokemonEntity> pokemons = [];

        for (var pokemon in pokemonList) {
          final id =
              int.parse(pokemon['pokemon']['url'].toString().split('/')[6]);
          final detail = await getPokemonById(id);
          pokemons.add(detail);
        }

        return pokemons;
      }
      throw Exception('Failed to load Pokemon by type');
    } catch (e) {
      throw Exception('Failed to load Pokemon by type: $e');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability) async {
    try {
      final response = await _client.get(
        Uri.parse('https://pokeapi.co/api/v2/ability/$ability'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> pokemonList = json.decode(response.body)['pokemon'];
        final List<PokemonEntity> pokemons = [];

        for (var pokemon in pokemonList) {
          final id =
              int.parse(pokemon['pokemon']['url'].toString().split('/')[6]);
          final detail = await getPokemonById(id);
          pokemons.add(detail);
        }

        return pokemons;
      }
      throw Exception('Failed to load Pokemon by ability');
    } catch (e) {
      throw Exception('Failed to load Pokemon by ability: $e');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByMove(String move) async {
    try {
      final response = await _client.get(
        Uri.parse('https://pokeapi.co/api/v2/move/$move'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> pokemonList =
            json.decode(response.body)['learned_by_pokemon'];
        final List<PokemonEntity> pokemons = [];

        for (var pokemon in pokemonList) {
          final id = int.parse(pokemon['url'].toString().split('/')[6]);
          final detail = await getPokemonById(id);
          pokemons.add(detail);
        }

        return pokemons;
      }
      throw Exception('Failed to load Pokemon by move');
    } catch (e) {
      throw Exception('Failed to load Pokemon by move: $e');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByEvolution(String evolution) async {
    try {
      final response = await _client.get(
        Uri.parse('https://pokeapi.co/api/v2/evolution-chain/$evolution'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> pokemonList =
            json.decode(response.body)['chain']['evolves_to'];
        final List<PokemonEntity> pokemons = [];

        for (var pokemon in pokemonList) {
          final id =
              int.parse(pokemon['species']['url'].toString().split('/')[6]);
          final detail = await getPokemonById(id);
          pokemons.add(detail);
        }

        return pokemons;
      }
      throw Exception('Failed to load Pokemon by evolution');
    } catch (e) {
      throw Exception('Failed to load Pokemon by evolution: $e');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByStat(String stat, int value) async {
    try {
      final response = await _client.get(
        Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=1118'),
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
      }
      throw Exception('Failed to load Pokemon by stat');
    } catch (e) {
      throw Exception('Failed to load Pokemon by stat: $e');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByDescription(
      String description) async {
    try {
      final response = await _client.get(
        Uri.parse('https://pokeapi.co/api/v2/pokemon-species?limit=1118'),
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
      }
      throw Exception('Failed to load Pokemon by description');
    } catch (e) {
      throw Exception('Failed to load Pokemon by description: $e');
    }
  }
}
