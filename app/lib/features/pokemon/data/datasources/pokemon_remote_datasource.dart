import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/domain/errors/pokemon_error.dart';
import '../../../../core/domain/result.dart' as core;
import '../../domain/entities/pokemon_entity.dart';
import '../models/pokemon_model.dart';

class PokemonRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  PokemonRemoteDataSource({
    required this.client,
    this.baseUrl = 'https://pokeapi.co/api/v2',
  });

  Future<core.Result<List<PokemonEntity>>> getPokemonList() async {
    try {
      final response =
          await client.get(Uri.parse('$baseUrl/pokemon?limit=151'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        final pokemons = await Future.wait(
          results.map((result) => getPokemonDetail(result['name'])),
        );
        return core.Result.success(
            pokemons.whereType<PokemonEntity>().toList());
      }
      return core.Result.failure(PokemonNetworkError());
    } catch (e) {
      return core.Result.failure(PokemonNetworkError());
    }
  }

  Future<core.Result<PokemonEntity>> getPokemonDetail(String name) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/pokemon/$name'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final pokemon = PokemonModel.fromJson(data);
        return core.Result.success(pokemon);
      }
      return core.Result.failure(PokemonNotFoundError());
    } catch (e) {
      return core.Result.failure(PokemonNetworkError());
    }
  }

  Future<core.Result<List<PokemonEntity>>> searchPokemon(String query) async {
    try {
      final response =
          await client.get(Uri.parse('$baseUrl/pokemon?limit=151'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        final pokemons = await Future.wait(
          results
              .where((result) => result['name']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .map((result) => getPokemonDetail(result['name'])),
        );
        return core.Result.success(
            pokemons.whereType<PokemonEntity>().toList());
      }
      return core.Result.failure(PokemonNetworkError());
    } catch (e) {
      return core.Result.failure(PokemonNetworkError());
    }
  }
}
