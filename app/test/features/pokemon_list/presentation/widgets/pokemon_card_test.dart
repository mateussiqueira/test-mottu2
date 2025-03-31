import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_list/presentation/widgets/pokemon_card.dart';

void main() {
  group('PokemonCard', () {
    final pokemon = PokemonEntityImpl(
      id: 1,
      name: 'bulbasaur',
      imageUrl: 'https://example.com/bulbasaur.png',
      types: ['grass', 'poison'],
      abilities: ['overgrow', 'chlorophyll'],
      height: 7,
      weight: 69,
      baseExperience: 64,
    );

    testWidgets('should display pokemon information correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonCard(
              pokemon: PokemonEntityImpl(
                id: 1,
                name: 'bulbasaur',
                imageUrl: 'https://example.com/bulbasaur.png',
                types: ['grass', 'poison'],
                abilities: ['overgrow', 'chlorophyll'],
                height: 7,
                weight: 69,
                baseExperience: 64,
              ),
            ),
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
            body: PokemonCard(
              pokemon: PokemonEntityImpl(
                id: 1,
                name: 'bulbasaur',
                imageUrl: 'https://example.com/bulbasaur.png',
                types: ['grass', 'poison'],
                abilities: ['overgrow', 'chlorophyll'],
                height: 7,
                weight: 69,
                baseExperience: 64,
              ),
            ),
          ),
        ),
      );

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.image, isA<NetworkImage>());
      expect((image.image as NetworkImage).url, pokemon.imageUrl);
    });

    testWidgets('should handle image loading error',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonCard(
              pokemon: PokemonEntityImpl(
                id: 1,
                name: 'bulbasaur',
                imageUrl: 'https://example.com/invalid.png',
                types: ['grass', 'poison'],
                abilities: ['overgrow', 'chlorophyll'],
                height: 7,
                weight: 69,
                baseExperience: 64,
              ),
            ),
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
            body: PokemonCard(
              pokemon: PokemonEntityImpl(
                id: 1,
                name: 'bulbasaur',
                imageUrl: 'https://example.com/bulbasaur.png',
                types: ['grass', 'poison'],
                abilities: ['overgrow', 'chlorophyll'],
                height: 7,
                weight: 69,
                baseExperience: 64,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
