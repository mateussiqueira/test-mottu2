import '../../../features/pokemon_list/domain/entities/pokemon.dart';

class PokemonModel {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<Stat> stats;
  final List<Type> types;
  final Sprites sprites;

  PokemonModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.stats,
    required this.types,
    required this.sprites,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) => PokemonModel(
        id: json['id'],
        name: json['name'],
        height: json['height'],
        weight: json['weight'],
        stats: (json['stats'] as List).map((e) => Stat.fromJson(e)).toList(),
        types: (json['types'] as List).map((e) => Type.fromJson(e)).toList(),
        sprites: Sprites.fromJson(json['sprites']),
      );

  PokemonEntity toEntity() => PokemonEntity(
        id: id,
        name: name,
        height: height,
        weight: weight,
        baseExperience: 0, // Replace with the actual value or variable
        abilities: [], // Replace with the actual list of abilities
        moves: [], // Replace with the actual list of moves
        stats: stats.map((e) => e.toEntity()).toList(),
        types: types.map((e) => e.toEntity()).toList(),
        sprites: sprites.toEntity(),
      );
}
