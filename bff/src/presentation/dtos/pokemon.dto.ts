export class PokemonTypeDto {
  slot: number;
  type: {
    name: string;
    url: string;
  };
}

export class PokemonAbilityDto {
  ability: {
    name: string;
    url: string;
  };
  isHidden: boolean;
  slot: number;
}

export class PokemonStatDto {
  baseStat: number;
  effort: number;
  stat: {
    name: string;
    url: string;
  };
}

export class PokemonMoveDto {
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
}

export class PokemonDto {
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
  types: PokemonTypeDto[];
  abilities: PokemonAbilityDto[];
  stats: PokemonStatDto[];
  moves: PokemonMoveDto[];
  species: {
    name: string;
    url: string;
  };
  evolutionChain?: {
    url: string;
  };
}
