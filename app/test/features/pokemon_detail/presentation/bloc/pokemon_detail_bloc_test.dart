import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/domain/errors/pokemon_error.dart';
import 'package:mobile/core/domain/result.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_list/domain/repositories/pokemon_repository.dart';
import 'package:mobile/features/pokemon_list/presentation/bloc/pokemon_list_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([PokemonRepository])
import 'pokemon_detail_bloc_test.mocks.dart';

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

  final tPokemons = [
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

  group('PokemonListBloc', () {
    blocTest<PokemonListBloc, PokemonListState>(
      'emits [PokemonListLoading, PokemonListLoaded] when LoadPokemons is added',
      build: () {
        when(mockRepository.getPokemonList(limit: 20, offset: 0))
            .thenAnswer((_) async => Result.success(tPokemons));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadPokemons()),
      expect: () => [
        PokemonListLoading(),
        PokemonListLoaded(tPokemons),
      ],
      verify: (_) {
        verify(mockRepository.getPokemonList(limit: 20, offset: 0)).called(1);
      },
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'emits [PokemonListLoading, PokemonListError] when LoadPokemons fails',
      build: () {
        when(mockRepository.getPokemonList(limit: 20, offset: 0))
            .thenAnswer((_) async => Result.failure(PokemonNetworkError()));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadPokemons()),
      expect: () => [
        PokemonListLoading(),
        PokemonListError('Network error occurred'),
      ],
      verify: (_) {
        verify(mockRepository.getPokemonList(limit: 20, offset: 0)).called(1);
      },
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'emits [PokemonListLoading, PokemonListLoaded] when SearchPokemons is added',
      build: () {
        when(mockRepository.searchPokemon('bulba'))
            .thenAnswer((_) async => Result.success(tPokemons));
        return bloc;
      },
      act: (bloc) => bloc.add(SearchPokemons('bulba')),
      expect: () => [
        PokemonListLoading(),
        PokemonListLoaded(tPokemons),
      ],
      verify: (_) {
        verify(mockRepository.searchPokemon('bulba')).called(1);
      },
    );

    blocTest<PokemonListBloc, PokemonListState>(
      'emits [PokemonListLoading, PokemonListError] when SearchPokemons fails',
      build: () {
        when(mockRepository.searchPokemon('bulba'))
            .thenAnswer((_) async => Result.failure(PokemonNetworkError()));
        return bloc;
      },
      act: (bloc) => bloc.add(SearchPokemons('bulba')),
      expect: () => [
        PokemonListLoading(),
        PokemonListError('Network error occurred'),
      ],
      verify: (_) {
        verify(mockRepository.searchPokemon('bulba')).called(1);
      },
    );
  });
}
