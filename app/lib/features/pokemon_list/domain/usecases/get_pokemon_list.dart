import '../../../../core/domain/errors/result.dart';
import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';
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
  /// Returns a [Result] containing a list of [PokemonEntity]
  Future<Result<List<PokemonEntity>>> call({
    int offset = 0,
    int limit = 20,
  }) {
    return repository.getPokemonList(
      offset: offset,
      limit: limit,
    );
  }
}
