import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_search_pokemon.dart';

/// Use case for searching Pokemon
class SearchPokemon implements ISearchPokemon {
  final IPokemonRepository repository;

  SearchPokemon(this.repository);

  @override
  Future<Either<Failure, List<PokemonEntity>>> call(String query) async {
    try {
      return await repository.searchPokemon(query);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
