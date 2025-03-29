import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokeapi/features/pokemon_detail/presentation/widgets/pokemon_stats.dart';

void main() {
  group('PokemonStats', () {
    testWidgets('should display all pokemon stats correctly',
        (WidgetTester tester) async {
      final stats = {
        'hp': 45,
        'attack': 49,
        'defense': 49,
        'special-attack': 65,
        'special-defense': 65,
        'speed': 45,
      };

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonStats(stats: stats),
          ),
        ),
      );

      expect(find.text('HP'), findsOneWidget);
      expect(find.text('45'), findsOneWidget);
      expect(find.text('Attack'), findsOneWidget);
      expect(find.text('49'), findsOneWidget);
      expect(find.text('Defense'), findsOneWidget);
      expect(find.text('49'), findsOneWidget);
      expect(find.text('Special Attack'), findsOneWidget);
      expect(find.text('65'), findsOneWidget);
      expect(find.text('Special Defense'), findsOneWidget);
      expect(find.text('65'), findsOneWidget);
      expect(find.text('Speed'), findsOneWidget);
      expect(find.text('45'), findsOneWidget);
    });

    testWidgets('should display progress bars for each stat',
        (WidgetTester tester) async {
      final stats = {
        'hp': 45,
        'attack': 49,
        'defense': 49,
        'special-attack': 65,
        'special-defense': 65,
        'speed': 45,
      };

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonStats(stats: stats),
          ),
        ),
      );

      expect(find.byType(LinearProgressIndicator), findsNWidgets(6));
    });

    testWidgets('should handle empty stats map', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonStats(stats: {}),
          ),
        ),
      );

      expect(find.byType(LinearProgressIndicator), findsNothing);
      expect(find.text('No stats available'), findsOneWidget);
    });
  });
}
