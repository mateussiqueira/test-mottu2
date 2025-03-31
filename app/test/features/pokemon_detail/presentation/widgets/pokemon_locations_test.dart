import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/pokemon_detail/presentation/widgets/pokemon_locations.dart';

void main() {
  group('PokemonLocations', () {
    testWidgets('should display locations correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonLocations(
              locations: ['pallet-town', 'viridian-city', 'pewter-city'],
            ),
          ),
        ),
      );

      expect(find.text('Locations'), findsOneWidget);
      expect(find.text('Pallet Town'), findsOneWidget);
      expect(find.text('Viridian City'), findsOneWidget);
      expect(find.text('Pewter City'), findsOneWidget);
    });

    testWidgets('should format location names correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonLocations(
              locations: ['pallet-town', 'viridian-city'],
            ),
          ),
        ),
      );

      expect(find.text('Pallet Town'), findsOneWidget);
      expect(find.text('Viridian City'), findsOneWidget);
    });

    testWidgets('should handle empty locations list',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonLocations(locations: []),
          ),
        ),
      );

      expect(find.text('No locations available'), findsOneWidget);
    });

    testWidgets('should display locations in a list',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonLocations(
              locations: ['pallet-town', 'viridian-city'],
            ),
          ),
        ),
      );

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(2));
      expect(find.byIcon(Icons.location_on), findsNWidgets(2));
    });

    testWidgets('should apply correct text styles',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonLocations(
              locations: ['pallet-town'],
            ),
          ),
        ),
      );

      final title = tester.widget<Text>(find.text('Locations'));
      expect(title.style?.fontSize, 18);
      expect(title.style?.fontWeight, FontWeight.bold);

      final locationName = tester.widget<Text>(find.text('Pallet Town'));
      expect(locationName.style?.fontSize, 16);
    });
  });
}
