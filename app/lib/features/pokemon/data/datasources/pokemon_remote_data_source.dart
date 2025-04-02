import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/core/config/app_config.dart';

import '../../domain/entities/i_pokemon_entity.dart';
import '../../domain/entities/pokemon_factory.dart';
import 'i_pokemon_remote_datasource.dart';

class PokemonRemoteDataSourceImpl implements IPokemonRemoteDataSource {
  final http.Client client;

  PokemonRemoteDataSourceImpl(this.client);

  @override
  Future<List<IPokemonEntity>> getPokemons({int? limit, int? offset}) async {
    final response = await client.get(
      Uri.parse(
          '${AppConfig.baseUrl}/pokemon?limit=${limit ?? 20}&offset=${offset ?? 0}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['results'];
      final List<IPokemonEntity> pokemons = [];

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
  Future<IPokemonEntity> getPokemonDetail(int id) async {
    final response = await client.get(
      Uri.parse('${AppConfig.baseUrl}/pokemon/$id'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return PokemonFactory.fromJson(json);
    } else {
      throw Exception('Failed to load pokemon details');
    }
  }

  @override
  Future<List<IPokemonEntity>> getPokemonsByType(String type) async {
    final response = await client.get(
      Uri.parse('${AppConfig.baseUrl}/type/$type'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['pokemon'];
      final List<IPokemonEntity> pokemons = [];

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
  Future<List<IPokemonEntity>> getPokemonsByAbility(String ability) async {
    final response = await client.get(
      Uri.parse('${AppConfig.baseUrl}/ability/$ability'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['pokemon'];
      final List<IPokemonEntity> pokemons = [];

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
  Future<List<IPokemonEntity>> searchPokemons(String query) async {
    try {
      final response = await client.get(
        Uri.parse('${AppConfig.baseUrl}/pokemon/$query'),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return [PokemonFactory.fromJson(json)];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
