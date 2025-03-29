import 'package:mobile/core/domain/errors/pokemon_error.dart';
import 'package:mobile/core/domain/result.dart' as core;
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_list/data/datasources/pokemon_remote_data_source.dart';
import 'package:mobile/features/pokemon_list/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  PokemonRepositoryImpl({required this.remoteDataSource});

  @override
  Future<core.Result<List<PokemonEntityImpl>>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final result = await remoteDataSource.getPokemons(
        limit: limit,
        offset: offset,
      );
      final entities = result
          .map((model) => PokemonEntityImpl(
                id: model.id,
                name: model.name,
                types: model.types.map((t) => t.type.name).toList(),
                abilities: model.abilities.map((a) => a.ability.name).toList(),
                height: model.height.toDouble(),
                weight: model.weight.toDouble(),
                baseExperience: model.baseExperience?.toDouble() ?? 0.0,
                imageUrl: model.sprites.frontDefault ?? '',
              ))
          .toList();
      return core.Result.success(entities);
    } catch (e) {
      if (e.toString().contains('Failed host lookup')) {
        return core.Result.failure(NetworkError());
      }
      return core.Result.failure(PokemonUnexpectedError());
    }
  }

  @override
  Future<core.Result<PokemonEntityImpl>> getPokemonDetail(int id) async {
    try {
      final result = await remoteDataSource.getPokemonById(id);
      final entity = PokemonEntityImpl(
        id: result.id,
        name: result.name,
        types: result.types.map((t) => t.type.name).toList(),
        abilities: result.abilities.map((a) => a.ability.name).toList(),
        height: result.height.toDouble(),
        weight: result.weight.toDouble(),
        baseExperience: result.baseExperience?.toDouble() ?? 0.0,
        imageUrl: result.sprites.frontDefault ?? '',
      );
      return core.Result.success(entity);
    } catch (e) {
      if (e.toString().contains('Failed host lookup')) {
        return core.Result.failure(NetworkError());
      }
      if (e.toString().contains('404')) {
        return core.Result.failure(PokemonNotFoundError());
      }
      return core.Result.failure(PokemonUnexpectedError());
    }
  }

  @override
  Future<core.Result<List<PokemonEntityImpl>>> searchPokemon(
      String query) async {
    try {
      final result = await remoteDataSource.searchPokemons(query);
      final entities = result
          .map((model) => PokemonEntityImpl(
                id: model.id,
                name: model.name,
                types: model.types.map((t) => t.type.name).toList(),
                abilities: model.abilities.map((a) => a.ability.name).toList(),
                height: model.height.toDouble(),
                weight: model.weight.toDouble(),
                baseExperience: model.baseExperience?.toDouble() ?? 0.0,
                imageUrl: model.sprites.frontDefault ?? '',
              ))
          .toList();
      return core.Result.success(entities);
    } catch (e) {
      if (e.toString().contains('Failed host lookup')) {
        return core.Result.failure(NetworkError());
      }
      return core.Result.failure(PokemonUnexpectedError());
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
