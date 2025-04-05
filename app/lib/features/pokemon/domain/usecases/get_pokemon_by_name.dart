import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemon_by_name.dart';

/// Use case to get Pokemon by name
class GetPokemonByName implements IGetPokemonByName {
  final IPokemonRepository repository;

  GetPokemonByName(this.repository);

  @override
  Future<Either<Failure, PokemonEntity>> call(String name) async {
    try {
      final result = await repository.searchPokemon(name);
      return result.fold(
        (failure) => Left(failure),
        (pokemons) => pokemons.isNotEmpty
            ? Right(pokemons.first)
            : const Left(ServerFailure(message: 'Pokemon not found')),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
