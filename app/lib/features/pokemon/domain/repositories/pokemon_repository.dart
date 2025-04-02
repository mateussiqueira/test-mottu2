import '../../../../core/domain/result.dart' as core;
import '../entities/pokemon_entity.dart';

abstract class PokemonRepository {
  /// Busca a lista de Pokemons
  Future<core.Result<List<PokemonEntityImpl>>> getPokemonList({
    required int limit,
    required int offset,
  });

  /// Busca os detalhes de um Pokemon
  Future<core.Result<PokemonEntityImpl>> getPokemonDetail(int id);

  /// Busca Pokemons por nome
  Future<core.Result<List<PokemonEntityImpl>>> searchPokemon(String query);

  /// Busca Pokemons por tipo
  Future<core.Result<List<PokemonEntityImpl>>> getPokemonsByType(String type);

  /// Busca Pokemons por habilidade
  Future<core.Result<List<PokemonEntityImpl>>> getPokemonsByAbility(
      String ability);
}
