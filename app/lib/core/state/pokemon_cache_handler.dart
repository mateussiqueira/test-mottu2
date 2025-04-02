import '../../../features/pokemon/domain/entities/i_pokemon_entity.dart';
import '../cache/i_pokemon_cache_manager.dart';
import 'i_pokemon_cache_handler.dart';

class PokemonCacheHandler implements IPokemonCacheHandler {
  final IPokemonCacheManager _cacheManager;
  static const String _pokemonListKey = 'pokemon_list';
  static const Duration _cacheDuration = Duration(hours: 1);

  PokemonCacheHandler(this._cacheManager);

  @override
  Future<void> cachePokemons(List<IPokemonEntity> pokemons) async {
    await _cacheManager.savePokemonList(pokemons);
  }

  @override
  Future<List<IPokemonEntity>?> loadCachedPokemons() async {
    return await _cacheManager.getPokemonList();
  }
}
