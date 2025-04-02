import '../../../../core/domain/result.dart' as core;
import '../entities/i_pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemons_by_ability.dart';

class GetPokemonsByAbility implements IGetPokemonsByAbility {
  final IPokemonRepository _repository;

  GetPokemonsByAbility(this._repository);

  @override
  Future<core.Result<List<IPokemonEntity>>> call(String ability) async {
    return _repository.getPokemonsByAbility(ability);
  }
}
