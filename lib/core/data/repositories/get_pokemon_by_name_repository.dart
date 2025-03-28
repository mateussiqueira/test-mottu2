import '../../domain/entities/pokemon.dart';
import '../adapters/poke_api_adapter.dart';

class GetPokemonByNameRepository {
  final PokeApiAdapter _adapter;

  GetPokemonByNameRepository(this._adapter);

  Future<Pokemon> call(String name) async {
    return _adapter.getPokemonByName(name);
  }
}
