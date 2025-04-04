import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';

/// Interface for getting Pokemon by description
abstract class IGetPokemonsByDescription {
  /// Get Pokemon by description
  Future<Result<List<PokemonEntity>>> call(String description);
}
