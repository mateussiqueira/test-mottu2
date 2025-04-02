import { HttpService } from '@nestjs/axios';
import { Injectable, InternalServerErrorException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { AxiosError, AxiosResponse } from 'axios';
import { firstValueFrom } from 'rxjs';
import { PokemonResponse } from './interfaces/pokemon.interface';

interface PokemonApiResponse {
  id: number;
  name: string;
  types: Array<{ type: { name: string } }>;
  abilities: Array<{ ability: { name: string } }>;
  height: number;
  weight: number;
  base_experience: number;
  sprites: {
    other: {
      'official-artwork': {
        front_default: string;
      };
    };
  };
  stats: Array<{
    base_stat: number;
  }>;
}

interface PokemonListResponse {
  results: Array<{
    name: string;
    url: string;
  }>;
}

interface PokemonStats {
  hp: number;
  attack: number;
  defense: number;
  specialAttack: number;
  specialDefense: number;
  speed: number;
}

@Injectable()
export class PokemonService {
  private readonly baseUrl: string;

  constructor(
    private readonly httpService: HttpService,
    private readonly configService: ConfigService,
  ) {
    this.baseUrl = this.configService.get<string>('POKEAPI_URL', 'https://pokeapi.co/api/v2');
  }

  async getPokemonList(limit = 20, offset = 0): Promise<PokemonResponse[]> {
    try {
      const response = await firstValueFrom<AxiosResponse<PokemonListResponse>>(
        this.httpService.get<PokemonListResponse>(
          `${this.baseUrl}/pokemon?limit=${limit}&offset=${offset}`,
        ),
      );

      if (!response?.data?.results) {
        throw new InternalServerErrorException('Invalid response from Pokemon API');
      }

      const pokemons = await Promise.all(
        response.data.results.map(async pokemon => {
          const detailResponse = await firstValueFrom<AxiosResponse<PokemonApiResponse>>(
            this.httpService.get<PokemonApiResponse>(pokemon.url),
          );

          if (!detailResponse?.data) {
            throw new InternalServerErrorException('Invalid response from Pokemon API');
          }

          return this.transformPokemonData(detailResponse.data);
        }),
      );

      return pokemons;
    } catch (error) {
      if (error instanceof AxiosError) {
        throw new InternalServerErrorException(`Failed to fetch Pokemon list: ${error.message}`);
      }
      if (error instanceof InternalServerErrorException) {
        throw error;
      }
      throw new InternalServerErrorException('Failed to fetch Pokemon list');
    }
  }

  async getPokemonById(id: number): Promise<PokemonResponse> {
    try {
      const response = await firstValueFrom<AxiosResponse<PokemonApiResponse>>(
        this.httpService.get<PokemonApiResponse>(`${this.baseUrl}/pokemon/${id}`),
      );

      if (!response?.data) {
        throw new InternalServerErrorException('Invalid response from Pokemon API');
      }

      return this.transformPokemonData(response.data);
    } catch (error) {
      if (error instanceof AxiosError) {
        throw new InternalServerErrorException(
          `Failed to fetch Pokemon with id ${id}: ${error.message}`,
        );
      }
      if (error instanceof InternalServerErrorException) {
        throw error;
      }
      throw new InternalServerErrorException(`Failed to fetch Pokemon with id ${id}`);
    }
  }

  async searchPokemon(query: string): Promise<PokemonResponse[]> {
    try {
      const response = await firstValueFrom<AxiosResponse<PokemonListResponse>>(
        this.httpService.get<PokemonListResponse>(`${this.baseUrl}/pokemon?limit=1118`),
      );

      if (!response?.data?.results) {
        throw new InternalServerErrorException('Invalid response from Pokemon API');
      }

      const filteredPokemons = response.data.results
        .filter(pokemon => pokemon.name.toLowerCase().includes(query.toLowerCase()))
        .slice(0, 20);

      const pokemons = await Promise.all(
        filteredPokemons.map(async pokemon => {
          const detailResponse = await firstValueFrom<AxiosResponse<PokemonApiResponse>>(
            this.httpService.get<PokemonApiResponse>(pokemon.url),
          );

          if (!detailResponse?.data) {
            throw new InternalServerErrorException('Invalid response from Pokemon API');
          }

          return this.transformPokemonData(detailResponse.data);
        }),
      );

      return pokemons;
    } catch (error) {
      if (error instanceof AxiosError) {
        throw new InternalServerErrorException(
          `Failed to search Pokemon with query ${query}: ${error.message}`,
        );
      }
      if (error instanceof InternalServerErrorException) {
        throw error;
      }
      throw new InternalServerErrorException(`Failed to search Pokemon with query ${query}`);
    }
  }

  async getPokemonsByType(type: string): Promise<PokemonResponse[]> {
    try {
      const response = await firstValueFrom<
        AxiosResponse<{ pokemon: Array<{ pokemon: { url: string } }> }>
      >(this.httpService.get(`${this.baseUrl}/type/${type}`));

      if (!response?.data?.pokemon) {
        throw new InternalServerErrorException('Invalid response from Pokemon API');
      }

      const pokemons = await Promise.all(
        response.data.pokemon.slice(0, 20).map(async ({ pokemon }) => {
          const detailResponse = await firstValueFrom<AxiosResponse<PokemonApiResponse>>(
            this.httpService.get<PokemonApiResponse>(pokemon.url),
          );

          if (!detailResponse?.data) {
            throw new InternalServerErrorException('Invalid response from Pokemon API');
          }

          return this.transformPokemonData(detailResponse.data);
        }),
      );

      return pokemons;
    } catch (error) {
      if (error instanceof AxiosError) {
        throw new InternalServerErrorException(
          `Failed to fetch Pokemon by type ${type}: ${error.message}`,
        );
      }
      if (error instanceof InternalServerErrorException) {
        throw error;
      }
      throw new InternalServerErrorException(`Failed to fetch Pokemon by type ${type}`);
    }
  }

  async getPokemonsByAbility(ability: string): Promise<PokemonResponse[]> {
    try {
      const response = await firstValueFrom<
        AxiosResponse<{ pokemon: Array<{ pokemon: { url: string } }> }>
      >(this.httpService.get(`${this.baseUrl}/ability/${ability}`));

      if (!response?.data?.pokemon) {
        throw new InternalServerErrorException('Invalid response from Pokemon API');
      }

      const pokemons = await Promise.all(
        response.data.pokemon.slice(0, 20).map(async ({ pokemon }) => {
          const detailResponse = await firstValueFrom<AxiosResponse<PokemonApiResponse>>(
            this.httpService.get<PokemonApiResponse>(pokemon.url),
          );

          if (!detailResponse?.data) {
            throw new InternalServerErrorException('Invalid response from Pokemon API');
          }

          return this.transformPokemonData(detailResponse.data);
        }),
      );

      return pokemons;
    } catch (error) {
      if (error instanceof AxiosError) {
        throw new InternalServerErrorException(
          `Failed to fetch Pokemon by ability ${ability}: ${error.message}`,
        );
      }
      if (error instanceof InternalServerErrorException) {
        throw error;
      }
      throw new InternalServerErrorException(`Failed to fetch Pokemon by ability ${ability}`);
    }
  }

  private transformPokemonData(data: PokemonApiResponse): PokemonResponse {
    return {
      id: data.id,
      name: data.name,
      types: data.types.map(type => type.type.name),
      abilities: data.abilities.map(ability => ability.ability.name),
      height: data.height / 10,
      weight: data.weight / 10,
      baseExperience: data.base_experience || 0,
      imageUrl: data.sprites.other['official-artwork'].front_default,
    };
  }
}
