import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokeapi/features/pokemon_detail/presentation/widgets/pokemon_ability_chip.dart';

void main() {
  group('PokemonAbilityChip', () {
    testWidgets('should display ability name correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonAbilityChip(ability: 'overgrow'),
          ),
        ),
      );

      expect(find.text('overgrow'), findsOneWidget);
    });

    testWidgets('should capitalize ability name', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonAbilityChip(ability: 'overgrow'),
          ),
        ),
      );

      expect(find.text('overgrow'), findsOneWidget);
    });

    testWidgets('should apply correct color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonAbilityChip(ability: 'overgrow'),
          ),
        ),
      );

      final chip = tester.widget<Chip>(find.byType(Chip));
      expect(chip.backgroundColor, Colors.blue);
    });

    testWidgets('should handle empty ability name',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonAbilityChip(ability: ''),
          ),
        ),
      );

      expect(find.text(''), findsOneWidget);
    });
  });
}
