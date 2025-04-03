import '../../../../core/domain/errors/failure.dart';
import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_search_pokemon.dart';

class SearchPokemon implements ISearchPokemon {
  final IPokemonRepository _repository;

  SearchPokemon(this._repository);

  @override
  Future<Result<List<PokemonEntity>>> call(String query) async {
    try {
      final result = await _repository.searchPokemon(query);
      return result;
    } catch (e) {
      return Result.failure(
          Failure(message: 'Failed to search Pokemon: ${e.toString()}'));
    }
  }
}
