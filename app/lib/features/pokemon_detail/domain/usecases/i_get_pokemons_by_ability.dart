import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';

abstract class IGetPokemonsByAbility {
  Future<Either<Failure, List<PokemonEntity>>> call(String ability);
}
