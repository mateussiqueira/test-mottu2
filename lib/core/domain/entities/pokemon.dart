import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final List<Map<String, dynamic>> stats;
  final List<String> abilities;
  final List<String> moves;
  final List<String> evolutionChain;
  final List<String> locations;
  final double height;
  final double weight;

  const Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.stats,
    required this.abilities,
    required this.moves,
    required this.evolutionChain,
    required this.locations,
    required this.height,
    required this.weight,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      types: List<String>.from(json['types']),
      abilities: List<String>.from(json['abilities']),
      stats: List<Map<String, dynamic>>.from(json['stats']),
      moves: List<String>.from(json['moves']),
      evolutionChain: List<String>.from(json['evolutionChain']),
      locations: List<String>.from(json['locations']),
      height: json['height'].toDouble(),
      weight: json['weight'].toDouble(),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'types': types,
      'abilities': abilities,
      'stats': stats,
      'moves': moves,
      'evolutionChain': evolutionChain,
      'locations': locations,
      'height': height,
      'weight': weight,
      'imageUrl': imageUrl,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        types,
        stats,
        abilities,
        moves,
        evolutionChain,
        locations,
        height,
        weight,
      ];
}
