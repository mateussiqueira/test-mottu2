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
    required this.types,
    required this.stats,
    required this.abilities,
    required this.moves,
    required this.evolutionChain,
    required this.locations,
    required this.height,
    required this.weight,
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
        weight,
      ];
}
