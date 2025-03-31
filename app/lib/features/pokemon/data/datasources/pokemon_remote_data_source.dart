import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

abstract class PokemonRemoteDataSource {
  Future<List<Map<String, dynamic>>> getPokemonList(int limit, int offset);
  Future<Map<String, dynamic>> getPokemonById(int id);
  Future<List<Map<String, dynamic>>> searchPokemon(String query);
  Future<List<Map<String, dynamic>>> getPokemonsByType(String type);
  Future<List<Map<String, dynamic>>> getPokemonsByAbility(String ability);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  PokemonRemoteDataSourceImpl({
    required this.client,
  }) : baseUrl = dotenv.env['BFF_URL'] ?? 'http://localhost:3000/api';

  @override
  Future<List<Map<String, dynamic>>> getPokemonList(
      int limit, int offset) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/pokemon?limit=$limit&offset=$offset'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Failed to load pokemon list');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  @override
  Future<Map<String, dynamic>> getPokemonById(int id) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/pokemon/$id'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load pokemon details');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> searchPokemon(String query) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/pokemon/search?q=$query'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else if (response.statusCode == 400) {
        throw Exception('Search query is required');
      } else {
        throw Exception('Failed to search pokemon');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getPokemonsByType(String type) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/pokemon/type/$type'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Failed to load pokemons by type');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getPokemonsByAbility(
      String ability) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/pokemon/ability/$ability'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Failed to load pokemons by ability');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}
