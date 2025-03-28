import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokeapi/features/pokemon_list/data/adapters/poke_api_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([http.Client, SharedPreferences])
void main() {
  late PokeApiAdapter adapter;
  late MockClient mockClient;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockClient = MockClient();
    mockPrefs = MockSharedPreferences();
    adapter = PokeApiAdapter(mockClient, mockPrefs);
  });

  group('PokeApiAdapter', () {
    test('should fetch pokemons from API', () async {
      final response = {
        'count': 151,
        'next': null,
        'previous': null,
        'results': [
          {'name': 'bulbasaur', 'url': 'https://pokeapi.co/api/v2/pokemon/1/'},
          {'name': 'charmander', 'url': 'https://pokeapi.co/api/v2/pokemon/4/'},
        ],
      };

      when(mockClient.get(
              Uri.parse('https://pokeapi.co/api/v2/pokemon?offset=0&limit=20')))
          .thenAnswer((_) async => http.Response(jsonEncode(response), 200));

      when(mockClient
              .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/bulbasaur')))
          .thenAnswer((_) async => http.Response(
                jsonEncode({
                  'id': 1,
                  'name': 'bulbasaur',
                  'sprites': {
                    'front_default': 'https://example.com/bulbasaur.png'
                  },
                  'types': [
                    {
                      'type': {'name': 'grass'}
                    },
                    {
                      'type': {'name': 'poison'}
                    },
                  ],
                  'abilities': [
                    {
                      'ability': {'name': 'overgrow'}
                    },
                    {
                      'ability': {'name': 'chlorophyll'}
                    },
                  ],
                  'stats': [
                    {
                      'base_stat': 45,
                      'stat': {'name': 'hp'}
                    },
                    {
                      'base_stat': 49,
                      'stat': {'name': 'attack'}
                    },
                    {
                      'base_stat': 49,
                      'stat': {'name': 'defense'}
                    },
                  ],
                  'height': 7,
                  'weight': 69,
                  'evolution_chain': {
                    'url': 'https://pokeapi.co/api/v2/evolution-chain/1/'
                  },
                  'location_area_encounters':
                      'https://pokeapi.co/api/v2/pokemon/1/encounters',
                }),
                200,
              ));

      final pokemons = await adapter.getPokemons();

      expect(pokemons.length, 1);
      expect(pokemons.first.name, 'bulbasaur');
      expect(pokemons.first.types, ['grass', 'poison']);
      expect(pokemons.first.abilities, ['overgrow', 'chlorophyll']);
      expect(pokemons.first.stats, {'hp': 45, 'attack': 49, 'defense': 49});
    });

    test('should handle API errors', () async {
      when(mockClient.get(
              Uri.parse('https://pokeapi.co/api/v2/pokemon?offset=0&limit=20')))
          .thenAnswer((_) async => http.Response('Error', 500));

      expect(() => adapter.getPokemons(), throwsException);
    });

    test('should search pokemons', () async {
      final response = {
        'count': 151,
        'next': null,
        'previous': null,
        'results': [
          {'name': 'bulbasaur', 'url': 'https://pokeapi.co/api/v2/pokemon/1/'},
          {'name': 'charmander', 'url': 'https://pokeapi.co/api/v2/pokemon/4/'},
        ],
      };

      when(mockClient.get(Uri.parse(
              'https://pokeapi.co/api/v2/pokemon?offset=0&limit=151')))
          .thenAnswer((_) async => http.Response(jsonEncode(response), 200));

      when(mockClient
              .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/bulbasaur')))
          .thenAnswer((_) async => http.Response(
                jsonEncode({
                  'id': 1,
                  'name': 'bulbasaur',
                  'sprites': {
                    'front_default': 'https://example.com/bulbasaur.png'
                  },
                  'types': [
                    {
                      'type': {'name': 'grass'}
                    },
                    {
                      'type': {'name': 'poison'}
                    },
                  ],
                  'abilities': [
                    {
                      'ability': {'name': 'overgrow'}
                    },
                    {
                      'ability': {'name': 'chlorophyll'}
                    },
                  ],
                  'stats': [
                    {
                      'base_stat': 45,
                      'stat': {'name': 'hp'}
                    },
                    {
                      'base_stat': 49,
                      'stat': {'name': 'attack'}
                    },
                    {
                      'base_stat': 49,
                      'stat': {'name': 'defense'}
                    },
                  ],
                  'height': 7,
                  'weight': 69,
                  'evolution_chain': {
                    'url': 'https://pokeapi.co/api/v2/evolution-chain/1/'
                  },
                  'location_area_encounters':
                      'https://pokeapi.co/api/v2/pokemon/1/encounters',
                }),
                200,
              ));

      final pokemons = await adapter.searchPokemons('bulba');

      expect(pokemons.length, 1);
      expect(pokemons.first.name, 'bulbasaur');
    });
  });
}
