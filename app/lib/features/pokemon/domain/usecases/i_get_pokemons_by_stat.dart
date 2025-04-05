import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon_entity.dart';

/// Interface for getting Pokemon by stat
abstract class IGetPokemonsByStat {
  /// Get Pokemon by stat
  Future<Either<Failure, List<PokemonEntity>>> call(String stat, int value);
}
