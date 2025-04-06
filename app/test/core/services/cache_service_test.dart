import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon_list/core/services/cache_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late CacheService cacheService;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    cacheService = CacheService(preferences: mockPrefs);
  });

  group('savePokemons', () {
    test('deve salvar pokémons e timestamp no SharedPreferences', () async {
      // arrange
      final pokemons = [{'id': 1, 'name': 'bulbasaur'}];
      when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
      when(mockPrefs.setInt(any, any)).thenAnswer((_) async => true);
      
      // act
      await cacheService.savePokemons(pokemons);
      
      // assert
      verify(mockPrefs.setString('pokemons', jsonEncode(pokemons)));
      verify(mockPrefs.setInt('pokemons_timestamp', any));
    });
  });

  group('getPokemons', () {
    test('deve retornar pokémons quando o cache for válido', () async {
      // arrange
      final pokemons = [{'id': 1, 'name': 'bulbasaur'}];
      final now = DateTime.now();
      final timestamp = now.millisecondsSinceEpoch;
      
      when(mockPrefs.getInt('pokemons_timestamp')).thenReturn(timestamp);
      when(mockPrefs.getString('pokemons')).thenReturn(jsonEncode(pokemons));
      
      // act
      final result = await cacheService.getPokemons();
      
      // assert
      expect(result, pokemons);
      verify(mockPrefs.getInt('pokemons_timestamp'));
      verify(mockPrefs.getString('pokemons'));
    });

    test('deve retornar null quando o cache estiver expirado', () async {
      // arrange
      final expiredTimestamp = DateTime.now()
          .subtract(const Duration(hours: 2))
          .millisecondsSinceEpoch;
      
      when(mockPrefs.getInt('pokemons_timestamp')).thenReturn(expiredTimestamp);
      
      // act
      final result = await cacheService.getPokemons();
      
      // assert
      expect(result, null);
      verify(mockPrefs.getInt('pokemons_timestamp'));
      verifyNever(mockPrefs.getString('pokemons'));
    });

    test('deve retornar null quando não houver timestamp', () async {
      // arrange
      when(mockPrefs.getInt('pokemons_timestamp')).thenReturn(null);
      
      // act
      final result = await cacheService.getPokemons();
      
      // assert
      expect(result, null);
      verify(mockPrefs.getInt('pokemons_timestamp'));
      verifyNever(mockPrefs.getString('pokemons'));
    });
  });

  group('clearCache', () {
    test('deve remover todas as chaves relacionadas a pokémon', () async {
      // arrange
      final keys = {'pokemon_1', 'pokemons_timestamp', 'other_key'};
      when(mockPrefs.getKeys()).thenReturn(keys);
      when(mockPrefs.remove(any)).thenAnswer((_) async => true);
      
      // act
      await cacheService.clearCache();
      
      // assert
      verify(mockPrefs.getKeys());
      verify(mockPrefs.remove('pokemon_1'));
      verify(mockPrefs.remove('pokemons_timestamp'));
      verifyNever(mockPrefs.remove('other_key'));
    });
  });
}
