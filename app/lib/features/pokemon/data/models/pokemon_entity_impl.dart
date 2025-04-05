import '../../domain/entities/pokemon_entity.dart';

class PokemonEntityImpl extends PokemonEntity {
  PokemonEntityImpl({
    required super.id,
    required super.name,
    required super.types,
    required super.abilities,
    required super.height,
    required super.weight,
    required super.imageUrl,
    required super.stats,
    required super.moves,
    required super.description,
    required super.baseExperience,
    required super.evolutions,
  });

  factory PokemonEntityImpl.fromJson(Map<String, dynamic> json) {
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

    return PokemonEntityImpl(
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
      baseExperience: json['base_experience'] as int? ?? 0,
      evolutions: [], // We need to fetch this separately
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'types': types,
      'abilities': abilities,
      'height': height,
      'weight': weight,
      'imageUrl': imageUrl,
      'stats': stats,
      'moves': moves,
      'description': description,
      'base_experience': baseExperience,
      'evolutions': evolutions,
    };
  }
}
