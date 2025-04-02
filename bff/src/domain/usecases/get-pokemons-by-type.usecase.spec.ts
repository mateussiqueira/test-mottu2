import { Test, TestingModule } from '@nestjs/testing';
import { Pokemon } from '../entities/pokemon.entity';
import { PokemonRepository } from '../repositories/pokemon.repository';
import { GetPokemonsByTypeUseCase } from './get-pokemons-by-type.usecase';

describe('GetPokemonsByTypeUseCase', () => {
  let useCase: GetPokemonsByTypeUseCase;
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
    getPokemonsByType: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        GetPokemonsByTypeUseCase,
        {
          provide: 'PokemonRepository',
          useValue: mockRepository,
        },
      ],
    }).compile();

    useCase = module.get<GetPokemonsByTypeUseCase>(GetPokemonsByTypeUseCase);
    repository = module.get<PokemonRepository>('PokemonRepository');
  });

  it('should be defined', () => {
    expect(useCase).toBeDefined();
  });

  it('should get pokemons by type', async () => {
    const type = 'grass';
    const expectedPokemons = [mockPokemon];

    mockRepository.getPokemonsByType.mockResolvedValue(expectedPokemons);

    const result = await useCase.execute(type);

    expect(result).toEqual(expectedPokemons);
    expect(mockRepository.getPokemonsByType).toHaveBeenCalledWith(type);
  });
});
