import 'package:dartz/dartz.dart';

import '../entities/pokemon_entity_impl.dart';
import '../failures/pokemon_failure.dart';

/// Interface for getting Pokemon detail
abstract class IGetPokemonDetail {
  /// Get Pokemon detail by ID
  Future<Either<PokemonFailure, PokemonEntityImpl>> call({
    required int id,
  });
}
