import { Pokemon } from '../entities/pokemon.entity';
import { PokemonRepository } from '../repositories/pokemon.repository';

export class GetPokemonsByAbilityUseCase {
  constructor(private readonly pokemonRepository: PokemonRepository) {}

  async execute(ability: string): Promise<Pokemon[]> {
    return this.pokemonRepository.getPokemonsByAbility(ability);
  }
}
