import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokeapi/core/domain/entities/pokemon.dart';
import 'package:pokeapi/core/domain/repositories/pokemon_repository.dart';
import 'package:pokeapi/features/pokemon_list/presentation/bloc/pokemon_list_bloc.dart';

import 'pokemon_list_bloc_test.mocks.dart';

@GenerateMocks([PokemonRepository])
void main() {
  late PokemonListBloc bloc;
  late MockPokemonRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonRepository();
    bloc = PokemonListBloc(repository: mockRepository);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be PokemonListInitial', () {
    expect(bloc.state, isA<PokemonListInitial>());
  });

  group('LoadPokemons', () {
    final pokemons = [
      const Pokemon(
        id: 1,
        name: 'Bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
        types: ['grass', 'poison'],
        stats: [
          {'name': 'hp', 'value': 45},
          {'name': 'attack', 'value': 49},
        ],
        abilities: ['overgrow'],
        moves: ['tackle', 'growl'],
        evolutionChain: [],
        locations: [],
        height: 0.7,
        weight: 6.9,
      ),
    ];

    test('should emit [Loading, Loaded] when data is fetched successfully',
        () async {
      when(mockRepository.getPokemons(offset: 0, limit: 20))
          .thenAnswer((_) async => pokemons);

      final expected = [
        PokemonListLoading(),
        PokemonListLoaded(pokemons: pokemons),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const LoadPokemons());
    });

    test('should emit [Loading, Error] when data is fetched unsuccessfully',
        () async {
      when(mockRepository.getPokemons(offset: 0, limit: 20))
          .thenThrow(Exception('Failed to load pokemons'));

      final expected = [
        PokemonListLoading(),
        const PokemonListError('Exception: Failed to load pokemons'),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const LoadPokemons());
    });
  });

  group('SearchPokemon', () {
    final pokemons = [
      const Pokemon(
        id: 1,
        name: 'Bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
        types: ['grass', 'poison'],
        stats: [
          {'name': 'hp', 'value': 45},
          {'name': 'attack', 'value': 49},
        ],
        abilities: ['overgrow'],
        moves: ['tackle', 'growl'],
        evolutionChain: [],
        locations: [],
        height: 0.7,
        weight: 6.9,
      ),
    ];

    test('should emit [Loading, Loaded] when search is successful', () async {
      when(mockRepository.searchPokemons('bulbasaur'))
          .thenAnswer((_) async => pokemons);

      final expected = [
        PokemonListLoading(),
        PokemonListLoaded(pokemons: pokemons, hasMore: false),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const SearchPokemon('bulbasaur'));
    });

    test('should emit [Loading, Error] when search fails', () async {
      when(mockRepository.searchPokemons('bulbasaur'))
          .thenThrow(Exception('Failed to search pokemon'));

      final expected = [
        PokemonListLoading(),
        const PokemonListError('Exception: Failed to search pokemon'),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const SearchPokemon('bulbasaur'));
    });
  });
}
