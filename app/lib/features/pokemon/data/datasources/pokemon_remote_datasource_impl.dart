import 'package:dio/dio.dart';

import '../../domain/entities/pokemon_entity.dart';
import 'i_pokemon_remote_datasource.dart';

class PokemonRemoteDataSourceImpl implements IPokemonRemoteDataSource {
  final Dio dio;

  PokemonRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<PokemonEntity>> getPokemonList({
    required int offset,
    required int limit,
  }) async {
    final response = await dio.get(
      '/pokemon',
      queryParameters: {
        'offset': offset,
        'limit': limit,
      },
    );

    final results = response.data['results'] as List;
    final pokemons = await Future.wait(
      results.map((result) async {
        final pokemonResponse = await dio.get(result['url']);
        return _mapToPokemonEntity(pokemonResponse.data);
      }),
    );

    return pokemons;
  }

  @override
  Future<PokemonEntity> getPokemonDetail(int id) async {
    final response = await dio.get('/pokemon/$id');
    return _mapToPokemonEntity(response.data);
  }

  @override
  Future<List<PokemonEntity>> searchPokemon(String query) async {
    final response =
        await dio.get('/pokemon', queryParameters: {'limit': 1000});
    final results = response.data['results'] as List;
    final filteredResults = results.where(
      (result) =>
          result['name'].toString().toLowerCase().contains(query.toLowerCase()),
    );

    final pokemons = await Future.wait(
      filteredResults.map((result) async {
        final pokemonResponse = await dio.get(result['url']);
        return _mapToPokemonEntity(pokemonResponse.data);
      }),
    );

    return pokemons;
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByType(String type) async {
    final response = await dio.get('/type/$type');
    final pokemonList = response.data['pokemon'] as List;

    final pokemons = await Future.wait(
      pokemonList.map((pokemon) async {
        final pokemonResponse = await dio.get(pokemon['pokemon']['url']);
        return _mapToPokemonEntity(pokemonResponse.data);
      }),
    );

    return pokemons;
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability) async {
    final response = await dio.get('/ability/$ability');
    final pokemonList = response.data['pokemon'] as List;

    final pokemons = await Future.wait(
      pokemonList.map((pokemon) async {
        final pokemonResponse = await dio.get(pokemon['pokemon']['url']);
        return _mapToPokemonEntity(pokemonResponse.data);
      }),
    );

    return pokemons;
  }

  PokemonEntity _mapToPokemonEntity(Map<String, dynamic> data) {
    return PokemonEntity(
      id: data['id'],
      name: data['name'],
      types: (data['types'] as List)
          .map((type) => type['type']['name'].toString())
          .toList(),
      abilities: (data['abilities'] as List)
          .map((ability) => ability['ability']['name'].toString())
          .toList(),
      height: data['height'],
      weight: data['weight'],
      baseExperience: data['base_experience'],
      imageUrl: data['sprites']['other']['official-artwork']['front_default'],
    );
  }
}
