import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';

abstract class IGetPokemonDetail {
  Future<Result<PokemonEntity>> call(int id);
}
