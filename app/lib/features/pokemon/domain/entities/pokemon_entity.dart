import 'i_pokemon_entity.dart';

part 'pokemon_entity.g.dart';

/// Entity class for Pokemon data
class PokemonEntity implements IPokemonEntity {
  @override
  final int id;
  @override
  final String name;
  @override
  final int height;
  @override
  final int weight;
  @override
  final int baseExperience;
  final bool isDefault;
  final int order;
  @override
  final List<String> abilities;
  final List<String> forms;
  final List<String> gameIndices;
  final List<String> heldItems;
  final String locationAreaEncounters;
  @override
  final List<String> moves;
  final String species;
  final Map<String, dynamic> sprites;
  @override
  final Map<String, int> stats;
  @override
  final List<String> types;
  @override
  final List<String> evolutions;
  @override
  final String description;
  final TypeRelations? typeRelations;

  @override
  String get imageUrl =>
      sprites['other']?['official-artwork']?['front_default'] ??
      sprites['front_default'] ??
      '';

  PokemonEntity({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.isDefault,
    required this.order,
    required this.abilities,
    required this.forms,
    required this.gameIndices,
    required this.heldItems,
    required this.locationAreaEncounters,
    required this.moves,
    required this.species,
    required this.sprites,
    required this.stats,
    required this.types,
    this.evolutions = const [],
    this.description = '',
    this.typeRelations,
  });

  factory PokemonEntity.fromJson(Map<String, dynamic> json) {
    return PokemonEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      height: json['height'] as int,
      weight: json['weight'] as int,
      baseExperience: json['base_experience'] as int,
      isDefault: json['is_default'] as bool,
      order: json['order'] as int,
      abilities: (json['abilities'] as List<dynamic>)
          .map((a) => a['ability']['name'] as String)
          .toList(),
      forms: (json['forms'] as List<dynamic>)
          .map((f) => f['name'] as String)
          .toList(),
      gameIndices: (json['game_indices'] as List<dynamic>)
          .map((g) => g['version']['name'] as String)
          .toList(),
      heldItems: (json['held_items'] as List<dynamic>)
          .map((h) => h['item']['name'] as String)
          .toList(),
      locationAreaEncounters: json['location_area_encounters'] as String,
      moves: (json['moves'] as List<dynamic>)
          .map((m) => m['move']['name'] as String)
          .toList(),
      species: json['species']['name'] as String,
      sprites: Map<String, dynamic>.from(json['sprites'] as Map),
      stats: Map<String, int>.fromEntries(
        (json['stats'] as List<dynamic>).map(
          (s) => MapEntry(
            s['stat']['name'] as String,
            (s['base_stat'] as num).toInt(),
          ),
        ),
      ),
      types: (json['types'] as List<dynamic>)
          .map((t) => t['type']['name'] as String)
          .toList(),
      description: json['description'] as String? ?? '',
      evolutions: (json['evolutions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      typeRelations: json['type_relations'] != null
          ? TypeRelations.fromJson(
              json['type_relations'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'weight': weight,
      'base_experience': baseExperience,
      'is_default': isDefault,
      'order': order,
      'abilities': abilities
          .map((a) => {
                'ability': {'name': a}
              })
          .toList(),
      'forms': forms.map((f) => {'name': f}).toList(),
      'game_indices': gameIndices
          .map((g) => {
                'version': {'name': g}
              })
          .toList(),
      'held_items': heldItems
          .map((h) => {
                'item': {'name': h}
              })
          .toList(),
      'location_area_encounters': locationAreaEncounters,
      'moves': moves
          .map((m) => {
                'move': {'name': m}
              })
          .toList(),
      'species': {'name': species},
      'sprites': sprites,
      'stats': stats.entries
          .map((e) => {
                'stat': {'name': e.key},
                'base_stat': e.value,
              })
          .toList(),
      'types': types
          .map((t) => {
                'type': {'name': t}
              })
          .toList(),
      'description': description,
      'evolutions': evolutions,
      'type_relations': typeRelations?.toJson(),
    };
  }

  @override
  String toString() {
    return 'PokemonEntity(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PokemonEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  PokemonEntity copyWith({
    int? id,
    String? name,
    int? height,
    int? weight,
    int? baseExperience,
    bool? isDefault,
    int? order,
    List<String>? abilities,
    List<String>? forms,
    List<String>? gameIndices,
    List<String>? heldItems,
    String? locationAreaEncounters,
    List<String>? moves,
    String? species,
    Map<String, dynamic>? sprites,
    Map<String, int>? stats,
    List<String>? types,
    List<String>? evolutions,
    String? description,
    TypeRelations? typeRelations,
  }) {
    return PokemonEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      baseExperience: baseExperience ?? this.baseExperience,
      isDefault: isDefault ?? this.isDefault,
      order: order ?? this.order,
      abilities: abilities ?? this.abilities,
      forms: forms ?? this.forms,
      gameIndices: gameIndices ?? this.gameIndices,
      heldItems: heldItems ?? this.heldItems,
      locationAreaEncounters:
          locationAreaEncounters ?? this.locationAreaEncounters,
      moves: moves ?? this.moves,
      species: species ?? this.species,
      sprites: sprites ?? this.sprites,
      stats: stats ?? this.stats,
      types: types ?? this.types,
      evolutions: evolutions ?? this.evolutions,
      description: description ?? this.description,
      typeRelations: typeRelations ?? this.typeRelations,
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
