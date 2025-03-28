import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final List<Map<String, dynamic>> stats;
  final List<String> abilities;
  final List<String> moves;
  final List<Map<String, dynamic>> evolutionChain;
  final List<Map<String, dynamic>> locations;
  final double height;
  final double weight;

  const Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.types = const [],
    this.stats = const [],
    this.abilities = const [],
    this.moves = const [],
    this.evolutionChain = const [],
    this.locations = const [],
    this.height = 0,
    this.weight = 0,
  });

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
        weight
      ];
}
