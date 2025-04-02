import '../../../../core/domain/result.dart' as core;
import '../entities/i_pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_search_pokemon_use_case.dart';

/// Implementation of the SearchPokemon use case
class SearchPokemonUseCase implements ISearchPokemonUseCase {
  final IPokemonRepository _repository;

  SearchPokemonUseCase(this._repository);

  @override
  Future<core.Result<List<IPokemonEntity>>> call(String query) async {
    try {
      return await _repository.searchPokemon(query);
    } catch (e) {
      return core.Result.failure('Failed to search Pokemon: ${e.toString()}');
    }
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
