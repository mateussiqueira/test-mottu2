import { Test, TestingModule } from '@nestjs/testing';
import { GetPokemonByIdUseCase } from './get-pokemon-by-id.usecase';
import { GetPokemonListUseCase } from './get-pokemon-list.usecase';
import { GetPokemonsByAbilityUseCase } from './get-pokemons-by-ability.usecase';
import { GetPokemonsByTypeUseCase } from './get-pokemons-by-type.usecase';
import { PokemonController } from './pokemon.controller';
import { PokemonModule } from './pokemon.module';
import { PokemonRepositoryImpl } from './pokemon.repository.impl';
import { PokemonService } from './pokemon.service';
import { SearchPokemonUseCase } from './search-pokemon.usecase';

describe('PokemonModule', () => {
  let module: TestingModule;

  beforeEach(async () => {
    module = await Test.createTestingModule({
      imports: [PokemonModule],
    }).compile();
  });

  it('should be defined', () => {
    expect(module).toBeDefined();
  });

  it('should provide PokemonController', () => {
    const controller = module.get<PokemonController>(PokemonController);
    expect(controller).toBeDefined();
  });

  it('should provide PokemonService', () => {
    const service = module.get<PokemonService>(PokemonService);
    expect(service).toBeDefined();
  });

  it('should provide PokemonRepositoryImpl', () => {
    const repository = module.get<PokemonRepositoryImpl>('PokemonRepository');
    expect(repository).toBeDefined();
  });

  it('should provide GetPokemonListUseCase', () => {
    const useCase = module.get<GetPokemonListUseCase>(GetPokemonListUseCase);
    expect(useCase).toBeDefined();
  });

  it('should provide GetPokemonByIdUseCase', () => {
    const useCase = module.get<GetPokemonByIdUseCase>(GetPokemonByIdUseCase);
    expect(useCase).toBeDefined();
  });

  it('should provide SearchPokemonUseCase', () => {
    const useCase = module.get<SearchPokemonUseCase>(SearchPokemonUseCase);
    expect(useCase).toBeDefined();
  });

  it('should provide GetPokemonsByTypeUseCase', () => {
    const useCase = module.get<GetPokemonsByTypeUseCase>(GetPokemonsByTypeUseCase);
    expect(useCase).toBeDefined();
  });

  it('should provide GetPokemonsByAbilityUseCase', () => {
    const useCase = module.get<GetPokemonsByAbilityUseCase>(GetPokemonsByAbilityUseCase);
    expect(useCase).toBeDefined();
  });
});
