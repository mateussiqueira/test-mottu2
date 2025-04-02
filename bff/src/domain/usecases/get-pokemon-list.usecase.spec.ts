import { Test, TestingModule } from '@nestjs/testing';
import { Pokemon } from '../entities/pokemon.entity';
import { PokemonRepository } from '../repositories/pokemon.repository';
import { GetPokemonListUseCase } from './get-pokemon-list.usecase';

describe('GetPokemonListUseCase', () => {
  let useCase: GetPokemonListUseCase;
  let repository: PokemonRepository;

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

  const mockRepository = {
    getPokemonList: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        GetPokemonListUseCase,
        {
          provide: 'PokemonRepository',
          useValue: mockRepository,
        },
      ],
    }).compile();

    useCase = module.get<GetPokemonListUseCase>(GetPokemonListUseCase);
    repository = module.get<PokemonRepository>('PokemonRepository');
  });

  it('should be defined', () => {
    expect(useCase).toBeDefined();
  });

  it('should get pokemon list', async () => {
    const limit = 20;
    const offset = 0;
    const expectedPokemons = [mockPokemon];

    mockRepository.getPokemonList.mockResolvedValue(expectedPokemons);

    const result = await useCase.execute(limit, offset);

    expect(result).toEqual(expectedPokemons);
    expect(mockRepository.getPokemonList).toHaveBeenCalledWith(limit, offset);
  });
});
