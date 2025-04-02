import { Pokemon } from '../entities/pokemon.entity';
import { PokemonRepository } from '../repositories/pokemon.repository';

export class GetPokemonsByTypeUseCase {
  constructor(private readonly pokemonRepository: PokemonRepository) {}

  async execute(type: string): Promise<Pokemon[]> {
    return this.pokemonRepository.getPokemonsByType(type);
  }
}
