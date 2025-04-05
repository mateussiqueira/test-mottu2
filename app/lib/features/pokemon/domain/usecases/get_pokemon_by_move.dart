import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemons_by_move.dart';

/// Use case for getting Pokemon by move
class GetPokemonsByMove implements IGetPokemonsByMove {
  final IPokemonRepository repository;

  GetPokemonsByMove(this.repository);

  @override
  Future<Either<Failure, List<PokemonEntity>>> call(String move) async {
    try {
      return await repository.getPokemonsByMove(move);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
