import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';

/// Interface for the GetPokemonsByType use case
abstract class IGetPokemonsByType {
  /// Fetches a list of Pokemon that have a specific type
  ///
  /// [type] - The type to search for
  /// Returns a [Result] containing either a list of Pokemon or an error
  Future<Result<List<PokemonEntity>>> call(String type);
}
