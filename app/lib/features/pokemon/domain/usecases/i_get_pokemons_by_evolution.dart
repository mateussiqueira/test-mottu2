import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';

/// Interface for getting Pokemon by evolution
abstract class IGetPokemonsByEvolution {
  /// Get Pokemon by evolution
  Future<Result<List<PokemonEntity>>> call(String evolution);
}
