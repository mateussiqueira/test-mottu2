import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon_entity.dart';

/// Interface for searching Pokemon
abstract class ISearchPokemon {
  /// Search Pokemon by query
  Future<Either<Failure, List<PokemonEntity>>> call(String query);
}
