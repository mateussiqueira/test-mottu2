import '../../../../core/domain/errors/result.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/i_pokemon_repository.dart';
import '../datasources/i_pokemon_remote_datasource.dart';

/// Implementation of the Pokemon repository
class PokemonRepositoryImpl implements IPokemonRepository {
  final IPokemonRemoteDataSource _remoteDataSource;

  PokemonRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<PokemonEntity>>> getPokemonList(
      {int? limit, int? offset}) async {
    try {
      final pokemons =
          await _remoteDataSource.getPokemonList(limit: limit, offset: offset);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<PokemonEntity>> getPokemonById(int id) async {
    try {
      final pokemon = await _remoteDataSource.getPokemonById(id);
      return Result.success(pokemon);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> searchPokemon(String query) async {
    try {
      final pokemons = await _remoteDataSource.searchPokemons(query);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByType(String type) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByType(type);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByAbility(
      String ability) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByAbility(ability);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByMove(String move) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByMove(move);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure('Failed to fetch Pokemon by move: $e');
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByEvolution(
      String evolution) async {
    try {
      final pokemons =
          await _remoteDataSource.getPokemonsByEvolution(evolution);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure('Failed to fetch Pokemon by evolution: $e');
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByStat(
      String stat, int value) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByStat(stat, value);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure('Failed to fetch Pokemon by stat: $e');
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByDescription(
      String description) async {
    try {
      final pokemons =
          await _remoteDataSource.getPokemonsByDescription(description);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure('Failed to fetch Pokemon by description: $e');
    }
  }

  @override
  Future<Result<PokemonEntity>> getPokemonDetail(int id) async {
    try {
      final pokemon = await _remoteDataSource.getPokemonById(id);
      return Result.success(pokemon);
    } catch (e) {
      return Result.failure('Failed to fetch Pokemon detail: $e');
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
