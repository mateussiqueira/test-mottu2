import '../../../../core/domain/result.dart' as core;
import '../entities/i_pokemon_entity.dart';

abstract class ISearchPokemon {
  Future<core.Result<List<IPokemonEntity>>> call(String query);
}
