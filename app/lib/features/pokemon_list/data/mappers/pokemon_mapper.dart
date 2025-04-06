import '../../../pokemon/domain/entities/i_pokemon_entity.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../../../pokemon/domain/entities/pokemon_entity_impl.dart';

/// Mapper for Pokemon entities
class PokemonMapper {
  /// Converts a Pokemon entity to its implementation
  static PokemonEntity toEntity(IPokemonEntity pokemon) {
    return PokemonEntity(
      id: pokemon.id,
      name: pokemon.name,
      types: pokemon.types,
      abilities: pokemon.abilities,
      height: pokemon.height,
      weight: pokemon.weight,
      imageUrl: pokemon.imageUrl,
      stats: pokemon.stats,
      moves: pokemon.moves,
      description: pokemon.description,
      baseExperience: pokemon.baseExperience,
      evolutions: pokemon.evolutions,
    );
  }

  /// Converts a list of Pokemon entities to their implementations
  static List<PokemonEntity> toEntityList(List<IPokemonEntity> pokemons) {
    return pokemons.map((p) => toEntity(p)).toList();
  }
  
  /// Converts a JSON object to a PokemonEntityImpl
  static PokemonEntityImpl fromJson(Map<String, dynamic> json) {
    return PokemonEntityImpl(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      baseExperience: json['base_experience'] ?? 0,
      types: List<String>.from(json['types'] ?? []),
      abilities: List<String>.from(json['abilities'] ?? []),
      imageUrl: json['sprites']?['other']?['official-artwork']?['front_default'] ?? 
              json['sprites']?['front_default'] ?? '',
      stats: Map<String, int>.from(json['stats'] ?? {}),
      moves: List<String>.from(json['moves'] ?? []),
      evolutions: List<String>.from(json['evolutions'] ?? []),
      description: json['description'] ?? '',
      isDefault: json['is_default'] ?? true,
      order: json['order'] ?? 0,
      forms: List<String>.from(json['forms'] ?? []),
      gameIndices: List<String>.from(json['game_indices'] ?? []),
      heldItems: List<String>.from(json['held_items'] ?? []),
      locationAreaEncounters: json['location_area_encounters'] ?? '',
      species: json['species'] ?? '',
      sprites: Map<String, String>.from(json['sprites'] ?? {}),
    );
  }
  
  /// Converts a list of JSON objects to a list of PokemonEntityImpl
  static List<PokemonEntityImpl> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => fromJson(json)).toList();
  }
}
