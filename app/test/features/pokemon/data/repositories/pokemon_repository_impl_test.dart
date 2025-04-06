import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon_list/features/pokemon/data/datasources/i_pokemon_remote_datasource.dart';
import 'package:pokemon_list/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon_list/features/pokemon/domain/entities/pokemon_entity_impl.dart';
import 'package:pokemon_list/features/pokemon/domain/errors/failures.dart';

@GenerateMocks([IPokemonRemoteDataSource])
void main() {
  late PokemonRepositoryImpl repository;
  late MockIPokemonRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockIPokemonRemoteDataSource();
    repository = PokemonRepositoryImpl(mockRemoteDataSource);
  });

  group('getPokemonList', () {
    final tPokemonList = [
      PokemonEntityImpl(
        id: 1,
        name: 'bulbasaur',
        height: 7,
        weight: 69,
        baseExperience: 64,
        types: ['grass', 'poison'],
        abilities: ['overgrow', 'chlorophyll'],
        imageUrl: 'https://example.com/image.png',
        stats: {'hp': 45, 'attack': 49},
        moves: [],
        evolutions: [],
        description: '',
        isDefault: true,
        order: 1,
        forms: [],
        gameIndices: [],
        heldItems: [],
        locationAreaEncounters: '',
        species: 'bulbasaur',
        sprites: {},
      )
    ];

    test('deve retornar lista de pokemon quando a chamada for bem-sucedida', () async {
      // arrange
      when(mockRemoteDataSource.getPokemonList(offset: 0, limit: 20))
          .thenAnswer((_) async => tPokemonList);

      // act
      final result = await repository.getPokemonList(offset: 0, limit: 20);

      // assert
      expect(result, Right(tPokemonList));
      verify(mockRemoteDataSource.getPokemonList(offset: 0, limit: 20));
    });

    test('deve retornar PokemonApiFailure quando a chamada for malsucedida', () async {
      // arrange
      when(mockRemoteDataSource.getPokemonList(offset: 0, limit: 20))
          .thenThrow(Exception('Falha na API'));

      // act
      final result = await repository.getPokemonList(offset: 0, limit: 20);

      // assert
      expect(result.isLeft(), true);
      verify(mockRemoteDataSource.getPokemonList(offset: 0, limit: 20));
    });
  });

  group('getPokemonByName', () {
    final tPokemon = PokemonEntityImpl(
      id: 1,
      name: 'bulbasaur',
      height: 7,
      weight: 69,
      baseExperience: 64,
      types: ['grass', 'poison'],
      abilities: ['overgrow', 'chlorophyll'],
      imageUrl: 'https://example.com/image.png',
      stats: {'hp': 45, 'attack': 49},
      moves: [],
      evolutions: [],
      description: '',
      isDefault: true,
      order: 1,
      forms: [],
      gameIndices: [],
      heldItems: [],
      locationAreaEncounters: '',
      species: 'bulbasaur',
      sprites: {},
    );

    test('deve retornar pokemon quando a chamada for bem-sucedida', () async {
      // arrange
      when(mockRemoteDataSource.getPokemonByName('bulbasaur'))
          .thenAnswer((_) async => tPokemon);

      // act
      final result = await repository.getPokemonByName(name: 'bulbasaur');

      // assert
      expect(result, Right(tPokemon));
      verify(mockRemoteDataSource.getPokemonByName('bulbasaur'));
    });

    test('deve retornar PokemonApiFailure quando a chamada for malsucedida', () async {
      // arrange
      when(mockRemoteDataSource.getPokemonByName('bulbasaur'))
          .thenThrow(Exception('Falha na API'));

      // act
      final result = await repository.getPokemonByName(name: 'bulbasaur');

      // assert
      expect(result.isLeft(), true);
      verify(mockRemoteDataSource.getPokemonByName('bulbasaur'));
    });
  });
}
