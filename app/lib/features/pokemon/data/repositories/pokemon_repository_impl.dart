import '../../../../core/domain/result.dart' as core;
import '../../domain/entities/i_pokemon_entity.dart';
import '../../domain/repositories/i_pokemon_repository.dart';
import '../datasources/i_pokemon_remote_datasource.dart';

/// Implementation of the Pokemon repository
class PokemonRepositoryImpl implements IPokemonRepository {
  final IPokemonRemoteDataSource _remoteDataSource;

  PokemonRepositoryImpl(this._remoteDataSource);

  @override
  Future<core.Result<List<IPokemonEntity>>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final pokemons = await _remoteDataSource.getPokemons(
        limit: limit,
        offset: offset,
      );
      return core.Result.success(pokemons);
    } catch (e) {
      return core.Result.failure(
          'Failed to fetch Pokemon list: ${e.toString()}');
    }
  }

  @override
  Future<core.Result<IPokemonEntity>> getPokemonDetail(int id) async {
    try {
      final pokemon = await _remoteDataSource.getPokemonDetail(id);
      return core.Result.success(pokemon);
    } catch (e) {
      return core.Result.failure(
          'Failed to fetch Pokemon details: ${e.toString()}');
    }
  }

  @override
  Future<core.Result<List<IPokemonEntity>>> searchPokemon(String query) async {
    try {
      final pokemons = await _remoteDataSource.searchPokemons(query);
      return core.Result.success(pokemons);
    } catch (e) {
      return core.Result.failure('Failed to search Pokemon: ${e.toString()}');
    }
  }

  @override
  Future<core.Result<List<IPokemonEntity>>> getPokemonsByType(
    String type,
  ) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByType(type);
      return core.Result.success(pokemons);
    } catch (e) {
      return core.Result.failure(
          'Failed to fetch Pokemon by type: ${e.toString()}');
    }
  }

  @override
  Future<core.Result<List<IPokemonEntity>>> getPokemonsByAbility(
    String ability,
  ) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByAbility(ability);
      return core.Result.success(pokemons);
    } catch (e) {
      return core.Result.failure(
          'Failed to fetch Pokemon by ability: ${e.toString()}');
    }
  }

  @override
  String toString() {
    return 'PokemonRepositoryImpl()';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PokemonRepositoryImpl &&
        other._remoteDataSource == _remoteDataSource;
  }

  @override
  int get hashCode => _remoteDataSource.hashCode;
}
