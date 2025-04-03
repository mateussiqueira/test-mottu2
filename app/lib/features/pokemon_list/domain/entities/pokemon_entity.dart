import 'package:get/get.dart';
import 'package:pokemon_list/features/pokemon_list/domain/entities/type_relations.dart';

class PokemonEntity {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final List<String> abilities;
  final int height;
  final int weight;
  final double baseExperience;
  final Rx<TypeRelations?> typeRelations = Rx<TypeRelations?>(null);

  PokemonEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.abilities,
    required this.height,
    required this.weight,
    required this.baseExperience,
    TypeRelations? typeRelations,
  }) {
    this.typeRelations.value = typeRelations;
  }

  factory PokemonEntity.fromJson(Map<String, dynamic> json) {
    return PokemonEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['sprites']['front_default'] as String,
      types: (json['types'] as List<dynamic>)
          .map((type) => type['type']['name'] as String)
          .toList(),
      abilities: (json['abilities'] as List<dynamic>)
          .map((ability) => ability['ability']['name'] as String)
          .toList(),
      height: json['height'] as int,
      weight: json['weight'] as int,
      baseExperience: json['base_experience'] as double,
    );
  }
}
