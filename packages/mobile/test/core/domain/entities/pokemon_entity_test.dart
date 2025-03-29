import 'package:flutter_test/flutter_test.dart';
import 'package:pokeapi/core/domain/entities/pokemon_entity.dart';

void main() {
  group('PokemonEntity', () {
    late PokemonEntity pokemon;

    setUp(() {
      pokemon = PokemonEntity(
        id: 25,
        name: 'Pikachu',
        types: ['Electric'],
        abilities: ['Static', 'Lightning Rod'],
        height: 0.4,
        weight: 6.0,
        baseExperience: 112,
        imageUrl: 'https://example.com/pikachu.png',
      );
    });

    test('should create PokemonEntity with correct values', () {
      expect(pokemon.id, 25);
      expect(pokemon.name, 'Pikachu');
      expect(pokemon.types, ['Electric']);
      expect(pokemon.abilities, ['Static', 'Lightning Rod']);
      expect(pokemon.height, 0.4);
      expect(pokemon.weight, 6.0);
      expect(pokemon.baseExperience, 112);
      expect(pokemon.imageUrl, 'https://example.com/pikachu.png');
    });

    test('should convert PokemonEntity to JSON', () {
      final json = pokemon.toJson();
      expect(json['id'], 25);
      expect(json['name'], 'Pikachu');
      expect(json['types'], ['Electric']);
      expect(json['abilities'], ['Static', 'Lightning Rod']);
      expect(json['height'], 0.4);
      expect(json['weight'], 6.0);
      expect(json['baseExperience'], 112);
      expect(json['imageUrl'], 'https://example.com/pikachu.png');
    });

    test('should create PokemonEntity from JSON', () {
      final json = {
        'id': 25,
        'name': 'Pikachu',
        'types': ['Electric'],
        'abilities': ['Static', 'Lightning Rod'],
        'height': 0.4,
        'weight': 6.0,
        'baseExperience': 112,
        'imageUrl': 'https://example.com/pikachu.png',
      };

      final entity = PokemonEntity.fromJson(json);
      expect(entity.id, 25);
      expect(entity.name, 'Pikachu');
      expect(entity.types, ['Electric']);
      expect(entity.abilities, ['Static', 'Lightning Rod']);
      expect(entity.height, 0.4);
      expect(entity.weight, 6.0);
      expect(entity.baseExperience, 112);
      expect(entity.imageUrl, 'https://example.com/pikachu.png');
    });

    test('should create copy with updated values', () {
      final copy = pokemon.copyWith(
        name: 'Raichu',
        types: ['Electric', 'Psychic'],
      );

      expect(copy.id, 25);
      expect(copy.name, 'Raichu');
      expect(copy.types, ['Electric', 'Psychic']);
      expect(copy.abilities, ['Static', 'Lightning Rod']);
      expect(copy.height, 0.4);
      expect(copy.weight, 6.0);
      expect(copy.baseExperience, 112);
      expect(copy.imageUrl, 'https://example.com/pikachu.png');
    });

    test('should be equal when all properties are the same', () {
      final other = PokemonEntity(
        id: 25,
        name: 'Pikachu',
        types: ['Electric'],
        abilities: ['Static', 'Lightning Rod'],
        height: 0.4,
        weight: 6.0,
        baseExperience: 112,
        imageUrl: 'https://example.com/pikachu.png',
      );

      expect(pokemon == other, true);
    });

    test('should not be equal when any property is different', () {
      final other = PokemonEntity(
        id: 25,
        name: 'Raichu',
        types: ['Electric'],
        abilities: ['Static', 'Lightning Rod'],
        height: 0.4,
        weight: 6.0,
        baseExperience: 112,
        imageUrl: 'https://example.com/pikachu.png',
      );

      expect(pokemon == other, false);
    });

    test('should have same hashCode when equal', () {
      final other = PokemonEntity(
        id: 25,
        name: 'Pikachu',
        types: ['Electric'],
        abilities: ['Static', 'Lightning Rod'],
        height: 0.4,
        weight: 6.0,
        baseExperience: 112,
        imageUrl: 'https://example.com/pikachu.png',
      );

      expect(pokemon.hashCode == other.hashCode, true);
    });

    test('should have different hashCode when not equal', () {
      final other = PokemonEntity(
        id: 25,
        name: 'Raichu',
        types: ['Electric'],
        abilities: ['Static', 'Lightning Rod'],
        height: 0.4,
        weight: 6.0,
        baseExperience: 112,
        imageUrl: 'https://example.com/pikachu.png',
      );

      expect(pokemon.hashCode == other.hashCode, false);
    });
  });
}
