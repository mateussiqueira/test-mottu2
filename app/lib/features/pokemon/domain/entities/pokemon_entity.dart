import 'package:json_annotation/json_annotation.dart';

import 'i_pokemon_entity.dart';

part 'pokemon_entity.g.dart';

@JsonSerializable()
class PokemonEntity implements IPokemonEntity {
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
  final int baseExperience;
  @override
  final Map<String, int> stats;
  @override
  final String description;
  @override
  final TypeRelations? typeRelations;
  @override
  final List<String> moves;
  @override
  final List<String> evolutions;

  PokemonEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.abilities,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.stats,
    required this.description,
    required this.moves,
    required this.evolutions,
    this.typeRelations,
  });

  factory PokemonEntity.fromJson(Map<String, dynamic> json) =>
      _$PokemonEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PokemonEntityToJson(this);

  @override
  String toString() {
    return 'PokemonEntity{id: $id, name: $name, types: $types}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PokemonEntity &&
        other.id == id &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.types.toString() == types.toString() &&
        other.abilities.toString() == abilities.toString() &&
        other.stats.toString() == stats.toString() &&
        other.moves.toString() == moves.toString() &&
        other.evolutions.toString() == evolutions.toString() &&
        other.description == description;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      imageUrl.hashCode ^
      types.hashCode ^
      abilities.hashCode ^
      stats.hashCode ^
      moves.hashCode ^
      evolutions.hashCode ^
      description.hashCode;

  PokemonEntity copyWith({
    int? id,
    String? name,
    String? imageUrl,
    List<String>? types,
    List<String>? abilities,
    int? height,
    int? weight,
    int? baseExperience,
    Map<String, int>? stats,
    String? description,
    List<String>? moves,
    List<String>? evolutions,
    TypeRelations? typeRelations,
  }) {
    return PokemonEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      types: types ?? this.types,
      abilities: abilities ?? this.abilities,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      baseExperience: baseExperience ?? this.baseExperience,
      stats: stats ?? this.stats,
      description: description ?? this.description,
      moves: moves ?? this.moves,
      evolutions: evolutions ?? this.evolutions,
      typeRelations: typeRelations ?? this.typeRelations,
    );
  }
}

class PokemonStats {
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

  PokemonStats({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  });

  factory PokemonStats.fromJson(Map<String, dynamic> json) {
    return PokemonStats(
      hp: json['hp'],
      attack: json['attack'],
      defense: json['defense'],
      specialAttack: json['specialAttack'],
      specialDefense: json['specialDefense'],
      speed: json['speed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hp': hp,
      'attack': attack,
      'defense': defense,
      'specialAttack': specialAttack,
      'specialDefense': specialDefense,
      'speed': speed,
    };
  }
}
