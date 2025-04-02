import '../../../features/pokemon/domain/entities/i_pokemon_entity.dart';

abstract class IPokeApiAdapter {
  Future<List<IPokemonEntity>> getPokemons({int offset = 0, int limit = 20});
  Future<IPokemonEntity> getPokemonById(int id);
  Future<IPokemonEntity> getPokemonByName(String name);
  Future<List<IPokemonEntity>> searchPokemons(String query);
  Future<List<IPokemonEntity>> getPokemonsByType(String type);
  Future<List<IPokemonEntity>> getPokemonsByAbility(String ability);
  Future<void> clearCache();
}
