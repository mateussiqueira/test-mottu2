import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/pokemon_detail/presentation/widgets/pokemon_ability_chip.dart';

void main() {
  group('PokemonAbilityChip', () {
    testWidgets('should display ability name correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonAbilityChip(ability: 'overgrow'),
          ),
        ),
      );

      expect(find.text('overgrow'), findsOneWidget);
    });

    testWidgets('should apply correct style', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonAbilityChip(ability: 'overgrow'),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('overgrow'));
      expect(text.style?.color, Colors.white);
      expect(text.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('should apply correct color', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonAbilityChip(ability: 'overgrow'),
          ),
        ),
      );

      final chip = tester.widget<Chip>(find.byType(Chip));
      expect(chip.backgroundColor, Colors.blue);
    });

    testWidgets('should apply correct padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonAbilityChip(ability: 'overgrow'),
          ),
        ),
      );

      final chip = tester.widget<Chip>(find.byType(Chip));
      expect(chip.padding, const EdgeInsets.symmetric(horizontal: 8));
    });

    testWidgets('should handle empty ability name',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonAbilityChip(ability: ''),
          ),
        ),
      );

      expect(find.text(''), findsOneWidget);
    });
  });
}
