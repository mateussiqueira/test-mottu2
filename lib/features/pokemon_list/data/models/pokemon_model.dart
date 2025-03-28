import '../../../../core/domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {
  const PokemonModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.types,
    required super.stats,
    required super.abilities,
    required super.moves,
    required super.evolutionChain,
    required super.locations,
    required super.height,
    required super.weight,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      types: List<String>.from(
        (json['types'] as List).map((type) => type['type']['name'] as String),
      ),
      stats: List<Map<String, dynamic>>.from(
        (json['stats'] as List).map(
          (stat) => {
            'name': stat['stat']['name'],
            'value': stat['base_stat'],
          },
        ),
      ),
      abilities: List<String>.from(
        (json['abilities'] as List)
            .map((ability) => ability['ability']['name'] as String),
      ),
      moves: List<String>.from(
        (json['moves'] as List).map((move) => move['move']['name'] as String),
      ),
      evolutionChain:
          List<Map<String, dynamic>>.from(json['evolution_chain'] ?? []),
      locations: List<Map<String, dynamic>>.from(json['locations'] ?? []),
      height: (json['height'] as num) / 10,
      weight: (json['weight'] as num) / 10,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'types': types,
      'stats': stats,
      'abilities': abilities,
      'moves': moves,
      'evolutionChain': evolutionChain,
      'locations': locations,
      'height': height,
      'weight': weight,
    };
  }
}
