import '../../../../core/domain/errors/result.dart';
import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';
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
  /// Returns a [Result] containing a list of [PokemonEntity] that match the search criteria
  Future<Result<List<PokemonEntity>>> call(String query) {
    return repository.searchPokemon(query);
  }
}
