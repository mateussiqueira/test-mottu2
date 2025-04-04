import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';

/// Use case for getting Pokemon by description
class GetPokemonsByDescription {
  final PokemonRepository repository;

  GetPokemonsByDescription(this.repository);

  Future<Either<Failure, List<PokemonEntity>>> call(String description) async {
    return await repository.getPokemonsByDescription(description);
  }
}
