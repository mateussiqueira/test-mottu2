import { Request, Response } from 'express';
import { PokemonController } from './controllers/pokemon.controller';
import { PokemonService } from './services/pokemon.service';

// Mock the PokemonService
jest.mock('./services/pokemon.service');

describe('PokemonController', () => {
  let controller: PokemonController;
  let mockService: jest.Mocked<PokemonService>;
  let mockReq: Partial<Request>;
  let mockRes: Partial<Response>;

  beforeEach(() => {
    mockService = new PokemonService() as jest.Mocked<PokemonService>;
    controller = new PokemonController(mockService);
    mockReq = {
      query: {},
      params: {},
    };
    mockRes = {
      json: jest.fn(),
      status: jest.fn().mockReturnThis(),
    };
  });

  describe('getPokemonList', () => {
    it('should return pokemon list with default pagination', async () => {
      const mockPokemons = [
        { id: 1, name: 'bulbasaur', types: ['grass'], abilities: ['overgrow'], height: 0.7, weight: 6.9, baseExperience: 64, imageUrl: 'url' },
      ];
      mockService.getPokemonList.mockResolvedValue(mockPokemons);

      await controller.getPokemonList(mockReq as Request, mockRes as Response);

      expect(mockService.getPokemonList).toHaveBeenCalledWith(20, 0);
      expect(mockRes.json).toHaveBeenCalledWith(mockPokemons);
    });

    it('should handle errors', async () => {
      mockService.getPokemonList.mockRejectedValue(new Error('API Error'));

      await controller.getPokemonList(mockReq as Request, mockRes as Response);

      expect(mockRes.status).toHaveBeenCalledWith(500);
      expect(mockRes.json).toHaveBeenCalledWith({ error: 'Internal server error' });
    });
  });

  describe('getPokemonById', () => {
    it('should return pokemon by id', async () => {
      const mockPokemon = { id: 1, name: 'bulbasaur', types: ['grass'], abilities: ['overgrow'], height: 0.7, weight: 6.9, baseExperience: 64, imageUrl: 'url' };
      mockService.getPokemonById.mockResolvedValue(mockPokemon);
      mockReq = { params: { id: '1' } };

      await controller.getPokemonById(mockReq as Request, mockRes as Response);

      expect(mockService.getPokemonById).toHaveBeenCalledWith(1);
      expect(mockRes.json).toHaveBeenCalledWith(mockPokemon);
    });

    it('should handle errors', async () => {
      mockService.getPokemonById.mockRejectedValue(new Error('API Error'));
      mockReq = { params: { id: '1' } };

      await controller.getPokemonById(mockReq as Request, mockRes as Response);

      expect(mockRes.status).toHaveBeenCalledWith(500);
      expect(mockRes.json).toHaveBeenCalledWith({ error: 'Internal server error' });
    });
  });

  describe('searchPokemon', () => {
    it('should return pokemons matching search query', async () => {
      const mockPokemons = [
        { id: 25, name: 'pikachu', types: ['electric'], abilities: ['static'], height: 0.4, weight: 6.0, baseExperience: 112, imageUrl: 'url' },
      ];
      mockService.searchPokemon.mockResolvedValue(mockPokemons);
      mockReq = { query: { q: 'pikachu' } };

      await controller.searchPokemon(mockReq as Request, mockRes as Response);

      expect(mockService.searchPokemon).toHaveBeenCalledWith('pikachu');
      expect(mockRes.json).toHaveBeenCalledWith(mockPokemons);
    });

    it('should return 400 if query is missing', async () => {
      mockReq = { query: {} };

      await controller.searchPokemon(mockReq as Request, mockRes as Response);

      expect(mockRes.status).toHaveBeenCalledWith(400);
      expect(mockRes.json).toHaveBeenCalledWith({ error: 'Query parameter is required' });
    });

    it('should handle errors', async () => {
      mockService.searchPokemon.mockRejectedValue(new Error('API Error'));
      mockReq = { query: { q: 'pikachu' } };

      await controller.searchPokemon(mockReq as Request, mockRes as Response);

      expect(mockRes.status).toHaveBeenCalledWith(500);
      expect(mockRes.json).toHaveBeenCalledWith({ error: 'Internal server error' });
    });
  });

  describe('getPokemonsByType', () => {
    it('should return pokemons by type', async () => {
      const mockPokemons = [
        { id: 4, name: 'charmander', types: ['fire'], abilities: ['blaze'], height: 0.6, weight: 8.5, baseExperience: 62, imageUrl: 'url' },
      ];
      mockService.getPokemonsByType.mockResolvedValue(mockPokemons);
      mockReq = { params: { type: 'fire' } };

      await controller.getPokemonsByType(mockReq as Request, mockRes as Response);

      expect(mockService.getPokemonsByType).toHaveBeenCalledWith('fire');
      expect(mockRes.json).toHaveBeenCalledWith(mockPokemons);
    });

    it('should handle errors', async () => {
      mockService.getPokemonsByType.mockRejectedValue(new Error('API Error'));
      mockReq = { params: { type: 'fire' } };

      await controller.getPokemonsByType(mockReq as Request, mockRes as Response);

      expect(mockRes.status).toHaveBeenCalledWith(500);
      expect(mockRes.json).toHaveBeenCalledWith({ error: 'Internal server error' });
    });
  });

  describe('getPokemonsByAbility', () => {
    it('should return pokemons by ability', async () => {
      const mockPokemons = [
        { id: 1, name: 'bulbasaur', types: ['grass'], abilities: ['overgrow'], height: 0.7, weight: 6.9, baseExperience: 64, imageUrl: 'url' },
      ];
      mockService.getPokemonsByAbility.mockResolvedValue(mockPokemons);
      mockReq = { params: { ability: 'overgrow' } };

      await controller.getPokemonsByAbility(mockReq as Request, mockRes as Response);

      expect(mockService.getPokemonsByAbility).toHaveBeenCalledWith('overgrow');
      expect(mockRes.json).toHaveBeenCalledWith(mockPokemons);
    });

    it('should handle errors', async () => {
      mockService.getPokemonsByAbility.mockRejectedValue(new Error('API Error'));
      mockReq = { params: { ability: 'overgrow' } };

      await controller.getPokemonsByAbility(mockReq as Request, mockRes as Response);

      expect(mockRes.status).toHaveBeenCalledWith(500);
      expect(mockRes.json).toHaveBeenCalledWith({ error: 'Internal server error' });
    });
  });
});
