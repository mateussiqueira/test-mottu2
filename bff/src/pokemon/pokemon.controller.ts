import { Controller, Get, Param, Query } from '@nestjs/common';
import { PokemonResponse } from './interfaces/pokemon.interface';
import { PokemonService } from './pokemon.service';

@Controller('pokemon')
export class PokemonController {
  constructor(private readonly pokemonService: PokemonService) {}

  @Get()
  async getPokemonList(
    @Query('limit') limit: string = '20',
    @Query('offset') offset: string = '0',
  ): Promise<PokemonResponse[]> {
    return this.pokemonService.getPokemonList(parseInt(limit), parseInt(offset));
  }

  @Get(':id')
  async getPokemonById(@Param('id') id: string): Promise<PokemonResponse> {
    return this.pokemonService.getPokemonById(parseInt(id));
  }

  @Get('search/:query')
  async searchPokemon(@Param('query') query: string): Promise<PokemonResponse[]> {
    return this.pokemonService.searchPokemon(query);
  }

  @Get('type/:type')
  async getPokemonsByType(@Param('type') type: string): Promise<PokemonResponse[]> {
    return this.pokemonService.getPokemonsByType(type);
  }

  @Get('ability/:ability')
  async getPokemonsByAbility(@Param('ability') ability: string): Promise<PokemonResponse[]> {
    return this.pokemonService.getPokemonsByAbility(ability);
  }
}
