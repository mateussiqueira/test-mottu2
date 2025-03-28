import '../../domain/entities/pokemon.dart';
import '../adapters/poke_api_adapter.dart';

class GetPokemonsByTypeRepository {
  final PokeApiAdapter _adapter;

  GetPokemonsByTypeRepository(this._adapter);

  Future<List<Pokemon>> call(String type) async {
    return _adapter.getPokemonsByType(type);
  }
}
