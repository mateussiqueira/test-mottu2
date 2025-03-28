import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokeapi/features/pokemon_detail/presentation/widgets/pokemon_evolution_chain.dart';

void main() {
  group('PokemonEvolutionChain', () {
    testWidgets('should display evolution chain correctly',
        (WidgetTester tester) async {
      final evolutionChain = ['bulbasaur', 'ivysaur', 'venusaur'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonEvolutionChain(evolutionChain: evolutionChain),
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
      final evolutionChain = ['bulbasaur', 'ivysaur', 'venusaur'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonEvolutionChain(evolutionChain: evolutionChain),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_forward), findsNWidgets(2));
    });

    testWidgets('should handle empty evolution chain',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonEvolutionChain(evolutionChain: []),
          ),
        ),
      );

      expect(find.text('Evolution Chain'), findsOneWidget);
      expect(find.text('No evolution chain available'), findsOneWidget);
    });

    testWidgets('should handle single pokemon in evolution chain',
        (WidgetTester tester) async {
      final evolutionChain = ['bulbasaur'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonEvolutionChain(evolutionChain: evolutionChain),
          ),
        ),
      );

      expect(find.text('Evolution Chain'), findsOneWidget);
      expect(find.text('bulbasaur'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsNothing);
    });
  });
}
