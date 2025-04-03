import '../../domain/entities/pokemon_entity.dart';

/// Model class for Pokemon data from the API
class PokemonModel extends PokemonEntity {
  PokemonModel({
    required int id,
    required String name,
    required int height,
    required int weight,
    required List<String> types,
    required List<String> abilities,
    required Map<String, int> stats,
    required String imageUrl,
    required List<String> moves,
    required String description,
  }) : super(
          id: id,
          name: name,
          height: height,
          weight: weight,
          types: types,
          abilities: abilities,
          stats: stats,
          imageUrl: imageUrl,
          moves: moves,
          description: description,
        );

  /// Creates a PokemonModel from JSON data
  factory PokemonModel.fromJson(Map<String, dynamic> json) {
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

    return PokemonModel(
      id: json['id'] as int,
      name: (json['name'] as String).replaceAll('-', ' '),
      height: json['height'] as int,
      weight: json['weight'] as int,
      types: types,
      abilities: abilities,
      stats: stats,
      imageUrl: imageUrl,
      moves: moves,
      description: '',
    );
  }

  /// Converts the PokemonModel to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'weight': weight,
      'types': types
          .map((type) => {
                'type': {'name': type}
              })
          .toList(),
      'abilities': abilities
          .map((ability) => {
                'ability': {'name': ability}
              })
          .toList(),
      'stats': stats.entries
          .map((stat) => {
                'stat': {'name': stat.key},
                'base_stat': stat.value,
              })
          .toList(),
      'sprites': {
        'other': {
          'official-artwork': {'front_default': imageUrl}
        }
      },
      'moves': moves
          .map((move) => {
                'move': {'name': move}
              })
          .toList(),
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
