import 'package:http/http.dart' as http;

import '../../domain/entities/i_pokemon_entity.dart';
import '../mappers/pokemon_mapper.dart';
import 'i_pokemon_remote_datasource.dart';
import 'pokemon_api_response.dart';
import 'pokemon_api_urls.dart';

/// Implementation of the Pokemon remote data source using HTTP client
class PokemonRemoteDataSource implements IPokemonRemoteDataSource {
  final http.Client _client;

  PokemonRemoteDataSource({required http.Client client}) : _client = client;

  @override
  Future<List<IPokemonEntity>> getPokemons({int? limit, int? offset}) async {
    try {
      final response = await _client.get(
        Uri.parse(PokemonApiUrls.getPokemonListUrl(
            offset: offset ?? 0, limit: limit ?? 20)),
      );
      final apiResponse = PokemonApiResponse(response);

      if (apiResponse.isSuccess) {
        final pokemons = await Future.wait(
          apiResponse.results.map((result) => getPokemonDetail(result['name'])),
        );
        return pokemons.whereType<IPokemonEntity>().toList();
      }
      throw Exception('Failed to fetch pokemon list: ${response.statusCode}');
    } catch (e) {
      throw Exception('Network error while fetching pokemon list: $e');
    }
  }

  @override
  Future<IPokemonEntity> getPokemonDetail(int id) async {
    try {
      final response = await _client
          .get(Uri.parse(PokemonApiUrls.getPokemonDetailUrl(id.toString())));
      final apiResponse = PokemonApiResponse(response);

      if (apiResponse.isSuccess) {
        return PokemonMapper.fromJson(apiResponse.data);
      }
      throw Exception('Pokemon not found: $id');
    } catch (e) {
      throw Exception('Network error while fetching pokemon detail: $e');
    }
  }

  @override
  Future<List<IPokemonEntity>> getPokemonsByType(String type) async {
    try {
      final response = await _client.get(
        Uri.parse(PokemonApiUrls.getPokemonByTypeUrl(type)),
      );
      final apiResponse = PokemonApiResponse(response);

      if (apiResponse.isSuccess) {
        final pokemonList = apiResponse.data['pokemon'] as List;
        final pokemons = await Future.wait(
          pokemonList
              .map((pokemon) => getPokemonDetail(pokemon['pokemon']['name'])),
        );
        return pokemons.whereType<IPokemonEntity>().toList();
      }
      throw Exception(
          'Failed to fetch pokemon by type: ${response.statusCode}');
    } catch (e) {
      throw Exception('Network error while fetching pokemon by type: $e');
    }
  }

  @override
  Future<List<IPokemonEntity>> getPokemonsByAbility(String ability) async {
    try {
      final response = await _client.get(
        Uri.parse(PokemonApiUrls.getPokemonByAbilityUrl(ability)),
      );
      final apiResponse = PokemonApiResponse(response);

      if (apiResponse.isSuccess) {
        final pokemonList = apiResponse.data['pokemon'] as List;
        final pokemons = await Future.wait(
          pokemonList
              .map((pokemon) => getPokemonDetail(pokemon['pokemon']['name'])),
        );
        return pokemons.whereType<IPokemonEntity>().toList();
      }
      throw Exception(
          'Failed to fetch pokemon by ability: ${response.statusCode}');
    } catch (e) {
      throw Exception('Network error while fetching pokemon by ability: $e');
    }
  }

  @override
  Future<List<IPokemonEntity>> searchPokemons(String query) async {
    try {
      final response =
          await _client.get(Uri.parse(PokemonApiUrls.getPokemonListUrl()));
      final apiResponse = PokemonApiResponse(response);

      if (apiResponse.isSuccess) {
        final pokemons = await Future.wait(
          apiResponse.results
              .where((result) => result['name']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .map((result) => getPokemonDetail(result['name'])),
        );
        return pokemons.whereType<IPokemonEntity>().toList();
      }
      throw Exception('Failed to search pokemon: ${response.statusCode}');
    } catch (e) {
      throw Exception('Network error while searching pokemon: $e');
    }
  }
}
