import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemons_by_evolution.dart';

/// Use case to get Pokemon by evolution
class GetPokemonsByEvolution implements IGetPokemonsByEvolution {
  final IPokemonRepository repository;

  GetPokemonsByEvolution(this.repository);

  @override
  Future<Either<Failure, List<PokemonEntity>>> call(String evolution) async {
    try {
      return await repository.getPokemonsByEvolution(evolution);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
