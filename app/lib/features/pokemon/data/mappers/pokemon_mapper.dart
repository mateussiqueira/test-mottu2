import 'package:pokemon_list/features/pokemon/domain/entities/pokemon_entity_impl.dart';

import '../../domain/entities/pokemon_entity.dart';
import '../models/pokemon_model.dart';
import '../validators/pokemon_response_validator.dart';

/// Handles Pokemon data transformations
class PokemonMapper {
  /// Maps a list of Pokemon data to Pokemon entities
  static Future<List<PokemonEntity>> mapToEntities(
    List<dynamic> results,
    Future<Map<String, dynamic>> Function(String url) fetchDetails,
  ) async {
    return Future.wait(
      results.map((pokemon) async {
        if (!PokemonResponseValidator.hasValidUrl(pokemon)) {
          throw Exception('Invalid pokemon data: missing url');
        }
        final response = await fetchDetails(pokemon['url']);
        return PokemonModel.fromJson(response) as PokemonEntity;
      }),
    );
  }

  /// Maps a list of Pokemon data from type/ability responses to Pokemon entities
  static Future<List<PokemonEntity>> mapTypeResultsToEntities(
    List<dynamic> results,
    Future<Map<String, dynamic>> Function(String url) fetchDetails,
  ) async {
    return Future.wait(
      results.map((pokemon) async {
        if (!PokemonResponseValidator.hasValidTypeUrl(pokemon)) {
          throw Exception('Invalid pokemon data: missing url');
        }
        final response = await fetchDetails(pokemon['pokemon']['url']);
        return PokemonModel.fromJson(response) as PokemonEntity;
      }),
    );
  }

  /// Filters Pokemon by name based on the search query
  static List<dynamic> filterByName(
    List<dynamic> results,
    String query,
  ) {
    return results.where((pokemon) {
      final name = pokemon['name']?.toString().toLowerCase();
      return name?.contains(query.toLowerCase()) ?? false;
    }).toList();
  }

  /// Converts JSON data to a Pokemon entity
  static PokemonEntity fromJson(Map<String, dynamic> json) {
    final stats = <String, int>{};
    if (json['stats'] != null) {
      for (var stat in json['stats'] as List<dynamic>) {
        stats[stat['stat']['name'] as String] =
            (stat['base_stat'] as num).toInt();
      }
    }

    return PokemonEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      height: json['height'] as int,
      weight: json['weight'] as int,
      baseExperience: json['base_experience'] as int,
      isDefault: json['is_default'] as bool,
      order: json['order'] as int,
      abilities: (json['abilities'] as List<dynamic>?)
              ?.map((a) => a['ability']['name'] as String)
              .toList() ??
          [],
      forms: (json['forms'] as List<dynamic>?)
              ?.map((f) => f['name'] as String)
              .toList() ??
          [],
      gameIndices: (json['game_indices'] as List<dynamic>?)
              ?.map((g) => g['version']['name'] as String)
              .toList() ??
          [],
      heldItems: (json['held_items'] as List<dynamic>?)
              ?.map((h) => h['item']['name'] as String)
              .toList() ??
          [],
      locationAreaEncounters: json['location_area_encounters'] as String? ?? '',
      moves: (json['moves'] as List<dynamic>?)
              ?.map((m) => m['move']['name'] as String)
              .toList() ??
          [],
      species: json['species']?['name'] as String? ?? '',
      sprites: Map<String, dynamic>.from(json['sprites'] as Map),
      stats: stats,
      types: (json['types'] as List<dynamic>?)
              ?.map((t) => t['type']['name'] as String)
              .toList() ??
          [],
      description: json['description'] as String? ?? '',
      evolutions: (json['evolutions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  /// Convert Pokemon model to entity
  static PokemonEntityImpl toEntity(PokemonModel model) {
    return PokemonEntityImpl(
      id: model.id,
      name: model.name,
      types: model.types,
      abilities: model.abilities,
      height: model.height,
      weight: model.weight,
      imageUrl: model.sprites['front_default'] ?? '',
      stats: model.stats,
      moves: model.moves,
      description: model.description,
      baseExperience: model.baseExperience,
      evolutions: model.evolutions,
      isDefault: model.isDefault,
      order: model.order,
      forms: model.forms,
      gameIndices: model.gameIndices,
      heldItems: model.heldItems,
      locationAreaEncounters: model.locationAreaEncounters,
      species: model.species,
      sprites: model.sprites,
    );
  }

  /// Convert Pokemon entity to model
  static PokemonModel toModel(PokemonEntityImpl entity) {
    return PokemonModel(
      id: entity.id,
      name: entity.name,
      types: entity.types,
      abilities: entity.abilities,
      height: entity.height,
      weight: entity.weight,
      stats: entity.stats,
      sprites: entity.sprites,
      baseExperience: entity.baseExperience,
      moves: entity.moves,
      evolutions: entity.evolutions,
      description: entity.description,
      isDefault: entity.isDefault,
      order: entity.order,
      forms: entity.forms,
      gameIndices: entity.gameIndices,
      heldItems: entity.heldItems,
      locationAreaEncounters: entity.locationAreaEncounters,
      species: entity.species,
    );
  }

  /// Convert Pokemon entity to JSON
  static Map<String, dynamic> toJson(PokemonEntity entity) {
    return {
      'id': entity.id,
      'name': entity.name,
      'height': entity.height,
      'weight': entity.weight,
      'base_experience': entity.baseExperience,
      'is_default': entity.isDefault,
      'order': entity.order,
      'abilities': entity.abilities
          .map((a) => {
                'ability': {'name': a}
              })
          .toList(),
      'forms': entity.forms.map((f) => {'name': f}).toList(),
      'game_indices': entity.gameIndices
          .map((g) => {
                'version': {'name': g}
              })
          .toList(),
      'held_items': entity.heldItems
          .map((h) => {
                'item': {'name': h}
              })
          .toList(),
      'location_area_encounters': entity.locationAreaEncounters,
      'moves': entity.moves
          .map((m) => {
                'move': {'name': m}
              })
          .toList(),
      'species': {'name': entity.species},
      'sprites': entity.sprites,
      'stats': entity.stats.entries
          .map((e) => {
                'stat': {'name': e.key},
                'base_stat': e.value,
              })
          .toList(),
      'types': entity.types
          .map((t) => {
                'type': {'name': t}
              })
          .toList(),
      'description': entity.description,
      'evolutions': entity.evolutions,
    };
  }
}
