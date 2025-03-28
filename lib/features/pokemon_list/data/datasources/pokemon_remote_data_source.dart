import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/domain/entities/pokemon.dart';
import '../models/pokemon_model.dart';

abstract class PokemonRemoteDataSource {
  Future<List<Pokemon>> getPokemons({int offset = 0, int limit = 20});
  Future<Pokemon> getPokemonById(int id);
  Future<List<Pokemon>> searchPokemons(String query);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;
  static const String _baseUrl = 'https://pokeapi.co/api/v2';

  PokemonRemoteDataSourceImpl({http.Client? client})
      : client = client ?? http.Client();

  @override
  Future<List<Pokemon>> getPokemons({int offset = 0, int limit = 20}) async {
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/pokemon?offset=$offset&limit=$limit'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        final List<Pokemon> pokemons = [];

        for (var result in results) {
          final urlParts = result['url'].split('/');
          final id = int.parse(urlParts[urlParts.length - 2]);
          final pokemon = await getPokemonById(id);
          pokemons.add(pokemon);
        }

        return pokemons;
      }

      throw Exception('Failed to fetch pokemons: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to fetch pokemons: $e');
    }
  }

  @override
  Future<Pokemon> getPokemonById(int id) async {
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/pokemon/$id'),
      );

      if (response.statusCode == 200) {
        return PokemonModel.fromJson(json.decode(response.body));
      }

      throw Exception('Failed to fetch pokemon: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to fetch pokemon: $e');
    }
  }

  @override
  Future<List<Pokemon>> searchPokemons(String query) async {
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/pokemon?limit=1118'), // Total number of pokemons
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
            final pokemon = await getPokemonById(id);
            pokemons.add(pokemon);
          }
        }

        return pokemons;
      }

      throw Exception('Failed to search pokemons: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to search pokemons: $e');
    }
  }
}
