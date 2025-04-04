import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';

/// Interface for getting Pokemon detail
abstract class IGetPokemonDetail {
  /// Get Pokemon detail by ID
  Future<Result<PokemonEntity>> call(int id);
}
