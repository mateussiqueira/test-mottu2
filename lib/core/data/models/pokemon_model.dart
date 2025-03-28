import '../../domain/entities/pokemon.dart';

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
      sprites: json['sprites'] ?? {},
      types:
          (json['types'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [],
      abilities:
          (json['abilities'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ??
              [],
      stats:
          (json['stats'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [],
      moves:
          (json['moves'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [],
      forms:
          (json['forms'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [],
      gameIndices: (json['game_indices'] as List<dynamic>?)
              ?.cast<Map<String, dynamic>>() ??
          [],
      heldItems: (json['held_items'] as List<dynamic>?)
              ?.cast<Map<String, dynamic>>() ??
          [],
      locationAreaEncounters: json['location_area_encounters'] ?? '',
      cries:
          (json['cries'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [],
      pastAbilities: (json['past_abilities'] as List<dynamic>?)
              ?.cast<Map<String, dynamic>>() ??
          [],
      pastTypes: (json['past_types'] as List<dynamic>?)
              ?.cast<Map<String, dynamic>>() ??
          [],
      species: json['species'] ?? {},
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
      'sprites': sprites,
      'types': types,
      'abilities': abilities,
      'stats': stats,
      'moves': moves,
      'forms': forms,
      'game_indices': gameIndices,
      'held_items': heldItems,
      'location_area_encounters': locationAreaEncounters,
      'cries': cries,
      'past_abilities': pastAbilities,
      'past_types': pastTypes,
      'species': species,
    };
  }
}
