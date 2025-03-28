import '../../../../core/domain/entities/pokemon.dart' as core;
import '../../../../core/domain/repositories/pokemon_repository.dart';
import '../../domain/entities/pokemon.dart' as feature;
import '../adapters/poke_api_adapter.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokeApiAdapter _adapter;

  PokemonRepositoryImpl(this._adapter);

  core.Pokemon _convertToCorePokemon(feature.Pokemon pokemon) {
    return core.Pokemon(
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
    );
  }

  @override
  Future<List<core.Pokemon>> getPokemons(
      {int offset = 0, int limit = 20}) async {
    final pokemons = await _adapter.getPokemons(offset: offset, limit: limit);
    return pokemons.map(_convertToCorePokemon).toList();
  }

  @override
  Future<core.Pokemon> getPokemonById(int id) async {
    final pokemon = await _adapter.getPokemonById(id.toString());
    return _convertToCorePokemon(pokemon);
  }

  @override
  Future<List<core.Pokemon>> searchPokemons(String query) async {
    final pokemons = await _adapter.searchPokemons(query);
    return pokemons.map(_convertToCorePokemon).toList();
  }

  @override
  Future<List<core.Pokemon>> getPokemonsByType(String type) async {
    // TODO: Implement getPokemonsByType
    return [];
  }

  @override
  Future<List<core.Pokemon>> getPokemonsByAbility(String ability) async {
    // TODO: Implement getPokemonsByAbility
    return [];
  }
}
