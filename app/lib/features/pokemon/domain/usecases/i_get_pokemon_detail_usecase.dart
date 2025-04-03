import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';

/// Interface for the GetPokemonDetail use case
abstract class IGetPokemonDetailUseCase {
  /// Fetches detailed information about a specific Pokemon
  ///
  /// [id] - The ID of the Pokemon to fetch
  /// Returns a [Result] containing either the Pokemon details or an error
  Future<Result<PokemonEntity>> call(int id);
}
