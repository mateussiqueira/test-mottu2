import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';

void main() {
  group('Pokemon Entity', () {
    test('should create Pokemon from JSON', () {
      final json = {
        'id': 1,
        'name': 'bulbasaur',
        'imageUrl': 'https://example.com/bulbasaur.png',
        'types': ['grass', 'poison'],
        'abilities': ['overgrow', 'chlorophyll'],
        'height': 7,
        'weight': 69,
        'baseExperience': 64,
      };

      final pokemon = PokemonEntityImpl.fromJson(json);

      expect(pokemon.id, 1);
      expect(pokemon.name, 'bulbasaur');
      expect(pokemon.imageUrl, 'https://example.com/bulbasaur.png');
      expect(pokemon.types, ['grass', 'poison']);
      expect(pokemon.abilities, ['overgrow', 'chlorophyll']);
      expect(pokemon.height, 7);
      expect(pokemon.weight, 69);
      expect(pokemon.baseExperience, 64);
    });

    test('should convert Pokemon to JSON', () {
      final pokemon = PokemonEntityImpl(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
        types: ['grass', 'poison'],
        abilities: ['overgrow', 'chlorophyll'],
        height: 7,
        weight: 69,
        baseExperience: 64,
      );

      final json = pokemon.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'bulbasaur');
      expect(json['imageUrl'], 'https://example.com/bulbasaur.png');
      expect(json['types'], ['grass', 'poison']);
      expect(json['abilities'], ['overgrow', 'chlorophyll']);
      expect(json['height'], 7);
      expect(json['weight'], 69);
      expect(json['baseExperience'], 64);
    });

    test('should create copy with new values', () {
      final pokemon = PokemonEntityImpl(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
        types: ['grass', 'poison'],
        abilities: ['overgrow', 'chlorophyll'],
        height: 7,
        weight: 69,
        baseExperience: 64,
      );

      final copy = pokemon.copyWith(
        name: 'charmander',
        types: ['fire'],
        abilities: ['blaze'],
      );

      expect(copy.id, 1);
      expect(copy.name, 'charmander');
      expect(copy.imageUrl, 'https://example.com/bulbasaur.png');
      expect(copy.types, ['fire']);
      expect(copy.abilities, ['blaze']);
      expect(copy.height, 7);
      expect(copy.weight, 69);
      expect(copy.baseExperience, 64);
    });
  });
}
