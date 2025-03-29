import '../../domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  PokemonModel({
    required super.id,
    required super.name,
    required super.types,
    required super.abilities,
    required super.height,
    required super.weight,
    required super.baseExperience,
    required super.imageUrl,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'] as int,
      name: json['name'] as String,
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      abilities: (json['abilities'] as List)
          .map((ability) => ability['ability']['name'] as String)
          .toList(),
      height: (json['height'] as int).toDouble(),
      weight: (json['weight'] as int).toDouble(),
      baseExperience: (json['base_experience'] as int?)?.toDouble() ?? 0.0,
      imageUrl: json['sprites']['front_default'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'types': types
          .map((type) => {
                'type': {'name': type}
              })
          .toList(),
      'abilities': abilities
          .map((ability) => {
                'ability': {'name': ability}
              })
          .toList(),
      'height': height.toInt(),
      'weight': weight.toInt(),
      'base_experience': baseExperience.toInt(),
      'sprites': {'front_default': imageUrl},
    };
  }
}
