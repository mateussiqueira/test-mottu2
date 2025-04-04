import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';

/// Interface for getting Pokemon list
abstract class IGetPokemonList {
  /// Get Pokemon list with pagination
  Future<Result<List<PokemonEntity>>> call({
    int? limit,
    int? offset,
  });
}
