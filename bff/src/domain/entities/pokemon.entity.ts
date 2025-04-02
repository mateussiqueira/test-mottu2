export interface Pokemon {
  id: number;
  name: string;
  baseExperience: number;
  height: number;
  weight: number;
  sprites: {
    frontDefault: string;
    backDefault: string;
    frontShiny: string;
    backShiny: string;
  };
  types: {
    slot: number;
    type: {
      name: string;
      url: string;
    };
  }[];
  abilities: {
    ability: {
      name: string;
      url: string;
    };
    isHidden: boolean;
    slot: number;
  }[];
  stats: {
    baseStat: number;
    effort: number;
    stat: {
      name: string;
      url: string;
    };
  }[];
  moves: {
    move: {
      name: string;
      url: string;
    };
    versionGroupDetails: {
      levelLearnedAt: number;
      moveLearnMethod: {
        name: string;
        url: string;
      };
      versionGroup: {
        name: string;
        url: string;
      };
    }[];
  }[];
  species: {
    name: string;
    url: string;
  };
  evolutionChain?: {
    url: string;
  };
}
