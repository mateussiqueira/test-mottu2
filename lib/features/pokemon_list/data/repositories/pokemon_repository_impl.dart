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
      baseExperience: 0,
      height: pokemon.height,
      weight: pokemon.weight,
      isDefault: true,
      order: 0,
      sprites: core.Sprites(
        backDefault: '',
        backFemale: '',
        backShiny: '',
        backShinyFemale: '',
        frontDefault: '',
        frontFemale: '',
        frontShiny: '',
        frontShinyFemale: '',
        other: core.Other(
          dreamWorld: core.DreamWorld(
            frontDefault: '',
            frontFemale: '',
          ),
          home: core.Home(
            frontDefault: '',
            frontFemale: '',
            frontShiny: '',
            frontShinyFemale: '',
          ),
          officialArtwork: core.OfficialArtwork(
            frontDefault: pokemon.imageUrl,
            frontShiny: '',
          ),
        ),
      ),
      types: pokemon.types
          .map((type) => core.Type(
                slot: 1,
                type: core.Species(
                  name: type,
                  url: '',
                ),
              ))
          .toList(),
      abilities: pokemon.abilities
          .map((ability) => core.Ability(
                ability: core.Species(
                  name: ability,
                  url: '',
                ),
                isHidden: false,
                slot: 1,
              ))
          .toList(),
      stats: pokemon.stats.entries
          .map((e) => core.Stat(
                baseStat: e.value,
                effort: 0,
                stat: core.Species(
                  name: e.key,
                  url: '',
                ),
              ))
          .toList(),
      moves: pokemon.moves
          .map((move) => core.Move(
                move: core.Species(
                  name: move['name'] as String? ?? '',
                  url: '',
                ),
                versionGroupDetails: [],
              ))
          .toList(),
      forms: [],
      gameIndices: [],
      heldItems: [],
      locationAreaEncounters: '',
      cries: core.Cries(
        latest: '',
        legacy: '',
      ),
      pastAbilities: [],
      pastTypes: [],
      species: core.Species(
        name: pokemon.name,
        url: '',
      ),
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
