class PokemonEntity {
  final int id;
  final String name;
  final List<String> types;
  final List<String> abilities;
  final double height;
  final double weight;
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

  /// Converte a entidade para JSON
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

  /// Cria uma entidade a partir de JSON
  factory PokemonEntity.fromJson(Map<String, dynamic> json) {
    return PokemonEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      types: List<String>.from(json['types'] as List),
      abilities: List<String>.from(json['abilities'] as List),
      height: json['height'] as double,
      weight: json['weight'] as double,
      baseExperience: json['baseExperience'] as int,
      imageUrl: json['imageUrl'] as String,
    );
  }

  /// Cria uma cópia da entidade com campos opcionais atualizados
  PokemonEntity copyWith({
    int? id,
    String? name,
    List<String>? types,
    List<String>? abilities,
    double? height,
    double? weight,
    int? baseExperience,
    String? imageUrl,
  }) {
    return PokemonEntity(
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PokemonEntity &&
        other.id == id &&
        other.name == name &&
        other.types == types &&
        other.abilities == abilities &&
        other.height == height &&
        other.weight == weight &&
        other.baseExperience == baseExperience &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      Object.hashAll(types),
      Object.hashAll(abilities),
      height,
      weight,
      baseExperience,
      imageUrl,
    );
  }
}
