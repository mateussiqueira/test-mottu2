import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokeapi/features/pokemon_list/domain/entities/pokemon.dart';
import 'package:pokeapi/features/pokemon_list/presentation/bloc/pokemon_list_bloc.dart';
import 'package:pokeapi/features/pokemon_list/presentation/bloc/pokemon_list_event.dart';
import 'package:pokeapi/features/pokemon_list/presentation/bloc/pokemon_list_state.dart';
import 'package:pokeapi/features/pokemon_list/presentation/pages/pokemon_list_page.dart';

@GenerateMocks([PokemonListBloc])
void main() {
  late MockPokemonListBloc mockBloc;

  setUp(() {
    mockBloc = MockPokemonListBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<PokemonListBloc>.value(
        value: mockBloc,
        child: const PokemonListPage(),
      ),
    );
  }

  testWidgets('should show loading indicator when state is loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(const PokemonListLoading());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show pokemon list when state is loaded',
      (WidgetTester tester) async {
    final pokemons = [
      Pokemon(
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

    when(mockBloc.state).thenReturn(PokemonListLoaded(pokemons));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('bulbasaur'), findsOneWidget);
  });

  testWidgets('should show error message when state is error',
      (WidgetTester tester) async {
    when(mockBloc.state)
        .thenReturn(const PokemonListError('Failed to load pokemons'));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Failed to load pokemons'), findsOneWidget);
  });

  testWidgets('should call LoadPokemons when page is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(const PokemonListLoading());

    await tester.pumpWidget(createWidgetUnderTest());

    verify(mockBloc.add(const LoadPokemons())).called(1);
  });

  testWidgets('should call SearchPokemons when search text is entered',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(const PokemonListLoading());

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(TextField), 'bulba');
    await tester.pump();

    verify(mockBloc.add(SearchPokemons('bulba'))).called(1);
  });
}
