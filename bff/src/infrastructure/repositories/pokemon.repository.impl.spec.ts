import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { Test, TestingModule } from '@nestjs/testing';
import { AxiosResponse } from 'axios';
import { of } from 'rxjs';
import { Pokemon } from '../../domain/entities/pokemon.entity';
import { PokemonRepositoryImpl } from './pokemon.repository.impl';

jest.mock('@nestjs/axios');
jest.mock('rxjs');

describe('PokemonRepositoryImpl', () => {
  let repository: PokemonRepositoryImpl;
  let httpService: HttpService;
  let configService: ConfigService;

  const mockPokemonData = {
    id: 1,
    name: 'bulbasaur',
    base_experience: 64,
    height: 7,
    weight: 69,
    sprites: {
      front_default: 'front_default',
      back_default: 'back_default',
      front_shiny: 'front_shiny',
      back_shiny: 'back_shiny',
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
        is_hidden: false,
        slot: 1,
      },
    ],
    stats: [
      {
        base_stat: 45,
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
        version_group_details: [
          {
            level_learned_at: 1,
            move_learn_method: {
              name: 'level-up',
              url: 'level-up_url',
            },
            version_group: {
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

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        PokemonRepositoryImpl,
        {
          provide: HttpService,
          useValue: {
            get: jest.fn(),
          },
        },
        {
          provide: ConfigService,
          useValue: {
            get: jest.fn(),
          },
        },
      ],
    }).compile();

    repository = module.get<PokemonRepositoryImpl>(PokemonRepositoryImpl);
    httpService = module.get<HttpService>(HttpService);
    configService = module.get<ConfigService>(ConfigService);
  });

  it('should be defined', () => {
    expect(repository).toBeDefined();
  });

  it('should get pokemon list', async () => {
    const limit = 20;
    const offset = 0;
    const mockResponse: AxiosResponse = {
      data: {
        count: 1,
        next: null,
        previous: null,
        results: [
          {
            name: 'bulbasaur',
            url: 'https://pokeapi.co/api/v2/pokemon/1/',
          },
        ],
      },
      status: 200,
      statusText: 'OK',
      headers: {},
      config: {} as any,
    };

    jest.spyOn(configService, 'get').mockReturnValue('https://pokeapi.co/api/v2');
    jest.spyOn(httpService, 'get').mockReturnValue(of(mockResponse));

    const result = await repository.getPokemonList(limit, offset);

    expect(result).toEqual([mockPokemon]);
    expect(httpService.get).toHaveBeenCalledWith(
      'https://pokeapi.co/api/v2/pokemon?limit=20&offset=0',
    );
  });

  it('should get pokemon by id', async () => {
    const id = 1;
    const mockResponse: AxiosResponse = {
      data: mockPokemon,
      status: 200,
      statusText: 'OK',
      headers: {},
      config: {} as any,
    };

    jest.spyOn(configService, 'get').mockReturnValue('https://pokeapi.co/api/v2');
    jest.spyOn(httpService, 'get').mockReturnValue(of(mockResponse));

    const result = await repository.getPokemonById(id);

    expect(result).toEqual(mockPokemon);
    expect(httpService.get).toHaveBeenCalledWith('https://pokeapi.co/api/v2/pokemon/1');
  });

  it('should search pokemon', async () => {
    const query = 'bulba';
    const mockResponse: AxiosResponse = {
      data: {
        count: 1,
        next: null,
        previous: null,
        results: [
          {
            name: 'bulbasaur',
            url: 'https://pokeapi.co/api/v2/pokemon/1/',
          },
        ],
      },
      status: 200,
      statusText: 'OK',
      headers: {},
      config: {} as any,
    };

    jest.spyOn(configService, 'get').mockReturnValue('https://pokeapi.co/api/v2');
    jest.spyOn(httpService, 'get').mockReturnValue(of(mockResponse));

    const result = await repository.searchPokemon(query);

    expect(result).toEqual([mockPokemon]);
    expect(httpService.get).toHaveBeenCalledWith(
      'https://pokeapi.co/api/v2/pokemon?limit=151&offset=0',
    );
  });

  it('should get pokemons by type', async () => {
    const type = 'grass';
    const mockResponse: AxiosResponse = {
      data: {
        pokemon: [
          {
            pokemon: {
              name: 'bulbasaur',
              url: 'https://pokeapi.co/api/v2/pokemon/1/',
            },
            slot: 1,
          },
        ],
      },
      status: 200,
      statusText: 'OK',
      headers: {},
      config: {} as any,
    };

    jest.spyOn(configService, 'get').mockReturnValue('https://pokeapi.co/api/v2');
    jest.spyOn(httpService, 'get').mockReturnValue(of(mockResponse));

    const result = await repository.getPokemonsByType(type);

    expect(result).toEqual([mockPokemon]);
    expect(httpService.get).toHaveBeenCalledWith('https://pokeapi.co/api/v2/type/grass');
  });

  it('should get pokemons by ability', async () => {
    const ability = 'overgrow';
    const mockResponse: AxiosResponse = {
      data: {
        pokemon: [
          {
            pokemon: {
              name: 'bulbasaur',
              url: 'https://pokeapi.co/api/v2/pokemon/1/',
            },
            isHidden: false,
            slot: 1,
          },
        ],
      },
      status: 200,
      statusText: 'OK',
      headers: {},
      config: {} as any,
    };

    jest.spyOn(configService, 'get').mockReturnValue('https://pokeapi.co/api/v2');
    jest.spyOn(httpService, 'get').mockReturnValue(of(mockResponse));

    const result = await repository.getPokemonsByAbility(ability);

    expect(result).toEqual([mockPokemon]);
    expect(httpService.get).toHaveBeenCalledWith('https://pokeapi.co/api/v2/ability/overgrow');
  });
});
