import { Test, TestingModule } from '@nestjs/testing';
import { PokemonResponse } from './interfaces/pokemon.interface';
import { PokemonController } from './pokemon.controller';
import { PokemonService } from './pokemon.service';

describe('PokemonController', () => {
  let controller: PokemonController;

  const mockPokemonService = {
    getPokemonList: jest.fn(),
    getPokemonById: jest.fn(),
    searchPokemon: jest.fn(),
  };

  const mockPokemon: PokemonResponse = {
    id: 1,
    name: 'bulbasaur',
    types: ['grass', 'poison'],
    abilities: ['overgrow', 'chlorophyll'],
    height: 0.7,
    weight: 6.9,
    baseExperience: 64,
    imageUrl:
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
    stats: {
      hp: 45,
      attack: 49,
      defense: 49,
      specialAttack: 65,
      specialDefense: 65,
      speed: 45,
    },
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [PokemonController],
      providers: [
        {
          provide: PokemonService,
          useValue: mockPokemonService,
        },
      ],
    }).compile();

    controller = module.get<PokemonController>(PokemonController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  describe('getPokemonList', () => {
    it('should return an array of pokemon', async () => {
      const result = [mockPokemon];
      mockPokemonService.getPokemonList.mockResolvedValue(result);

      expect(await controller.getPokemonList(20, 0)).toBe(result);
      expect(mockPokemonService.getPokemonList).toHaveBeenCalledWith(20, 0);
    });
  });

  describe('getPokemonById', () => {
    it('should return a pokemon by id', async () => {
      mockPokemonService.getPokemonById.mockResolvedValue(mockPokemon);

      expect(await controller.getPokemonById('1')).toBe(mockPokemon);
      expect(mockPokemonService.getPokemonById).toHaveBeenCalledWith(1);
    });
  });

  describe('searchPokemon', () => {
    it('should return an array of pokemon matching the search query', async () => {
      const result = [mockPokemon];
      mockPokemonService.searchPokemon.mockResolvedValue(result);

      expect(await controller.searchPokemon('bulbasaur')).toBe(result);
      expect(mockPokemonService.searchPokemon).toHaveBeenCalledWith(
        'bulbasaur',
      );
    });
  });
});
