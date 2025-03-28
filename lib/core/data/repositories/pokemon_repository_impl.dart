import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../adapters/poke_api_adapter.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokeApiAdapter _adapter;

  PokemonRepositoryImpl(this._adapter);

  @override
  Future<List<Pokemon>> getPokemons({int limit = 20, int offset = 0}) async {
    return _adapter.getPokemons(limit: limit, offset: offset);
  }

  @override
  Future<Pokemon> getPokemonByName(String name) async {
    return _adapter.getPokemonByName(name);
  }

  @override
  Future<List<Pokemon>> getPokemonsByType(String type) async {
    return _adapter.getPokemonsByType(type);
  }

  @override
  Future<List<Pokemon>> getPokemonsByAbility(String ability) async {
    return _adapter.getPokemonsByAbility(ability);
  }

  @override
  Future<void> clearCache() async {
    await _adapter.clearCache();
  }
}
