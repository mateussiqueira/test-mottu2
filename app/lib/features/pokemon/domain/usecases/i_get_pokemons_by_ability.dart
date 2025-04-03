import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';

/// Interface for the GetPokemonsByAbility use case
abstract class IGetPokemonsByAbility {
  /// Fetches a list of Pokemon that have a specific ability
  ///
  /// [ability] - The ability to search for
  /// Returns a [Result] containing either a list of Pokemon or an error
  Future<Result<List<PokemonEntity>>> call(String ability);
}
