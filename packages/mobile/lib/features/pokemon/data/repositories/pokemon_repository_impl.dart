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
      final result = await remoteDataSource.getPokemonList(limit, offset);
      final pokemons =
          result.map((json) => PokemonEntityImpl.fromJson(json)).toList();
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(PokemonUnexpectedError());
    }
  }

  @override
  Future<Result<PokemonEntityImpl>> getPokemonDetail(int id) async {
    try {
      final result = await remoteDataSource.getPokemonById(id);
      final pokemon = PokemonEntityImpl.fromJson(result);
      return Result.success(pokemon);
    } catch (e) {
      return Result.failure(PokemonUnexpectedError());
    }
  }

  @override
  Future<Result<List<PokemonEntityImpl>>> searchPokemon(String query) async {
    try {
      final result = await remoteDataSource.searchPokemon(query);
      final pokemons =
          result.map((json) => PokemonEntityImpl.fromJson(json)).toList();
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(PokemonUnexpectedError());
    }
  }

  @override
  Future<Result<List<PokemonEntityImpl>>> getPokemonsByType(String type) async {
    try {
      final result = await remoteDataSource.getPokemonsByType(type);
      final pokemons =
          result.map((json) => PokemonEntityImpl.fromJson(json)).toList();
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(PokemonUnexpectedError());
    }
  }

  @override
  Future<Result<List<PokemonEntityImpl>>> getPokemonsByAbility(
      String ability) async {
    try {
      final result = await remoteDataSource.getPokemonsByAbility(ability);
      final pokemons =
          result.map((json) => PokemonEntityImpl.fromJson(json)).toList();
      return Result.success(pokemons);
    } catch (e) {
      return Result.failure(PokemonUnexpectedError());
    }
  }
}
