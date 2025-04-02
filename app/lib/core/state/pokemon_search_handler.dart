import '../../../features/pokemon/domain/entities/i_pokemon_entity.dart';
import 'i_pokemon_search_handler.dart';

class PokemonSearchHandler implements IPokemonSearchHandler {
  @override
  List<IPokemonEntity> filterPokemons(
      List<IPokemonEntity> pokemons, String query) {
    if (query.isEmpty) {
      return pokemons;
    }

    final lowercaseQuery = query.toLowerCase();
    return pokemons
        .where((pokemon) => _matchesSearch(pokemon, lowercaseQuery))
        .toList();
  }

  bool _matchesSearch(IPokemonEntity pokemon, String query) {
    return pokemon.name.toLowerCase().contains(query) ||
        pokemon.types.any((type) => type.toLowerCase().contains(query));
  }
}
