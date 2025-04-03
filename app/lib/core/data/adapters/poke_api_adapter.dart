import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/pokemon/data/models/pokemon_model.dart';
import '../../../features/pokemon/domain/entities/i_pokemon_entity.dart';
import 'i_poke_api_adapter.dart';
import 'poke_api_urls.dart';

class PokeApiAdapter implements IPokeApiAdapter {
  final http.Client client;
  final SharedPreferences prefs;

  PokeApiAdapter({
    required this.client,
    required this.prefs,
  });

  @override
  Future<List<IPokemonEntity>> getPokemons(
      {int offset = 0, int limit = 20}) async {
    final response = await client
        .get(Uri.parse(PokeApiUrls.getPokemons(offset: offset, limit: limit)));

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

  @override
  Future<IPokemonEntity> getPokemonById(int id) async {
    final response =
        await client.get(Uri.parse(PokeApiUrls.getPokemonById(id)));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PokemonModel.fromJson(data) as IPokemonEntity;
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  @override
  Future<IPokemonEntity> getPokemonByName(String name) async {
    final response =
        await client.get(Uri.parse(PokeApiUrls.getPokemonByName(name)));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PokemonModel.fromJson(data) as IPokemonEntity;
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  @override
  Future<List<IPokemonEntity>> searchPokemons(String query) async {
    final response = await client.get(Uri.parse(PokeApiUrls.getAllPokemons()));

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

  @override
  Future<List<IPokemonEntity>> getPokemonsByType(String type) async {
    final response =
        await client.get(Uri.parse(PokeApiUrls.getPokemonsByType(type)));

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

  @override
  Future<List<IPokemonEntity>> getPokemonsByAbility(String ability) async {
    final response =
        await client.get(Uri.parse(PokeApiUrls.getPokemonsByAbility(ability)));

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

  @override
  Future<void> clearCache() async {
    await prefs.clear();
  }
}
