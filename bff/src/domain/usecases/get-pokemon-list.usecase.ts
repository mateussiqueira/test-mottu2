import { Pokemon } from '../entities/pokemon.entity';
import { PokemonRepository } from '../repositories/pokemon.repository';

export class GetPokemonListUseCase {
  constructor(private readonly pokemonRepository: PokemonRepository) {}

  async execute(limit: number, offset: number): Promise<Pokemon[]> {
    return this.pokemonRepository.getPokemonList(limit, offset);
  }
}
