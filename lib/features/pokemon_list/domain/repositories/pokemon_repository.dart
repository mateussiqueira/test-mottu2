import '../entities/pokemon.dart';

abstract class PokemonRepository {
  Future<List<PokemonEntity>> getPokemons({int offset = 0, int limit = 20});
  Future<PokemonEntity> getPokemonById(int id);
  Future<List<PokemonEntity>> searchPokemons(String query);
  Future<List<PokemonEntity>> getPokemonsByType(String type);
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability);
  Future<PokemonEntity> getPokemonByName(String name);
  Future<void> clearCache();
}
