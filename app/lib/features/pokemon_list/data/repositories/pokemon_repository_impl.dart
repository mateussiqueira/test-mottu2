import '../../../../core/domain/errors/failure.dart';
import '../../../../core/domain/errors/result.dart';
import '../../../pokemon/data/datasources/i_pokemon_remote_datasource.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';

/// Implementation of PokemonRepository
class PokemonRepositoryImpl implements IPokemonRepository {
  final IPokemonRemoteDataSource _remoteDataSource;

  PokemonRepositoryImpl(IPokemonRemoteDataSource remoteDataSource)
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Result<List<PokemonEntity>>> getPokemonList({
    int? limit,
    int? offset,
  }) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonList(
        limit: limit,
        offset: offset,
      );
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(
        Failure(
            message: 'Unexpected error occurred while fetching pokemon list'),
      );
    }
  }

  @override
  Future<Result<PokemonEntity>> getPokemonDetail(int id) async {
    try {
      final pokemon = await _remoteDataSource.getPokemonById(id);
      return Result.success(pokemon);
    } catch (e) {
      return Result.failure(
        Failure(
            message: 'Unexpected error occurred while fetching pokemon detail'),
      );
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> searchPokemon(String query) async {
    try {
      final pokemons = await _remoteDataSource.searchPokemons(query);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(
        Failure(message: 'Unexpected error occurred while searching pokemon'),
      );
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> searchPokemons(String query) async {
    try {
      final pokemons = await _remoteDataSource.searchPokemons(query);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(
        Failure(message: 'Unexpected error occurred while searching pokemons'),
      );
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByType(String type) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByType(type);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(
        Failure(
            message:
                'Unexpected error occurred while fetching pokemons by type'),
      );
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByAbility(
      String ability) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByAbility(ability);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(
        Failure(
            message:
                'Unexpected error occurred while fetching pokemons by ability'),
      );
    }
  }

  @override
  Future<Result<PokemonEntity>> getPokemonById(int id) async {
    try {
      final pokemon = await _remoteDataSource.getPokemonById(id);
      return Result.success(pokemon);
    } catch (e) {
      return Result.failure(
        Failure(
            message: 'Unexpected error occurred while fetching pokemon by id'),
      );
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
      return Result.failure(
        Failure(
            message:
                'Unexpected error occurred while fetching pokemons by description'),
      );
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
      return Result.failure(
        Failure(
            message:
                'Unexpected error occurred while fetching pokemons by evolution'),
      );
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByMove(String move) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByMove(move);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(
        Failure(
            message:
                'Unexpected error occurred while fetching pokemons by move'),
      );
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByStat(
      String stat, int value) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByStat(stat, value);
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(
        Failure(
            message:
                'Unexpected error occurred while fetching pokemons by stat'),
      );
    }
  }
}
