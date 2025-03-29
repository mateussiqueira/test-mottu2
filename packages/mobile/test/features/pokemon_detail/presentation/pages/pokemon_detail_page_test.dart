import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokeapi/features/pokemon_detail/presentation/bloc/pokemon_detail_bloc.dart';
import 'package:pokeapi/features/pokemon_detail/presentation/bloc/pokemon_detail_event.dart';
import 'package:pokeapi/features/pokemon_detail/presentation/bloc/pokemon_detail_state.dart';
import 'package:pokeapi/features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import 'package:pokeapi/features/pokemon_list/domain/entities/pokemon.dart';

@GenerateMocks([PokemonDetailBloc])
void main() {
  late MockPokemonDetailBloc mockBloc;

  setUp(() {
    mockBloc = MockPokemonDetailBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<PokemonDetailBloc>.value(
        value: mockBloc,
        child: const PokemonDetailPage(pokemonId: '1'),
      ),
    );
  }

  testWidgets('should show loading indicator when state is loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(PokemonDetailLoading());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show pokemon details when state is loaded',
      (WidgetTester tester) async {
    final pokemon = Pokemon(
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
    );

    when(mockBloc.state).thenReturn(PokemonDetailLoaded(pokemon));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('bulbasaur'), findsOneWidget);
    expect(find.text('grass'), findsOneWidget);
    expect(find.text('poison'), findsOneWidget);
    expect(find.text('overgrow'), findsOneWidget);
    expect(find.text('chlorophyll'), findsOneWidget);
    expect(find.text('HP: 45'), findsOneWidget);
    expect(find.text('Attack: 49'), findsOneWidget);
    expect(find.text('Defense: 49'), findsOneWidget);
    expect(find.text('Height: 0.7m'), findsOneWidget);
    expect(find.text('Weight: 6.9kg'), findsOneWidget);
  });

  testWidgets('should show error message when state is error',
      (WidgetTester tester) async {
    when(mockBloc.state)
        .thenReturn(PokemonDetailError('Failed to load pokemon'));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Failed to load pokemon'), findsOneWidget);
  });

  testWidgets('should call LoadPokemonDetail when page is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(PokemonDetailLoading());

    await tester.pumpWidget(createWidgetUnderTest());

    verify(mockBloc.add(LoadPokemonDetail('1'))).called(1);
  });
}
