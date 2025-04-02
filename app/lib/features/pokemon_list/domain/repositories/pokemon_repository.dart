import '../../../../core/domain/result.dart' as core;
import '../../../pokemon/domain/entities/i_pokemon_entity.dart';

/// Repository for Pokemon operations
abstract class PokemonRepository {
  /// Gets a list of Pokemon with pagination
  Future<core.Result<List<IPokemonEntity>>> getPokemonList({
    required int limit,
    required int offset,
  });

  /// Gets details of a specific Pokemon
  Future<core.Result<IPokemonEntity>> getPokemonDetail(int id);

  /// Searches for Pokemon by name
  Future<core.Result<List<IPokemonEntity>>> searchPokemon(String query);
}
