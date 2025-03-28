import '../../../../core/domain/entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonsUseCase {
  final PokemonRepository repository;

  GetPokemonsUseCase(this.repository);

  Future<List<Pokemon>> call({int offset = 0, int limit = 20}) async {
    final pokemons = await repository.getPokemons(offset: offset, limit: limit);
    return pokemons
        .map((pokemon) => Pokemon(
              id: int.parse(pokemon.id),
              name: pokemon.name,
              imageUrl: pokemon.imageUrl,
              types: pokemon.types,
              abilities: pokemon.abilities,
              stats: pokemon.stats.entries
                  .map((e) => {
                        'name': e.key,
                        'value': e.value,
                      })
                  .toList(),
              height: pokemon.height,
              weight: pokemon.weight,
              evolutionChain: pokemon.evolutionChain,
              locations: pokemon.locations,
              moves: const [], // TODO: Implement moves
            ))
        .toList();
  }
}
