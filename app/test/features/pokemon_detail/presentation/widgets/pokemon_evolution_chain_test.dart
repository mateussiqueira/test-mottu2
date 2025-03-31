import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/pokemon_detail/presentation/widgets/pokemon_evolution_chain.dart';

void main() {
  group('PokemonEvolutionChain', () {
    testWidgets('should display evolution chain correctly',
        (WidgetTester tester) async {
      final evolutionChain = ['bulbasaur', 'ivysaur', 'venusaur'];

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonEvolutionChain(
                evolutionChain: ['bulbasaur', 'ivysaur', 'venusaur']),
          ),
        ),
      );

      expect(find.text('Evolution Chain'), findsOneWidget);
      expect(find.text('bulbasaur'), findsOneWidget);
      expect(find.text('ivysaur'), findsOneWidget);
      expect(find.text('venusaur'), findsOneWidget);
    });

    testWidgets('should display evolution arrows between pokemon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonEvolutionChain(
                evolutionChain: ['bulbasaur', 'ivysaur', 'venusaur']),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_forward), findsNWidgets(2));
    });

    testWidgets('should handle empty evolution chain',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonEvolutionChain(evolutionChain: []),
          ),
        ),
      );

      expect(find.text('No evolution chain available'), findsOneWidget);
    });

    testWidgets('should handle single pokemon in evolution chain',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonEvolutionChain(evolutionChain: ['bulbasaur']),
          ),
        ),
      );

      expect(find.text('Evolution Chain'), findsOneWidget);
      expect(find.text('bulbasaur'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsNothing);
    });

    testWidgets('should apply correct text styles',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonEvolutionChain(evolutionChain: ['bulbasaur']),
          ),
        ),
      );

      final title = tester.widget<Text>(find.text('Evolution Chain'));
      expect(title.style?.fontSize, 18);
      expect(title.style?.fontWeight, FontWeight.bold);

      final pokemonName = tester.widget<Text>(find.text('bulbasaur'));
      expect(pokemonName.style?.fontSize, 16);
    });
  });
}
