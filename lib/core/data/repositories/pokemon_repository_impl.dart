import 'dart:convert';

import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../adapters/poke_api_adapter.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokeApiAdapter _adapter;
  static const String _baseUrl = 'https://pokeapi.co/api/v2';
  List<Map<String, dynamic>>? _pokemonListCache;

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
    _pokemonListCache = null;
  }

  @override
  Future<Pokemon> getPokemonById(int id) async {
    return _adapter.getPokemonById(id);
  }

  @override
  Future<List<Pokemon>> searchPokemons(String query) async {
    try {
      // Usa o cache se disponível
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

      // Filtra os resultados usando o cache
      final List<Map<String, dynamic>> filteredResults = _pokemonListCache!
          .where((result) => result['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();

      // Limita a 10 resultados para melhor performance
      final limitedResults = filteredResults.take(10).toList();

      // Busca os detalhes dos Pokémon filtrados
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
}
