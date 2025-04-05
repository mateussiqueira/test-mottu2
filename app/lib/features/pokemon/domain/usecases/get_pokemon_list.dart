import 'package:dartz/dartz.dart';

import '../entities/pokemon_entity_impl.dart';
import '../failures/pokemon_failure.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemon_list.dart';

/// Use case for getting Pokemon list
class GetPokemonList implements IGetPokemonList {
  final IPokemonRepository repository;

  GetPokemonList(this.repository);

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> call({
    required int offset,
    required int limit,
  }) async {
    try {
      return await repository.getPokemonList(
        offset: offset,
        limit: limit,
      );
    } catch (e) {
      return Left(PokemonFailure.api(message: e.toString()));
    }
  }
}
