import 'package:json_annotation/json_annotation.dart';

part 'pokemon_model.g.dart';

/// Model for Pokemon data
@JsonSerializable()
class PokemonModel {
  final int id;
  final String name;
  final List<String> types;
  final List<String> abilities;
  final int height;
  final int weight;
  final Map<String, int> stats;
  final Map<String, String> sprites;
  final int baseExperience;
  final List<String> moves;
  final List<String> evolutions;
  final String description;
  final bool isDefault;
  final int order;
  final List<String> forms;
  final List<String> gameIndices;
  final List<String> heldItems;
  final String locationAreaEncounters;
  final String species;

  const PokemonModel({
    required this.id,
    required this.name,
    required this.types,
    required this.abilities,
    required this.height,
    required this.weight,
    required this.stats,
    required this.sprites,
    required this.baseExperience,
    required this.moves,
    required this.evolutions,
    required this.description,
    required this.isDefault,
    required this.order,
    required this.forms,
    required this.gameIndices,
    required this.heldItems,
    required this.locationAreaEncounters,
    required this.species,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonModelToJson(this);

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
