import '../../../../core/domain/result.dart' as core;
import '../entities/i_pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_search_pokemon.dart';

class SearchPokemon implements ISearchPokemon {
  final IPokemonRepository _repository;

  SearchPokemon(this._repository);

  @override
  Future<core.Result<List<IPokemonEntity>>> call(String query) async {
    return _repository.searchPokemon(query);
  }
}
