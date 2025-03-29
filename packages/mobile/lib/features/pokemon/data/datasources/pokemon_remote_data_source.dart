import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../../../core/domain/errors/pokemon_error.dart';
import '../../domain/entities/pokemon_entity.dart';

abstract class PokemonRemoteDataSource {
  Future<List<PokemonEntityImpl>> getPokemonList({
    required int limit,
    required int offset,
  });
  Future<PokemonEntityImpl> getPokemonById(int id);
  Future<List<PokemonEntityImpl>> searchPokemon(String query);
  Future<List<PokemonEntityImpl>> getPokemonsByType(String type);
  Future<List<PokemonEntityImpl>> getPokemonsByAbility(String ability);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;

  PokemonRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PokemonEntityImpl>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await client.get(
        Uri.parse(
            '${dotenv.env['API_URL']}/pokemon?limit=$limit&offset=$offset'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => PokemonEntityImpl.fromJson(json)).toList();
      } else {
        throw NetworkError();
      }
    } catch (e) {
      throw NetworkError();
    }
  }

  @override
  Future<PokemonEntityImpl> getPokemonById(int id) async {
    try {
      final response = await client.get(
        Uri.parse('${dotenv.env['API_URL']}/pokemon/$id'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return PokemonEntityImpl.fromJson(data);
      } else if (response.statusCode == 404) {
        throw PokemonNotFoundError();
      } else {
        throw NetworkError();
      }
    } catch (e) {
      throw NetworkError();
    }
  }

  @override
  Future<List<PokemonEntityImpl>> searchPokemon(String query) async {
    try {
      final response = await client.get(
        Uri.parse('${dotenv.env['API_URL']}/pokemon/search/$query'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => PokemonEntityImpl.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        throw PokemonNotFoundError();
      } else {
        throw NetworkError();
      }
    } catch (e) {
      throw NetworkError();
    }
  }

  @override
  Future<List<PokemonEntityImpl>> getPokemonsByType(String type) async {
    try {
      final response = await client.get(
        Uri.parse('${dotenv.env['API_URL']}/pokemon/type/$type'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => PokemonEntityImpl.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        throw PokemonNotFoundError();
      } else {
        throw NetworkError();
      }
    } catch (e) {
      throw NetworkError();
    }
  }

  @override
  Future<List<PokemonEntityImpl>> getPokemonsByAbility(String ability) async {
    try {
      final response = await client.get(
        Uri.parse('${dotenv.env['API_URL']}/pokemon/ability/$ability'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => PokemonEntityImpl.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        throw PokemonNotFoundError();
      } else {
        throw NetworkError();
      }
    } catch (e) {
      throw NetworkError();
    }
  }
}
