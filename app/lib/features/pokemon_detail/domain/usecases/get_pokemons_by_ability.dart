import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../repositories/i_pokemon_detail_repository.dart';
import 'i_get_pokemons_by_ability.dart';

class GetPokemonsByAbility implements IGetPokemonsByAbility {
  final IPokemonDetailRepository repository;

  GetPokemonsByAbility({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<PokemonEntity>>> call(String ability) async {
    try {
      return await repository.getPokemonsByAbility(ability);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
