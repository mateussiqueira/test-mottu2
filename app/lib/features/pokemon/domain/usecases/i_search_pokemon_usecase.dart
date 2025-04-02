import '../../../../core/domain/result.dart' as core;
import '../entities/i_pokemon_entity.dart';

/// Interface for the SearchPokemon use case
abstract class ISearchPokemonUseCase {
  /// Searches for Pokemon by name
  ///
  /// [query] - The search query to filter Pokemon names
  /// Returns a [Result] containing either a list of matching Pokemon or an error
  Future<core.Result<List<IPokemonEntity>>> call(String query);
}
