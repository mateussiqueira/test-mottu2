import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokeapi/core/data/cache/pokemon_cache_manager.dart';
import 'package:pokeapi/core/domain/entities/pokemon_entity.dart';
import 'package:pokeapi/core/domain/errors/pokemon_error.dart';
import 'package:pokeapi/core/domain/validators/pokemon_validator.dart';
import 'package:pokeapi/features/pokemon/domain/repositories/pokemon_repository.dart';

/// Implementação do repositório de Pokemon
class PokemonRepositoryImpl implements PokemonRepository {
  static const String _baseUrl = 'https://pokeapi.co/api/v2';
  final PokemonCacheManager _cacheManager;

  PokemonRepositoryImpl(this._cacheManager);

  @override
  Future<Result<List<PokemonEntity>>> getPokemonList({
    required int offset,
    required int limit,
  }) async {
    try {
      // Tenta buscar do cache primeiro
      final cachedList = await _cacheManager.getPokemonList();
      if (cachedList != null) {
        return Result.success(cachedList);
      }

      // Se não estiver no cache, busca da API
      final response = await http.get(
        Uri.parse('$_baseUrl/pokemon?offset=$offset&limit=$limit'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'] as List;
        final pokemons = <PokemonEntity>[];

        for (final result in results) {
          final id = int.parse(result['url'].split('/')[6]);
          final detailResult = await getPokemonDetail(id);
          if (detailResult.isSuccess && detailResult.data != null) {
            pokemons.add(detailResult.data!);
          }
        }

        // Salva no cache
        if (pokemons.isNotEmpty) {
          await _cacheManager.savePokemonList(pokemons);
        }

        return Result.success(pokemons);
      }

      return Result.failure(
        NetworkError(
          message: 'Failed to fetch pokemon list',
          code: 'FETCH_LIST_ERROR',
        ),
      );
    } catch (e) {
      return Result.failure(
        UnknownError(
          message: 'An unexpected error occurred',
          code: 'UNKNOWN_ERROR',
          originalError: e,
        ),
      );
    }
  }

  @override
  Future<Result<PokemonEntity>> getPokemonDetail(int id) async {
    try {
      // Valida o ID
      final idResult = PokemonValidator.validateId(id);
      if (idResult.isFailure) {
        return Result.failure(idResult.error);
      }

      // Tenta buscar do cache primeiro
      final cachedPokemon = await _cacheManager.getPokemonDetail(id);
      if (cachedPokemon != null) {
        return Result.success(cachedPokemon);
      }

      // Se não estiver no cache, busca da API
      final response = await http.get(
        Uri.parse('$_baseUrl/pokemon/$id'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final pokemon = PokemonEntity(
          id: data['id'],
          name: data['name'],
          types: (data['types'] as List)
              .map((type) => type['type']['name'] as String)
              .toList(),
          abilities: (data['abilities'] as List)
              .map((ability) => ability['ability']['name'] as String)
              .toList(),
          height: data['height'].toDouble(),
          weight: data['weight'].toDouble(),
          baseExperience: data['base_experience'] ?? 0,
          imageUrl: data['sprites']['other']['official-artwork']
              ['front_default'],
        );

        // Valida os dados
        final validationResults = [
          PokemonValidator.validateName(pokemon.name),
          PokemonValidator.validateTypes(pokemon.types),
          PokemonValidator.validateAbilities(pokemon.abilities),
          PokemonValidator.validateHeight(pokemon.height),
          PokemonValidator.validateWeight(pokemon.weight),
          PokemonValidator.validateBaseExperience(pokemon.baseExperience),
        ];

        for (final result in validationResults) {
          if (result.isFailure) {
            return Result.failure(result.error);
          }
        }

        // Salva no cache
        await _cacheManager.savePokemonDetail(pokemon);

        return Result.success(pokemon);
      }

      return Result.failure(
        NetworkError(
          message: 'Failed to fetch pokemon detail',
          code: 'FETCH_DETAIL_ERROR',
        ),
      );
    } catch (e) {
      return Result.failure(
        UnknownError(
          message: 'An unexpected error occurred',
          code: 'UNKNOWN_ERROR',
          originalError: e,
        ),
      );
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> searchPokemon(String query) async {
    try {
      // Valida a query
      if (query.isEmpty) {
        return Result.failure(
          ValidationError(
            message: 'Search query cannot be empty',
            code: 'EMPTY_QUERY',
          ),
        );
      }

      // Busca da API
      final response = await http.get(
        Uri.parse('$_baseUrl/pokemon?limit=1118'), // Busca todos os Pokemons
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'] as List;
        final pokemons = <PokemonEntity>[];

        for (final result in results) {
          final name = result['name'] as String;
          if (name.toLowerCase().contains(query.toLowerCase())) {
            final id = int.parse(result['url'].split('/')[6]);
            final detailResult = await getPokemonDetail(id);
            if (detailResult.isSuccess && detailResult.data != null) {
              pokemons.add(detailResult.data!);
            }
          }
        }

        return Result.success(pokemons);
      }

      return Result.failure(
        NetworkError(
          message: 'Failed to search pokemon',
          code: 'SEARCH_ERROR',
        ),
      );
    } catch (e) {
      return Result.failure(
        UnknownError(
          message: 'An unexpected error occurred',
          code: 'UNKNOWN_ERROR',
          originalError: e,
        ),
      );
    }
  }
}
