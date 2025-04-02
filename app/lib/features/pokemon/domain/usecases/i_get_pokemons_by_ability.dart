import '../../../../core/domain/result.dart' as core;
import '../entities/i_pokemon_entity.dart';

abstract class IGetPokemonsByAbility {
  Future<core.Result<List<IPokemonEntity>>> call(String ability);
}
