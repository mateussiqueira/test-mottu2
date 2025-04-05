import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon_entity.dart';

/// Interface for getting Pokemon by name
abstract class IGetPokemonByName {
  /// Get Pokemon by name
  Future<Either<Failure, PokemonEntity>> call(String name);
}
