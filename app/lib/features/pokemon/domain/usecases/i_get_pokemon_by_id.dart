import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';

/// Interface for getting Pokemon by ID
abstract class IGetPokemonById {
  /// Get Pokemon by ID
  Future<Result<PokemonEntity>> call(int id);
}
