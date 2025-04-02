import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';

class SearchPokemon {
  final IPokemonRepository repository;

  SearchPokemon(this.repository);

  Future<List<PokemonEntity>> call(String query) async {
    final result = await repository.searchPokemon(query);
    if (result.isSuccess && result.data != null) {
      return result.data!;
    }
    throw Exception(result.error?.toString() ?? 'Unknown error');
  }
}
