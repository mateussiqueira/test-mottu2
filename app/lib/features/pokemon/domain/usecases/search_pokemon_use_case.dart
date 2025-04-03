import '../../../../core/domain/errors/failure.dart';
import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_search_pokemon_use_case.dart';

/// Implementation of the SearchPokemon use case
class SearchPokemonUseCase implements ISearchPokemonUseCase {
  final IPokemonRepository _repository;

  SearchPokemonUseCase(this._repository);

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
