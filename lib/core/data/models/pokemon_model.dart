import '../../domain/entities/pokemon.dart';

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
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      stats: (json['stats'] as List)
          .map((stat) => {
                'name': stat['stat']['name'],
                'value': stat['base_stat'],
              })
          .toList(),
      abilities: (json['abilities'] as List)
          .map((ability) => ability['ability']['name'] as String)
          .toList(),
      moves: (json['moves'] as List)
          .map((move) => move['move']['name'] as String)
          .toList(),
      evolutionChain: const [], // Será preenchido em uma chamada separada
      locations: const [], // Será preenchido em uma chamada separada
      height: json['height'] / 10,
      weight: json['weight'] / 10,
    );
  }
}
