import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mobile/core/presentation/routes/app_router.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';

void main() {
  final tPokemon = PokemonEntityImpl(
    id: 1,
    name: 'bulbasaur',
    imageUrl: 'https://example.com/bulbasaur.png',
    types: ['grass', 'poison'],
    abilities: ['overgrow', 'chlorophyll'],
    height: 7,
    weight: 69,
    baseExperience: 64,
  );

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: PokemonDetailPage(pokemon: tPokemon),
    );
  }

  testWidgets('should show pokemon details', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('BULBASAUR'), findsOneWidget);
    expect(find.text('grass'), findsOneWidget);
    expect(find.text('poison'), findsOneWidget);
    expect(find.text('overgrow'), findsOneWidget);
    expect(find.text('chlorophyll'), findsOneWidget);
    expect(find.text('Height: 7m'), findsOneWidget);
    expect(find.text('Weight: 69kg'), findsOneWidget);
    expect(find.text('Base Experience: 64'), findsOneWidget);
  });

  testWidgets('should navigate back when back button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(Get.currentRoute, AppRouter.pokemonList);
  });
}
