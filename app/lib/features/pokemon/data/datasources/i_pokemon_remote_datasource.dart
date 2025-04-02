import '../../domain/entities/pokemon_entity.dart';

abstract class IPokemonRemoteDataSource {
  Future<List<PokemonEntity>> getPokemonList({
    required int offset,
    required int limit,
  });

  Future<PokemonEntity> getPokemonDetail(int id);

  Future<List<PokemonEntity>> searchPokemon(String query);

  Future<List<PokemonEntity>> getPokemonsByType(String type);

  Future<List<PokemonEntity>> getPokemonsByAbility(String ability);
}
