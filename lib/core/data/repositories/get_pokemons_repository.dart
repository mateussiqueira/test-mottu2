import '../../domain/entities/pokemon.dart';
import '../adapters/poke_api_adapter.dart';

class GetPokemonsRepository {
  final PokeApiAdapter _adapter;

  GetPokemonsRepository(this._adapter);

  Future<List<Pokemon>> call({int limit = 20, int offset = 0}) async {
    return _adapter.getPokemons(limit: limit, offset: offset);
  }
}
