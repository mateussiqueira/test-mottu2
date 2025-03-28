import 'dart:convert';

import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../adapters/poke_api_adapter.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokeApiAdapter _adapter;
  static const String _baseUrl = 'https://pokeapi.co/api/v2';

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

  @override
  Future<Pokemon> getPokemonById(int id) async {
    return _adapter.getPokemonById(id);
  }

  @override
  Future<List<Pokemon>> searchPokemons(String query) async {
    try {
      final response = await _adapter.client.get(
        Uri.parse('$_baseUrl/pokemon?limit=1118'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        final List<Pokemon> pokemons = [];

        for (var result in results) {
          if (result['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase())) {
            final urlParts = result['url'].split('/');
            final id = int.parse(urlParts[urlParts.length - 2]);
            final pokemon = await _adapter.getPokemonById(id);
            pokemons.add(pokemon);
          }
        }

        return pokemons;
      }

      throw Exception('Falha ao buscar Pokémon: ${response.statusCode}');
    } catch (e) {
      throw Exception('Falha ao buscar Pokémon: $e');
    }
  }
}
