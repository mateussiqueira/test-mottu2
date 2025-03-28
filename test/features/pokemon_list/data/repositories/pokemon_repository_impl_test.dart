import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokeapi/core/domain/entities/pokemon.dart';
import 'package:pokeapi/features/pokemon_list/data/datasources/pokemon_remote_data_source.dart';
import 'package:pokeapi/features/pokemon_list/data/repositories/pokemon_repository_impl.dart';

@GenerateMocks([PokemonRemoteDataSource])
import 'pokemon_repository_impl_test.mocks.dart';

void main() {
  late PokemonRepositoryImpl repository;
  late MockPokemonRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockPokemonRemoteDataSource();
    repository = PokemonRepositoryImpl(mockRemoteDataSource);
  });

  final tPokemons = [
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

  group('getPokemons', () {
    test(
      'should return a list of Pokemon when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getPokemons(offset: 0, limit: 20))
            .thenAnswer((_) async => tPokemons);

        // act
        final result = await repository.getPokemons();

        // assert
        expect(result, equals(tPokemons));
        verify(mockRemoteDataSource.getPokemons(offset: 0, limit: 20));
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should throw an Exception when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getPokemons(offset: 0, limit: 20))
            .thenThrow(Exception('Failed to fetch pokemons'));

        // act
        final call = repository.getPokemons;

        // assert
        expect(() => call(), throwsA(isA<Exception>()));
      },
    );
  });

  group('searchPokemons', () {
    const tQuery = 'bulba';

    test(
      'should return a list of Pokemon when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.searchPokemons(tQuery))
            .thenAnswer((_) async => tPokemons);

        // act
        final result = await repository.searchPokemons(tQuery);

        // assert
        expect(result, equals(tPokemons));
        verify(mockRemoteDataSource.searchPokemons(tQuery));
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should throw an Exception when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.searchPokemons(tQuery))
            .thenThrow(Exception('Failed to search pokemons'));

        // act
        final call = repository.searchPokemons;

        // assert
        expect(() => call(tQuery), throwsA(isA<Exception>()));
      },
    );
  });
}
