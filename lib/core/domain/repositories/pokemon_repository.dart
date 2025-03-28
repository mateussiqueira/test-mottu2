import '../entities/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemons({int offset = 0, int limit = 20});
  Future<Pokemon> getPokemonById(int id);
  Future<List<Pokemon>> searchPokemons(String query);
  Future<List<Pokemon>> getPokemonsByType(String type);
  Future<List<Pokemon>> getPokemonsByAbility(String ability);
}
