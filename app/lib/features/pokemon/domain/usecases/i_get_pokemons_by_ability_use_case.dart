import '../../../../core/domain/result.dart' as core;
import '../entities/i_pokemon_entity.dart';

/// Interface for the GetPokemonsByAbility use case
abstract class IGetPokemonsByAbilityUseCase {
  /// Fetches Pokemon with a specific ability
  ///
  /// [ability] - The ability to filter Pokemon by (e.g., "blaze", "torrent")
  /// Returns a [Result] containing either a list of Pokemon with the specified ability or an error
  Future<core.Result<List<IPokemonEntity>>> call(String ability);
}
