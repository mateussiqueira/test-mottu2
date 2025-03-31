import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/features/pokemon_list/data/adapters/poke_api_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([http.Client, SharedPreferences])
import 'poke_api_adapter_test.mocks.dart' as mocks;

void main() {
  late PokeApiAdapter adapter;
  late mocks.MockClient mockClient;
  late mocks.MockSharedPreferences mockPrefs;

  setUp(() {
    mockClient = mocks.MockClient();
    mockPrefs = mocks.MockSharedPreferences();
    adapter = PokeApiAdapter(client: mockClient, prefs: mockPrefs);
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
                  'base_experience': 64,
                }),
                200,
              ));

      final pokemons = await adapter.getPokemons();

      expect(pokemons.length, 1);
      expect(pokemons.first.name, 'bulbasaur');
      expect(pokemons.first.types.map((t) => t.type.name).toList(),
          ['grass', 'poison']);
      expect(pokemons.first.abilities.map((a) => a.ability.name).toList(),
          ['overgrow', 'chlorophyll']);
      expect(pokemons.first.height, 7);
      expect(pokemons.first.weight, 69);
      expect(pokemons.first.baseExperience, 64);
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
                  'base_experience': 64,
                }),
                200,
              ));

      final pokemons = await adapter.searchPokemons('bulba');

      expect(pokemons.length, 1);
      expect(pokemons.first.name, 'bulbasaur');
    });
  });
}
