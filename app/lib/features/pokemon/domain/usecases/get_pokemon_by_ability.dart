import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';

/// Use case for getting Pokemon by ability
class GetPokemonsByAbility {
  final PokemonRepository repository;

  GetPokemonsByAbility(this.repository);

  Future<Either<Failure, List<PokemonEntity>>> call(String ability) async {
    return await repository.getPokemonsByAbility(ability);
  }
}
