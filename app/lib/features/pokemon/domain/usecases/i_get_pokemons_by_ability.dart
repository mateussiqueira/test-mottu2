import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';

/// Interface for getting Pokemon by ability
abstract class IGetPokemonsByAbility {
  /// Get Pokemon by ability
  Future<Result<List<PokemonEntity>>> call(String ability);
}
