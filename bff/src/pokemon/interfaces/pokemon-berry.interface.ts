export interface PokemonBerry {
  id: number;
  name: string;
  growthTime: number;
  maxHarvest: number;
  naturalGiftPower: number;
  size: number;
  smoothness: number;
  soilDryness: number;
  firmness: string;
  flavors: {
    name: string;
    potency: number;
  }[];
}
