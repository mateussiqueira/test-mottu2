import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/domain/errors/pokemon_error.dart';
import 'package:mobile/features/pokemon_list/data/datasources/pokemon_remote_data_source.dart';
import 'package:mobile/features/pokemon_list/data/models/pokemon_model.dart';
import 'package:mobile/features/pokemon_list/data/repositories/pokemon_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([PokemonRemoteDataSource])
import 'pokemon_repository_impl_test.mocks.dart';

void main() {
  late PokemonRepositoryImpl repository;
  late MockPokemonRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockPokemonRemoteDataSource();
    repository = PokemonRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  final tPokemons = [
    PokemonModel(
      id: 1,
      name: 'bulbasaur',
      height: 7,
      weight: 69,
      baseExperience: 64,
      stats: [],
      types: [],
      abilities: [],
      moves: [],
      sprites: Sprites(frontDefault: 'https://example.com/bulbasaur.png'),
    ),
  ];

  test('should get pokemons', () async {
    // arrange
    when(mockRemoteDataSource.getPokemons(limit: 20, offset: 0))
        .thenAnswer((_) async => tPokemons);

    // act
    final result = await repository.getPokemonList(limit: 20, offset: 0);

    // assert
    expect(result.isSuccess, true);
    expect(result.data, equals(tPokemons.map((p) => p.toEntity()).toList()));
    verify(mockRemoteDataSource.getPokemons(limit: 20, offset: 0));
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('should get pokemon by id', () async {
    // arrange
    final tPokemon = PokemonModel(
      id: 1,
      name: 'bulbasaur',
      height: 7,
      weight: 69,
      baseExperience: 64,
      stats: [],
      types: [],
      abilities: [],
      moves: [],
      sprites: Sprites(frontDefault: 'https://example.com/bulbasaur.png'),
    );

    when(mockRemoteDataSource.getPokemonById(1))
        .thenAnswer((_) async => tPokemon);

    // act
    final result = await repository.getPokemonDetail(1);

    // assert
    expect(result.isSuccess, true);
    expect(result.data, equals(tPokemon.toEntity()));
    verify(mockRemoteDataSource.getPokemonById(1));
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('should search pokemons', () async {
    // arrange
    when(mockRemoteDataSource.searchPokemons('bulba'))
        .thenAnswer((_) async => tPokemons);

    // act
    final result = await repository.searchPokemon('bulba');

    // assert
    expect(result.isSuccess, true);
    expect(result.data, equals(tPokemons.map((p) => p.toEntity()).toList()));
    verify(mockRemoteDataSource.searchPokemons('bulba'));
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('should handle network errors', () async {
    // arrange
    when(mockRemoteDataSource.getPokemons(limit: 20, offset: 0))
        .thenThrow(Exception('Failed host lookup'));

    // act
    final result = await repository.getPokemonList(limit: 20, offset: 0);

    // assert
    expect(result.isSuccess, false);
    expect(result.error, isA<NetworkError>());
    verify(mockRemoteDataSource.getPokemons(limit: 20, offset: 0));
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('should handle unexpected errors', () async {
    // arrange
    when(mockRemoteDataSource.getPokemons(limit: 20, offset: 0))
        .thenThrow(Exception('Unexpected error'));

    // act
    final result = await repository.getPokemonList(limit: 20, offset: 0);

    // assert
    expect(result.isSuccess, false);
    expect(result.error, isA<PokemonUnexpectedError>());
    verify(mockRemoteDataSource.getPokemons(limit: 20, offset: 0));
    verifyNoMoreInteractions(mockRemoteDataSource);
  });
}
