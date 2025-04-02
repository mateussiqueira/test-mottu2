import 'package:mobile/core/domain/errors/pokemon_error.dart';
import 'package:mobile/core/domain/result.dart';
import 'package:mobile/features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon/domain/repositories/pokemon_repository.dart';

/// Implementação do repositório de Pokemon
class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  PokemonRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<List<PokemonEntityImpl>>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final pokemons = await remoteDataSource.getPokemons();
      return Result.success(
          pokemons.map((p) => p as PokemonEntityImpl).toList());
    } catch (e) {
      return Result.failure(const PokemonUnexpectedError());
    }
  }

  @override
  Future<Result<PokemonEntityImpl>> getPokemonDetail(int id) async {
    try {
      final pokemon = await remoteDataSource.getPokemonDetail(id);
      return Result.success(pokemon as PokemonEntityImpl);
    } catch (e) {
      return Result.failure(const PokemonUnexpectedError());
    }
  }

  @override
  Future<Result<List<PokemonEntityImpl>>> searchPokemon(String query) async {
    try {
      final pokemons = await remoteDataSource.searchPokemons(query);
      return Result.success(
          pokemons.map((p) => p as PokemonEntityImpl).toList());
    } catch (e) {
      return Result.failure(const PokemonUnexpectedError());
    }
  }

  @override
  Future<Result<List<PokemonEntityImpl>>> getPokemonsByType(String type) async {
    try {
      final pokemons = await remoteDataSource.getPokemonsByType(type);
      return Result.success(
          pokemons.map((p) => p as PokemonEntityImpl).toList());
    } catch (e) {
      return Result.failure(const PokemonUnexpectedError());
    }
  }

  @override
  Future<Result<List<PokemonEntityImpl>>> getPokemonsByAbility(
      String ability) async {
    try {
      final pokemons = await remoteDataSource.getPokemonsByAbility(ability);
      return Result.success(
          pokemons.map((p) => p as PokemonEntityImpl).toList());
    } catch (e) {
      return Result.failure(const PokemonUnexpectedError());
    }
  }
}
