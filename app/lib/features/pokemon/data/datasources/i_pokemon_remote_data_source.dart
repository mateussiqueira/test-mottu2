import '../../../../core/domain/result.dart' as core;
import '../../domain/entities/pokemon_entity.dart';

abstract class IPokemonRemoteDataSource {
  Future<core.Result<List<PokemonEntity>>> getPokemonList({
    int offset = 0,
    int limit = 20,
  });
  Future<core.Result<PokemonEntity>> getPokemonDetail(String name);
  Future<core.Result<List<PokemonEntity>>> searchPokemon(String query);
}
