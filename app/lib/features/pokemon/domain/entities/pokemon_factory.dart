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
    required int baseExperience,
    required String imageUrl,
    required Map<String, int> stats,
  }) {
    return PokemonEntity(
      id: id,
      name: name,
      types: types,
      abilities: abilities,
      height: height,
      weight: weight,
      baseExperience: baseExperience,
      imageUrl: imageUrl,
      stats: stats,
    );
  }

  static IPokemonEntity fromJson(Map<String, dynamic> json) {
    final stats = <String, int>{};
    for (final stat in json['stats'] as List) {
      stats[stat['stat']['name'] as String] = stat['base_stat'] as int;
    }

    return create(
      id: json['id'],
      name: json['name'],
      types: (json['types'] as List)
          .map((t) => t['type']['name'] as String)
          .toList(),
      abilities: (json['abilities'] as List)
          .map((a) => a['ability']['name'] as String)
          .toList(),
      height: json['height'],
      weight: json['weight'],
      baseExperience: json['base_experience'] ?? 0,
      imageUrl: json['sprites']['front_default'] ?? '',
      stats: stats,
    );
  }
}
