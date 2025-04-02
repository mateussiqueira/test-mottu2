import '../../features/pokemon/domain/entities/pokemon_entity.dart';
import 'base_cache_module.dart';

class PokemonCacheModule extends BaseCacheModule {
  PokemonCacheModule() : super('pokemon_cache');

  Future<void> cachePokemon(PokemonEntity pokemon) async {
    await set('pokemon_${pokemon.id}', pokemon.toJson());
  }

  Future<PokemonEntity?> getCachedPokemon(int id) async {
    final json = await get('pokemon_$id');
    if (json != null) {
      return PokemonEntity.fromJson(json as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> cachePokemonList(List<PokemonEntity> pokemons) async {
    await set('pokemon_list', pokemons.map((p) => p.toJson()).toList());
  }

  Future<List<PokemonEntity>?> getCachedPokemonList() async {
    final json = await get('pokemon_list');
    if (json != null) {
      return (json as List)
          .map((p) => PokemonEntity.fromJson(p as Map<String, dynamic>))
          .toList();
    }
    return null;
  }

  Future<void> clearPokemonCache() async {
    await remove('pokemon_list');
  }

  @override
  Future<void> setup() async {
    await super.setup();
  }
}
