import 'dart:convert';

import '../../core/network/dio_client.dart';
import '../../domain/entities/pokemon_entity.dart';

class PokemonRepository {
  final DioClient _dio;

  PokemonRepository(this._dio);

  Future<List<PokemonEntity>> fetchPokemons({
    int page = 0,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get(
        '/pokemon',
        queryParameters: {
          'offset': page * limit,
          'limit': limit,
        },
      );

      final data = response is String ? json.decode(response) : response;
      final results = data['results'] as List;

      final pokemons = await Future.wait(
        results.map((pokemon) => getPokemonByUrl(pokemon['url'] as String)),
      );

      return pokemons;
    } catch (e) {
      throw Exception('Failed to fetch Pokémons: $e');
    }
  }

  Future<PokemonEntity> getPokemonById(int id) async {
    try {
      final response = await _dio.get('/pokemon/$id');
      final data = response is String ? json.decode(response) : response;
      return PokemonEntity.fromJson(data);
    } catch (e) {
      throw Exception('Failed to fetch Pokémon: $e');
    }
  }

  Future<PokemonEntity> getPokemonByUrl(String url) async {
    try {
      final response = await _dio.get(url, useCache: true);
      final data = response is String ? json.decode(response) : response;
      return PokemonEntity.fromJson(data);
    } catch (e) {
      throw Exception('Failed to fetch Pokémon: $e');
    }
  }

  Future<List<PokemonEntity>> searchPokemons(String query) async {
    try {
      final response = await _dio.get(
        '/pokemon',
        queryParameters: {
          'limit': 1000,
        },
      );

      final data = response is String ? json.decode(response) : response;
      final results = data['results'] as List;
      final filteredResults = results
          .where((pokemon) => pokemon['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();

      final pokemons = await Future.wait(
        filteredResults
            .map((pokemon) => getPokemonByUrl(pokemon['url'] as String)),
      );

      return pokemons;
    } catch (e) {
      throw Exception('Failed to search Pokémons: $e');
    }
  }

  Future<List<PokemonEntity>> getPokemonsByType(String type) async {
    try {
      final response = await _dio.get('/type/$type');
      final data = response is String ? json.decode(response) : response;
      final pokemonList = (data['pokemon'] as List)
          .map((pokemon) => pokemon['pokemon']['url'] as String)
          .toList();

      final pokemons = await Future.wait(
        pokemonList.take(20).map((url) => getPokemonByUrl(url)),
      );

      return pokemons;
    } catch (e) {
      throw Exception('Failed to fetch Pokémons by type: $e');
    }
  }
}
