import '../../../../core/domain/entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class SearchPokemonsUseCase {
  final PokemonRepository repository;

  SearchPokemonsUseCase(this.repository);

  Future<List<Pokemon>> call(String query) async {
    return repository.searchPokemons(query);
  }
}
