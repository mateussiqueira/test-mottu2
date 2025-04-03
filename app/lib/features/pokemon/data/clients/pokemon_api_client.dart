import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/domain/errors/failure.dart';
import '../../../../core/domain/errors/result.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../validators/pokemon_response_validator.dart';

/// Client for making Pokemon API requests
class PokemonApiClient {
  final String baseUrl;
  final http.Client _client;

  PokemonApiClient({
    required this.baseUrl,
    required http.Client client,
  }) : _client = client;

  Future<Result<List<PokemonEntity>>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/pokemon?limit=$limit&offset=$offset'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (!PokemonResponseValidator.isValidListResponse(data)) {
          return Result.failure(Failure(message: 'Invalid response format'));
        }

        final results = data['results'] as List;
        final futures = <Future<Result<PokemonEntity>>>[];

        for (final result in results) {
          if (!PokemonResponseValidator.hasValidUrl(result)) {
            continue;
          }
          final url = result['url'] as String;
          final segments = url.split('/');
          final id = int.parse(segments[segments.length - 2]);
          futures.add(getPokemonDetail(id));
        }

        final detailResults = await Future.wait(futures);
        final pokemons = <PokemonEntity>[];

        for (final result in detailResults) {
          if (result.isSuccess) {
            pokemons.add(result.data!);
          }
        }

        return Result.success(pokemons);
      }
      return Result.failure(Failure(message: 'Failed to fetch pokemon list'));
    } catch (e) {
      return Result.failure(
          Failure(message: 'Error fetching pokemon list: $e'));
    }
  }

  Future<Result<PokemonEntity>> getPokemonDetail(int id) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/pokemon/$id'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Result.success(PokemonEntity.fromJson(data));
      }
      return Result.failure(
          Failure(message: 'Failed to fetch pokemon details'));
    } catch (e) {
      return Result.failure(
          Failure(message: 'Error fetching pokemon details: $e'));
    }
  }

  Future<Result<List<PokemonEntity>>> searchPokemon(String query) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/pokemon?limit=1118'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (!PokemonResponseValidator.isValidListResponse(data)) {
          return Result.failure(Failure(message: 'Invalid response format'));
        }

        final results = data['results'] as List;
        final futures = <Future<Result<PokemonEntity>>>[];

        for (final result in results) {
          if (!PokemonResponseValidator.hasValidUrl(result)) {
            continue;
          }
          final name = result['name'] as String;
          if (name.toLowerCase().contains(query.toLowerCase())) {
            final id =
                int.parse(result['url'].split('/').reversed.skip(1).first);
            futures.add(getPokemonDetail(id));
          }
        }

        final detailResults = await Future.wait(futures);
        final pokemons = <PokemonEntity>[];

        for (final result in detailResults) {
          if (result.isSuccess) {
            pokemons.add(result.data!);
          }
        }

        return Result.success(pokemons);
      }
      return Result.failure(Failure(message: 'Failed to search pokemon'));
    } catch (e) {
      return Result.failure(Failure(message: 'Error searching pokemon: $e'));
    }
  }

  Future<Result<List<PokemonEntity>>> getPokemonsByType(String type) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/type/$type'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (!PokemonResponseValidator.isValidTypeResponse(data)) {
          return Result.failure(Failure(message: 'Invalid response format'));
        }

        final results = data['pokemon'] as List;
        final futures = <Future<Result<PokemonEntity>>>[];

        for (final result in results) {
          if (!PokemonResponseValidator.hasValidTypeUrl(result)) {
            continue;
          }
          final id = int.parse(
              result['pokemon']['url'].split('/').reversed.skip(1).first);
          futures.add(getPokemonDetail(id));
        }

        final detailResults = await Future.wait(futures);
        final pokemons = <PokemonEntity>[];

        for (final result in detailResults) {
          if (result.isSuccess) {
            pokemons.add(result.data!);
          }
        }

        return Result.success(pokemons);
      }
      return Result.failure(
          Failure(message: 'Failed to fetch pokemon by type'));
    } catch (e) {
      return Result.failure(
          Failure(message: 'Error fetching pokemon by type: $e'));
    }
  }

  Future<Result<List<PokemonEntity>>> getPokemonsByAbility(
      String ability) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/ability/$ability'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (!PokemonResponseValidator.isValidAbilityResponse(data)) {
          return Result.failure(Failure(message: 'Invalid response format'));
        }

        final results = data['pokemon'] as List;
        final futures = <Future<Result<PokemonEntity>>>[];

        for (final result in results) {
          if (!PokemonResponseValidator.hasValidTypeUrl(result)) {
            continue;
          }
          final id = int.parse(
              result['pokemon']['url'].split('/').reversed.skip(1).first);
          futures.add(getPokemonDetail(id));
        }

        final detailResults = await Future.wait(futures);
        final pokemons = <PokemonEntity>[];

        for (final result in detailResults) {
          if (result.isSuccess) {
            pokemons.add(result.data!);
          }
        }

        return Result.success(pokemons);
      }
      return Result.failure(
          Failure(message: 'Failed to fetch pokemon by ability'));
    } catch (e) {
      return Result.failure(
          Failure(message: 'Error fetching pokemon by ability: $e'));
    }
  }

  Future<Result<List<PokemonEntity>>> getPokemonsByMove(String move) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/move/$move'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['learned_by_pokemon'] as List;
        final futures = <Future<Result<PokemonEntity>>>[];

        for (final result in results) {
          if (!PokemonResponseValidator.hasValidUrl(result)) {
            continue;
          }
          final id = int.parse(result['url'].split('/')[6]);
          futures.add(getPokemonDetail(id));
        }

        final detailResults = await Future.wait(futures);
        final pokemons = <PokemonEntity>[];

        for (final result in detailResults) {
          if (result.isSuccess) {
            pokemons.add(result.data!);
          }
        }

        return Result.success(pokemons);
      }
      return Result.failure(
          Failure(message: 'Failed to fetch pokemon by move'));
    } catch (e) {
      return Result.failure(
          Failure(message: 'Error fetching pokemon by move: $e'));
    }
  }

  Future<Result<List<PokemonEntity>>> getPokemonsByEvolution(
      String evolution) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/evolution-chain/$evolution'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['chain']['evolves_to'] as List;
        final futures = <Future<Result<PokemonEntity>>>[];

        for (final result in results) {
          final species = result['species'];
          if (!PokemonResponseValidator.hasValidUrl(species)) {
            continue;
          }
          final id = int.parse(species['url'].split('/')[6]);
          futures.add(getPokemonDetail(id));
        }

        final detailResults = await Future.wait(futures);
        final pokemons = <PokemonEntity>[];

        for (final result in detailResults) {
          if (result.isSuccess) {
            pokemons.add(result.data!);
          }
        }

        return Result.success(pokemons);
      }
      return Result.failure(
          Failure(message: 'Failed to fetch pokemon by evolution'));
    } catch (e) {
      return Result.failure(
          Failure(message: 'Error fetching pokemon by evolution: $e'));
    }
  }

  Future<Result<List<PokemonEntity>>> getPokemonsByStat(
      String stat, int value) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/pokemon?limit=1118'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (!PokemonResponseValidator.isValidListResponse(data)) {
          return Result.failure(Failure(message: 'Invalid response format'));
        }

        final results = data['results'] as List;
        final futures = <Future<Result<PokemonEntity>>>[];

        for (final result in results) {
          if (!PokemonResponseValidator.hasValidUrl(result)) {
            continue;
          }
          final id = int.parse(result['url'].split('/')[6]);
          futures.add(getPokemonDetail(id));
        }

        final detailResults = await Future.wait(futures);
        final pokemons = <PokemonEntity>[];

        for (final result in detailResults) {
          if (result.isSuccess && result.data!.stats[stat] == value) {
            pokemons.add(result.data!);
          }
        }

        return Result.success(pokemons);
      }
      return Result.failure(
          Failure(message: 'Failed to fetch pokemon by stat'));
    } catch (e) {
      return Result.failure(
          Failure(message: 'Error fetching pokemon by stat: $e'));
    }
  }

  Future<Result<List<PokemonEntity>>> getPokemonsByDescription(
      String description) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/pokemon-species?limit=1118'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (!PokemonResponseValidator.isValidListResponse(data)) {
          return Result.failure(Failure(message: 'Invalid response format'));
        }

        final results = data['results'] as List;
        final futures = <Future<Result<PokemonEntity>>>[];

        for (final result in results) {
          if (!PokemonResponseValidator.hasValidUrl(result)) {
            continue;
          }
          final id = int.parse(result['url'].split('/')[6]);
          futures.add(getPokemonDetail(id));
        }

        final detailResults = await Future.wait(futures);
        final pokemons = <PokemonEntity>[];

        for (final result in detailResults) {
          if (result.isSuccess &&
              result.data!.description
                  .toLowerCase()
                  .contains(description.toLowerCase())) {
            pokemons.add(result.data!);
          }
        }

        return Result.success(pokemons);
      }
      return Result.failure(
          Failure(message: 'Failed to fetch pokemon by description'));
    } catch (e) {
      return Result.failure(
          Failure(message: 'Error fetching pokemon by description: $e'));
    }
  }
}
