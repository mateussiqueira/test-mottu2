import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon_entity.dart';

/// Interface for getting Pokemon by ID
abstract class IGetPokemonById {
  /// Get Pokemon by ID
  Future<Either<Failure, PokemonEntity>> call(int id);
}
