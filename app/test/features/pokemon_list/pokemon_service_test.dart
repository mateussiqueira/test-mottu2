import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/src/services/pokemon_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([http.Client])
import 'pokemon_service_test.mocks.dart';

void main() {
  late PokemonService pokemonService;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    pokemonService = PokemonService(client: mockClient);
  });

  group('PokemonService', () {
    test('getPokemonList returns list of pokemons', () async {
      // Mock the list response
      when(mockClient.get(
              Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=20&offset=0')))
          .thenAnswer((_) async => http.Response(
                '''{
                  "results": [
                    {"name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon/1"},
                    {"name": "charmander", "url": "https://pokeapi.co/api/v2/pokemon/4"}
                  ]
                }''',
                200,
              ));

      // Mock the detail responses
      when(mockClient.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/1')))
          .thenAnswer((_) async => http.Response(
                '''{
                  "id": 1,
                  "name": "bulbasaur",
                  "types": [{"type": {"name": "grass"}}],
                  "abilities": [{"ability": {"name": "overgrow"}}],
                  "height": 7,
                  "weight": 69,
                  "base_experience": 64,
                  "sprites": {"front_default": "https://example.com/bulbasaur.png"}
                }''',
                200,
              ));

      when(mockClient.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/4')))
          .thenAnswer((_) async => http.Response(
                '''{
                  "id": 4,
                  "name": "charmander",
                  "types": [{"type": {"name": "fire"}}],
                  "abilities": [{"ability": {"name": "blaze"}}],
                  "height": 6,
                  "weight": 85,
                  "base_experience": 62,
                  "sprites": {"front_default": "https://example.com/charmander.png"}
                }''',
                200,
              ));

      final result = await pokemonService.getPokemonList();

      expect(result.length, 2);
      expect(result[0].id, 1);
      expect(result[0].name, 'bulbasaur');
      expect(result[0].types, ['grass']);
      expect(result[0].abilities, ['overgrow']);
      expect(result[0].height, 0.7);
      expect(result[0].weight, 6.9);
      expect(result[0].baseExperience, 64);
      expect(result[0].imageUrl, 'https://example.com/bulbasaur.png');
    });

    test('getPokemonById returns pokemon details', () async {
      when(mockClient.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/25')))
          .thenAnswer((_) async => http.Response(
                '''{
                  "id": 25,
                  "name": "pikachu",
                  "types": [{"type": {"name": "electric"}}],
                  "abilities": [{"ability": {"name": "static"}}],
                  "height": 4,
                  "weight": 60,
                  "base_experience": 112,
                  "sprites": {"front_default": "https://example.com/pikachu.png"}
                }''',
                200,
              ));

      final result = await pokemonService.getPokemonById(25);

      expect(result.id, 25);
      expect(result.name, 'pikachu');
      expect(result.types, ['electric']);
      expect(result.abilities, ['static']);
      expect(result.height, 0.4);
      expect(result.weight, 6.0);
      expect(result.baseExperience, 112);
      expect(result.imageUrl, 'https://example.com/pikachu.png');
    });

    test('searchPokemon returns matching pokemons', () async {
      when(mockClient
              .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=1000')))
          .thenAnswer((_) async => http.Response(
                '''{
                  "results": [
                    {"name": "pikachu", "url": "https://pokeapi.co/api/v2/pokemon/25"},
                    {"name": "raichu", "url": "https://pokeapi.co/api/v2/pokemon/26"}
                  ]
                }''',
                200,
              ));

      when(mockClient.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/25')))
          .thenAnswer((_) async => http.Response(
                '''{
                  "id": 25,
                  "name": "pikachu",
                  "types": [{"type": {"name": "electric"}}],
                  "abilities": [{"ability": {"name": "static"}}],
                  "height": 4,
                  "weight": 60,
                  "base_experience": 112,
                  "sprites": {"front_default": "https://example.com/pikachu.png"}
                }''',
                200,
              ));

      when(mockClient.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/26')))
          .thenAnswer((_) async => http.Response(
                '''{
                  "id": 26,
                  "name": "raichu",
                  "types": [{"type": {"name": "electric"}}],
                  "abilities": [{"ability": {"name": "static"}}],
                  "height": 8,
                  "weight": 300,
                  "base_experience": 218,
                  "sprites": {"front_default": "https://example.com/raichu.png"}
                }''',
                200,
              ));

      final result = await pokemonService.searchPokemon('pika');

      expect(result.length, 2);
      expect(result[0].name, 'pikachu');
      expect(result[1].name, 'raichu');
    });

    test('handles errors appropriately', () async {
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response('Error', 500));

      expect(
        () => pokemonService.getPokemonList(),
        throwsA(isA<Exception>()),
      );

      expect(
        () => pokemonService.getPokemonById(25),
        throwsA(isA<Exception>()),
      );

      expect(
        () => pokemonService.searchPokemon('pikachu'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
