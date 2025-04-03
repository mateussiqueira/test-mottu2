import '../../domain/entities/pokemon_entity.dart';

abstract class IPokemonRemoteDataSource {
  Future<List<PokemonEntity>> getPokemonList({int? limit, int? offset});
  Future<PokemonEntity> getPokemonById(int id);
  Future<List<PokemonEntity>> getPokemonsByType(String type);
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability);
  Future<List<PokemonEntity>> getPokemonsByMove(String move);
  Future<List<PokemonEntity>> getPokemonsByEvolution(String evolution);
  Future<List<PokemonEntity>> getPokemonsByStat(String stat, int value);
  Future<List<PokemonEntity>> getPokemonsByDescription(String description);
  Future<List<PokemonEntity>> searchPokemons(String query);
}
