import { Test, TestingModule } from '@nestjs/testing';
import axios from 'axios';
import { PokemonService } from './pokemon.service';

// Mock axios
jest.mock('axios');
const mockedAxios = axios as jest.Mocked<typeof axios>;

describe('PokemonService', () => {
  let service: PokemonService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [PokemonService],
    }).compile();

    service = module.get<PokemonService>(PokemonService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  describe('getPokemonList', () => {
    it('should return a list of pokemons', async () => {
      const mockResponse = {
        data: {
          results: [
            { name: 'bulbasaur', url: 'https://pokeapi.co/api/v2/pokemon/1/' },
            { name: 'charmander', url: 'https://pokeapi.co/api/v2/pokemon/4/' },
          ],
        },
      };

      const mockPokemonResponse = {
        data: {
          id: 1,
          name: 'bulbasaur',
          types: [{ type: { name: 'grass' } }],
          abilities: [{ ability: { name: 'overgrow' } }],
          height: 7,
          weight: 69,
          base_experience: 64,
          sprites: {
            front_default:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
          },
        },
      };

      mockedAxios.get
        .mockResolvedValueOnce(mockResponse)
        .mockResolvedValueOnce(mockPokemonResponse)
        .mockResolvedValueOnce(mockPokemonResponse);

      const result = await service.getPokemonList(2, 0);

      expect(result).toHaveLength(2);
      expect(result[0]).toEqual({
        id: 1,
        name: 'bulbasaur',
        types: ['grass'],
        abilities: ['overgrow'],
        height: 0.7,
        weight: 6.9,
        baseExperience: 64,
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      });
    });

    it('should handle errors', async () => {
      mockedAxios.get.mockRejectedValueOnce(new Error('API Error'));

      await expect(service.getPokemonList()).rejects.toThrow('API Error');
    });
  });

  describe('getPokemonById', () => {
    it('should return a pokemon by id', async () => {
      const mockResponse = {
        data: {
          id: 1,
          name: 'bulbasaur',
          types: [{ type: { name: 'grass' } }],
          abilities: [{ ability: { name: 'overgrow' } }],
          height: 7,
          weight: 69,
          base_experience: 64,
          sprites: {
            front_default:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
          },
        },
      };

      mockedAxios.get.mockResolvedValueOnce(mockResponse);

      const result = await service.getPokemonById(1);

      expect(result).toEqual({
        id: 1,
        name: 'bulbasaur',
        types: ['grass'],
        abilities: ['overgrow'],
        height: 0.7,
        weight: 6.9,
        baseExperience: 64,
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      });
    });

    it('should handle errors', async () => {
      mockedAxios.get.mockRejectedValueOnce(new Error('API Error'));

      await expect(service.getPokemonById(1)).rejects.toThrow('API Error');
    });
  });

  describe('searchPokemon', () => {
    it('should return pokemons matching the search query', async () => {
      const mockResponse = {
        data: {
          results: [
            { name: 'bulbasaur', url: 'https://pokeapi.co/api/v2/pokemon/1/' },
            { name: 'charmander', url: 'https://pokeapi.co/api/v2/pokemon/4/' },
          ],
        },
      };

      const mockPokemonResponse = {
        data: {
          id: 1,
          name: 'bulbasaur',
          types: [{ type: { name: 'grass' } }],
          abilities: [{ ability: { name: 'overgrow' } }],
          height: 7,
          weight: 69,
          base_experience: 64,
          sprites: {
            front_default:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
          },
        },
      };

      mockedAxios.get
        .mockResolvedValueOnce(mockResponse)
        .mockResolvedValueOnce(mockPokemonResponse)
        .mockResolvedValueOnce(mockPokemonResponse);

      const result = await service.searchPokemon('bulba');

      expect(result).toHaveLength(1);
      expect(result[0]).toEqual({
        id: 1,
        name: 'bulbasaur',
        types: ['grass'],
        abilities: ['overgrow'],
        height: 0.7,
        weight: 6.9,
        baseExperience: 64,
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      });
    });

    it('should handle errors', async () => {
      mockedAxios.get.mockRejectedValueOnce(new Error('API Error'));

      await expect(service.searchPokemon('bulba')).rejects.toThrow('API Error');
    });
  });

  describe('getPokemonsByType', () => {
    it('should return pokemons of a specific type', async () => {
      const mockResponse = {
        data: {
          pokemon: [
            { pokemon: { name: 'bulbasaur', url: 'https://pokeapi.co/api/v2/pokemon/1/' } },
            { pokemon: { name: 'charmander', url: 'https://pokeapi.co/api/v2/pokemon/4/' } },
          ],
        },
      };

      const mockPokemonResponse = {
        data: {
          id: 1,
          name: 'bulbasaur',
          types: [{ type: { name: 'grass' } }],
          abilities: [{ ability: { name: 'overgrow' } }],
          height: 7,
          weight: 69,
          base_experience: 64,
          sprites: {
            front_default:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
          },
        },
      };

      mockedAxios.get
        .mockResolvedValueOnce(mockResponse)
        .mockResolvedValueOnce(mockPokemonResponse)
        .mockResolvedValueOnce(mockPokemonResponse);

      const result = await service.getPokemonsByType('grass');

      expect(result).toHaveLength(2);
      expect(result[0]).toEqual({
        id: 1,
        name: 'bulbasaur',
        types: ['grass'],
        abilities: ['overgrow'],
        height: 0.7,
        weight: 6.9,
        baseExperience: 64,
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      });
    });

    it('should handle errors', async () => {
      mockedAxios.get.mockRejectedValueOnce(new Error('API Error'));

      await expect(service.getPokemonsByType('grass')).rejects.toThrow('API Error');
    });
  });

  describe('getPokemonsByAbility', () => {
    it('should return pokemons with a specific ability', async () => {
      const mockResponse = {
        data: {
          pokemon: [
            { pokemon: { name: 'bulbasaur', url: 'https://pokeapi.co/api/v2/pokemon/1/' } },
            { pokemon: { name: 'charmander', url: 'https://pokeapi.co/api/v2/pokemon/4/' } },
          ],
        },
      };

      const mockPokemonResponse = {
        data: {
          id: 1,
          name: 'bulbasaur',
          types: [{ type: { name: 'grass' } }],
          abilities: [{ ability: { name: 'overgrow' } }],
          height: 7,
          weight: 69,
          base_experience: 64,
          sprites: {
            front_default:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
          },
        },
      };

      mockedAxios.get
        .mockResolvedValueOnce(mockResponse)
        .mockResolvedValueOnce(mockPokemonResponse)
        .mockResolvedValueOnce(mockPokemonResponse);

      const result = await service.getPokemonsByAbility('overgrow');

      expect(result).toHaveLength(2);
      expect(result[0]).toEqual({
        id: 1,
        name: 'bulbasaur',
        types: ['grass'],
        abilities: ['overgrow'],
        height: 0.7,
        weight: 6.9,
        baseExperience: 64,
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      });
    });

    it('should handle errors', async () => {
      mockedAxios.get.mockRejectedValueOnce(new Error('API Error'));

      await expect(service.getPokemonsByAbility('overgrow')).rejects.toThrow('API Error');
    });
  });
});
