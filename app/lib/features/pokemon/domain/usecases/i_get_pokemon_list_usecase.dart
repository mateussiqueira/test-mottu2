import '../../../../core/result/result.dart';
import '../entities/pokemon_entity.dart';

/// Interface for getting a list of Pokemon
abstract class IGetPokemonListUseCase {
  /// Get a list of Pokemon
  Future<Result<List<PokemonEntity>>> call({
    required int limit,
    required int offset,
  });
}
