import '../../../features/pokemon/domain/entities/i_pokemon_entity.dart';

abstract class IPokemonCacheManager {
  Future<void> savePokemonList(List<IPokemonEntity> pokemons);
  Future<List<IPokemonEntity>?> getPokemonList();
  Future<void> savePokemonDetail(IPokemonEntity pokemon);
  Future<IPokemonEntity?> getPokemonDetail(int id);
  Future<void> clearPokemonList();
  Future<void> clearPokemonDetail(int id);
  Future<void> clearAll();
}
