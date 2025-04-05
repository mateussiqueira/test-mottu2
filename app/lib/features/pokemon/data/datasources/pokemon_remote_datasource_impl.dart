import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/failure.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../mappers/pokemon_mapper.dart';
import '../models/pokemon_model.dart';
import '../models/pokemon_response.dart';
import '../validators/pokemon_response_validator.dart';
import 'i_pokemon_remote_datasource.dart';

/// Implementation of the Pokemon remote data source
class PokemonRemoteDataSourceImpl implements IPokemonRemoteDataSource {
  final http.Client _client;
  final String _baseUrl = 'https://pokeapi.co/api/v2';
  final PokemonResponseValidator _validator;
  final PokemonMapper _mapper;

  PokemonRemoteDataSourceImpl({
    required http.Client client,
    required PokemonResponseValidator validator,
    required PokemonMapper mapper,
  })  : _client = client,
        _validator = validator,
        _mapper = mapper;

  @override
  Future<List<PokemonEntity>> getPokemonList({
    int? offset,
    int? limit,
  }) async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$_baseUrl/pokemon?offset=${offset ?? 0}&limit=${limit ?? 20}',
        ),
      );

      if (response.statusCode != 200) {
        throw ServerFailure(
          message: 'Failed to fetch Pokemon list: ${response.statusCode}',
        );
      }

      final Map<String, dynamic> data = json.decode(response.body);
      _validator.validateResponse(data);

      final pokemonResponse = PokemonResponse.fromJson(data);
      final List<PokemonEntity> pokemons = [];

      for (final result in pokemonResponse.results) {
        final detailResponse = await _client.get(Uri.parse(result['url']));
        if (detailResponse.statusCode == 200) {
          final pokemonData = json.decode(detailResponse.body);
          _validator.validatePokemonResponse(pokemonData);
          final model = PokemonModel.fromJson(pokemonData);
          pokemons.add(_mapper.toEntity(model));
        }
      }

      return pokemons;
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<PokemonEntity> getPokemonById(int id) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/pokemon/$id'),
      );

      if (response.statusCode != 200) {
        throw ServerFailure(
          message: 'Failed to fetch Pokemon by id: ${response.statusCode}',
        );
      }

      final Map<String, dynamic> data = json.decode(response.body);
      _validator.validatePokemonResponse(data);

      final model = PokemonModel.fromJson(data);
      return _mapper.toEntity(model);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<PokemonEntity> getPokemonByName(String name) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/pokemon/$name'),
      );

      if (response.statusCode != 200) {
        throw ServerFailure(
          message: 'Failed to fetch Pokemon by name: ${response.statusCode}',
        );
      }

      final Map<String, dynamic> data = json.decode(response.body);
      _validator.validatePokemonResponse(data);

      final model = PokemonModel.fromJson(data);
      return _mapper.toEntity(model);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<PokemonEntity>> searchPokemon(String query) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/pokemon?limit=1000'),
      );

      if (response.statusCode != 200) {
        throw ServerFailure(
          message: 'Failed to search Pokemon: ${response.statusCode}',
        );
      }

      final Map<String, dynamic> data = json.decode(response.body);
      _validator.validateResponse(data);

      final pokemonResponse = PokemonResponse.fromJson(data);
      final List<PokemonEntity> pokemons = [];

      for (final result in pokemonResponse.results) {
        if (result['name'].toString().contains(query.toLowerCase())) {
          final detailResponse = await _client.get(Uri.parse(result['url']));
          if (detailResponse.statusCode == 200) {
            final pokemonData = json.decode(detailResponse.body);
            _validator.validatePokemonResponse(pokemonData);
            final model = PokemonModel.fromJson(pokemonData);
            pokemons.add(_mapper.toEntity(model));
          }
        }
      }

      return pokemons;
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByType(String type) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/type/$type'),
      );

      if (response.statusCode != 200) {
        throw ServerFailure(
          message: 'Failed to fetch Pokemon by type: ${response.statusCode}',
        );
      }

      final Map<String, dynamic> data = json.decode(response.body);
      final List<PokemonEntity> pokemons = [];

      for (final pokemon in data['pokemon'] as List) {
        final detailResponse = await _client.get(
          Uri.parse(pokemon['pokemon']['url']),
        );
        if (detailResponse.statusCode == 200) {
          final pokemonData = json.decode(detailResponse.body);
          _validator.validatePokemonResponse(pokemonData);
          final model = PokemonModel.fromJson(pokemonData);
          pokemons.add(_mapper.toEntity(model));
        }
      }

      return pokemons;
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/ability/$ability'),
      );

      if (response.statusCode != 200) {
        throw ServerFailure(
          message: 'Failed to fetch Pokemon by ability: ${response.statusCode}',
        );
      }

      final Map<String, dynamic> data = json.decode(response.body);
      final List<PokemonEntity> pokemons = [];

      for (final pokemon in data['pokemon'] as List) {
        final detailResponse = await _client.get(
          Uri.parse(pokemon['pokemon']['url']),
        );
        if (detailResponse.statusCode == 200) {
          final pokemonData = json.decode(detailResponse.body);
          _validator.validatePokemonResponse(pokemonData);
          final model = PokemonModel.fromJson(pokemonData);
          pokemons.add(_mapper.toEntity(model));
        }
      }

      return pokemons;
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByMove(String move) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/move/$move'),
      );

      if (response.statusCode != 200) {
        throw ServerFailure(
          message: 'Failed to fetch Pokemon by move: ${response.statusCode}',
        );
      }

      final Map<String, dynamic> data = json.decode(response.body);
      final List<PokemonEntity> pokemons = [];

      for (final pokemon in data['pokemon'] as List) {
        final detailResponse = await _client.get(
          Uri.parse(pokemon['pokemon']['url']),
        );
        if (detailResponse.statusCode == 200) {
          final pokemonData = json.decode(detailResponse.body);
          _validator.validatePokemonResponse(pokemonData);
          final model = PokemonModel.fromJson(pokemonData);
          pokemons.add(_mapper.toEntity(model));
        }
      }

      return pokemons;
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByEvolution(String evolution) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/evolution-chain/$evolution'),
      );

      if (response.statusCode != 200) {
        throw ServerFailure(
          message:
              'Failed to fetch Pokemon by evolution: ${response.statusCode}',
        );
      }

      final Map<String, dynamic> data = json.decode(response.body);
      final List<PokemonEntity> pokemons = [];

      for (final pokemon in data['chain']['evolves_to'] as List) {
        final detailResponse = await _client.get(
          Uri.parse(pokemon['species']['url']),
        );
        if (detailResponse.statusCode == 200) {
          final pokemonData = json.decode(detailResponse.body);
          _validator.validatePokemonResponse(pokemonData);
          final model = PokemonModel.fromJson(pokemonData);
          pokemons.add(_mapper.toEntity(model));
        }
      }

      return pokemons;
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByStat(String stat, int value) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/stat/$stat'),
      );

      if (response.statusCode != 200) {
        throw ServerFailure(
          message: 'Failed to fetch Pokemon by stat: ${response.statusCode}',
        );
      }

      final Map<String, dynamic> data = json.decode(response.body);
      final List<PokemonEntity> pokemons = [];

      for (final pokemon in data['pokemon'] as List) {
        if (pokemon['base_stat'] >= value) {
          final detailResponse = await _client.get(
            Uri.parse(pokemon['pokemon']['url']),
          );
          if (detailResponse.statusCode == 200) {
            final pokemonData = json.decode(detailResponse.body);
            _validator.validatePokemonResponse(pokemonData);
            final model = PokemonModel.fromJson(pokemonData);
            pokemons.add(_mapper.toEntity(model));
          }
        }
      }

      return pokemons;
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByDescription(
      String description) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/pokemon?limit=1000'),
      );

      if (response.statusCode != 200) {
        throw ServerFailure(
          message: 'Failed to search Pokemon: ${response.statusCode}',
        );
      }

      final Map<String, dynamic> data = json.decode(response.body);
      _validator.validateResponse(data);

      final pokemonResponse = PokemonResponse.fromJson(data);
      final List<PokemonEntity> pokemons = [];

      for (final result in pokemonResponse.results) {
        if (result['name'].toString().contains(description.toLowerCase())) {
          final detailResponse = await _client.get(Uri.parse(result['url']));
          if (detailResponse.statusCode == 200) {
            final pokemonData = json.decode(detailResponse.body);
            _validator.validatePokemonResponse(pokemonData);
            final model = PokemonModel.fromJson(pokemonData);
            pokemons.add(_mapper.toEntity(model));
          }
        }
      }

      return pokemons;
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }
}
