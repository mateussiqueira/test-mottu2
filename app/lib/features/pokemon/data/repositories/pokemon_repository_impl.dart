import 'package:mobile/core/domain/errors/pokemon_error.dart';
import 'package:mobile/core/domain/result.dart' as core;
import 'package:mobile/features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon/domain/repositories/pokemon_repository.dart';

/// Implementação do repositório de Pokemon
class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  PokemonRepositoryImpl(this.remoteDataSource);

  @override
  Future<core.Result<List<PokemonEntityImpl>>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final pokemons = await remoteDataSource.getPokemons(
        limit: limit,
        offset: offset,
      );

      return core.Result.success(
        pokemons
            .map((p) => PokemonEntityImpl(
                  id: p.id,
                  name: p.name,
                  types: p.types,
                  abilities: p.abilities,
                  height: p.height,
                  weight: p.weight,
                  baseExperience: p.baseExperience,
                  imageUrl: p.imageUrl,
                ))
            .toList(),
      );
    } catch (e) {
      return core.Result.failure(const PokemonUnexpectedError());
    }
  }

  @override
  Future<core.Result<PokemonEntityImpl>> getPokemonDetail(int id) async {
    try {
      final pokemon = await remoteDataSource.getPokemonDetail(id);
      return core.Result.success(PokemonEntityImpl(
        id: pokemon.id,
        name: pokemon.name,
        types: pokemon.types,
        abilities: pokemon.abilities,
        height: pokemon.height,
        weight: pokemon.weight,
        baseExperience: pokemon.baseExperience,
        imageUrl: pokemon.imageUrl,
      ));
    } catch (e) {
      return core.Result.failure(const PokemonUnexpectedError());
    }
  }

  @override
  Future<core.Result<List<PokemonEntityImpl>>> searchPokemon(
      String query) async {
    try {
      final pokemons = await remoteDataSource.searchPokemons(query);
      return core.Result.success(
        pokemons
            .map((p) => PokemonEntityImpl(
                  id: p.id,
                  name: p.name,
                  types: p.types,
                  abilities: p.abilities,
                  height: p.height,
                  weight: p.weight,
                  baseExperience: p.baseExperience,
                  imageUrl: p.imageUrl,
                ))
            .toList(),
      );
    } catch (e) {
      return core.Result.failure(const PokemonUnexpectedError());
    }
  }

  @override
  Future<core.Result<List<PokemonEntityImpl>>> getPokemonsByType(
      String type) async {
    try {
      final pokemons = await remoteDataSource.getPokemonsByType(type);
      return core.Result.success(
        pokemons
            .map((p) => PokemonEntityImpl(
                  id: p.id,
                  name: p.name,
                  types: p.types,
                  abilities: p.abilities,
                  height: p.height,
                  weight: p.weight,
                  baseExperience: p.baseExperience,
                  imageUrl: p.imageUrl,
                ))
            .toList(),
      );
    } catch (e) {
      return core.Result.failure(const PokemonUnexpectedError());
    }
  }

  @override
  Future<core.Result<List<PokemonEntityImpl>>> getPokemonsByAbility(
      String ability) async {
    try {
      final pokemons = await remoteDataSource.getPokemonsByAbility(ability);
      return core.Result.success(
        pokemons
            .map((p) => PokemonEntityImpl(
                  id: p.id,
                  name: p.name,
                  types: p.types,
                  abilities: p.abilities,
                  height: p.height,
                  weight: p.weight,
                  baseExperience: p.baseExperience,
                  imageUrl: p.imageUrl,
                ))
            .toList(),
      );
    } catch (e) {
      return core.Result.failure(const PokemonUnexpectedError());
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
