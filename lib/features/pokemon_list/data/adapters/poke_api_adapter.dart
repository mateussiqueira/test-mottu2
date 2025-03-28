import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/pokemon.dart';

class PokeApiAdapter {
  final http.Client _client;
  final String _baseUrl;

  PokeApiAdapter({
    http.Client? client,
    String? baseUrl,
  })  : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? AppConstants.baseUrl;

  Future<List<Pokemon>> getPokemons({
    required int offset,
    required int limit,
  }) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/pokemon?offset=$offset&limit=$limit'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;

        final pokemons = await Future.wait(
          results.map((result) => getPokemon(result['name'] as String)),
        );

        return pokemons;
      } else {
        throw Exception(AppConstants.errorLoadingPokemons);
      }
    } catch (e) {
      throw Exception(AppConstants.errorLoadingPokemons);
    }
  }

  Future<Pokemon> getPokemon(String name) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/pokemon/$name'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Pokemon.fromJson(data);
      } else {
        throw Exception(AppConstants.errorLoadingPokemon);
      }
    } catch (e) {
      throw Exception(AppConstants.errorLoadingPokemon);
    }
  }

  Future<List<Pokemon>> searchPokemons(String query) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/pokemon?limit=1118'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;

        final pokemons = await Future.wait(
          results
              .where((result) =>
                  (result['name'] as String).contains(query.toLowerCase()))
              .map((result) => getPokemon(result['name'] as String)),
        );

        return pokemons;
      } else {
        throw Exception(AppConstants.errorSearchingPokemons);
      }
    } catch (e) {
      throw Exception(AppConstants.errorSearchingPokemons);
    }
  }

  void dispose() {
    _client.close();
  }
}
