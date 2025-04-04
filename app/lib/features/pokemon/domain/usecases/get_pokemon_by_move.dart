import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';

/// Use case for getting Pokemon by move
class GetPokemonsByMove {
  final PokemonRepository repository;

  GetPokemonsByMove(this.repository);

  Future<Either<Failure, List<PokemonEntity>>> call(String move) async {
    return await repository.getPokemonsByMove(move);
  }
}
