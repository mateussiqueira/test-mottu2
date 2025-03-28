import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokeapi/features/pokemon_detail/presentation/widgets/pokemon_locations.dart';

void main() {
  group('PokemonLocations', () {
    testWidgets('should display locations correctly',
        (WidgetTester tester) async {
      final locations = ['pallet-town', 'viridian-city', 'pewter-city'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonLocations(locations: locations),
          ),
        ),
      );

      expect(find.text('Locations'), findsOneWidget);
      expect(find.text('pallet-town'), findsOneWidget);
      expect(find.text('viridian-city'), findsOneWidget);
      expect(find.text('pewter-city'), findsOneWidget);
    });

    testWidgets('should format location names correctly',
        (WidgetTester tester) async {
      final locations = ['pallet-town', 'viridian-city'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonLocations(locations: locations),
          ),
        ),
      );

      expect(find.text('Pallet Town'), findsOneWidget);
      expect(find.text('Viridian City'), findsOneWidget);
    });

    testWidgets('should handle empty locations list',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonLocations(locations: []),
          ),
        ),
      );

      expect(find.text('Locations'), findsOneWidget);
      expect(find.text('No locations available'), findsOneWidget);
    });

    testWidgets('should display locations in a list',
        (WidgetTester tester) async {
      final locations = ['pallet-town', 'viridian-city'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonLocations(locations: locations),
          ),
        ),
      );

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(2));
    });
  });
}
