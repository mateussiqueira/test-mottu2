import 'package:flutter_test/flutter_test.dart';
import 'package:pokeapi/features/pokemon_list/domain/entities/pokemon.dart';

void main() {
  group('Pokemon Entity', () {
    test('should create Pokemon from JSON', () {
      final json = {
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
      };

      final pokemon = Pokemon.fromJson(json);

      expect(pokemon.id, '1');
      expect(pokemon.name, 'bulbasaur');
      expect(pokemon.imageUrl, 'https://example.com/bulbasaur.png');
      expect(pokemon.types, ['grass', 'poison']);
      expect(pokemon.abilities, ['overgrow', 'chlorophyll']);
      expect(pokemon.stats, {'hp': 45, 'attack': 49, 'defense': 49});
      expect(pokemon.height, 0.7);
      expect(pokemon.weight, 6.9);
      expect(pokemon.evolutionChain, ['bulbasaur', 'ivysaur', 'venusaur']);
      expect(pokemon.locations, ['pallet-town', 'viridian-city']);
    });

    test('should convert Pokemon to JSON', () {
      final pokemon = Pokemon(
        id: '1',
        name: 'bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
        types: ['grass', 'poison'],
        abilities: ['overgrow', 'chlorophyll'],
        stats: {'hp': 45, 'attack': 49, 'defense': 49},
        height: 0.7,
        weight: 6.9,
        evolutionChain: ['bulbasaur', 'ivysaur', 'venusaur'],
        locations: ['pallet-town', 'viridian-city'],
      );

      final json = pokemon.toJson();

      expect(json['id'], '1');
      expect(json['name'], 'bulbasaur');
      expect(json['imageUrl'], 'https://example.com/bulbasaur.png');
      expect(json['types'], ['grass', 'poison']);
      expect(json['abilities'], ['overgrow', 'chlorophyll']);
      expect(json['stats'], {'hp': 45, 'attack': 49, 'defense': 49});
      expect(json['height'], 0.7);
      expect(json['weight'], 6.9);
      expect(json['evolutionChain'], ['bulbasaur', 'ivysaur', 'venusaur']);
      expect(json['locations'], ['pallet-town', 'viridian-city']);
    });
  });
}
