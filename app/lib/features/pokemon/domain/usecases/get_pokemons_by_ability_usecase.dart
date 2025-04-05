import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/result/result.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemons_by_ability.dart';

/// Use case to get Pokemon by ability
class GetPokemonsByAbilityUseCase implements IGetPokemonsByAbility {
  final IPokemonRepository _repository;

  GetPokemonsByAbilityUseCase(this._repository);

  @override
  Future<Result<List<PokemonEntity>>> call(String ability) async {
    try {
      final result = await _repository.getPokemonsByAbility(ability);
      return result;
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
