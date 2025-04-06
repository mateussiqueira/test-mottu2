import 'package:dartz/dartz.dart';
import '../../../pokemon/data/datasources/i_pokemon_remote_datasource.dart';
import '../../../pokemon/domain/entities/pokemon_entity_impl.dart';
import '../../../pokemon/domain/errors/failures.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';

/// Implementation of PokemonRepository
class PokemonRepositoryImpl implements IPokemonRepository {
  final IPokemonRemoteDataSource _remoteDataSource;

  PokemonRepositoryImpl(IPokemonRemoteDataSource remoteDataSource)
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonList(
        limit: limit,
        offset: offset,
      );
      return Right(pokemons);
    } catch (e) {
      return Left(
        PokemonApiFailure('Unexpected error occurred while fetching pokemon list: $e'),
      );
    }
  }

  @override
  Future<Either<PokemonFailure, PokemonEntityImpl>> getPokemonById({
    required int id,
  }) async {
    try {
      final pokemon = await _remoteDataSource.getPokemonById(id);
      return Right(pokemon);
    } catch (e) {
      return Left(
        PokemonApiFailure('Unexpected error occurred while fetching pokemon detail: $e'),
      );
    }
  }

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> searchPokemon({
    required String query,
  }) async {
    try {
      final pokemons = await _remoteDataSource.searchPokemons(query);
      return Right(pokemons);
    } catch (e) {
      return Left(
        PokemonApiFailure('Unexpected error occurred while searching pokemon: $e'),
      );
    }
  }

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonsByType({
    required String type,
  }) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByType(type);
      return Right(pokemons);
    } catch (e) {
      return Left(
        PokemonApiFailure('Unexpected error occurred while fetching pokemons by type: $e'),
      );
    }
  }

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonsByAbility({
    required String ability,
  }) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByAbility(ability);
      return Right(pokemons);
    } catch (e) {
      return Left(
        PokemonApiFailure('Unexpected error occurred while fetching pokemons by ability: $e'),
      );
    }
  }

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonsByDescription({
    required String description,
  }) async {
    try {
      final pokemons =
          await _remoteDataSource.getPokemonsByDescription(description);
      return Right(pokemons);
    } catch (e) {
      return Left(
        PokemonApiFailure('Unexpected error occurred while fetching pokemons by description: $e'),
      );
    }
  }

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonsByEvolution({
    required String evolution,
  }) async {
    try {
      final pokemons =
          await _remoteDataSource.getPokemonsByEvolution(evolution);
      return Right(pokemons);
    } catch (e) {
      return Left(
        PokemonApiFailure('Unexpected error occurred while fetching pokemons by evolution: $e'),
      );
    }
  }

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonsByMove({
    required String move,
  }) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByMove(move);
      return Right(pokemons);
    } catch (e) {
      return Left(
        PokemonApiFailure('Unexpected error occurred while fetching pokemons by move: $e'),
      );
    }
  }

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonsByStat({
    required String stat,
    required int value,
  }) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByStat(stat, value);
      return Right(pokemons);
    } catch (e) {
      return Left(
        PokemonApiFailure('Unexpected error occurred while fetching pokemons by stat: $e'),
      );
    }
  }

  @override
  Future<Either<PokemonFailure, PokemonEntityImpl>> getPokemonByName({
    required String name,
  }) async {
    try {
      final pokemon = await _remoteDataSource.getPokemonByName(name);
      return Right(pokemon);
    } catch (e) {
      return Left(
        PokemonApiFailure('Unexpected error occurred while fetching pokemon by name: $e'),
      );
    }
  }
}
