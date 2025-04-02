import '../../../../core/domain/result.dart' as core;
import '../../../pokemon/data/datasources/i_pokemon_remote_datasource.dart';
import '../../../pokemon/domain/entities/i_pokemon_entity.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';

/// Implementation of PokemonRepository
class PokemonRepositoryImpl implements IPokemonRepository {
  final IPokemonRemoteDataSource remoteDataSource;

  PokemonRepositoryImpl(this.remoteDataSource);

  @override
  Future<core.Result<List<IPokemonEntity>>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final pokemons = await remoteDataSource.getPokemons(
        limit: limit,
        offset: offset,
      );

      return core.Result.success(pokemons);
    } catch (e) {
      return core.Result.failure(
          'Unexpected error occurred while fetching pokemon list');
    }
  }

  @override
  Future<core.Result<IPokemonEntity>> getPokemonDetail(int id) async {
    try {
      final pokemon = await remoteDataSource.getPokemonDetail(id);
      return core.Result.success(pokemon);
    } catch (e) {
      return core.Result.failure(
          'Unexpected error occurred while fetching pokemon detail');
    }
  }

  @override
  Future<core.Result<List<IPokemonEntity>>> searchPokemon(String query) async {
    try {
      final pokemons = await remoteDataSource.searchPokemons(query);
      return core.Result.success(pokemons);
    } catch (e) {
      return core.Result.failure(
          'Unexpected error occurred while searching pokemon');
    }
  }

  @override
  Future<core.Result<List<IPokemonEntity>>> getPokemonsByType(
      String type) async {
    try {
      final pokemons = await remoteDataSource.getPokemonsByType(type);
      return core.Result.success(pokemons);
    } catch (e) {
      return core.Result.failure(
          'Unexpected error occurred while fetching pokemons by type');
    }
  }

  @override
  Future<core.Result<List<IPokemonEntity>>> getPokemonsByAbility(
      String ability) async {
    try {
      final pokemons = await remoteDataSource.getPokemonsByAbility(ability);
      return core.Result.success(pokemons);
    } catch (e) {
      return core.Result.failure(
          'Unexpected error occurred while fetching pokemons by ability');
    }
  }
}
