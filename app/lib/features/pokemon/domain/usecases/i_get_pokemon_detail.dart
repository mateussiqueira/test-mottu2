import '../../../../core/domain/result.dart' as core;
import '../entities/i_pokemon_entity.dart';

abstract class IGetPokemonDetail {
  Future<core.Result<IPokemonEntity>> call(int id);
}
