import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';

/// Interface for getting Pokemon by name
abstract class IGetPokemonByName {
  /// Get Pokemon by name
  Future<Result<PokemonEntity>> call(String name);
}
