import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/core/config/app_config.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';

abstract class PokemonRemoteDataSource {
  Future<List<PokemonEntity>> getPokemons({int? limit, int? offset});
  Future<PokemonEntity> getPokemonDetail(int id);
  Future<List<PokemonEntity>> getPokemonsByType(String type);
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability);
  Future<List<PokemonEntity>> searchPokemons(String query);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;

  PokemonRemoteDataSourceImpl(this.client);

  @override
  Future<List<PokemonEntity>> getPokemons({int? limit, int? offset}) async {
    final response = await client.get(
      Uri.parse(
          '${AppConfig.baseUrl}/pokemon?limit=${limit ?? 20}&offset=${offset ?? 0}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['results'];
      final List<PokemonEntity> pokemons = [];

      for (var pokemon in jsonList) {
        final id = int.parse(pokemon['url'].toString().split('/')[6]);
        final detail = await getPokemonDetail(id);
        pokemons.add(detail);
      }

      return pokemons;
    } else {
      throw Exception('Failed to load pokemons');
    }
  }

  @override
  Future<PokemonEntity> getPokemonDetail(int id) async {
    final response = await client.get(
      Uri.parse('${AppConfig.baseUrl}/pokemon/$id'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return PokemonEntityImpl(
        id: json['id'],
        name: json['name'],
        types: (json['types'] as List)
            .map((t) => t['type']['name'] as String)
            .toList(),
        abilities: (json['abilities'] as List)
            .map((a) => a['ability']['name'] as String)
            .toList(),
        height: json['height'],
        weight: json['weight'],
        baseExperience: json['base_experience'] ?? 0,
        imageUrl: json['sprites']['front_default'] ?? '',
      );
    } else {
      throw Exception('Failed to load pokemon details');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByType(String type) async {
    final response = await client.get(
      Uri.parse('${AppConfig.baseUrl}/type/$type'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['pokemon'];
      final List<PokemonEntity> pokemons = [];

      for (var pokemon in jsonList) {
        final id =
            int.parse(pokemon['pokemon']['url'].toString().split('/')[6]);
        final detail = await getPokemonDetail(id);
        pokemons.add(detail);
      }

      return pokemons;
    } else {
      throw Exception('Failed to load pokemons by type');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability) async {
    final response = await client.get(
      Uri.parse('${AppConfig.baseUrl}/ability/$ability'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['pokemon'];
      final List<PokemonEntity> pokemons = [];

      for (var pokemon in jsonList) {
        final id =
            int.parse(pokemon['pokemon']['url'].toString().split('/')[6]);
        final detail = await getPokemonDetail(id);
        pokemons.add(detail);
      }

      return pokemons;
    } else {
      throw Exception('Failed to load pokemons by ability');
    }
  }

  @override
  Future<List<PokemonEntity>> searchPokemons(String query) async {
    try {
      final response = await client.get(
        Uri.parse('${AppConfig.baseUrl}/pokemon/$query'),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final pokemon = PokemonEntityImpl(
          id: json['id'],
          name: json['name'],
          types: (json['types'] as List)
              .map((t) => t['type']['name'] as String)
              .toList(),
          abilities: (json['abilities'] as List)
              .map((a) => a['ability']['name'] as String)
              .toList(),
          height: json['height'],
          weight: json['weight'],
          baseExperience: json['base_experience'] ?? 0,
          imageUrl: json['sprites']['front_default'] ?? '',
        );
        return [pokemon];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
