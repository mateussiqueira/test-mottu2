import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokeapi/features/pokemon_list/domain/entities/pokemon.dart';
import 'package:pokeapi/features/pokemon_list/presentation/widgets/pokemon_card.dart';

void main() {
  group('PokemonCard', () {
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

    testWidgets('should display pokemon information correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonCard(pokemon: pokemon),
          ),
        ),
      );

      expect(find.text('bulbasaur'), findsOneWidget);
      expect(find.text('grass'), findsOneWidget);
      expect(find.text('poison'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should handle tap on card', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonCard(
              pokemon: pokemon,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Card));
      await tester.pump();

      expect(tapped, true);
    });

    testWidgets('should display pokemon image correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonCard(pokemon: pokemon),
          ),
        ),
      );

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.image, isA<NetworkImage>());
      expect((image.image as NetworkImage).url, pokemon.imageUrl);
    });

    testWidgets('should handle image loading error',
        (WidgetTester tester) async {
      final invalidPokemon = Pokemon(
        id: '1',
        name: 'bulbasaur',
        imageUrl: 'https://example.com/invalid.png',
        types: ['grass', 'poison'],
        abilities: ['overgrow', 'chlorophyll'],
        stats: {'hp': 45, 'attack': 49, 'defense': 49},
        height: 0.7,
        weight: 6.9,
        evolutionChain: ['bulbasaur', 'ivysaur', 'venusaur'],
        locations: ['pallet-town', 'viridian-city'],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonCard(pokemon: invalidPokemon),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('should show loading indicator while image is loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonCard(pokemon: pokemon),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
