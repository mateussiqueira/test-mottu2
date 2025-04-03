import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';

/// Interface for the SearchPokemon use case
abstract class ISearchPokemonUseCase {
  /// Searches for Pokemon based on a query
  ///
  /// [query] - The search query
  /// Returns a [Result] containing either a list of Pokemon or an error
  Future<Result<List<PokemonEntity>>> call(String query);
}
