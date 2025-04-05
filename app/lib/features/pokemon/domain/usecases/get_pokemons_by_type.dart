import 'package:dartz/dartz.dart';

import '../entities/pokemon_entity_impl.dart';
import '../failures/pokemon_failure.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemons_by_type.dart';

/// Use case for getting Pokemon by type
class GetPokemonsByType implements IGetPokemonsByType {
  final IPokemonRepository repository;

  GetPokemonsByType(this.repository);

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> call({
    required String type,
  }) async {
    try {
      return await repository.getPokemonsByType(type: type);
    } catch (e) {
      return Left(PokemonFailure.api(message: e.toString()));
    }
  }
}
