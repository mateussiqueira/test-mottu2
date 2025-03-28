import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokeapi/features/pokemon_detail/presentation/widgets/pokemon_type_chip.dart';

void main() {
  group('PokemonTypeChip', () {
    testWidgets('should display type name correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonTypeChip(type: 'grass'),
          ),
        ),
      );

      expect(find.text('grass'), findsOneWidget);
    });

    testWidgets('should apply correct color for grass type',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonTypeChip(type: 'grass'),
          ),
        ),
      );

      final chip = tester.widget<Chip>(find.byType(Chip));
      expect(chip.backgroundColor, Colors.green);
    });

    testWidgets('should apply correct color for fire type',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonTypeChip(type: 'fire'),
          ),
        ),
      );

      final chip = tester.widget<Chip>(find.byType(Chip));
      expect(chip.backgroundColor, Colors.red);
    });

    testWidgets('should apply correct color for water type',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonTypeChip(type: 'water'),
          ),
        ),
      );

      final chip = tester.widget<Chip>(find.byType(Chip));
      expect(chip.backgroundColor, Colors.blue);
    });

    testWidgets('should apply default color for unknown type',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonTypeChip(type: 'unknown'),
          ),
        ),
      );

      final chip = tester.widget<Chip>(find.byType(Chip));
      expect(chip.backgroundColor, Colors.grey);
    });

    testWidgets('should capitalize type name', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonTypeChip(type: 'grass'),
          ),
        ),
      );

      expect(find.text('grass'), findsOneWidget);
    });
  });
}
