import '../entities/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemons({int offset = 0, int limit = 20});
  Future<Pokemon> getPokemonById(String id);
  Future<List<Pokemon>> searchPokemons(String query);
}
