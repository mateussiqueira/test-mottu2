import '../../../../core/domain/errors/result.dart';
import '../../domain/entities/i_pokemon_entity.dart';
import '../../domain/repositories/i_pokemon_repository.dart';
import '../datasources/i_pokemon_remote_datasource.dart';

/// Implementation of the Pokemon repository
class PokemonRepositoryImpl implements IPokemonRepository {
  final IPokemonRemoteDataSource _remoteDataSource;

  PokemonRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<IPokemonEntity>>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final pokemons = await _remoteDataSource.getPokemons(
        limit: limit,
        offset: offset,
      );
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure('Failed to fetch Pokemon list: ${e.toString()}');
    }
  }

  @override
  Future<Result<IPokemonEntity>> getPokemonById(int id) async {
    try {
      final pokemon = await _remoteDataSource.getPokemonDetail(id);
      return Result.success(pokemon);
    } catch (e) {
      return Result.failure('Failed to fetch Pokemon details: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<IPokemonEntity>>> searchPokemons(String query) async {
    try {
      final pokemons = await _remoteDataSource.searchPokemons(query);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure('Failed to search Pokemon: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<IPokemonEntity>>> getPokemonByType(String type) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByType(type);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure('Failed to fetch Pokemon by type: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<IPokemonEntity>>> getPokemonByAbility(
      String ability) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByAbility(ability);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(
          'Failed to fetch Pokemon by ability: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<IPokemonEntity>>> getPokemonByMove(String move) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByMove(move);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure('Failed to fetch Pokemon by move: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<IPokemonEntity>>> getPokemonByEvolution(
      String evolution) async {
    try {
      final pokemons =
          await _remoteDataSource.getPokemonsByEvolution(evolution);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(
          'Failed to fetch Pokemon by evolution: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<IPokemonEntity>>> getPokemonByStat(
      String stat, int value) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByStat(stat, value);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure('Failed to fetch Pokemon by stat: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<IPokemonEntity>>> getPokemonByDescription(
      String description) async {
    try {
      final pokemons =
          await _remoteDataSource.getPokemonsByDescription(description);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(
          'Failed to fetch Pokemon by description: ${e.toString()}');
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
