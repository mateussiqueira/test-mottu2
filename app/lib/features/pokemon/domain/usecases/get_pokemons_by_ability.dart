import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemons_by_ability.dart';

/// Use case to get Pokemon by ability
class GetPokemonsByAbility implements IGetPokemonsByAbility {
  final IPokemonRepository repository;

  GetPokemonsByAbility(this.repository);

  @override
  Future<Either<Failure, List<PokemonEntity>>> call(String ability) async {
    try {
      return await repository.getPokemonsByAbility(ability);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
