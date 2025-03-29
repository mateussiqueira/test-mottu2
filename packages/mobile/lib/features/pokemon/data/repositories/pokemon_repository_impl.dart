import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/domain/errors/pokemon_error.dart';
import '../../../../core/domain/result.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_local_datasource.dart';
import '../datasources/pokemon_remote_data_source.dart';

/// Implementação do repositório de Pokemon
class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;
  final PokemonLocalDataSource localDataSource;
  final SharedPreferences prefs;

  PokemonRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.prefs,
  });

  @override
  Future<Result<List<PokemonEntityImpl>>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final cachedPokemons = await localDataSource.getPokemonList();
      if (cachedPokemons.isNotEmpty) {
        return Result.success(cachedPokemons);
      }

      final remoteResult = await remoteDataSource.getPokemonList(
        limit: limit,
        offset: offset,
      );
      await localDataSource.savePokemonList(remoteResult);
      return Result.success(remoteResult);
    } catch (e) {
      if (e is NetworkError) {
        return Result.failure(PokemonNetworkError());
      } else if (e is CacheError) {
        return Result.failure(CacheError());
      } else {
        return Result.failure(PokemonUnexpectedError());
      }
    }
  }

  @override
  Future<Result<PokemonEntityImpl>> getPokemonDetail(int id) async {
    try {
      final cachedPokemon = await localDataSource.getPokemonDetail(id);
      if (cachedPokemon != null) {
        return Result.success(cachedPokemon);
      }

      final remoteResult = await remoteDataSource.getPokemonById(id);
      await localDataSource.savePokemonDetail(remoteResult);
      return Result.success(remoteResult);
    } catch (e) {
      if (e is NetworkError) {
        return Result.failure(PokemonNetworkError());
      } else if (e is CacheError) {
        return Result.failure(CacheError());
      } else {
        return Result.failure(PokemonUnexpectedError());
      }
    }
  }

  @override
  Future<Result<List<PokemonEntityImpl>>> searchPokemon(String query) async {
    try {
      final remoteResult = await remoteDataSource.searchPokemon(query);
      return Result.success(remoteResult);
    } catch (e) {
      if (e is NetworkError) {
        return Result.failure(PokemonNetworkError());
      } else if (e is ValidationError) {
        return Result.failure(PokemonValidationError(e.message));
      } else {
        return Result.failure(PokemonUnexpectedError());
      }
    }
  }

  @override
  Future<Result<List<PokemonEntityImpl>>> getPokemonsByType(String type) async {
    try {
      final remoteResult = await remoteDataSource.getPokemonsByType(type);
      return Result.success(remoteResult);
    } catch (e) {
      if (e is NetworkError) {
        return Result.failure(PokemonNetworkError());
      } else if (e is ValidationError) {
        return Result.failure(PokemonValidationError(e.message));
      } else {
        return Result.failure(PokemonUnexpectedError());
      }
    }
  }

  @override
  Future<Result<List<PokemonEntityImpl>>> getPokemonsByAbility(
      String ability) async {
    try {
      final remoteResult = await remoteDataSource.getPokemonsByAbility(ability);
      return Result.success(remoteResult);
    } catch (e) {
      if (e is NetworkError) {
        return Result.failure(PokemonNetworkError());
      } else if (e is ValidationError) {
        return Result.failure(PokemonValidationError(e.message));
      } else {
        return Result.failure(PokemonUnexpectedError());
      }
    }
  }
}
