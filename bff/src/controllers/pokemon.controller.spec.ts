import { Test, TestingModule } from '@nestjs/testing';
import { PokemonService } from '../services/pokemon.service';
import { PokemonController } from './pokemon.controller';

describe('PokemonController', () => {
  let controller: PokemonController;
  let service: PokemonService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [PokemonController],
      providers: [PokemonService],
    }).compile();

    controller = module.get<PokemonController>(PokemonController);
    service = module.get<PokemonService>(PokemonService);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  describe('getPokemonList', () => {
    it('should return a list of pokemons', async () => {
      const result = await controller.getPokemonList('20', '0');
      expect(result).toBeDefined();
    });
  });

  describe('getPokemonById', () => {
    it('should return a pokemon by id', async () => {
      const result = await controller.getPokemonById('1');
      expect(result).toBeDefined();
    });
  });

  describe('searchPokemon', () => {
    it('should return pokemons matching the search query', async () => {
      const result = await controller.searchPokemon('bulba');
      expect(result).toBeDefined();
    });
  });

  describe('getPokemonsByType', () => {
    it('should return pokemons of a specific type', async () => {
      const result = await controller.getPokemonsByType('grass');
      expect(result).toBeDefined();
    });
  });

  describe('getPokemonsByAbility', () => {
    it('should return pokemons with a specific ability', async () => {
      const result = await controller.getPokemonsByAbility('overgrow');
      expect(result).toBeDefined();
    });
  });
});
