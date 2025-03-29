import '../../../../core/domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {
  PokemonModel({
    required super.id,
    required super.name,
    required super.baseExperience,
    required super.height,
    required super.weight,
    required super.isDefault,
    required super.order,
    required super.sprites,
    required super.types,
    required super.abilities,
    required super.stats,
    required super.moves,
    required super.forms,
    required super.gameIndices,
    required super.heldItems,
    required super.locationAreaEncounters,
    required super.cries,
    required super.pastAbilities,
    required super.pastTypes,
    required super.species,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      baseExperience: json['base_experience'] ?? 0,
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      isDefault: json['is_default'] ?? false,
      order: json['order'] ?? 0,
      sprites: Sprites.fromJson(json['sprites'] as Map<String, dynamic>),
      types: (json['types'] as List<dynamic>)
          .map((type) => Type.fromJson(type as Map<String, dynamic>))
          .toList(),
      abilities: (json['abilities'] as List<dynamic>)
          .map((ability) => Ability.fromJson(ability as Map<String, dynamic>))
          .toList(),
      stats: (json['stats'] as List<dynamic>)
          .map((stat) => Stat.fromJson(stat as Map<String, dynamic>))
          .toList(),
      moves: (json['moves'] as List<dynamic>)
          .map((move) => Move.fromJson(move as Map<String, dynamic>))
          .toList(),
      forms: (json['forms'] as List<dynamic>)
          .map((form) => Species.fromJson(form as Map<String, dynamic>))
          .toList(),
      gameIndices: (json['game_indices'] as List<dynamic>)
          .map((index) => GameIndex.fromJson(index as Map<String, dynamic>))
          .toList(),
      heldItems: (json['held_items'] as List<dynamic>)
          .map((item) => HeldItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      locationAreaEncounters: json['location_area_encounters'] ?? '',
      cries: Cries.fromJson(json['cries'] as Map<String, dynamic>),
      pastAbilities: json['past_abilities'] ?? [],
      pastTypes: json['past_types'] ?? [],
      species: Species.fromJson(json['species'] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'base_experience': baseExperience,
      'height': height,
      'weight': weight,
      'is_default': isDefault,
      'order': order,
      'sprites': sprites.toJson(),
      'types': types.map((type) => type.toJson()).toList(),
      'abilities': abilities.map((ability) => ability.toJson()).toList(),
      'stats': stats.map((stat) => stat.toJson()).toList(),
      'moves': moves.map((move) => move.toJson()).toList(),
      'forms': forms.map((form) => form.toJson()).toList(),
      'game_indices': gameIndices.map((index) => index.toJson()).toList(),
      'held_items': heldItems.map((item) => item.toJson()).toList(),
      'location_area_encounters': locationAreaEncounters,
      'cries': cries.toJson(),
      'past_abilities': pastAbilities,
      'past_types': pastTypes,
      'species': species.toJson(),
    };
  }
}
