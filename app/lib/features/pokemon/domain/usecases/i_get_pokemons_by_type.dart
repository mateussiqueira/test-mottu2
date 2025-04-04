import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';

/// Interface for getting Pokemon by type
abstract class IGetPokemonsByType {
  /// Get Pokemon by type
  Future<Result<List<PokemonEntity>>> call(String type);
}
