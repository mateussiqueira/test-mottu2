class PokemonEntity {
  final int id;
  final String name;
  final List<String> types;
  final List<String> abilities;
  final int height;
  final int weight;
  final String imageUrl;
  final Map<String, int> stats;
  final List<String> moves;
  final String description;

  PokemonEntity({
    required this.id,
    required this.name,
    required this.types,
    required this.abilities,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.stats,
    required this.moves,
    required this.description,
  });

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
        other.height == height &&
        other.weight == weight &&
        other.abilities.toString() == abilities.toString() &&
        other.stats.toString() == stats.toString() &&
        other.moves.toString() == moves.toString() &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imageUrl.hashCode ^
        types.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        abilities.hashCode ^
        stats.hashCode ^
        moves.hashCode ^
        description.hashCode;
  }

  factory PokemonEntity.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'] as Map<String, dynamic>;
    final officialArtwork =
        sprites['other']?['official-artwork'] as Map<String, dynamic>;
    final imageUrl = officialArtwork['front_default'] as String? ?? '';

    final types = (json['types'] as List)
        .map((type) => (type['type']['name'] as String))
        .toList();

    final abilities = (json['abilities'] as List)
        .map((ability) => (ability['ability']['name'] as String))
        .toList();

    final stats = Map<String, int>.fromEntries(
      (json['stats'] as List).map(
        (stat) => MapEntry(
          stat['stat']['name'] as String,
          stat['base_stat'] as int,
        ),
      ),
    );

    final moves = (json['moves'] as List)
        .map((move) => (move['move']['name'] as String))
        .toList();

    return PokemonEntity(
      id: json['id'] as int,
      name: (json['name'] as String).replaceAll('-', ' '),
      imageUrl: imageUrl,
      types: types,
      abilities: abilities,
      stats: stats,
      height: json['height'] as int,
      weight: json['weight'] as int,
      moves: moves,
      description: '', // We need to fetch this separately
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
      'imageUrl': imageUrl,
      'stats': stats,
      'moves': moves,
      'description': description,
    };
  }

  PokemonEntity copyWith({
    int? id,
    String? name,
    List<String>? types,
    List<String>? abilities,
    int? height,
    int? weight,
    String? imageUrl,
    Map<String, int>? stats,
    List<String>? moves,
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
      moves: moves ?? this.moves,
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
