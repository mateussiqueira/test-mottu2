// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokeapi/core/domain/entities/pokemon.dart';
import 'package:pokeapi/core/domain/repositories/pokemon_repository.dart';
import 'package:pokeapi/features/pokemon_list/presentation/bloc/pokemon_list_bloc.dart';
import 'package:pokeapi/features/pokemon_list/presentation/pages/pokemon_list_page.dart';
import 'package:pokeapi/features/pokemon_list/presentation/widgets/pokemon_skeleton_card.dart';

@GenerateMocks([PokemonRepository])
import 'widget_test.mocks.dart';

void main() {
  late MockPokemonRepository mockRepository;
  late PokemonListBloc bloc;

  setUp(() {
    mockRepository = MockPokemonRepository();
    bloc = PokemonListBloc(repository: mockRepository);
  });

  testWidgets('Pokemon list page shows loading state initially',
      (WidgetTester tester) async {
    // Arrange
    when(mockRepository.getPokemons(offset: 0, limit: 20))
        .thenAnswer((_) async => []);

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => bloc,
          child: const PokemonListPage(),
        ),
      ),
    );

    // Wait for the initial state
    await tester.pump();

    // Assert
    expect(find.byType(PokemonSkeletonCard), findsNWidgets(4));
  });

  testWidgets('Pokemon list page shows error state when repository fails',
      (WidgetTester tester) async {
    // Arrange
    when(mockRepository.getPokemons(offset: 0, limit: 20))
        .thenThrow(Exception('Failed to fetch pokemons'));

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => bloc,
          child: const PokemonListPage(),
        ),
      ),
    );

    // Wait for the initial state
    await tester.pump();

    // Wait for the error state
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));

    // Assert
    expect(find.text('Exception: Failed to fetch pokemons'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('Pokemon list page shows pokemons when loaded successfully',
      (WidgetTester tester) async {
    // Arrange
    final pokemons = [
      const Pokemon(
        id: 1,
        name: 'Bulbasaur',
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
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

    when(mockRepository.getPokemons(offset: 0, limit: 20))
        .thenAnswer((_) async => Future.delayed(
              const Duration(milliseconds: 100),
              () => pokemons,
            ));

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => bloc,
          child: const PokemonListPage(),
        ),
      ),
    );

    // Wait for the initial state
    await tester.pump();

    // Wait for the loaded state
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));

    // Assert
    expect(find.text('Bulbasaur'), findsOneWidget);
    expect(find.text('grass'), findsOneWidget);
  });
}
