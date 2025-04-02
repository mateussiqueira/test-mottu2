import { Pokemon } from '../entities/pokemon.entity';

export interface PokemonRepository {
  getPokemonList(limit: number, offset: number): Promise<Pokemon[]>;
  getPokemonById(id: number): Promise<Pokemon>;
  searchPokemon(query: string): Promise<Pokemon[]>;
  getPokemonsByType(type: string): Promise<Pokemon[]>;
  getPokemonsByAbility(ability: string): Promise<Pokemon[]>;
}
