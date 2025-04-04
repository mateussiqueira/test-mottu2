import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/entities/pokemon_entity.dart';
import 'i_pokemon_remote_datasource.dart';

/// Implementation of the Pokemon remote data source
class PokemonRemoteDataSourceImpl implements IPokemonRemoteDataSource {
  final http.Client _client;
  final String _baseUrl = 'https://pokeapi.co/api/v2';

  PokemonRemoteDataSourceImpl(this._client);

  @override
  Future<List<PokemonEntity>> getPokemonList(
      {int? limit = 20, int? offset = 0}) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/pokemon?limit=$limit&offset=$offset'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      final List<PokemonEntity> pokemons = [];

      for (var pokemon in results) {
        final detailResponse = await _client.get(Uri.parse(pokemon['url']));
        if (detailResponse.statusCode == 200) {
          final pokemonData = json.decode(detailResponse.body);
          pokemons.add(_mapToPokemonEntity(pokemonData));
        }
      }

      return pokemons;
    } else {
      throw Exception('Failed to load pokemon list');
    }
  }

  @override
  Future<PokemonEntity> getPokemonById(int id) async {
    final response = await _client.get(Uri.parse('$_baseUrl/pokemon/$id'));

    if (response.statusCode == 200) {
      final pokemonData = json.decode(response.body);
      return _mapToPokemonEntity(pokemonData);
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  @override
  Future<List<PokemonEntity>> searchPokemons(String query) async {
    final response =
        await _client.get(Uri.parse('$_baseUrl/pokemon?limit=1000'));

    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      final filteredResults = results.where((pokemon) => pokemon['name']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase()));

      final List<PokemonEntity> pokemons = [];
      for (var pokemon in filteredResults) {
        final detailResponse = await _client.get(Uri.parse(pokemon['url']));
        if (detailResponse.statusCode == 200) {
          final pokemonData = json.decode(detailResponse.body);
          pokemons.add(_mapToPokemonEntity(pokemonData));
        }
      }

      return pokemons;
    } else {
      throw Exception('Failed to search pokemons');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByType(String type) async {
    final response = await _client.get(Uri.parse('$_baseUrl/type/$type'));

    if (response.statusCode == 200) {
      final List<dynamic> pokemon = json.decode(response.body)['pokemon'];
      final List<PokemonEntity> pokemons = [];

      for (var p in pokemon) {
        final detailResponse =
            await _client.get(Uri.parse(p['pokemon']['url']));
        if (detailResponse.statusCode == 200) {
          final pokemonData = json.decode(detailResponse.body);
          pokemons.add(_mapToPokemonEntity(pokemonData));
        }
      }

      return pokemons;
    } else {
      throw Exception('Failed to load pokemons by type');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability) async {
    final response = await _client.get(Uri.parse('$_baseUrl/ability/$ability'));

    if (response.statusCode == 200) {
      final List<dynamic> pokemon = json.decode(response.body)['pokemon'];
      final List<PokemonEntity> pokemons = [];

      for (var p in pokemon) {
        final detailResponse =
            await _client.get(Uri.parse(p['pokemon']['url']));
        if (detailResponse.statusCode == 200) {
          final pokemonData = json.decode(detailResponse.body);
          pokemons.add(_mapToPokemonEntity(pokemonData));
        }
      }

      return pokemons;
    } else {
      throw Exception('Failed to load pokemons by ability');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByMove(String move) async {
    final response = await _client.get(Uri.parse('$_baseUrl/move/$move'));

    if (response.statusCode == 200) {
      final List<dynamic> pokemon =
          json.decode(response.body)['learned_by_pokemon'];
      final List<PokemonEntity> pokemons = [];

      for (var p in pokemon) {
        final detailResponse = await _client.get(Uri.parse(p['url']));
        if (detailResponse.statusCode == 200) {
          final pokemonData = json.decode(detailResponse.body);
          pokemons.add(_mapToPokemonEntity(pokemonData));
        }
      }

      return pokemons;
    } else {
      throw Exception('Failed to load pokemons by move');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByEvolution(String evolution) async {
    final response =
        await _client.get(Uri.parse('$_baseUrl/evolution-chain/$evolution'));

    if (response.statusCode == 200) {
      final chain = json.decode(response.body)['chain'];
      final List<PokemonEntity> pokemons = [];

      await _processEvolutionChain(chain, pokemons);

      return pokemons;
    } else {
      throw Exception('Failed to load pokemons by evolution');
    }
  }

  Future<void> _processEvolutionChain(
      Map<String, dynamic> chain, List<PokemonEntity> pokemons) async {
    final speciesUrl = chain['species']['url'];
    final speciesResponse = await _client.get(Uri.parse(speciesUrl));

    if (speciesResponse.statusCode == 200) {
      final speciesData = json.decode(speciesResponse.body);
      final pokemonResponse = await _client
          .get(Uri.parse('$_baseUrl/pokemon/${speciesData['id']}'));

      if (pokemonResponse.statusCode == 200) {
        final pokemonData = json.decode(pokemonResponse.body);
        pokemons.add(_mapToPokemonEntity(pokemonData));
      }
    }

    if (chain['evolves_to'] != null && chain['evolves_to'].isNotEmpty) {
      for (var evolution in chain['evolves_to']) {
        await _processEvolutionChain(evolution, pokemons);
      }
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByStat(String stat, int value) async {
    final response =
        await _client.get(Uri.parse('$_baseUrl/pokemon?limit=1000'));

    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      final List<PokemonEntity> pokemons = [];

      for (var pokemon in results) {
        final detailResponse = await _client.get(Uri.parse(pokemon['url']));
        if (detailResponse.statusCode == 200) {
          final pokemonData = json.decode(detailResponse.body);
          final stats = pokemonData['stats'];
          final matchingStat = stats.firstWhere(
            (s) => s['stat']['name'] == stat,
            orElse: () => null,
          );

          if (matchingStat != null && matchingStat['base_stat'] >= value) {
            pokemons.add(_mapToPokemonEntity(pokemonData));
          }
        }
      }

      return pokemons;
    } else {
      throw Exception('Failed to load pokemons by stat');
    }
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByDescription(
      String description) async {
    final response =
        await _client.get(Uri.parse('$_baseUrl/pokemon-species?limit=1000'));

    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      final List<PokemonEntity> pokemons = [];

      for (var species in results) {
        final speciesResponse = await _client.get(Uri.parse(species['url']));
        if (speciesResponse.statusCode == 200) {
          final speciesData = json.decode(speciesResponse.body);
          final flavorTextEntries = speciesData['flavor_text_entries'];
          final englishDescription = flavorTextEntries.firstWhere(
            (entry) => entry['language']['name'] == 'en',
            orElse: () => null,
          );

          if (englishDescription != null &&
              englishDescription['flavor_text']
                  .toString()
                  .toLowerCase()
                  .contains(description.toLowerCase())) {
            final pokemonResponse = await _client.get(
              Uri.parse('$_baseUrl/pokemon/${speciesData['id']}'),
            );
            if (pokemonResponse.statusCode == 200) {
              final pokemonData = json.decode(pokemonResponse.body);
              pokemons.add(_mapToPokemonEntity(pokemonData));
            }
          }
        }
      }

      return pokemons;
    } else {
      throw Exception('Failed to load pokemons by description');
    }
  }

  PokemonEntity _mapToPokemonEntity(Map<String, dynamic> data) {
    return PokemonEntity(
      id: data['id'],
      name: data['name'],
      imageUrl: data['sprites']['other']['official-artwork']['front_default'],
      types: (data['types'] as List)
          .map((type) => type['type']['name'].toString())
          .toList(),
      height: data['height'],
      weight: data['weight'],
      baseExperience: data['base_experience'] ?? 0,
      abilities: (data['abilities'] as List)
          .map((ability) => ability['ability']['name'].toString())
          .toList(),
      stats: Map.fromEntries(
        (data['stats'] as List).map(
          (stat) => MapEntry(
            stat['stat']['name'].toString(),
            stat['base_stat'] as int,
          ),
        ),
      ),
      moves: (data['moves'] as List)
          .map((move) => move['move']['name'].toString())
          .toList(),
      evolutions: [], // This will be filled when needed from evolution-chain endpoint
      description: '', // This will be filled when needed from species endpoint
    );
  }
}
