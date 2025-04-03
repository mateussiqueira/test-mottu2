import 'i_pokemon_entity.dart';
import 'pokemon_entity.dart';

class PokemonFactory {
  static IPokemonEntity create({
    required int id,
    required String name,
    required List<String> types,
    required List<String> abilities,
    required int height,
    required int weight,
    required String imageUrl,
    required Map<String, int> stats,
    required List<String> moves,
    required String description,
  }) {
    return PokemonEntity(
      id: id,
      name: name,
      types: types,
      abilities: abilities,
      height: height,
      weight: weight,
      imageUrl: imageUrl,
      stats: stats,
      moves: moves,
      description: description,
    ) as IPokemonEntity;
  }

  static IPokemonEntity fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'] as Map<String, dynamic>;
    final officialArtwork =
        sprites['other']?['official-artwork'] as Map<String, dynamic>;
    final imageUrl = officialArtwork['front_default'] as String? ?? '';

    final types = (json['types'] as List)
        .map((type) => (type['type']['name'] as String))
        .toList();

    final abilities = (json['abilities'] as List)
        .map((ability) => (ability['ability']['name'] as String))
        .toList();

    final stats = Map<String, int>.fromEntries(
      (json['stats'] as List).map(
        (stat) => MapEntry(
          stat['stat']['name'] as String,
          stat['base_stat'] as int,
        ),
      ),
    );

    final moves = (json['moves'] as List)
        .map((move) => (move['move']['name'] as String))
        .toList();

    return create(
      id: json['id'] as int,
      name: (json['name'] as String).replaceAll('-', ' '),
      types: types,
      abilities: abilities,
      height: json['height'] as int,
      weight: json['weight'] as int,
      imageUrl: imageUrl,
      stats: stats,
      moves: moves,
      description: '', // We need to fetch this separately
    );
  }
}
