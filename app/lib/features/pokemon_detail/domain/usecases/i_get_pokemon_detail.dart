import '../../../pokemon/domain/entities/i_pokemon_entity.dart';

/// Interface for getting Pokemon details
abstract class IGetPokemonDetail {
  /// Gets Pokemon details by ID
  Future<IPokemonEntity> call(int id);
}
