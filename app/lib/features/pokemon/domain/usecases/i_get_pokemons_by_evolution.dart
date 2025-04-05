import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon_entity.dart';

/// Interface for getting Pokemon by evolution
abstract class IGetPokemonsByEvolution {
  /// Get Pokemon by evolution
  Future<Either<Failure, List<PokemonEntity>>> call(String evolution);
}
