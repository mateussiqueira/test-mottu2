import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_list/domain/repositories/pokemon_repository.dart';
import 'package:mobile/features/pokemon_list/presentation/bloc/pokemon_list_bloc.dart';
import 'package:mobile/features/pokemon_list/presentation/pages/pokemon_list_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([PokemonRepository, PokemonListBloc])
import 'pokemon_list_page_test.mocks.dart';

void main() {
  late MockPokemonListBloc mockBloc;
  late MockPokemonRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonRepository();
    mockBloc = MockPokemonListBloc();
    Get.testMode = true;
  });

  tearDown(() {
    Get.reset();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<PokemonListBloc>.value(
        value: mockBloc,
        child: PokemonListPage(repository: mockRepository),
      ),
    );
  }

  testWidgets('should show loading indicator when state is loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(PokemonListLoading());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show pokemon list when state is loaded',
      (WidgetTester tester) async {
    final pokemons = [
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

    when(mockBloc.state).thenReturn(PokemonListLoaded(pokemons));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('bulbasaur'), findsOneWidget);
  });

  testWidgets('should show error message when state is error',
      (WidgetTester tester) async {
    when(mockBloc.state)
        .thenReturn(PokemonListError('Failed to load pokemons'));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text('Failed to load pokemons'), findsOneWidget);
  });

  testWidgets('should call LoadPokemons when page is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(PokemonListLoading());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    verify(mockBloc.add(LoadPokemons())).called(1);
  });

  testWidgets('should call SearchPokemons when search text is entered',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(PokemonListLoading());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    await tester.enterText(find.byType(TextField), 'bulba');
    await tester.pump();

    verify(mockBloc.add(SearchPokemons('bulba'))).called(1);
  });
}
