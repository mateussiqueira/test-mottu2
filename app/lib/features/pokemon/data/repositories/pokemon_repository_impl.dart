import 'package:dartz/dartz.dart';
import 'package:pokemon_list/features/pokemon/data/models/pokemon_response.dart';

import '../../domain/entities/pokemon_entity_impl.dart';
import '../../domain/failures/pokemon_failure.dart';
import '../../domain/repositories/i_pokemon_repository.dart';
import '../datasources/pokemon_remote_data_source.dart';
import '../mappers/pokemon_mapper.dart';
import '../validators/pokemon_response_validator.dart';

/// Implementation of Pokemon repository
class PokemonRepositoryImpl implements IPokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  const PokemonRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonList({
    required int offset,
    required int limit,
  }) async {
    try {
      final response = await remoteDataSource.getPokemonList(
        offset: offset,
        limit: limit,
      );

      PokemonResponseValidator.validate(
          PokemonResponse(results: response.results));

      final pokemons = response.results
          .map((model) => PokemonMapper.toEntity(model))
          .toList();

      return Right(pokemons);
    } on PokemonFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(PokemonFailure.api(message: e.toString()));
    }
  }

  @override
  Future<Either<PokemonFailure, PokemonEntityImpl>> getPokemonById({
    required int id,
  }) async {
    try {
      final model = await remoteDataSource.getPokemonById(id);
      final entity = PokemonMapper.toEntity(model);
      return Right(entity);
    } on PokemonFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(PokemonFailure.api(message: e.toString()));
    }
  }

  @override
  Future<Either<PokemonFailure, PokemonEntityImpl>> getPokemonByName({
    required String name,
  }) async {
    try {
      final response = await remoteDataSource.searchPokemon(name);
      PokemonResponseValidator.validate(response);

      if (response.results.isEmpty) {
        return const Left(PokemonFailure.notFound());
      }

      final model = await remoteDataSource.getPokemonById(
        int.parse(response.results.first.url.split('/').reversed.elementAt(1)),
      );
      final entity = PokemonMapper.toEntity(model);
      return Right(entity);
    } on PokemonFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(PokemonFailure.api(message: e.toString()));
    }
  }

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonsByType({
    required String type,
  }) async {
    try {
      final response = await remoteDataSource.getPokemonsByType(type);
      PokemonResponseValidator.validate(response);

      final pokemons = response.results
          .map((model) => PokemonMapper.toEntity(model))
          .toList();

      return Right(pokemons);
    } on PokemonFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(PokemonFailure.api(message: e.toString()));
    }
  }

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonsByAbility({
    required String ability,
  }) async {
    try {
      final response = await remoteDataSource.getPokemonsByAbility(ability);
      PokemonResponseValidator.validate(response);

      final pokemons = response.results
          .map((model) => PokemonMapper.toEntity(model))
          .toList();

      return Right(pokemons);
    } on PokemonFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(PokemonFailure.api(message: e.toString()));
    }
  }

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonsByMove({
    required String move,
  }) async {
    try {
      final response = await remoteDataSource.getPokemonsByMove(move);
      PokemonResponseValidator.validate(response);

      final pokemons = response.results
          .map((model) => PokemonMapper.toEntity(model))
          .toList();

      return Right(pokemons);
    } on PokemonFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(PokemonFailure.api(message: e.toString()));
    }
  }

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonsByStat({
    required String stat,
    required int value,
  }) async {
    try {
      final response = await remoteDataSource.getPokemonsByStat(stat, value);
      PokemonResponseValidator.validate(response);

      final pokemons = response.results
          .map((model) => PokemonMapper.toEntity(model))
          .toList();

      return Right(pokemons);
    } on PokemonFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(PokemonFailure.api(message: e.toString()));
    }
  }

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>>
      getPokemonsByEvolution({
    required String evolution,
  }) async {
    try {
      final response = await remoteDataSource.getPokemonsByEvolution(evolution);
      PokemonResponseValidator.validate(response);

      final pokemons = response.results
          .map((model) => PokemonMapper.toEntity(model))
          .toList();

      return Right(pokemons);
    } on PokemonFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(PokemonFailure.api(message: e.toString()));
    }
  }

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>>
      getPokemonsByDescription({
    required String description,
  }) async {
    try {
      final response = await remoteDataSource.getPokemonsByDescription(
        description,
      );
      PokemonResponseValidator.validate(response);

      final pokemons = response.results
          .map((model) => PokemonMapper.toEntity(model))
          .toList();

      return Right(pokemons);
    } on PokemonFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(PokemonFailure.api(message: e.toString()));
    }
  }

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> searchPokemon({
    required String query,
  }) async {
    try {
      final response = await remoteDataSource.searchPokemon(query);
      PokemonResponseValidator.validate(response);

      final pokemons = response.results
          .map((model) => PokemonMapper.toEntity(model))
          .toList();

      return Right(pokemons);
    } on PokemonFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(PokemonFailure.api(message: e.toString()));
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
        other.remoteDataSource == remoteDataSource;
  }

  @override
  int get hashCode => remoteDataSource.hashCode;
}
