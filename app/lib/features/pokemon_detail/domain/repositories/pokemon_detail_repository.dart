import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';

abstract class PokemonDetailRepository {
  Future<Either<Failure, PokemonEntity>> getPokemonById(int id);
  Future<Either<Failure, List<PokemonEntity>>> getPokemonsByType(String type);
  Future<Either<Failure, List<PokemonEntity>>> getPokemonsByAbility(
      String ability);
}
