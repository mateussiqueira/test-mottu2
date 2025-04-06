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
  final String baseUrl;
  final Duration cacheDuration;

  PokeApiAdapter({
    required this.client,
    required this.prefs,
    this.baseUrl = 'https://pokeapi.co/api/v2',
    this.cacheDuration = const Duration(hours: 1),
  });

  @override
  Future<List<IPokemonEntity>> getPokemons(
      {int offset = 0, int limit = 20}) async {
    final cacheKey = 'pokemon_list_${offset}_$limit';
    
    // Tentar obter do cache primeiro
    final cachedData = await _getFromCache(cacheKey);
    if (cachedData != null) {
      final List<IPokemonEntity> pokemons = [];
      for (final item in cachedData) {
        pokemons.add(PokemonModel.fromJson(item) as IPokemonEntity);
      }
      return pokemons;
    }
    
    // Se não estiver em cache, buscar da API
    final response = await client
        .get(Uri.parse(PokeApiUrls.getPokemons(offset: offset, limit: limit)));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      final pokemons = await Future.wait(
        results.map((result) => getPokemonByName(result['name'])),
      );
      
      // Salvar em cache
      final List<Map<String, dynamic>> pokemonsJson = [];
      for (final pokemon in pokemons) {
        if (pokemon is PokemonModel) {
          pokemonsJson.add(pokemon.toJson());
        }
      }
      await _saveToCache(cacheKey, pokemonsJson);
      
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
    final keys = prefs.getKeys();
    for (final key in keys) {
      if (key.startsWith('pokemon_')) {
        await prefs.remove(key);
      }
    }
  }
  
  // Método auxiliar para salvar dados em cache
  Future<void> _saveToCache(String key, dynamic data) async {
    final jsonData = json.encode(data);
    await prefs.setString(key, jsonData);
    await prefs.setInt('${key}_timestamp', DateTime.now().millisecondsSinceEpoch);
  }
  
  // Método auxiliar para recuperar dados do cache
  Future<dynamic> _getFromCache(String key) async {
    final timestamp = prefs.getInt('${key}_timestamp');
    if (timestamp == null) return null;
    
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - timestamp > cacheDuration.inMilliseconds) {
      await prefs.remove(key);
      await prefs.remove('${key}_timestamp');
      return null;
    }
    
    final jsonData = prefs.getString(key);
    if (jsonData == null) return null;
    
    return json.decode(jsonData);
  }
}
