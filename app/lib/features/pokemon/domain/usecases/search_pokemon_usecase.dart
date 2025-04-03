import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_search_pokemon_usecase.dart';

/// Implementation of the SearchPokemon use case
class SearchPokemonUseCase implements ISearchPokemonUseCase {
  final IPokemonRepository _repository;

  SearchPokemonUseCase(this._repository);

  @override
  Future<Result<List<PokemonEntity>>> call(String query) async {
    return await _repository.searchPokemon(query);
  }

  @override
  String toString() {
    return 'SearchPokemonUseCase()';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SearchPokemonUseCase && other._repository == _repository;
  }

  @override
  int get hashCode => _repository.hashCode;
}
