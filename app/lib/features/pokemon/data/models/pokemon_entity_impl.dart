import '../../domain/entities/pokemon_entity.dart';

class PokemonEntityImpl extends PokemonEntity {
  PokemonEntityImpl({
    required super.id,
    required super.name,
    required super.types,
    required super.abilities,
    required super.height,
    required super.weight,
    required super.baseExperience,
    required super.imageUrl,
  });

  factory PokemonEntityImpl.fromJson(Map<String, dynamic> json) {
    return PokemonEntityImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      types: List<String>.from(json['types'] as List),
      abilities: List<String>.from(json['abilities'] as List),
      height: json['height'] as int,
      weight: json['weight'] as int,
      baseExperience: json['baseExperience'] as int? ?? 0,
      imageUrl: json['imageUrl'] as String,
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
}
