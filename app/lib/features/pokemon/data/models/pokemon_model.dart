import '../../domain/entities/i_pokemon_entity.dart';

/// Model class for Pokemon data from the API
class PokemonModel implements IPokemonEntity {
  @override
  final int id;
  @override
  final String name;
  @override
  final String imageUrl;
  @override
  final List<String> types;
  @override
  final List<String> abilities;
  @override
  final int height;
  @override
  final int weight;
  @override
  final Map<String, int> stats;
  @override
  final int baseExperience;
  @override
  final List<String> moves;
  @override
  final List<String> evolutions;
  @override
  final String description;

  PokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.abilities,
    required this.height,
    required this.weight,
    required this.stats,
    required this.baseExperience,
    required this.moves,
    required this.evolutions,
    required this.description,
  });

  /// Creates a PokemonModel from JSON data
  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      abilities: (json['abilities'] as List)
          .map((ability) => ability['ability']['name'] as String)
          .toList(),
      height: json['height'],
      weight: json['weight'],
      baseExperience: json['base_experience'] ?? 0,
      moves: (json['moves'] as List)
          .map((move) => move['move']['name'] as String)
          .toList(),
      evolutions: (json['evolutions'] as List?)?.cast<String>() ?? [],
      description: json['description'] ?? '',
      stats: Map.fromEntries(
        (json['stats'] as List).map(
          (stat) => MapEntry(
            stat['stat']['name'] as String,
            stat['base_stat'] as int,
          ),
        ),
      ),
    );
  }

  /// Converts the PokemonModel to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'types': types,
      'abilities': abilities,
      'height': height,
      'weight': weight,
      'baseExperience': baseExperience,
      'stats': stats,
      'moves': moves,
      'evolutions': evolutions,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'PokemonModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PokemonModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => Object.hash(id, name);
}
