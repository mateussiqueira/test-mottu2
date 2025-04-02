import '../../../../core/domain/result.dart' as core;
import '../entities/i_pokemon_entity.dart';

abstract class IGetPokemonList {
  Future<core.Result<List<IPokemonEntity>>> call({
    required int limit,
    required int offset,
  });
}
