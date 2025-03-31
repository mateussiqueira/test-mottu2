import axios from "axios";

interface PokemonResponse {
  id: number;
  name: string;
  types: Array<{ type: { name: string } }>;
  abilities: Array<{ ability: { name: string } }>;
  height: number;
  weight: number;
  base_experience: number;
  sprites: { front_default: string };
}

interface PokemonListResponse {
  results: Array<{ name: string; url: string }>;
}

interface PokemonTypeResponse {
  pokemon: Array<{ pokemon: { name: string; url: string } }>;
}

interface PokemonAbilityResponse {
  pokemon: Array<{ pokemon: { name: string; url: string } }>;
}

export class PokemonService {
  private readonly baseUrl = "https://pokeapi.co/api/v2";

  private transformPokemonResponse(pokemon: PokemonResponse) {
    return {
      id: pokemon.id,
      name: pokemon.name,
      types: pokemon.types.map((type) => type.type.name),
      abilities: pokemon.abilities.map((ability) => ability.ability.name),
      height: pokemon.height / 10, // Convert to meters
      weight: pokemon.weight / 10, // Convert to kilograms
      baseExperience: pokemon.base_experience,
      imageUrl: pokemon.sprites.front_default,
    };
  }

  async getPokemonList() {
    try {
      const response = await axios.get<PokemonListResponse>(
        `${this.baseUrl}/pokemon?limit=20`
      );
      const pokemons = await Promise.all(
        response.data.results.map(async (pokemon) => {
          const detailsResponse = await axios.get<PokemonResponse>(pokemon.url);
          return this.transformPokemonResponse(detailsResponse.data);
        })
      );
      return pokemons;
    } catch (error) {
      console.error("Error fetching pokemon list:", error);
      throw error;
    }
  }

  async getPokemonById(id: number) {
    try {
      const response = await axios.get<PokemonResponse>(
        `${this.baseUrl}/pokemon/${id}`
      );
      return this.transformPokemonResponse(response.data);
    } catch (error) {
      console.error(`Error fetching pokemon with id ${id}:`, error);
      throw error;
    }
  }

  async searchPokemon(query: string) {
    try {
      const response = await axios.get<PokemonListResponse>(
        `${this.baseUrl}/pokemon?limit=1000`
      );
      const filteredPokemons = response.data.results
        .filter((pokemon) =>
          pokemon.name.toLowerCase().includes(query.toLowerCase())
        )
        .slice(0, 20); // Limit to 20 results

      const pokemons = await Promise.all(
        filteredPokemons.map(async (pokemon) => {
          const detailsResponse = await axios.get<PokemonResponse>(pokemon.url);
          return this.transformPokemonResponse(detailsResponse.data);
        })
      );
      return pokemons;
    } catch (error) {
      console.error("Error searching pokemon:", error);
      throw error;
    }
  }

  async getPokemonsByType(type: string) {
    try {
      const response = await axios.get<PokemonTypeResponse>(
        `${this.baseUrl}/type/${type}`
      );
      const pokemons = await Promise.all(
        response.data.pokemon.slice(0, 20).map(async ({ pokemon }) => {
          const detailsResponse = await axios.get<PokemonResponse>(pokemon.url);
          return this.transformPokemonResponse(detailsResponse.data);
        })
      );
      return pokemons;
    } catch (error) {
      console.error(`Error fetching pokemons by type ${type}:`, error);
      throw error;
    }
  }

  async getPokemonsByAbility(ability: string) {
    try {
      const response = await axios.get<PokemonAbilityResponse>(
        `${this.baseUrl}/ability/${ability}`
      );
      const pokemons = await Promise.all(
        response.data.pokemon.slice(0, 20).map(async ({ pokemon }) => {
          const detailsResponse = await axios.get<PokemonResponse>(pokemon.url);
          return this.transformPokemonResponse(detailsResponse.data);
        })
      );
      return pokemons;
    } catch (error) {
      console.error(`Error fetching pokemons by ability ${ability}:`, error);
      throw error;
    }
  }
}
