import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/domain/errors/pokemon_error.dart';
import 'package:mobile/core/domain/result.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_list/domain/repositories/pokemon_repository.dart';
import 'package:mobile/features/pokemon_list/presentation/bloc/pokemon_list_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
      PokemonEntityImpl(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
        types: ['grass', 'poison'],
        abilities: ['overgrow', 'chlorophyll'],
        height: 7,
        weight: 69,
        baseExperience: 64,
      ),
    ];

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [PokemonListLoading, PokemonListLoaded] when LoadPokemons is successful',
      build: () {
        when(
          mockRepository.getPokemonList(offset: 0, limit: 20),
        ).thenAnswer((_) async => Result.success(pokemons));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadPokemons()),
      expect: () => [PokemonListLoading(), PokemonListLoaded(pokemons)],
      verify: (bloc) => mockRepository.getPokemonList(offset: 0, limit: 20),
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [PokemonListLoading, PokemonListError] when LoadPokemons fails',
      build: () {
        when(
          mockRepository.getPokemonList(offset: 0, limit: 20),
        ).thenAnswer((_) async => Result.failure(PokemonNetworkError()));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadPokemons()),
      expect:
          () => [
            PokemonListLoading(),
            PokemonListError('Network error occurred'),
          ],
      verify: (bloc) => mockRepository.getPokemonList(offset: 0, limit: 20),
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [PokemonListLoading, PokemonListLoaded] when SearchPokemons is successful',
      build: () {
        when(
          mockRepository.searchPokemon('bulba'),
        ).thenAnswer((_) async => Result.success(pokemons));
        return bloc;
      },
      act: (bloc) => bloc.add(SearchPokemons('bulba')),
      expect: () => [PokemonListLoading(), PokemonListLoaded(pokemons)],
      verify: (bloc) => mockRepository.searchPokemon('bulba'),
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [PokemonListLoading, PokemonListError] when SearchPokemons fails',
      build: () {
        when(
          mockRepository.searchPokemon('bulba'),
        ).thenAnswer((_) async => Result.failure(PokemonNetworkError()));
        return bloc;
      },
      act: (bloc) => bloc.add(SearchPokemons('bulba')),
      expect:
          () => [
            PokemonListLoading(),
            PokemonListError('Network error occurred'),
          ],
      verify: (bloc) => mockRepository.searchPokemon('bulba'),
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [PokemonListLoading, PokemonListLoaded] when LoadPokemonsByType is successful',
      build: () {
        when(
          mockRepository.getPokemonList(offset: 0, limit: 20),
        ).thenAnswer((_) async => Result.success(pokemons));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadPokemonsByType('grass')),
      expect: () => [PokemonListLoading(), PokemonListLoaded(pokemons)],
      verify: (bloc) => mockRepository.getPokemonList(offset: 0, limit: 20),
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [PokemonListLoading, PokemonListError] when LoadPokemonsByType fails',
      build: () {
        when(
          mockRepository.getPokemonList(offset: 0, limit: 20),
        ).thenAnswer((_) async => Result.failure(PokemonNetworkError()));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadPokemonsByType('grass')),
      expect:
          () => [
            PokemonListLoading(),
            PokemonListError('Network error occurred'),
          ],
      verify: (bloc) => mockRepository.getPokemonList(offset: 0, limit: 20),
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [PokemonListLoading, PokemonListLoaded] when LoadPokemonsByAbility is successful',
      build: () {
        when(
          mockRepository.getPokemonList(offset: 0, limit: 20),
        ).thenAnswer((_) async => Result.success(pokemons));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadPokemonsByAbility('overgrow')),
      expect: () => [PokemonListLoading(), PokemonListLoaded(pokemons)],
      verify: (bloc) => mockRepository.getPokemonList(offset: 0, limit: 20),
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'should emit [PokemonListLoading, PokemonListError] when LoadPokemonsByAbility fails',
      build: () {
        when(
          mockRepository.getPokemonList(offset: 0, limit: 20),
        ).thenAnswer((_) async => Result.failure(PokemonNetworkError()));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadPokemonsByAbility('overgrow')),
      expect:
          () => [
            PokemonListLoading(),
            PokemonListError('Network error occurred'),
          ],
      verify: (bloc) => mockRepository.getPokemonList(offset: 0, limit: 20),
    );
  });
}
