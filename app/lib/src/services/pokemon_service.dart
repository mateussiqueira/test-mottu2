import 'dart:convert';

import 'package:http/http.dart' as http;

class Pokemon {
  final int id;
  final String name;
  final List<String> types;
  final List<String> abilities;
  final double height;
  final double weight;
  final int baseExperience;
  final String imageUrl;

  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.abilities,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      abilities: (json['abilities'] as List)
          .map((ability) => ability['ability']['name'] as String)
          .toList(),
      height: json['height'] / 10, // Convert to meters
      weight: json['weight'] / 10, // Convert to kilograms
      baseExperience: json['base_experience'],
      imageUrl: json['sprites']['front_default'],
    );
  }
}

class PokemonService {
  final http.Client client;
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  PokemonService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Pokemon>> getPokemonList() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/pokemon?limit=20'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        final pokemons = await Future.wait(
          results.map((pokemon) async {
            final detailResponse = await client.get(Uri.parse(pokemon['url']));
            if (detailResponse.statusCode == 200) {
              return Pokemon.fromJson(json.decode(detailResponse.body));
            }
            throw Exception('Failed to load pokemon details');
          }),
        );
        return pokemons;
      }
      throw Exception('Failed to load pokemon list');
    } catch (e) {
      throw Exception('Error fetching pokemon list: $e');
    }
  }

  Future<Pokemon> getPokemonById(int id) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/pokemon/$id'));
      if (response.statusCode == 200) {
        return Pokemon.fromJson(json.decode(response.body));
      }
      throw Exception('Failed to load pokemon');
    } catch (e) {
      throw Exception('Error fetching pokemon with id $id: $e');
    }
  }

  Future<List<Pokemon>> searchPokemon(String query) async {
    try {
      final response =
          await client.get(Uri.parse('$baseUrl/pokemon?limit=1000'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        final filteredResults = results
            .where((pokemon) => pokemon['name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .take(20)
            .toList();

        final pokemons = await Future.wait(
          filteredResults.map((pokemon) async {
            final detailResponse = await client.get(Uri.parse(pokemon['url']));
            if (detailResponse.statusCode == 200) {
              return Pokemon.fromJson(json.decode(detailResponse.body));
            }
            throw Exception('Failed to load pokemon details');
          }),
        );
        return pokemons;
      }
      throw Exception('Failed to search pokemon');
    } catch (e) {
      throw Exception('Error searching pokemon: $e');
    }
  }

  Future<List<Pokemon>> getPokemonsByType(String type) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/type/$type'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = (data['pokemon'] as List).take(20).toList();
        final pokemons = await Future.wait(
          results.map((pokemon) async {
            final detailResponse =
                await client.get(Uri.parse(pokemon['pokemon']['url']));
            if (detailResponse.statusCode == 200) {
              return Pokemon.fromJson(json.decode(detailResponse.body));
            }
            throw Exception('Failed to load pokemon details');
          }),
        );
        return pokemons;
      }
      throw Exception('Failed to load pokemons by type');
    } catch (e) {
      throw Exception('Error fetching pokemons by type $type: $e');
    }
  }

  Future<List<Pokemon>> getPokemonsByAbility(String ability) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/ability/$ability'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = (data['pokemon'] as List).take(20).toList();
        final pokemons = await Future.wait(
          results.map((pokemon) async {
            final detailResponse =
                await client.get(Uri.parse(pokemon['pokemon']['url']));
            if (detailResponse.statusCode == 200) {
              return Pokemon.fromJson(json.decode(detailResponse.body));
            }
            throw Exception('Failed to load pokemon details');
          }),
        );
        return pokemons;
      }
      throw Exception('Failed to load pokemons by ability');
    } catch (e) {
      throw Exception('Error fetching pokemons by ability $ability: $e');
    }
  }
}
