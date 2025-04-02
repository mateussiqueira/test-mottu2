import '../../../../core/domain/result.dart' as core;
import '../entities/i_pokemon_entity.dart';

/// Mixin for the GetPokemonList use case
mixin IGetPokemonListUseCase {
  /// Fetches a list of Pokemon with pagination support
  ///
  /// [limit] - Maximum number of Pokemon to return
  /// [offset] - Number of Pokemon to skip
  /// Returns a [Result] containing either a list of Pokemon or an error
  Future<core.Result<List<IPokemonEntity>>> call({
    required int limit,
    required int offset,
  });
}
