import {
  Controller,
  Get,
  HttpException,
  HttpStatus,
  Param,
  Query,
} from '@nestjs/common';
import { PokemonResponse } from './interfaces/pokemon.interface';
import { PokemonService } from './pokemon.service';

@Controller('pokemon')
export class PokemonController {
  constructor(private readonly pokemonService: PokemonService) {}

  @Get()
  async getPokemonList(
    @Query('limit') limit?: number,
    @Query('offset') offset?: number,
  ): Promise<PokemonResponse[]> {
    try {
      const pokemons = await this.pokemonService.getPokemonList(limit, offset);
      if (!Array.isArray(pokemons)) {
        throw new HttpException(
          'Invalid response from Pokemon service',
          HttpStatus.INTERNAL_SERVER_ERROR,
        );
      }
      return pokemons;
    } catch (error: unknown) {
      if (error instanceof HttpException) {
        throw error;
      }
      throw new HttpException(
        'Failed to fetch Pokemon list',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  @Get(':id')
  async getPokemonById(@Param('id') id: string): Promise<PokemonResponse> {
    try {
      const pokemonId = parseInt(id, 10);
      if (isNaN(pokemonId)) {
        throw new HttpException('Invalid Pokemon ID', HttpStatus.BAD_REQUEST);
      }
      const result = await this.pokemonService.getPokemonById(pokemonId);
      if (!result || typeof result !== 'object') {
        throw new HttpException(
          'Invalid response from Pokemon service',
          HttpStatus.INTERNAL_SERVER_ERROR,
        );
      }
      return result;
    } catch (error: unknown) {
      if (error instanceof HttpException) {
        throw error;
      }
      throw new HttpException(
        'Failed to fetch Pokemon',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  @Get('search/:query')
  async searchPokemon(
    @Param('query') query: string,
  ): Promise<PokemonResponse[]> {
    try {
      if (!query || query.trim().length === 0) {
        throw new HttpException(
          'Search query is required',
          HttpStatus.BAD_REQUEST,
        );
      }
      const pokemons = await this.pokemonService.searchPokemon(query);
      if (!Array.isArray(pokemons)) {
        throw new HttpException(
          'Invalid response from Pokemon service',
          HttpStatus.INTERNAL_SERVER_ERROR,
        );
      }
      return pokemons;
    } catch (error: unknown) {
      if (error instanceof HttpException) {
        throw error;
      }
      throw new HttpException(
        'Failed to search Pokemon',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}
