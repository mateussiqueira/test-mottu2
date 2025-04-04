import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';

/// Use case for getting Pokemon by type
class GetPokemonsByType {
  final PokemonRepository repository;

  GetPokemonsByType(this.repository);

  Future<Either<Failure, List<PokemonEntity>>> call(String type) async {
    return await repository.getPokemonsByType(type);
  }
}
