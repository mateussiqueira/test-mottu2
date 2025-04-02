import { Controller, Get, Param, Query } from '@nestjs/common';
import { GetPokemonByIdUseCase } from '../../domain/usecases/get-pokemon-by-id.usecase';
import { GetPokemonListUseCase } from '../../domain/usecases/get-pokemon-list.usecase';
import { GetPokemonsByAbilityUseCase } from '../../domain/usecases/get-pokemons-by-ability.usecase';
import { GetPokemonsByTypeUseCase } from '../../domain/usecases/get-pokemons-by-type.usecase';
import { SearchPokemonUseCase } from '../../domain/usecases/search-pokemon.usecase';
import { PokemonDto } from '../dtos/pokemon.dto';
import { PokemonMapper } from '../mappers/pokemon.mapper';

@Controller('pokemon')
export class PokemonController {
  constructor(
    private readonly getPokemonListUseCase: GetPokemonListUseCase,
    private readonly getPokemonByIdUseCase: GetPokemonByIdUseCase,
    private readonly searchPokemonUseCase: SearchPokemonUseCase,
    private readonly getPokemonsByTypeUseCase: GetPokemonsByTypeUseCase,
    private readonly getPokemonsByAbilityUseCase: GetPokemonsByAbilityUseCase,
  ) {}

  @Get()
  async getPokemonList(
    @Query('limit') limit: string = '20',
    @Query('offset') offset: string = '0',
  ): Promise<PokemonDto[]> {
    const pokemons = await this.getPokemonListUseCase.execute(parseInt(limit), parseInt(offset));
    return PokemonMapper.toDtoList(pokemons);
  }

  @Get(':id')
  async getPokemonById(@Param('id') id: string): Promise<PokemonDto> {
    const pokemon = await this.getPokemonByIdUseCase.execute(parseInt(id));
    return PokemonMapper.toDto(pokemon);
  }

  @Get('search/:query')
  async searchPokemon(@Param('query') query: string): Promise<PokemonDto[]> {
    const pokemons = await this.searchPokemonUseCase.execute(query);
    return PokemonMapper.toDtoList(pokemons);
  }

  @Get('type/:type')
  async getPokemonsByType(@Param('type') type: string): Promise<PokemonDto[]> {
    const pokemons = await this.getPokemonsByTypeUseCase.execute(type);
    return PokemonMapper.toDtoList(pokemons);
  }

  @Get('ability/:ability')
  async getPokemonsByAbility(@Param('ability') ability: string): Promise<PokemonDto[]> {
    const pokemons = await this.getPokemonsByAbilityUseCase.execute(ability);
    return PokemonMapper.toDtoList(pokemons);
  }
}
