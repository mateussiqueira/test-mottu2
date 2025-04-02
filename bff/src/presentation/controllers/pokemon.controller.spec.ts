import { Test, TestingModule } from '@nestjs/testing';
import { Pokemon } from '../../domain/entities/pokemon.entity';
import { GetPokemonByIdUseCase } from '../../domain/usecases/get-pokemon-by-id.usecase';
import { GetPokemonListUseCase } from '../../domain/usecases/get-pokemon-list.usecase';
import { GetPokemonsByAbilityUseCase } from '../../domain/usecases/get-pokemons-by-ability.usecase';
import { GetPokemonsByTypeUseCase } from '../../domain/usecases/get-pokemons-by-type.usecase';
import { SearchPokemonUseCase } from '../../domain/usecases/search-pokemon.usecase';
import { PokemonDto } from '../dtos/pokemon.dto';
import { PokemonController } from './pokemon.controller';

describe('PokemonController', () => {
  let controller: PokemonController;
  let getPokemonListUseCase: GetPokemonListUseCase;
  let getPokemonByIdUseCase: GetPokemonByIdUseCase;
  let searchPokemonUseCase: SearchPokemonUseCase;
  let getPokemonsByTypeUseCase: GetPokemonsByTypeUseCase;
  let getPokemonsByAbilityUseCase: GetPokemonsByAbilityUseCase;

  const mockPokemon: Pokemon = {
    id: 1,
    name: 'bulbasaur',
    baseExperience: 64,
    height: 7,
    weight: 69,
    sprites: {
      frontDefault: 'front_default',
      backDefault: 'back_default',
      frontShiny: 'front_shiny',
      backShiny: 'back_shiny',
    },
    types: [
      {
        slot: 1,
        type: {
          name: 'grass',
          url: 'grass_url',
        },
      },
    ],
    abilities: [
      {
        ability: {
          name: 'overgrow',
          url: 'overgrow_url',
        },
        isHidden: false,
        slot: 1,
      },
    ],
    stats: [
      {
        baseStat: 45,
        effort: 0,
        stat: {
          name: 'hp',
          url: 'hp_url',
        },
      },
    ],
    moves: [
      {
        move: {
          name: 'tackle',
          url: 'tackle_url',
        },
        versionGroupDetails: [
          {
            levelLearnedAt: 1,
            moveLearnMethod: {
              name: 'level-up',
              url: 'level-up_url',
            },
            versionGroup: {
              name: 'red-blue',
              url: 'red-blue_url',
            },
          },
        ],
      },
    ],
    species: {
      name: 'bulbasaur',
      url: 'bulbasaur_url',
    },
  };

  const mockPokemonDto: PokemonDto = {
    id: 1,
    name: 'bulbasaur',
    baseExperience: 64,
    height: 7,
    weight: 69,
    sprites: {
      frontDefault: 'front_default',
      backDefault: 'back_default',
      frontShiny: 'front_shiny',
      backShiny: 'back_shiny',
    },
    types: [
      {
        slot: 1,
        type: {
          name: 'grass',
          url: 'grass_url',
        },
      },
    ],
    abilities: [
      {
        ability: {
          name: 'overgrow',
          url: 'overgrow_url',
        },
        isHidden: false,
        slot: 1,
      },
    ],
    stats: [
      {
        baseStat: 45,
        effort: 0,
        stat: {
          name: 'hp',
          url: 'hp_url',
        },
      },
    ],
    moves: [
      {
        move: {
          name: 'tackle',
          url: 'tackle_url',
        },
        versionGroupDetails: [
          {
            levelLearnedAt: 1,
            moveLearnMethod: {
              name: 'level-up',
              url: 'level-up_url',
            },
            versionGroup: {
              name: 'red-blue',
              url: 'red-blue_url',
            },
          },
        ],
      },
    ],
    species: {
      name: 'bulbasaur',
      url: 'bulbasaur_url',
    },
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [PokemonController],
      providers: [
        {
          provide: GetPokemonListUseCase,
          useValue: {
            execute: jest.fn(),
          },
        },
        {
          provide: GetPokemonByIdUseCase,
          useValue: {
            execute: jest.fn(),
          },
        },
        {
          provide: SearchPokemonUseCase,
          useValue: {
            execute: jest.fn(),
          },
        },
        {
          provide: GetPokemonsByTypeUseCase,
          useValue: {
            execute: jest.fn(),
          },
        },
        {
          provide: GetPokemonsByAbilityUseCase,
          useValue: {
            execute: jest.fn(),
          },
        },
      ],
    }).compile();

    controller = module.get<PokemonController>(PokemonController);
    getPokemonListUseCase = module.get<GetPokemonListUseCase>(GetPokemonListUseCase);
    getPokemonByIdUseCase = module.get<GetPokemonByIdUseCase>(GetPokemonByIdUseCase);
    searchPokemonUseCase = module.get<SearchPokemonUseCase>(SearchPokemonUseCase);
    getPokemonsByTypeUseCase = module.get<GetPokemonsByTypeUseCase>(GetPokemonsByTypeUseCase);
    getPokemonsByAbilityUseCase = module.get<GetPokemonsByAbilityUseCase>(
      GetPokemonsByAbilityUseCase,
    );
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should get pokemon list', async () => {
    const limit = '20';
    const offset = '0';
    const expectedPokemons = [mockPokemon];

    jest.spyOn(getPokemonListUseCase, 'execute').mockResolvedValue(expectedPokemons);

    const result = await controller.getPokemonList(limit, offset);

    expect(result).toEqual([mockPokemonDto]);
    expect(getPokemonListUseCase.execute).toHaveBeenCalledWith(20, 0);
  });

  it('should get pokemon by id', async () => {
    const id = '1';

    jest.spyOn(getPokemonByIdUseCase, 'execute').mockResolvedValue(mockPokemon);

    const result = await controller.getPokemonById(id);

    expect(result).toEqual(mockPokemonDto);
    expect(getPokemonByIdUseCase.execute).toHaveBeenCalledWith(1);
  });

  it('should search pokemon', async () => {
    const query = 'bulba';
    const expectedPokemons = [mockPokemon];

    jest.spyOn(searchPokemonUseCase, 'execute').mockResolvedValue(expectedPokemons);

    const result = await controller.searchPokemon(query);

    expect(result).toEqual([mockPokemonDto]);
    expect(searchPokemonUseCase.execute).toHaveBeenCalledWith(query);
  });

  it('should get pokemons by type', async () => {
    const type = 'grass';
    const expectedPokemons = [mockPokemon];

    jest.spyOn(getPokemonsByTypeUseCase, 'execute').mockResolvedValue(expectedPokemons);

    const result = await controller.getPokemonsByType(type);

    expect(result).toEqual([mockPokemonDto]);
    expect(getPokemonsByTypeUseCase.execute).toHaveBeenCalledWith(type);
  });

  it('should get pokemons by ability', async () => {
    const ability = 'overgrow';
    const expectedPokemons = [mockPokemon];

    jest.spyOn(getPokemonsByAbilityUseCase, 'execute').mockResolvedValue(expectedPokemons);

    const result = await controller.getPokemonsByAbility(ability);

    expect(result).toEqual([mockPokemonDto]);
    expect(getPokemonsByAbilityUseCase.execute).toHaveBeenCalledWith(ability);
  });
});
