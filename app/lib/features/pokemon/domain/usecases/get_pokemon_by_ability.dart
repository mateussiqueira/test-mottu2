import 'package:dartz/dartz.dart';

import '../entities/pokemon_entity_impl.dart';
import '../failures/pokemon_failure.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemons_by_ability.dart';

/// Use case for getting Pokemon by ability
class GetPokemonsByAbility implements IGetPokemonsByAbility {
  final IPokemonRepository repository;

  GetPokemonsByAbility(this.repository);

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> call({
    required String ability,
  }) async {
    try {
      return await repository.getPokemonsByAbility(ability: ability);
    } catch (e) {
      return Left(PokemonFailure.api(message: e.toString()));
    }
  }
}
