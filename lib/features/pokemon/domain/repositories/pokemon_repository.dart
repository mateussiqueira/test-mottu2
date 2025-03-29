import 'package:pokeapi/core/domain/entities/pokemon_entity.dart';
import 'package:pokeapi/core/domain/errors/pokemon_error.dart';

/// Interface do repositório de Pokemon
abstract class PokemonRepository {
  /// Busca a lista de Pokemons
  Future<Result<List<PokemonEntity>>> getPokemonList({
    required int offset,
    required int limit,
  });

  /// Busca os detalhes de um Pokemon
  Future<Result<PokemonEntity>> getPokemonDetail(int id);

  /// Busca Pokemons por nome
  Future<Result<List<PokemonEntity>>> searchPokemon(String query);
}
