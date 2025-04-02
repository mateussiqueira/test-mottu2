import { HttpService } from '@nestjs/axios';
import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { firstValueFrom } from 'rxjs';
import { Pokemon } from '../../domain/entities/pokemon.entity';
import { PokemonRepository } from '../../domain/repositories/pokemon.repository';

@Injectable()
export class PokemonRepositoryImpl implements PokemonRepository {
  constructor(
    private readonly httpService: HttpService,
    private readonly configService: ConfigService,
  ) {}

  private get baseUrl(): string {
    return this.configService.get<string>('POKEAPI_BASE_URL');
  }

  async getPokemonList(limit: number, offset: number): Promise<Pokemon[]> {
    const response = await firstValueFrom(
      this.httpService.get(`${this.baseUrl}/pokemon?limit=${limit}&offset=${offset}`),
    );

    const pokemonPromises = response.data.results.map(async (result: any) => {
      const pokemonResponse = await firstValueFrom(this.httpService.get(result.url));
      return this.mapToPokemon(pokemonResponse.data);
    });

    return Promise.all(pokemonPromises);
  }

  async getPokemonById(id: number): Promise<Pokemon> {
    const response = await firstValueFrom(this.httpService.get(`${this.baseUrl}/pokemon/${id}`));
    return this.mapToPokemon(response.data);
  }

  async searchPokemon(query: string): Promise<Pokemon[]> {
    const response = await firstValueFrom(
      this.httpService.get(`${this.baseUrl}/pokemon?limit=1000`),
    );

    const filteredResults = response.data.results.filter((result: any) =>
      result.name.toLowerCase().includes(query.toLowerCase()),
    );

    const pokemonPromises = filteredResults.map(async (result: any) => {
      const pokemonResponse = await firstValueFrom(this.httpService.get(result.url));
      return this.mapToPokemon(pokemonResponse.data);
    });

    return Promise.all(pokemonPromises);
  }

  async getPokemonsByType(type: string): Promise<Pokemon[]> {
    const response = await firstValueFrom(this.httpService.get(`${this.baseUrl}/type/${type}`));

    const pokemonPromises = response.data.pokemon.map(async (result: any) => {
      const pokemonResponse = await firstValueFrom(this.httpService.get(result.pokemon.url));
      return this.mapToPokemon(pokemonResponse.data);
    });

    return Promise.all(pokemonPromises);
  }

  async getPokemonsByAbility(ability: string): Promise<Pokemon[]> {
    const response = await firstValueFrom(
      this.httpService.get(`${this.baseUrl}/ability/${ability}`),
    );

    const pokemonPromises = response.data.pokemon.map(async (result: any) => {
      const pokemonResponse = await firstValueFrom(this.httpService.get(result.pokemon.url));
      return this.mapToPokemon(pokemonResponse.data);
    });

    return Promise.all(pokemonPromises);
  }

  private mapToPokemon(data: any): Pokemon {
    return {
      id: data.id,
      name: data.name,
      baseExperience: data.base_experience,
      height: data.height,
      weight: data.weight,
      sprites: {
        frontDefault: data.sprites.front_default,
        backDefault: data.sprites.back_default,
        frontShiny: data.sprites.front_shiny,
        backShiny: data.sprites.back_shiny,
      },
      types: data.types.map((type: any) => ({
        slot: type.slot,
        type: {
          name: type.type.name,
          url: type.type.url,
        },
      })),
      abilities: data.abilities.map((ability: any) => ({
        ability: {
          name: ability.ability.name,
          url: ability.ability.url,
        },
        isHidden: ability.is_hidden,
        slot: ability.slot,
      })),
      stats: data.stats.map((stat: any) => ({
        baseStat: stat.base_stat,
        effort: stat.effort,
        stat: {
          name: stat.stat.name,
          url: stat.stat.url,
        },
      })),
      moves: data.moves.map((move: any) => ({
        move: {
          name: move.move.name,
          url: move.move.url,
        },
        versionGroupDetails: move.version_group_details.map((detail: any) => ({
          levelLearnedAt: detail.level_learned_at,
          moveLearnMethod: {
            name: detail.move_learn_method.name,
            url: detail.move_learn_method.url,
          },
          versionGroup: {
            name: detail.version_group.name,
            url: detail.version_group.url,
          },
        })),
      })),
      species: {
        name: data.species.name,
        url: data.species.url,
      },
    };
  }
}
