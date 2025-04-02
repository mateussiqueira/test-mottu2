import '../../domain/entities/i_pokemon_entity.dart';

abstract class IPokemonRemoteDataSource {
  Future<List<IPokemonEntity>> getPokemons({int? limit, int? offset});

  Future<IPokemonEntity> getPokemonDetail(int id);

  Future<List<IPokemonEntity>> getPokemonsByType(String type);

  Future<List<IPokemonEntity>> getPokemonsByAbility(String ability);

  Future<List<IPokemonEntity>> searchPokemons(String query);
}
