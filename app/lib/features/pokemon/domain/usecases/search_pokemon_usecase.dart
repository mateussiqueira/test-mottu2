import 'package:mobile/core/domain/result.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_list/domain/repositories/pokemon_repository.dart';

class SearchPokemonUseCase {
  final PokemonRepository _repository;

  SearchPokemonUseCase(this._repository);

  Future<Result<List<PokemonEntityImpl>>> call(String query) async {
    return _repository.searchPokemon(query);
  }
}
