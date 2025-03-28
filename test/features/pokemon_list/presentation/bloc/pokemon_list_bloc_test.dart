import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokeapi/core/domain/entities/pokemon.dart';
import 'package:pokeapi/core/domain/repositories/pokemon_repository.dart';
import 'package:pokeapi/features/pokemon_list/presentation/bloc/pokemon_list_bloc.dart';
import 'package:pokeapi/features/pokemon_list/presentation/bloc/pokemon_list_event.dart';
import 'package:pokeapi/features/pokemon_list/presentation/bloc/pokemon_list_state.dart';

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

  group('PokemonListBloc', () {
    final pokemons = [
      const Pokemon(
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

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [PokemonListLoading, PokemonListLoaded] when LoadPokemons is successful',
      build: () {
        when(mockRepository.getPokemons()).thenAnswer((_) async => pokemons);
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadPokemons()),
      expect: () => [
        const PokemonListLoading(),
        PokemonListLoaded(pokemons),
      ],
      verify: (bloc) => mockRepository.getPokemons(),
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [PokemonListLoading, PokemonListError] when LoadPokemons fails',
      build: () {
        when(mockRepository.getPokemons())
            .thenThrow(Exception('Failed to load pokemons'));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadPokemons()),
      expect: () => [
        const PokemonListLoading(),
        const PokemonListError('Failed to load pokemons'),
      ],
      verify: (bloc) => mockRepository.getPokemons(),
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [PokemonListLoading, PokemonListLoaded] when SearchPokemons is successful',
      build: () {
        when(mockRepository.searchPokemons('bulba'))
            .thenAnswer((_) async => pokemons);
        return bloc;
      },
      act: (bloc) => bloc.add(SearchPokemons('bulba')),
      expect: () => [
        const PokemonListLoading(),
        PokemonListLoaded(pokemons),
      ],
      verify: (bloc) => mockRepository.searchPokemons('bulba'),
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [PokemonListLoading, PokemonListError] when SearchPokemons fails',
      build: () {
        when(mockRepository.searchPokemons('bulba'))
            .thenThrow(Exception('Failed to search pokemons'));
        return bloc;
      },
      act: (bloc) => bloc.add(SearchPokemons('bulba')),
      expect: () => [
        const PokemonListLoading(),
        const PokemonListError('Failed to search pokemons'),
      ],
      verify: (bloc) => mockRepository.searchPokemons('bulba'),
    );
  });
}
