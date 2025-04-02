import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/core/config/app_config.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';

abstract class PokemonRemoteDataSource {
  Future<List<PokemonEntity>> getPokemons();
  Future<PokemonEntity> getPokemonDetail(int id);
  Future<List<PokemonEntity>> getPokemonsByType(String type);
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability);
  Future<List<PokemonEntity>> searchPokemons(String query);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;

  PokemonRemoteDataSourceImpl(this.client);

  @override
  Future<List<PokemonEntity>> getPokemons() async {
    final response = await client.get(
      Uri.parse('${AppConfig.baseUrl}/pokemon'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['results'];
      return jsonList.map((json) => PokemonEntity.fromJson(json)).toList();
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
      return PokemonEntity.fromJson(json);
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
      return jsonList
          .map((json) => PokemonEntity.fromJson(json['pokemon']))
          .toList();
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
      return jsonList
          .map((json) => PokemonEntity.fromJson(json['pokemon']))
          .toList();
    } else {
      throw Exception('Failed to load pokemons by ability');
    }
  }

  @override
  Future<List<PokemonEntity>> searchPokemons(String query) async {
    final response = await client.get(
      Uri.parse('${AppConfig.baseUrl}/pokemon?search=$query'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['results'];
      return jsonList.map((json) => PokemonEntity.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search pokemons');
    }
  }
}
