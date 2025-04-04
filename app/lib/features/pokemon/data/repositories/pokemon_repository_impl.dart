import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/result/result.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/i_pokemon_repository.dart';
import '../datasources/pokemon_remote_data_source_impl.dart';

/// Implementation of Pokemon repository
class PokemonRepositoryImpl implements IPokemonRepository {
  final PokemonRemoteDataSourceImpl _remoteDataSource;

  PokemonRepositoryImpl(this._remoteDataSource);

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
      return Right(pokemons);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<PokemonEntity>> getPokemonById(int id) async {
    try {
      final pokemon = await _remoteDataSource.getPokemonById(id);
      return Right(pokemon);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> searchPokemon(String query) async {
    try {
      final pokemons = await _remoteDataSource.searchPokemon(query);
      return Right(pokemons);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByType(String type) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByType(type);
      return Right(pokemons);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByAbility(
      String ability) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByAbility(ability);
      return Right(pokemons);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByMove(String move) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByMove(move);
      return Right(pokemons);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByEvolution(
    String evolution,
  ) async {
    try {
      final pokemons =
          await _remoteDataSource.getPokemonsByEvolution(evolution);
      return Right(pokemons);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByStat(
    String stat,
    int value,
  ) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByStat(stat, value);
      return Right(pokemons);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByDescription(
    String description,
  ) async {
    try {
      final pokemons = await _remoteDataSource.getPokemonsByDescription(
        description,
      );
      return Right(pokemons);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<PokemonEntity>> getPokemonDetail(int id) async {
    try {
      final pokemon = await _remoteDataSource.getPokemonById(id);
      return Right(pokemon);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
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
