import '../../../../core/domain/result.dart' as core;
import '../../../../features/pokemon/domain/entities/i_pokemon_entity.dart';
import '../../../../features/pokemon/domain/repositories/i_pokemon_repository.dart';

/// Use case for searching Pokemon
class SearchPokemon {
  final IPokemonRepository repository;

  SearchPokemon({
    required this.repository,
  });

  /// Searches for Pokemon by name
  ///
  /// [query] - The search query to find Pokemon
  /// Returns a [Result] containing a list of [IPokemonEntity] that match the search criteria
  Future<core.Result<List<IPokemonEntity>>> call(String query) {
    return repository.searchPokemon(query);
  }
}
