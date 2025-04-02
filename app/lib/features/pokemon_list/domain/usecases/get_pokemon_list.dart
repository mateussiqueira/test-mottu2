import '../../../../core/domain/result.dart' as core;
import '../../../../features/pokemon/domain/entities/i_pokemon_entity.dart';
import '../../../../features/pokemon/domain/repositories/i_pokemon_repository.dart';

/// Use case for fetching a list of Pokemon
class GetPokemonList {
  final IPokemonRepository repository;

  GetPokemonList({
    required this.repository,
  });

  /// Fetches a list of Pokemon with pagination
  ///
  /// [offset] - The starting point for pagination (default: 0)
  /// [limit] - The maximum number of Pokemon to fetch (default: 20)
  /// Returns a [Result] containing a list of [IPokemonEntity]
  Future<core.Result<List<IPokemonEntity>>> call({
    int offset = 0,
    int limit = 20,
  }) {
    return repository.getPokemonList(
      offset: offset,
      limit: limit,
    );
  }
}
