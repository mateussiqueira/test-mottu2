import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/pokemon/data/models/pokemon_model.dart';
import '../../../features/pokemon/domain/entities/pokemon_entity.dart';

abstract class PokemonRepository {
  Future<List<PokemonEntityImpl>> getPokemons({int offset = 0, int limit = 20});
  Future<PokemonEntityImpl> getPokemonById(int id);
  Future<List<PokemonEntityImpl>> searchPokemons(String query);
  Future<List<PokemonEntityImpl>> getPokemonsByType(String type);
  Future<List<PokemonEntityImpl>> getPokemonsByAbility(String ability);
}

class PokeApiAdapter {
  final http.Client client;
  final SharedPreferences prefs;
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  PokeApiAdapter({
    required this.client,
    required this.prefs,
  });

  Future<List<PokemonModel>> getPokemons(
      {int offset = 0, int limit = 20}) async {
    final response = await client.get(
      Uri.parse('$baseUrl/pokemon?offset=$offset&limit=$limit'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      final pokemons = await Future.wait(
        results.map((result) => getPokemonByName(result['name'])),
      );
      return pokemons;
    } else {
      throw Exception('Failed to load pokemons');
    }
  }

  Future<PokemonModel> getPokemonById(int id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/pokemon/$id'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PokemonModel.fromJson(data);
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  Future<PokemonModel> getPokemonByName(String name) async {
    final response = await client.get(
      Uri.parse('$baseUrl/pokemon/$name'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PokemonModel.fromJson(data);
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  Future<List<PokemonModel>> searchPokemons(String query) async {
    final response = await client.get(
      Uri.parse('$baseUrl/pokemon?limit=1118'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      final pokemons = await Future.wait(
        results
            .where((result) => result['name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .map((result) => getPokemonByName(result['name'])),
      );
      return pokemons;
    } else {
      throw Exception('Failed to search pokemons');
    }
  }

  Future<List<PokemonModel>> getPokemonsByType(String type) async {
    final response = await client.get(
      Uri.parse('$baseUrl/type/$type'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final pokemons = data['pokemon'] as List;
      final results = await Future.wait(
        pokemons.map((pokemon) => getPokemonByName(pokemon['pokemon']['name'])),
      );
      return results;
    } else {
      throw Exception('Failed to load pokemons by type');
    }
  }

  Future<List<PokemonModel>> getPokemonsByAbility(String ability) async {
    final response = await client.get(
      Uri.parse('$baseUrl/ability/$ability'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final pokemons = data['pokemon'] as List;
      final results = await Future.wait(
        pokemons.map((pokemon) => getPokemonByName(pokemon['pokemon']['name'])),
      );
      return results;
    } else {
      throw Exception('Failed to load pokemons by ability');
    }
  }

  Future<void> clearCache() async {
    await prefs.clear();
  }
}
