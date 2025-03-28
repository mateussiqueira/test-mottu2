import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokeapi/features/pokemon_list/data/adapters/poke_api_adapter.dart';
import 'package:pokeapi/features/pokemon_list/data/repositories/pokemon_repository_impl.dart';
import 'package:pokeapi/features/pokemon_list/domain/entities/pokemon.dart';
import 'package:pokeapi/features/pokemon_list/domain/repositories/pokemon_repository.dart';

@GenerateMocks([PokeApiAdapter])
void main() {
  late PokemonRepository repository;
  late MockPokeApiAdapter mockAdapter;

  setUp(() {
    mockAdapter = MockPokeApiAdapter();
    repository = PokemonRepositoryImpl(mockAdapter);
  });

  group('PokemonRepository', () {
    test('should get pokemons', () async {
      final pokemons = [
        Pokemon(
          id: '1',
          name: 'bulbasaur',
          imageUrl: 'https://example.com/bulbasaur.png',
          types: ['grass', 'poison'],
          abilities: ['overgrow', 'chlorophyll'],
          stats: {'hp': 45, 'attack': 49, 'defense': 49},
          height: 0.7,
          weight: 6.9,
          evolutionChain: ['bulbasaur', 'ivysaur', 'venusaur'],
          locations: ['pallet-town', 'viridian-city'],
        ),
      ];

      when(mockAdapter.getPokemons()).thenAnswer((_) async => pokemons);

      final result = await repository.getPokemons();

      expect(result, pokemons);
      verify(mockAdapter.getPokemons()).called(1);
    });

    test('should get pokemon by id', () async {
      final pokemon = Pokemon(
        id: '1',
        name: 'bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
        types: ['grass', 'poison'],
        abilities: ['overgrow', 'chlorophyll'],
        stats: {'hp': 45, 'attack': 49, 'defense': 49},
        height: 0.7,
        weight: 6.9,
        evolutionChain: ['bulbasaur', 'ivysaur', 'venusaur'],
        locations: ['pallet-town', 'viridian-city'],
      );

      when(mockAdapter.getPokemonById('1')).thenAnswer((_) async => pokemon);

      final result = await repository.getPokemonById('1');

      expect(result, pokemon);
      verify(mockAdapter.getPokemonById('1')).called(1);
    });

    test('should search pokemons', () async {
      final pokemons = [
        Pokemon(
          id: '1',
          name: 'bulbasaur',
          imageUrl: 'https://example.com/bulbasaur.png',
          types: ['grass', 'poison'],
          abilities: ['overgrow', 'chlorophyll'],
          stats: {'hp': 45, 'attack': 49, 'defense': 49},
          height: 0.7,
          weight: 6.9,
          evolutionChain: ['bulbasaur', 'ivysaur', 'venusaur'],
          locations: ['pallet-town', 'viridian-city'],
        ),
      ];

      when(mockAdapter.searchPokemons('bulba'))
          .thenAnswer((_) async => pokemons);

      final result = await repository.searchPokemons('bulba');

      expect(result, pokemons);
      verify(mockAdapter.searchPokemons('bulba')).called(1);
    });
  });
}
