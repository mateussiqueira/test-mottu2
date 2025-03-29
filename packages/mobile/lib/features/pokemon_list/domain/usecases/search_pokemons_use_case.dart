import '../../../../core/domain/result.dart' as core;
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

class SearchPokemonsUseCase {
  final PokemonRepository repository;

  SearchPokemonsUseCase(this.repository);

  Future<core.Result<List<PokemonEntityImpl>>> call(String query) async {
    return repository.searchPokemon(query);
  }
}
