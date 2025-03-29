import axios from 'axios';

const POKEAPI_URL = process.env.POKEAPI_URL || 'https://pokeapi.co/api/v2';

export interface Pokemon {
  id: number;
  name: string;
  types: string[];
  abilities: string[];
  height: number;
  weight: number;
  baseExperience: number;
  imageUrl: string;
}

export class PokemonService {
  private readonly baseUrl: string;

  constructor() {
    this.baseUrl = POKEAPI_URL;
  }

  async getPokemonList(limit: number = 20, offset: number = 0): Promise<Pokemon[]> {
    try {
      const response = await axios.get(`${this.baseUrl}/pokemon?limit=${limit}&offset=${offset}`);
      const results = response.data.results;

      const pokemons = await Promise.all(
        results.map(async (pokemon: { name: string; url: string }) => {
          const id = parseInt(pokemon.url.split('/').slice(-2, -1)[0]);
          return this.getPokemonById(id);
        }),
      );

      return pokemons;
    } catch (error) {
      console.error('Error fetching pokemon list:', error);
      throw error;
    }
  }

  async getPokemonById(id: number): Promise<Pokemon> {
    try {
      const response = await axios.get(`${this.baseUrl}/pokemon/${id}`);
      const data = response.data;

      return {
        id: data.id,
        name: data.name,
        types: data.types.map((type: any) => type.type.name),
        abilities: data.abilities.map((ability: any) => ability.ability.name),
        height: data.height / 10, // Convert to meters
        weight: data.weight / 10, // Convert to kg
        baseExperience: data.base_experience,
        imageUrl: data.sprites.other['official-artwork'].front_default,
      };
    } catch (error) {
      console.error(`Error fetching pokemon with id ${id}:`, error);
      throw error;
    }
  }

  async searchPokemon(query: string): Promise<Pokemon[]> {
    try {
      const response = await axios.get(`${this.baseUrl}/pokemon?limit=1118`); // Get all pokemons
      const results = response.data.results;

      const filteredPokemons = results
        .filter((pokemon: { name: string }) =>
          pokemon.name.toLowerCase().includes(query.toLowerCase()),
        )
        .slice(0, 20); // Limit to 20 results

      const pokemons = await Promise.all(
        filteredPokemons.map(async (pokemon: { name: string; url: string }) => {
          const id = parseInt(pokemon.url.split('/').slice(-2, -1)[0]);
          return this.getPokemonById(id);
        }),
      );

      return pokemons;
    } catch (error) {
      console.error('Error searching pokemon:', error);
      throw error;
    }
  }

  async getPokemonsByType(type: string): Promise<Pokemon[]> {
    try {
      const response = await axios.get(`${this.baseUrl}/type/${type}`);
      const pokemons = response.data.pokemon.slice(0, 20); // Limit to 20 results

      const pokemonDetails = await Promise.all(
        pokemons.map(async (pokemon: { pokemon: { url: string } }) => {
          const id = parseInt(pokemon.pokemon.url.split('/').slice(-2, -1)[0]);
          return this.getPokemonById(id);
        }),
      );

      return pokemonDetails;
    } catch (error) {
      console.error(`Error fetching pokemons by type ${type}:`, error);
      throw error;
    }
  }

  async getPokemonsByAbility(ability: string): Promise<Pokemon[]> {
    try {
      const response = await axios.get(`${this.baseUrl}/ability/${ability}`);
      const pokemons = response.data.pokemon.slice(0, 20); // Limit to 20 results

      const pokemonDetails = await Promise.all(
        pokemons.map(async (pokemon: { pokemon: { url: string } }) => {
          const id = parseInt(pokemon.pokemon.url.split('/').slice(-2, -1)[0]);
          return this.getPokemonById(id);
        }),
      );

      return pokemonDetails;
    } catch (error) {
      console.error(`Error fetching pokemons by ability ${ability}:`, error);
      throw error;
    }
  }
}
