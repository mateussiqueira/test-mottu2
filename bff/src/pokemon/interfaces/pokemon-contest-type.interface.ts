export interface PokemonContestType {
  id: number;
  name: string;
  berryFlavor: string;
  names: {
    name: string;
    color: string;
  }[];
}
