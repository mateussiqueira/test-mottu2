import '../../../../core/domain/entities/pokemon.dart' as core;
import '../../../../core/domain/repositories/pokemon_repository.dart';
import '../../domain/entities/pokemon.dart' as feature;
import '../adapters/poke_api_adapter.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokeApiAdapter _adapter;

  PokemonRepositoryImpl(this._adapter);

  core.Pokemon _convertToCorePokemon(feature.Pokemon pokemon) {
    return core.Pokemon(
      id: int.tryParse(pokemon.id) ?? 0,
      name: pokemon.name,
      baseExperience: 0, // Not available in feature model
      height: pokemon.height,
      weight: pokemon.weight,
      isDefault: true, // Default value
      order: 0, // Not available in feature model
      sprites: {
        'other': {
          'official-artwork': {
            'front_default': pokemon.imageUrl,
          },
        },
      },
      types: pokemon.types
          .map((type) => {
                'type': {'name': type}
              })
          .toList(),
      abilities: pokemon.abilities
          .map((ability) => {
                'ability': {'name': ability}
              })
          .toList(),
      stats: pokemon.stats.entries
          .map((e) => {
                'stat': {'name': e.key},
                'base_stat': e.value,
              })
          .toList(),
      moves: pokemon.moves
          .map((move) => {
                'move': {'name': move['name']}
              })
          .toList(),
      forms: [], // Not available in feature model
      gameIndices: [], // Not available in feature model
      heldItems: [], // Not available in feature model
      locationAreaEncounters: '', // Not available in feature model
      cries: [], // Not available in feature model
      pastAbilities: [], // Not available in feature model
      pastTypes: [], // Not available in feature model
      species: {}, // Not available in feature model
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
    final pokemon = await _adapter.getPokemonById(id);
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
