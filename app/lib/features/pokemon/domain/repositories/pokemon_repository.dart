import '../../../../core/domain/result.dart';
import '../entities/pokemon_entity.dart';

/// Interface do repositório de Pokemon
abstract class PokemonRepository {
  /// Busca a lista de Pokemons
  Future<Result<List<PokemonEntityImpl>>> getPokemonList({
    required int limit,
    required int offset,
  });

  /// Busca os detalhes de um Pokemon
  Future<Result<PokemonEntityImpl>> getPokemonDetail(int id);

  /// Busca Pokemons por nome
  Future<Result<List<PokemonEntityImpl>>> searchPokemon(String query);

  /// Busca Pokemons por tipo
  Future<Result<List<PokemonEntityImpl>>> getPokemonsByType(String type);

  /// Busca Pokemons por habilidade
  Future<Result<List<PokemonEntityImpl>>> getPokemonsByAbility(String ability);
}
