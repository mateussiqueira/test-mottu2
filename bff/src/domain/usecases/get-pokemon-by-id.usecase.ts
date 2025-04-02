import { Pokemon } from '../entities/pokemon.entity';
import { PokemonRepository } from '../repositories/pokemon.repository';

export class GetPokemonByIdUseCase {
  constructor(private readonly pokemonRepository: PokemonRepository) {}

  async execute(id: number): Promise<Pokemon> {
    return this.pokemonRepository.getPokemonById(id);
  }
}
