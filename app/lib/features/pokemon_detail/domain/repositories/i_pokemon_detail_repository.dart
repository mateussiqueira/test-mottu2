import '../../../../core/domain/result.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';

abstract class IPokemonDetailRepository {
  Future<Result<List<PokemonEntity>>> getPokemonsByType(String type);
  Future<Result<List<PokemonEntity>>> getPokemonsByAbility(String ability);
}
