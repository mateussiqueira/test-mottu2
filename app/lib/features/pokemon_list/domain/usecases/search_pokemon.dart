import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';
import '../../../../features/pokemon/domain/repositories/pokemon_repository.dart';

class SearchPokemon {
  final PokemonRepository repository;

  SearchPokemon({
    required this.repository,
  });

  Future<List<PokemonEntity>> call(String query) async {
    return await repository.searchPokemon(query);
  }
}
