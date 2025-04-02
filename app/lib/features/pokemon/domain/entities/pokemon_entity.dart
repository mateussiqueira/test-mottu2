import 'i_pokemon_entity.dart';

/// Implementation of IPokemonEntity
class PokemonEntity implements IPokemonEntity {
  @override
  final int id;
  @override
  final String name;
  @override
  final List<String> types;
  @override
  final List<String> abilities;
  @override
  final int height;
  @override
  final int weight;
  @override
  final int? baseExperience;
  @override
  final String imageUrl;
  @override
  final Map<String, int> stats;

  PokemonEntity({
    required this.id,
    required this.name,
    required this.types,
    required this.abilities,
    required this.height,
    required this.weight,
    this.baseExperience,
    required this.imageUrl,
    required this.stats,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          imageUrl == other.imageUrl &&
          types == other.types &&
          abilities == other.abilities &&
          stats == other.stats &&
          height == other.height &&
          weight == other.weight &&
          baseExperience == other.baseExperience;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      imageUrl.hashCode ^
      types.hashCode ^
      abilities.hashCode ^
      stats.hashCode ^
      height.hashCode ^
      weight.hashCode ^
      baseExperience.hashCode;

  @override
  String toString() {
    return 'PokemonEntity{id: $id, name: $name, imageUrl: $imageUrl, types: $types, abilities: $abilities, stats: $stats, height: $height, weight: $weight, baseExperience: $baseExperience}';
  }

  factory PokemonEntity.fromJson(Map<String, dynamic> json) {
    return PokemonEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      types: List<String>.from(json['types'] as List),
      abilities: List<String>.from(json['abilities'] as List),
      stats: Map<String, int>.from(json['stats'] as Map),
      height: json['height'] as int,
      weight: json['weight'] as int,
      baseExperience: json['base_experience'] as int?,
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
      'base_experience': baseExperience,
      'imageUrl': imageUrl,
      'stats': stats,
    };
  }

  PokemonEntity copyWith({
    int? id,
    String? name,
    String? imageUrl,
    List<String>? types,
    List<String>? abilities,
    Map<String, int>? stats,
    int? height,
    int? weight,
    int? baseExperience,
  }) {
    return PokemonEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      types: types ?? this.types,
      abilities: abilities ?? this.abilities,
      stats: stats ?? this.stats,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      baseExperience: baseExperience ?? this.baseExperience,
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
