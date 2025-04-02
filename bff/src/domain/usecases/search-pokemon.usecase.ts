import { Pokemon } from '../entities/pokemon.entity';
import { PokemonRepository } from '../repositories/pokemon.repository';

export class SearchPokemonUseCase {
  constructor(private readonly pokemonRepository: PokemonRepository) {}

  async execute(query: string): Promise<Pokemon[]> {
    return this.pokemonRepository.searchPokemon(query);
  }
}
