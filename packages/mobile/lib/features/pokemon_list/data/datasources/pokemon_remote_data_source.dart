import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pokemon_model.dart';

abstract class PokemonRemoteDataSource {
  Future<List<PokemonModel>> getPokemons({int offset = 0, int limit = 20});
  Future<PokemonModel> getPokemonById(int id);
  Future<PokemonModel> getPokemonByName(String name);
  Future<List<PokemonModel>> searchPokemons(String query);
  Future<List<PokemonModel>> getPokemonsByType(String type);
  Future<List<PokemonModel>> getPokemonsByAbility(String ability);
  Future<void> clearCache();
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;
  static const String _baseUrl = 'https://pokeapi.co/api/v2';

  PokemonRemoteDataSourceImpl({http.Client? client})
      : client = client ?? http.Client();

  @override
  Future<List<PokemonModel>> getPokemons(
      {int offset = 0, int limit = 20}) async {
    final response = await client.get(
      Uri.parse('$_baseUrl/pokemon?offset=$offset&limit=$limit'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      final pokemons = await Future.wait(
        results.map((pokemon) async {
          final pokemonResponse = await client.get(Uri.parse(pokemon['url']));
          if (pokemonResponse.statusCode == 200) {
            return PokemonModel.fromJson(json.decode(pokemonResponse.body));
          } else {
            throw Exception('Failed to load pokemon: ${pokemon['name']}');
          }
        }),
      );
      return pokemons;
    } else {
      throw Exception('Failed to load pokemons');
    }
  }

  @override
  Future<PokemonModel> getPokemonById(int id) async {
    final response = await client.get(Uri.parse('$_baseUrl/pokemon/$id'));

    if (response.statusCode == 200) {
      return PokemonModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  @override
  Future<PokemonModel> getPokemonByName(String name) async {
    final response = await client.get(Uri.parse('$_baseUrl/pokemon/$name'));

    if (response.statusCode == 200) {
      return PokemonModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  @override
  Future<List<PokemonModel>> searchPokemons(String query) async {
    final response = await client.get(
      Uri.parse('$_baseUrl/pokemon?limit=1000'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      final filteredResults = results
          .where((pokemon) => pokemon['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      final pokemons = await Future.wait(
        filteredResults.map((pokemon) async {
          final pokemonResponse = await client.get(Uri.parse(pokemon['url']));
          if (pokemonResponse.statusCode == 200) {
            return PokemonModel.fromJson(json.decode(pokemonResponse.body));
          } else {
            throw Exception('Failed to load pokemon: ${pokemon['name']}');
          }
        }),
      );
      return pokemons;
    } else {
      throw Exception('Failed to search pokemons');
    }
  }

  @override
  Future<List<PokemonModel>> getPokemonsByType(String type) async {
    final response = await client.get(Uri.parse('$_baseUrl/type/$type'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final pokemon = data['pokemon'] as List;
      final pokemons = await Future.wait(
        pokemon.map((p) async {
          final pokemonResponse =
              await client.get(Uri.parse(p['pokemon']['url']));
          if (pokemonResponse.statusCode == 200) {
            return PokemonModel.fromJson(json.decode(pokemonResponse.body));
          } else {
            throw Exception('Failed to load pokemon: ${p['pokemon']['name']}');
          }
        }),
      );
      return pokemons;
    } else {
      throw Exception('Failed to load pokemons by type');
    }
  }

  @override
  Future<List<PokemonModel>> getPokemonsByAbility(String ability) async {
    final response = await client.get(Uri.parse('$_baseUrl/ability/$ability'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final pokemon = data['pokemon'] as List;
      final pokemons = await Future.wait(
        pokemon.map((p) async {
          final pokemonResponse =
              await client.get(Uri.parse(p['pokemon']['url']));
          if (pokemonResponse.statusCode == 200) {
            return PokemonModel.fromJson(json.decode(pokemonResponse.body));
          } else {
            throw Exception('Failed to load pokemon: ${p['pokemon']['name']}');
          }
        }),
      );
      return pokemons;
    } else {
      throw Exception('Failed to load pokemons by ability');
    }
  }

  @override
  Future<void> clearCache() async {
    // Implement cache clearing if needed
  }

  @override
  String toString() {
    return 'PokemonRemoteDataSourceImpl()';
  }
}
