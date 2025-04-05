import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon_entity.dart';

/// Interface for getting Pokemon by description
abstract class IGetPokemonsByDescription {
  /// Get Pokemon by description
  Future<Either<Failure, List<PokemonEntity>>> call(String description);
}
