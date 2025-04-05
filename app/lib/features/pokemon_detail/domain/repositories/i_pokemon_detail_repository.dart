import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';

abstract class IPokemonDetailRepository {
  Future<Either<Failure, List<PokemonEntity>>> getPokemonsByType(String type);
  Future<Either<Failure, List<PokemonEntity>>> getPokemonsByAbility(
      String ability);
}
