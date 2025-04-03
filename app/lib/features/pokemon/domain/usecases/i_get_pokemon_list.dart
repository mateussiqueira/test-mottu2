import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';

/// Interface for the GetPokemonList use case
abstract class IGetPokemonList {
  /// Fetches a list of Pokemon with pagination support
  ///
  /// [limit] - Maximum number of Pokemon to return
  /// [offset] - Number of Pokemon to skip
  /// Returns a [Result] containing either a list of Pokemon or an error
  Future<Result<List<PokemonEntity>>> call({int? limit, int? offset});
}
