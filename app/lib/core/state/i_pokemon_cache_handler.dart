import '../../../features/pokemon/domain/entities/i_pokemon_entity.dart';

abstract class IPokemonCacheHandler {
  Future<void> cachePokemons(List<IPokemonEntity> pokemons);
  Future<List<IPokemonEntity>?> loadCachedPokemons();
}
