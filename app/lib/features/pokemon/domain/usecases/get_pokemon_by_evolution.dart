import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';

/// Use case for getting Pokemon by evolution
class GetPokemonsByEvolution {
  final PokemonRepository repository;

  GetPokemonsByEvolution(this.repository);

  Future<Either<Failure, List<PokemonEntity>>> call(String evolution) async {
    return await repository.getPokemonsByEvolution(evolution);
  }
}
