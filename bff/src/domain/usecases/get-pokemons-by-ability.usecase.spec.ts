import { Test, TestingModule } from '@nestjs/testing';
import { Pokemon } from '../entities/pokemon.entity';
import { PokemonRepository } from '../repositories/pokemon.repository';
import { GetPokemonsByAbilityUseCase } from './get-pokemons-by-ability.usecase';

describe('GetPokemonsByAbilityUseCase', () => {
  let useCase: GetPokemonsByAbilityUseCase;
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
    getPokemonsByAbility: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        GetPokemonsByAbilityUseCase,
        {
          provide: 'PokemonRepository',
          useValue: mockRepository,
        },
      ],
    }).compile();

    useCase = module.get<GetPokemonsByAbilityUseCase>(GetPokemonsByAbilityUseCase);
    repository = module.get<PokemonRepository>('PokemonRepository');
  });

  it('should be defined', () => {
    expect(useCase).toBeDefined();
  });

  it('should get pokemons by ability', async () => {
    const ability = 'overgrow';
    const expectedPokemons = [mockPokemon];

    mockRepository.getPokemonsByAbility.mockResolvedValue(expectedPokemons);

    const result = await useCase.execute(ability);

    expect(result).toEqual(expectedPokemons);
    expect(mockRepository.getPokemonsByAbility).toHaveBeenCalledWith(ability);
  });
});
