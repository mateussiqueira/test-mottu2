import 'package:dartz/dartz.dart';

import '../entities/pokemon_entity_impl.dart';
import '../failures/pokemon_failure.dart';

/// Interface for getting Pokemon by ability
abstract class IGetPokemonsByAbility {
  /// Get Pokemon by ability
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> call({
    required String ability,
  });
}
