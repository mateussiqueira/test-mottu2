import '../../../../core/domain/errors/result.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';

/// Interface for the GetPokemonDetail use case
abstract class IGetPokemonDetail {
  /// Fetches details of a specific Pokemon
  ///
  /// [id] - The ID of the Pokemon to fetch
  /// Returns a [Result] containing either the Pokemon details or an error
  Future<Result<PokemonEntity>> call(int id);
}
