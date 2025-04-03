import '../../../../core/domain/errors/result.dart';
import '../../../pokemon/domain/entities/i_pokemon_entity.dart';

abstract class PokemonDetailRepository {
  Future<Result<IPokemonEntity>> getPokemonById(int id);
  Future<Result<List<IPokemonEntity>>> getPokemonsByType(String type);
  Future<Result<List<IPokemonEntity>>> getPokemonsByAbility(String ability);
}
