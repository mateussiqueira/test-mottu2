import 'package:dartz/dartz.dart';

import '../entities/pokemon_entity_impl.dart';
import '../failures/pokemon_failure.dart';

/// Interface for getting Pokemon by type
abstract class IGetPokemonsByType {
  /// Get Pokemon by type
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> call({
    required String type,
  });
}
