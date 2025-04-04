import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';
import '../../repositories/i_pokemon_repository.dart';
import 'i_search_pokemon.dart';

/// Use case to search Pokemon
class SearchPokemon implements ISearchPokemon {
  final IPokemonRepository _repository;

  SearchPokemon(this._repository);

  @override
  Future<Result<List<PokemonEntity>>> call(String query) async {
    try {
      final result = await _repository.searchPokemon(query);
      return result;
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
