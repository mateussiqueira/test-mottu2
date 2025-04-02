import 'package:dio/dio.dart';

import '../../../../core/domain/result.dart' as core;
import '../../domain/entities/i_pokemon_entity.dart';
import '../mappers/pokemon_mapper.dart';

/// Client for making Pokemon API calls
class PokemonApiClient {
  final Dio _dio;
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  PokemonApiClient(this._dio) {
    _dio.options.baseUrl = baseUrl;
  }

  /// Fetches a list of Pokemon with pagination
  Future<core.Result<List<IPokemonEntity>>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await _dio.get(
        '/pokemon',
        queryParameters: {
          'offset': offset,
          'limit': limit,
        },
      );

      final results = response.data['results'] as List;
      final pokemons = await Future.wait(
        results.map((result) async {
          final pokemonResponse = await _dio.get(result['url']);
          return PokemonMapper.fromJson(pokemonResponse.data);
        }),
      );

      return core.Result.success(pokemons);
    } catch (e) {
      return core.Result.failure('Failed to fetch Pokemon list: $e');
    }
  }

  /// Fetches detailed information about a specific Pokemon
  Future<core.Result<IPokemonEntity>> getPokemonDetail(int id) async {
    try {
      final response = await _dio.get('/pokemon/$id');
      return core.Result.success(PokemonMapper.fromJson(response.data));
    } catch (e) {
      return core.Result.failure('Failed to fetch Pokemon detail: $e');
    }
  }

  /// Searches for Pokemon by name
  Future<core.Result<List<IPokemonEntity>>> searchPokemon(String query) async {
    try {
      final response = await getPokemonList(limit: 1000, offset: 0);
      if (response.isFailure) {
        return core.Result.failure(response.error!);
      }

      final pokemons = response.data!;
      final filteredPokemons = pokemons
          .where((pokemon) =>
              pokemon.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      return core.Result.success(filteredPokemons);
    } catch (e) {
      return core.Result.failure('Failed to search Pokemon: $e');
    }
  }

  /// Fetches Pokemon of a specific type
  Future<core.Result<List<IPokemonEntity>>> getPokemonsByType(
    String type,
  ) async {
    try {
      final response = await _dio.get('/type/$type');
      final pokemonList = response.data['pokemon'] as List;

      final pokemons = await Future.wait(
        pokemonList.map((pokemon) async {
          final pokemonResponse = await _dio.get(pokemon['pokemon']['url']);
          return PokemonMapper.fromJson(pokemonResponse.data);
        }),
      );

      return core.Result.success(pokemons);
    } catch (e) {
      return core.Result.failure('Failed to fetch Pokemon by type: $e');
    }
  }

  /// Fetches Pokemon with a specific ability
  Future<core.Result<List<IPokemonEntity>>> getPokemonsByAbility(
    String ability,
  ) async {
    try {
      final response = await _dio.get('/ability/$ability');
      final pokemonList = response.data['pokemon'] as List;

      final pokemons = await Future.wait(
        pokemonList.map((pokemon) async {
          final pokemonResponse = await _dio.get(pokemon['pokemon']['url']);
          return PokemonMapper.fromJson(pokemonResponse.data);
        }),
      );

      return core.Result.success(pokemons);
    } catch (e) {
      return core.Result.failure('Failed to fetch Pokemon by ability: $e');
    }
  }
}
