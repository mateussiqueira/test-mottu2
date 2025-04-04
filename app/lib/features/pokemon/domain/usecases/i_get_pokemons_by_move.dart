import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';

/// Interface for getting Pokemon by move
abstract class IGetPokemonsByMove {
  /// Get Pokemon by move
  Future<Result<List<PokemonEntity>>> call(String move);
}
