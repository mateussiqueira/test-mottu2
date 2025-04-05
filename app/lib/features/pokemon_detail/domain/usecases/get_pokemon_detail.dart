import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';
import 'i_get_pokemon_detail.dart';

/// Use case for getting Pokemon details
class GetPokemonDetail implements IGetPokemonDetail {
  final IPokemonRepository repository;

  GetPokemonDetail(this.repository);

  @override
  Future<Either<Failure, PokemonEntity>> call(int id) async {
    try {
      return await repository.getPokemonById(id);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
