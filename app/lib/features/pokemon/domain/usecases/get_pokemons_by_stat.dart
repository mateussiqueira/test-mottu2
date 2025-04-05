import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemons_by_stat.dart';

/// Use case to get Pokemon by stat
class GetPokemonsByStat implements IGetPokemonsByStat {
  final IPokemonRepository repository;

  GetPokemonsByStat(this.repository);

  @override
  Future<Either<Failure, List<PokemonEntity>>> call(
      String stat, int value) async {
    try {
      return await repository.getPokemonsByStat(stat, value);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
