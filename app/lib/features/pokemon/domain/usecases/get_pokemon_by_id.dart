import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemon_by_id.dart';

/// Use case to get a Pokemon by ID
class GetPokemonById implements IGetPokemonById {
  final IPokemonRepository repository;

  GetPokemonById(this.repository);

  @override
  Future<Either<Failure, PokemonEntity>> call(int id) async {
    try {
      return await repository.getPokemonById(id);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
