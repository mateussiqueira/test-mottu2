export interface PokemonStats {
  hp: number;
  attack: number;
  defense: number;
  specialAttack: number;
  specialDefense: number;
  speed: number;
}

export interface PokemonResponse {
  id: number;
  name: string;
  types: string[];
  abilities: string[];
  height: number;
  weight: number;
  baseExperience: number;
  imageUrl: string;
  stats: PokemonStats;
}
