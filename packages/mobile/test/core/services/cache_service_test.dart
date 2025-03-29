import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokeapi/core/services/cache_service.dart';
import 'package:pokeapi/test/mocks.mocks.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late CacheService cacheService;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    cacheService = CacheService(preferences: mockPrefs);
  });

  group('CacheService', () {
    test('should cache pokemons', () async {
      final pokemons = [
        {
          'id': '1',
          'name': 'bulbasaur',
          'imageUrl': 'https://example.com/bulbasaur.png',
          'types': ['grass', 'poison'],
          'abilities': ['overgrow', 'chlorophyll'],
          'stats': {'hp': 45, 'attack': 49, 'defense': 49},
          'height': 0.7,
          'weight': 6.9,
          'evolutionChain': ['bulbasaur', 'ivysaur', 'venusaur'],
          'locations': ['pallet-town', 'viridian-city'],
        },
      ];

      when(mockPrefs.setString('pokemons', any)).thenAnswer((_) async => true);
      when(mockPrefs.setInt('pokemons_timestamp', any))
          .thenAnswer((_) async => true);

      await cacheService.savePokemons(pokemons);

      verify(mockPrefs.setString('pokemons', any)).called(1);
      verify(mockPrefs.setInt('pokemons_timestamp', any)).called(1);
    });

    test('should get cached pokemons', () async {
      final pokemons = [
        {
          'id': '1',
          'name': 'bulbasaur',
          'imageUrl': 'https://example.com/bulbasaur.png',
          'types': ['grass', 'poison'],
          'abilities': ['overgrow', 'chlorophyll'],
          'stats': {'hp': 45, 'attack': 49, 'defense': 49},
          'height': 0.7,
          'weight': 6.9,
          'evolutionChain': ['bulbasaur', 'ivysaur', 'venusaur'],
          'locations': ['pallet-town', 'viridian-city'],
        },
      ];

      when(mockPrefs.getString('pokemons')).thenReturn(pokemons.toString());
      when(mockPrefs.getInt('pokemons_timestamp'))
          .thenReturn(DateTime.now().millisecondsSinceEpoch);

      final cachedPokemons = await cacheService.getPokemons();

      expect(cachedPokemons, isNotNull);
      expect(cachedPokemons!.length, 1);
      expect(cachedPokemons.first['name'], 'bulbasaur');
    });

    test('should return null when cache is expired', () async {
      when(mockPrefs.getString('pokemons')).thenReturn('[]');
      when(mockPrefs.getInt('pokemons_timestamp')).thenReturn(
        DateTime.now()
            .subtract(const Duration(hours: 2))
            .millisecondsSinceEpoch,
      );

      final cachedPokemons = await cacheService.getPokemons();

      expect(cachedPokemons, isNull);
    });

    test('should clear cache', () async {
      when(mockPrefs.remove('pokemons')).thenAnswer((_) async => true);
      when(mockPrefs.remove('pokemons_timestamp'))
          .thenAnswer((_) async => true);

      await cacheService.clearPokemons();

      verify(mockPrefs.remove('pokemons')).called(1);
      verify(mockPrefs.remove('pokemons_timestamp')).called(1);
    });
  });
}
