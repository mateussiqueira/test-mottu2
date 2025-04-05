import 'package:dartz/dartz.dart';

import '../entities/pokemon_entity_impl.dart';
import '../failures/pokemon_failure.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemon_detail.dart';

/// Use case for getting Pokemon detail
class GetPokemonDetail implements IGetPokemonDetail {
  final IPokemonRepository repository;

  GetPokemonDetail(this.repository);

  @override
  Future<Either<PokemonFailure, PokemonEntityImpl>> call({
    required int id,
  }) async {
    try {
      return await repository.getPokemonById(id: id);
    } catch (e) {
      return Left(PokemonFailure.api(message: e.toString()));
    }
  }
}
