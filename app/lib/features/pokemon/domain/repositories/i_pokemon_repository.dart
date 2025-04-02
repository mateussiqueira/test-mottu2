import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';

abstract class IPokemonRepository {
  Future<Result<List<PokemonEntity>>> getPokemonList({
    int offset = 0,
    int limit = 20,
  });

  Future<Result<PokemonEntity>> getPokemonDetail(int id);

  Future<Result<List<PokemonEntity>>> searchPokemon(String query);

  Future<Result<List<PokemonEntity>>> getPokemonsByType(String type);

  Future<Result<List<PokemonEntity>>> getPokemonsByAbility(String ability);
}
