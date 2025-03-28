import '../../domain/entities/pokemon.dart';
import '../adapters/poke_api_adapter.dart';

class GetPokemonByIdRepository {
  final PokeApiAdapter _adapter;

  GetPokemonByIdRepository(this._adapter);

  Future<Pokemon> call(int id) async {
    return _adapter.getPokemonById(id);
  }
}
