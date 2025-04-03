import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../core/domain/errors/i_logger.dart';
import '../../../../core/domain/errors/i_performance_monitor.dart';
import '../../../../core/domain/errors/result.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';
import '../../../pokemon/domain/usecases/i_get_pokemon_list.dart';
import '../../../pokemon/domain/usecases/i_search_pokemon.dart';
import 'pokemon_list_controller.dart';

class MockGetPokemonList extends Mock implements IGetPokemonList {}

class MockSearchPokemon extends Mock implements ISearchPokemon {}

class MockPokemonRepository extends Mock implements IPokemonRepository {}

class MockLogger extends Mock implements ILogger {}

class MockPerformanceMonitor extends Mock implements IPerformanceMonitor {}

void main() {
  late PokemonListController controller;
  late MockGetPokemonList mockGetPokemonList;
  late MockSearchPokemon mockSearchPokemon;
  late MockPokemonRepository mockRepository;
  late MockLogger mockLogger;
  late MockPerformanceMonitor mockPerformanceMonitor;

  setUp(() {
    mockGetPokemonList = MockGetPokemonList();
    mockSearchPokemon = MockSearchPokemon();
    mockRepository = MockPokemonRepository();
    mockLogger = MockLogger();
    mockPerformanceMonitor = MockPerformanceMonitor();

    controller = PokemonListController(
      getPokemonList: mockGetPokemonList,
      searchPokemon: mockSearchPokemon,
      repository: mockRepository,
      logger: mockLogger,
      performanceMonitor: mockPerformanceMonitor,
    );
  });

  group('PokemonListController', () {
    test('initial state is correct', () {
      expect(controller.pokemons, isEmpty);
      expect(controller.isLoading, isFalse);
      expect(controller.hasError, isFalse);
      expect(controller.error, isNull);
      expect(controller.searchQuery, isEmpty);
      expect(controller.filterType, isEmpty);
      expect(controller.filterAbility, isEmpty);
    });

    test('fetchPokemonList success', () async {
      final pokemon = PokemonEntity(
        id: 1,
        name: 'bulbasaur',
        types: ['grass'],
        abilities: ['overgrow'],
        height: 7,
        weight: 69,
        imageUrl: 'https://example.com/bulbasaur.png',
        stats: {},
        moves: [],
        description: '',
      );

      when(() => mockPerformanceMonitor.measure(
            any(),
            any(),
          )).thenAnswer((_) async => Result.success([pokemon]));

      await controller.fetchPokemonList();

      expect(controller.pokemons, hasLength(1));
      expect(controller.pokemons.first, equals(pokemon));
      expect(controller.hasError, isFalse);
      expect(controller.error, isNull);
    });

    test('fetchPokemonList failure', () async {
      when(() => mockPerformanceMonitor.measure(
            any(),
            any(),
          )).thenAnswer((_) async => Result.failure(Exception('API Error')));

      await controller.fetchPokemonList();

      expect(controller.pokemons, isEmpty);
      expect(controller.hasError, isTrue);
      expect(controller.error, equals('API Error'));
    });

    test('search success', () async {
      final pokemon = PokemonEntity(
        id: 25,
        name: 'pikachu',
        types: ['electric'],
        abilities: ['static'],
        height: 4,
        weight: 60,
        imageUrl: 'https://example.com/pikachu.png',
        stats: {},
        moves: [],
        description: '',
      );

      when(() => mockPerformanceMonitor.measure(
            any(),
            any(),
          )).thenAnswer((_) async => Result.success([pokemon]));

      await controller.search('pikachu');

      expect(controller.searchResults, hasLength(1));
      expect(controller.searchResults.first, equals(pokemon));
      expect(controller.hasError, isFalse);
      expect(controller.error, isNull);
    });

    test('search failure', () async {
      when(() => mockPerformanceMonitor.measure(
            any(),
            any(),
          )).thenAnswer((_) async => Result.failure(Exception('API Error')));

      await controller.search('pikachu');

      expect(controller.searchResults, isEmpty);
      expect(controller.hasError, isTrue);
      expect(controller.error, equals('API Error'));
    });

    test('filterByType success', () async {
      final pokemon = PokemonEntity(
        id: 4,
        name: 'charmander',
        types: ['fire'],
        abilities: ['blaze'],
        height: 6,
        weight: 85,
        imageUrl: 'https://example.com/charmander.png',
        stats: {},
        moves: [],
        description: '',
      );

      when(() => mockPerformanceMonitor.measure(
            any(),
            any(),
          )).thenAnswer((_) async => Result.success([pokemon]));

      await controller.filterByType('fire');

      expect(controller.pokemons, hasLength(1));
      expect(controller.pokemons.first, equals(pokemon));
      expect(controller.hasError, isFalse);
      expect(controller.error, isNull);
    });

    test('filterByType failure', () async {
      when(() => mockPerformanceMonitor.measure(
            any(),
            any(),
          )).thenAnswer((_) async => Result.failure(Exception('API Error')));

      await controller.filterByType('fire');

      expect(controller.pokemons, isEmpty);
      expect(controller.hasError, isTrue);
      expect(controller.error, equals('API Error'));
    });

    test('filterByAbility success', () async {
      final pokemon = PokemonEntity(
        id: 4,
        name: 'charmander',
        types: ['fire'],
        abilities: ['blaze'],
        height: 6,
        weight: 85,
        imageUrl: 'https://example.com/charmander.png',
        stats: {},
        moves: [],
        description: '',
      );

      when(() => mockPerformanceMonitor.measure(
            any(),
            any(),
          )).thenAnswer((_) async => Result.success([pokemon]));

      await controller.filterByAbility('blaze');

      expect(controller.pokemons, hasLength(1));
      expect(controller.pokemons.first, equals(pokemon));
      expect(controller.hasError, isFalse);
      expect(controller.error, isNull);
    });

    test('filterByAbility failure', () async {
      when(() => mockPerformanceMonitor.measure(
            any(),
            any(),
          )).thenAnswer((_) async => Result.failure(Exception('API Error')));

      await controller.filterByAbility('blaze');

      expect(controller.pokemons, isEmpty);
      expect(controller.hasError, isTrue);
      expect(controller.error, equals('API Error'));
    });

    test('clearFilters resets state', () async {
      controller.state.filterType.value = 'fire';
      controller.state.filterAbility.value = 'blaze';

      controller.clearFilters();

      expect(controller.filterType, isEmpty);
      expect(controller.filterAbility, isEmpty);
    });

    test('clearSearch resets state', () async {
      controller.state.searchQuery.value = 'pikachu';

      controller.clearSearch();

      expect(controller.searchQuery, isEmpty);
    });
  });
}
