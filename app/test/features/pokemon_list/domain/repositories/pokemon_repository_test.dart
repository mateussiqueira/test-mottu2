import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/domain/errors/pokemon_error.dart';
import 'package:mobile/features/pokemon_list/data/datasources/pokemon_remote_data_source.dart';
import 'package:mobile/features/pokemon_list/data/models/pokemon_model.dart';
import 'package:mobile/features/pokemon_list/data/repositories/pokemon_repository_impl.dart';
import 'package:mobile/features/pokemon_list/domain/repositories/pokemon_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([PokemonRemoteDataSource])
import 'pokemon_repository_test.mocks.dart';

void main() {
  late PokemonRepository repository;
  late MockPokemonRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockPokemonRemoteDataSource();
    repository = PokemonRepositoryImpl(remoteDataSource: mockDataSource);
  });

  group('PokemonRepository', () {
    test('should get pokemons', () async {
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

      when(mockDataSource.getPokemons(limit: 20, offset: 0))
          .thenAnswer((_) async => tPokemons);

      final result = await repository.getPokemonList(limit: 20, offset: 0);

      expect(result.isSuccess, true);
      expect(result.data, equals(tPokemons.map((p) => p.toEntity()).toList()));
      verify(mockDataSource.getPokemons(limit: 20, offset: 0)).called(1);
    });

    test('should get pokemon by id', () async {
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

      when(mockDataSource.getPokemonById(1)).thenAnswer((_) async => tPokemon);

      final result = await repository.getPokemonDetail(1);

      expect(result.isSuccess, true);
      expect(result.data, equals(tPokemon.toEntity()));
      verify(mockDataSource.getPokemonById(1)).called(1);
    });

    test('should search pokemons', () async {
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

      when(mockDataSource.searchPokemons('bulba'))
          .thenAnswer((_) async => tPokemons);

      final result = await repository.searchPokemon('bulba');

      expect(result.isSuccess, true);
      expect(result.data, equals(tPokemons.map((p) => p.toEntity()).toList()));
      verify(mockDataSource.searchPokemons('bulba')).called(1);
    });

    test('should handle network errors', () async {
      when(mockDataSource.getPokemons(limit: 20, offset: 0))
          .thenThrow(Exception('Failed host lookup'));

      final result = await repository.getPokemonList(limit: 20, offset: 0);

      expect(result.isSuccess, false);
      expect(result.error, isA<NetworkError>());
      verify(mockDataSource.getPokemons(limit: 20, offset: 0)).called(1);
    });

    test('should handle unexpected errors', () async {
      when(mockDataSource.getPokemons(limit: 20, offset: 0))
          .thenThrow(Exception('Unexpected error'));

      final result = await repository.getPokemonList(limit: 20, offset: 0);

      expect(result.isSuccess, false);
      expect(result.error, isA<PokemonUnexpectedError>());
      verify(mockDataSource.getPokemons(limit: 20, offset: 0)).called(1);
    });
  });
}
