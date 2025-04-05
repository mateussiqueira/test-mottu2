import 'package:dartz/dartz.dart';

import '../entities/pokemon_entity_impl.dart';
import '../failures/pokemon_failure.dart';

/// Interface for the GetPokemonList use case
abstract class IGetPokemonList {
  /// Fetches a list of Pokemon with pagination
  ///
  /// [offset] - The starting point for pagination (default: 0)
  /// [limit] - The maximum number of Pokemon to fetch (default: 20)
  /// Returns an [Either] containing a list of [PokemonEntityImpl] or a [PokemonFailure]
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> call({
    required int offset,
    required int limit,
  });
}
