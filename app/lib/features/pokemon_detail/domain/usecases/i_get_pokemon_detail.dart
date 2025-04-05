import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';

/// Interface for the GetPokemonDetail use case
abstract class IGetPokemonDetail {
  /// Fetches details of a specific Pokemon
  ///
  /// [id] - The ID of the Pokemon to fetch
  /// Returns a [Either] containing either the Pokemon details or an error
  Future<Either<Failure, PokemonEntity>> call(int id);
}
