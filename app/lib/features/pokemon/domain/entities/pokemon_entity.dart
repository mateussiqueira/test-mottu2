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
  final int baseExperience;
  @override
  final String imageUrl;
  @override
  final Map<String, int> stats;
  @override
  final List<String> moves;
  @override
  final List<String> evolutions;
  @override
  final String description;

  PokemonEntity({
    required this.id,
    required this.name,
    required this.types,
    required this.abilities,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.imageUrl,
    required this.stats,
    required this.moves,
    required this.evolutions,
    required this.description,
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
          baseExperience == other.baseExperience &&
          moves == other.moves &&
          evolutions == other.evolutions &&
          description == other.description;

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
      baseExperience.hashCode ^
      moves.hashCode ^
      evolutions.hashCode ^
      description.hashCode;

  @override
  String toString() {
    return 'PokemonEntity{id: $id, name: $name, imageUrl: $imageUrl, types: $types, abilities: $abilities, stats: $stats, height: $height, weight: $weight, baseExperience: $baseExperience, moves: $moves, evolutions: $evolutions, description: $description}';
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
      baseExperience: json['base_experience'] as int,
      moves: List<String>.from(json['moves'] as List),
      evolutions: List<String>.from(json['evolutions'] as List),
      description: json['description'] as String,
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
      'moves': moves,
      'evolutions': evolutions,
      'description': description,
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
    List<String>? moves,
    List<String>? evolutions,
    String? description,
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
      moves: moves ?? this.moves,
      evolutions: evolutions ?? this.evolutions,
      description: description ?? this.description,
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
