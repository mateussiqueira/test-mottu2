import 'dart:convert';

import '../../domain/entities/pokemon.dart';
import '../adapters/poke_api_adapter.dart';

class SearchPokemonsRepository {
  final PokeApiAdapter _adapter;
  static const String _baseUrl = 'https://pokeapi.co/api/v2';
  List<Map<String, dynamic>>? _pokemonListCache;

  SearchPokemonsRepository(this._adapter);

  Future<List<Pokemon>> call(String query) async {
    try {
      if (_pokemonListCache == null) {
        final response = await _adapter.client.get(
          Uri.parse('$_baseUrl/pokemon?limit=1118'),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          _pokemonListCache = List<Map<String, dynamic>>.from(data['results']);
        } else {
          throw Exception('Falha ao buscar Pokémon: ${response.statusCode}');
        }
      }

      final List<Map<String, dynamic>> filteredResults = _pokemonListCache!
          .where((result) => result['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();

      final limitedResults = filteredResults.take(10).toList();

      final List<Pokemon> pokemons = [];
      for (var result in limitedResults) {
        final urlParts = result['url'].split('/');
        final id = int.parse(urlParts[urlParts.length - 2]);
        final pokemon = await _adapter.getPokemonById(id);
        pokemons.add(pokemon);
      }

      return pokemons;
    } catch (e) {
      throw Exception('Falha ao buscar Pokémon: $e');
    }
  }

  void clearCache() {
    _pokemonListCache = null;
  }
}
