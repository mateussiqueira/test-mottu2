
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/domain/errors/pokemon_error.dart';
import 'package:mobile/core/domain/result.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_list/domain/repositories/pokemon_repository.dart';
import 'package:mobile/features/pokemon_list/presentation/bloc/pokemon_list_bloc.dart';
import 'package:mobile/features/pokemon_list/presentation/pages/pokemon_list_page.dart';
import 'package:mobile/features/pokemon_list/presentation/widgets/pokemon_skeleton_card.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
    when(mockRepository.getPokemonList(offset: 0, limit: 20))
        .thenAnswer((_) async => Result.success([]));

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => bloc,
          child: PokemonListPage(repository: mockRepository),
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
    when(mockRepository.getPokemonList(offset: 0, limit: 20))
        .thenAnswer((_) async => Result.failure(PokemonNetworkError()));

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => bloc,
          child: PokemonListPage(repository: mockRepository),
        ),
      ),
    );

    // Wait for the initial state
    await tester.pump();

    // Wait for the error state
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));

    // Assert
    expect(find.text('Network error occurred'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('Pokemon list page shows pokemons when loaded successfully',
      (WidgetTester tester) async {
    // Arrange
    final pokemons = [
      PokemonEntityImpl(
        id: 1,
        name: 'Bulbasaur',
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
        types: ['grass', 'poison'],
        abilities: ['overgrow'],
        height: 7,
        weight: 69,
        baseExperience: 64,
      ),
    ];

    when(mockRepository.getPokemonList(offset: 0, limit: 20))
        .thenAnswer((_) async => Result.success(pokemons));

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => bloc,
          child: PokemonListPage(repository: mockRepository),
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
