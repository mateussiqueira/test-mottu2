import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokeapi/features/pokemon_list/presentation/widgets/pokemon_search_bar.dart';

void main() {
  group('PokemonSearchBar', () {
    testWidgets('should display search bar correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonSearchBar(
              onSearch: (query) {},
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.clear), findsNothing);
    });

    testWidgets('should show clear button when text is entered',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonSearchBar(
              onSearch: (query) {},
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'bulba');
      await tester.pump();

      expect(find.byIcon(Icons.clear), findsOneWidget);
    });

    testWidgets('should clear text when clear button is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonSearchBar(
              onSearch: (query) {},
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'bulba');
      await tester.pump();

      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();

      expect(find.text('bulba'), findsNothing);
      expect(find.byIcon(Icons.clear), findsNothing);
    });

    testWidgets('should call onSearch when text is entered',
        (WidgetTester tester) async {
      String? searchQuery;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonSearchBar(
              onSearch: (query) => searchQuery = query,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'bulba');
      await tester.pump();

      expect(searchQuery, 'bulba');
    });

    testWidgets('should handle empty search query',
        (WidgetTester tester) async {
      String? searchQuery;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonSearchBar(
              onSearch: (query) => searchQuery = query,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), '');
      await tester.pump();

      expect(searchQuery, '');
    });
  });
}
