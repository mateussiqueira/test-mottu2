import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemons_by_description.dart';

/// Use case for getting Pokemon by description
class GetPokemonsByDescription implements IGetPokemonsByDescription {
  final IPokemonRepository repository;

  GetPokemonsByDescription(this.repository);

  @override
  Future<Either<Failure, List<PokemonEntity>>> call(String description) async {
    try {
      return await repository.getPokemonsByDescription(description);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
