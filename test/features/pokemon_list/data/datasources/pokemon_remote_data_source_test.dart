import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokeapi/core/domain/entities/pokemon.dart';
import 'package:pokeapi/features/pokemon_list/data/datasources/pokemon_remote_data_source.dart';

@GenerateMocks([http.Client])
import 'pokemon_remote_data_source_test.mocks.dart';

void main() {
  late PokemonRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = PokemonRemoteDataSourceImpl(client: mockClient);
  });

  group('getPokemons', () {
    final tPokemonListResponse = {
      'results': [
        {
          'name': 'bulbasaur',
          'url': 'https://pokeapi.co/api/v2/pokemon/1/',
        },
      ],
    };

    final tPokemonResponse = {
      'id': 1,
      'name': 'bulbasaur',
      'sprites': {
        'other': {
          'official-artwork': {
            'front_default': 'https://example.com/bulbasaur.png',
          },
        },
      },
      'types': [
        {
          'type': {'name': 'grass'},
        },
        {
          'type': {'name': 'poison'},
        },
      ],
      'stats': [
        {
          'base_stat': 45,
          'stat': {'name': 'hp'},
        },
        {
          'base_stat': 49,
          'stat': {'name': 'attack'},
        },
      ],
      'abilities': [
        {
          'ability': {'name': 'overgrow'},
        },
      ],
      'moves': [
        {
          'move': {'name': 'tackle'},
        },
        {
          'move': {'name': 'growl'},
        },
      ],
      'evolution_chain': [],
      'locations': [],
      'height': 7,
      'weight': 69,
    };

    test(
      'should return a list of Pokemon when the response is successful',
      () async {
        // arrange
        when(mockClient.get(Uri.parse(
                'https://pokeapi.co/api/v2/pokemon?offset=0&limit=20')))
            .thenAnswer((_) async => http.Response(
                  json.encode(tPokemonListResponse),
                  200,
                ));

        when(mockClient.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/1')))
            .thenAnswer((_) async => http.Response(
                  json.encode(tPokemonResponse),
                  200,
                ));

        // act
        final result = await dataSource.getPokemons();

        // assert
        expect(result, isA<List<Pokemon>>());
        expect(result.length, 1);
        expect(result[0].id, 1);
        expect(result[0].name, 'bulbasaur');
        expect(result[0].height, 0.7);
        expect(result[0].weight, 6.9);
        verify(mockClient.get(
            Uri.parse('https://pokeapi.co/api/v2/pokemon?offset=0&limit=20')));
        verify(
            mockClient.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/1')));
      },
    );

    test(
      'should throw an Exception when the response is unsuccessful',
      () async {
        // arrange
        when(mockClient.get(Uri.parse(
                'https://pokeapi.co/api/v2/pokemon?offset=0&limit=20')))
            .thenThrow(Exception('Something went wrong'));

        // act
        final call = dataSource.getPokemons;

        // assert
        expect(() => call(), throwsA(isA<Exception>()));
      },
    );
  });
}
