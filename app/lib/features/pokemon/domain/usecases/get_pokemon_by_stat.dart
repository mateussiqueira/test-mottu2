import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';

/// Use case for getting Pokemon by stat
class GetPokemonsByStat {
  final PokemonRepository repository;

  GetPokemonsByStat(this.repository);

  Future<Either<Failure, List<PokemonEntity>>> call(String stat) async {
    return await repository.getPokemonsByStat(stat);
  }
}
