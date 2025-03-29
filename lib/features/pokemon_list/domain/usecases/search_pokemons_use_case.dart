import 'package:pokeapi/features/pokemon_list/domain/entities/pokemon.dart';

import '../repositories/pokemon_repository.dart';

class SearchPokemonsUseCase {
  final PokemonRepository repository;

  SearchPokemonsUseCase(this.repository);

  Future<List<PokemonEntity>> call(String query) async {
    return repository.searchPokemons(query);
  }
}
