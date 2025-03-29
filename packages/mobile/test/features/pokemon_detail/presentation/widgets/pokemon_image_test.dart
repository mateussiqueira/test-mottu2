import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokeapi/features/pokemon_detail/presentation/widgets/pokemon_image.dart';

void main() {
  group('PokemonImage', () {
    testWidgets('should display pokemon image correctly',
        (WidgetTester tester) async {
      const imageUrl = 'https://example.com/bulbasaur.png';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonImage(imageUrl: imageUrl),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      final image = tester.widget<Image>(find.byType(Image));
      expect(image.image, isA<NetworkImage>());
      expect((image.image as NetworkImage).url, imageUrl);
    });

    testWidgets('should handle image loading error',
        (WidgetTester tester) async {
      const imageUrl = 'https://example.com/invalid.png';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonImage(imageUrl: imageUrl),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('should show loading indicator while image is loading',
        (WidgetTester tester) async {
      const imageUrl = 'https://example.com/bulbasaur.png';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonImage(imageUrl: imageUrl),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should handle empty image URL', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonImage(imageUrl: ''),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });
  });
}
