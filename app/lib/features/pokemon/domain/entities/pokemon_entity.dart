class PokemonEntity {
  final int id;
  final String name;
  final List<String> types;
  final List<String> abilities;
  final int height;
  final int weight;
  final int baseExperience;
  final String imageUrl;

  PokemonEntity({
    required this.id,
    required this.name,
    required this.types,
    required this.abilities,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.imageUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          types == other.types &&
          abilities == other.abilities &&
          height == other.height &&
          weight == other.weight &&
          baseExperience == other.baseExperience &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      types.hashCode ^
      abilities.hashCode ^
      height.hashCode ^
      weight.hashCode ^
      baseExperience.hashCode ^
      imageUrl.hashCode;

  @override
  String toString() {
    return 'PokemonEntity{id: $id, name: $name, types: $types, abilities: $abilities, height: $height, weight: $weight, baseExperience: $baseExperience, imageUrl: $imageUrl}';
  }
}

class PokemonEntityImpl extends PokemonEntity {
  const PokemonEntityImpl({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.types,
    required super.abilities,
    required super.height,
    required super.weight,
    required super.baseExperience,
  });

  factory PokemonEntityImpl.fromJson(Map<String, dynamic> json) {
    return PokemonEntityImpl(
      id: json['id'],
      name: json['name'],
      types: List<String>.from(json['types']),
      abilities: List<String>.from(json['abilities']),
      height: json['height'].toInt(),
      weight: json['weight'].toInt(),
      baseExperience: json['baseExperience'].toInt(),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'types': types,
      'abilities': abilities,
      'height': height,
      'weight': weight,
      'baseExperience': baseExperience,
      'imageUrl': imageUrl,
    };
  }

  PokemonEntityImpl copyWith({
    int? id,
    String? name,
    List<String>? types,
    List<String>? abilities,
    int? height,
    int? weight,
    int? baseExperience,
    String? imageUrl,
  }) {
    return PokemonEntityImpl(
      id: id ?? this.id,
      name: name ?? this.name,
      types: types ?? this.types,
      abilities: abilities ?? this.abilities,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      baseExperience: baseExperience ?? this.baseExperience,
      imageUrl: imageUrl ?? this.imageUrl,
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
