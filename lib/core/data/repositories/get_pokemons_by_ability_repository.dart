import '../../domain/entities/pokemon.dart';
import '../adapters/poke_api_adapter.dart';

class GetPokemonsByAbilityRepository {
  final PokeApiAdapter _adapter;

  GetPokemonsByAbilityRepository(this._adapter);

  Future<List<Pokemon>> call(String ability) async {
    return _adapter.getPokemonsByAbility(ability);
  }
}
