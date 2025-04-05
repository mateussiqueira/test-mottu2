import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon_entity.dart';

/// Interface for getting Pokemon by move
abstract class IGetPokemonsByMove {
  /// Get Pokemon by move
  Future<Either<Failure, List<PokemonEntity>>> call(String move);
}
