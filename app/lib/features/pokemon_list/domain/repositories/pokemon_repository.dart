import '../../../../core/domain/result.dart' as core;
import '../../../pokemon/domain/entities/pokemon_entity.dart';

abstract class PokemonRepository {
  Future<core.Result<List<PokemonEntityImpl>>> getPokemonList({
    required int limit,
    required int offset,
  });
  Future<core.Result<PokemonEntityImpl>> getPokemonDetail(int id);
  Future<core.Result<List<PokemonEntityImpl>>> searchPokemon(String query);
}
