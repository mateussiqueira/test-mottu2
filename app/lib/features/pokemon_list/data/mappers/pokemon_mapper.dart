import '../../../pokemon/domain/entities/i_pokemon_entity.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';

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
      baseExperience: pokemon.baseExperience,
      imageUrl: pokemon.imageUrl,
      stats: pokemon.stats,
    );
  }

  /// Converts a list of Pokemon entities to their implementations
  static List<PokemonEntity> toEntityList(List<IPokemonEntity> pokemons) {
    return pokemons.map((p) => toEntity(p)).toList();
  }
}
