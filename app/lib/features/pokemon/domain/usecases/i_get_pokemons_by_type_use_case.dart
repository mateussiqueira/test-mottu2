import '../../../../core/domain/result.dart' as core;
import '../entities/i_pokemon_entity.dart';

/// Interface for the GetPokemonsByType use case
abstract class IGetPokemonsByTypeUseCase {
  /// Fetches Pokemon of a specific type
  ///
  /// [type] - The type to filter Pokemon by (e.g., "fire", "water")
  /// Returns a [Result] containing either a list of Pokemon of the specified type or an error
  Future<core.Result<List<IPokemonEntity>>> call(String type);
}
