import axios from 'axios';

interface PokemonResponse {
  id: number;
  name: string;
  types: { type: { name: string } }[];
  abilities: { ability: { name: string } }[];
  height: number;
  weight: number;
  base_experience: number;
  sprites: {
    front_default: string;
  };
}

interface PokemonListResponse {
  results: Array<{
    name: string;
    url: string;
  }>;
}

interface PokemonTypeResponse {
  pokemon: Array<{
    pokemon: {
      name: string;
      url: string;
    };
  }>;
}

interface PokemonAbilityResponse {
  pokemon: Array<{
    pokemon: {
      name: string;
      url: string;
    };
  }>;
}

export class PokemonService {
  private readonly baseUrl = 'https://pokeapi.co/api/v2';

  async getPokemonList(limit = 20, offset = 0): Promise<any[]> {
    try {
      const response = await axios.get<PokemonListResponse>(
        `${this.baseUrl}/pokemon?limit=${limit}&offset=${offset}`,
      );

      const pokemons = await Promise.all(
        response.data.results.map(async pokemon => {
          const id = parseInt(pokemon.url.split('/').slice(-2)[0]);
          const detailResponse = await axios.get<PokemonResponse>(`${this.baseUrl}/pokemon/${id}`);
          return this.transformPokemonResponse(detailResponse.data);
        }),
      );

      return pokemons;
    } catch (error) {
      console.error('Error fetching pokemon list:', error);
      throw error;
    }
  }

  async getPokemonById(id: number): Promise<any> {
    try {
      const response = await axios.get<PokemonResponse>(`${this.baseUrl}/pokemon/${id}`);
      return this.transformPokemonResponse(response.data);
    } catch (error) {
      console.error(`Error fetching pokemon with id ${id}:`, error);
      throw error;
    }
  }

  async searchPokemon(query: string): Promise<any[]> {
    try {
      const response = await axios.get<PokemonListResponse>(`${this.baseUrl}/pokemon?limit=1000`);

      const filteredPokemons = response.data.results
        .filter(pokemon => pokemon.name.toLowerCase().includes(query.toLowerCase()))
        .slice(0, 20);

      const pokemons = await Promise.all(
        filteredPokemons.map(async pokemon => {
          const id = parseInt(pokemon.url.split('/').slice(-2)[0]);
          const detailResponse = await axios.get<PokemonResponse>(`${this.baseUrl}/pokemon/${id}`);
          return this.transformPokemonResponse(detailResponse.data);
        }),
      );

      return pokemons;
    } catch (error) {
      console.error('Error searching pokemon:', error);
      throw error;
    }
  }

  async getPokemonsByType(type: string): Promise<any[]> {
    try {
      const response = await axios.get<PokemonTypeResponse>(`${this.baseUrl}/type/${type}`);

      const pokemons = await Promise.all(
        response.data.pokemon.slice(0, 20).map(async ({ pokemon }) => {
          const id = parseInt(pokemon.url.split('/').slice(-2)[0]);
          const detailResponse = await axios.get<PokemonResponse>(`${this.baseUrl}/pokemon/${id}`);
          return this.transformPokemonResponse(detailResponse.data);
        }),
      );

      return pokemons;
    } catch (error) {
      console.error(`Error fetching pokemons by type ${type}:`, error);
      throw error;
    }
  }

  async getPokemonsByAbility(ability: string): Promise<any[]> {
    try {
      const response = await axios.get<PokemonAbilityResponse>(
        `${this.baseUrl}/ability/${ability}`,
      );

      const pokemons = await Promise.all(
        response.data.pokemon.slice(0, 20).map(async ({ pokemon }) => {
          const id = parseInt(pokemon.url.split('/').slice(-2)[0]);
          const detailResponse = await axios.get<PokemonResponse>(`${this.baseUrl}/pokemon/${id}`);
          return this.transformPokemonResponse(detailResponse.data);
        }),
      );

      return pokemons;
    } catch (error) {
      console.error(`Error fetching pokemons by ability ${ability}:`, error);
      throw error;
    }
  }

  private transformPokemonResponse(data: PokemonResponse): any {
    return {
      id: data.id,
      name: data.name,
      types: data.types.map(type => type.type.name),
      abilities: data.abilities.map(ability => ability.ability.name),
      height: data.height / 10,
      weight: data.weight / 10,
      baseExperience: data.base_experience || 0,
      imageUrl: data.sprites.front_default,
    };
  }
}
