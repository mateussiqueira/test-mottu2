import { Pokemon } from '../../domain/entities/pokemon.entity';
import { PokemonDto } from '../dtos/pokemon.dto';

export class PokemonMapper {
  static toDto(pokemon: Pokemon): PokemonDto {
    return {
      id: pokemon.id,
      name: pokemon.name,
      baseExperience: pokemon.baseExperience,
      height: pokemon.height,
      weight: pokemon.weight,
      sprites: pokemon.sprites,
      types: pokemon.types,
      abilities: pokemon.abilities,
      stats: pokemon.stats,
      moves: pokemon.moves,
      species: pokemon.species,
      evolutionChain: pokemon.evolutionChain,
    };
  }

  static toDtoList(pokemons: Pokemon[]): PokemonDto[] {
    return pokemons.map(pokemon => this.toDto(pokemon));
  }
}
