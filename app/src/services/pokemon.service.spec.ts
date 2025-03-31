import axios from "axios";
import { PokemonService } from "./pokemon.service";

jest.mock("axios");
const mockedAxios = axios as jest.Mocked<typeof axios>;

describe("PokemonService", () => {
  let service: PokemonService;

  beforeEach(() => {
    service = new PokemonService();
    jest.clearAllMocks();
  });

  describe("getPokemonList", () => {
    it("should return a list of pokemons", async () => {
      const mockPokemonList = {
        data: {
          results: [
            { name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1" },
            { name: "charmander", url: "https://pokeapi.co/api/v2/pokemon/4" },
          ],
        },
      };

      const mockPokemonDetails = [
        {
          data: {
            id: 1,
            name: "bulbasaur",
            types: [{ type: { name: "grass" } }],
            abilities: [{ ability: { name: "overgrow" } }],
            height: 7,
            weight: 69,
            base_experience: 64,
            sprites: { front_default: "https://example.com/bulbasaur.png" },
          },
        },
        {
          data: {
            id: 4,
            name: "charmander",
            types: [{ type: { name: "fire" } }],
            abilities: [{ ability: { name: "blaze" } }],
            height: 6,
            weight: 85,
            base_experience: 62,
            sprites: { front_default: "https://example.com/charmander.png" },
          },
        },
      ];

      mockedAxios.get
        .mockResolvedValueOnce(mockPokemonList)
        .mockResolvedValueOnce(mockPokemonDetails[0])
        .mockResolvedValueOnce(mockPokemonDetails[1]);

      const result = await service.getPokemonList();

      expect(result).toHaveLength(2);
      expect(result[0]).toEqual({
        id: 1,
        name: "bulbasaur",
        types: ["grass"],
        abilities: ["overgrow"],
        height: 0.7,
        weight: 6.9,
        baseExperience: 64,
        imageUrl: "https://example.com/bulbasaur.png",
      });
    });

    it("should handle errors when fetching pokemon list", async () => {
      mockedAxios.get.mockRejectedValueOnce(new Error("API Error"));
      await expect(service.getPokemonList()).rejects.toThrow("API Error");
    });
  });

  describe("getPokemonById", () => {
    it("should return a pokemon by id", async () => {
      const mockPokemonResponse = {
        data: {
          id: 25,
          name: "pikachu",
          types: [{ type: { name: "electric" } }],
          abilities: [{ ability: { name: "static" } }],
          height: 4,
          weight: 60,
          base_experience: 112,
          sprites: { front_default: "https://example.com/pikachu.png" },
        },
      };

      mockedAxios.get.mockResolvedValueOnce(mockPokemonResponse);

      const result = await service.getPokemonById(25);

      expect(result).toEqual({
        id: 25,
        name: "pikachu",
        types: ["electric"],
        abilities: ["static"],
        height: 0.4,
        weight: 6.0,
        baseExperience: 112,
        imageUrl: "https://example.com/pikachu.png",
      });
    });

    it("should handle errors when fetching pokemon by id", async () => {
      mockedAxios.get.mockRejectedValueOnce(new Error("API Error"));
      await expect(service.getPokemonById(25)).rejects.toThrow("API Error");
    });
  });

  describe("searchPokemon", () => {
    it("should return pokemons matching search query", async () => {
      const mockSearchResponse = {
        data: {
          results: [
            { name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon/25" },
            { name: "raichu", url: "https://pokeapi.co/api/v2/pokemon/26" },
          ],
        },
      };

      const mockPokemonDetails = [
        {
          data: {
            id: 25,
            name: "pikachu",
            types: [{ type: { name: "electric" } }],
            abilities: [{ ability: { name: "static" } }],
            height: 4,
            weight: 60,
            base_experience: 112,
            sprites: { front_default: "https://example.com/pikachu.png" },
          },
        },
        {
          data: {
            id: 26,
            name: "raichu",
            types: [{ type: { name: "electric" } }],
            abilities: [{ ability: { name: "static" } }],
            height: 8,
            weight: 300,
            base_experience: 218,
            sprites: { front_default: "https://example.com/raichu.png" },
          },
        },
      ];

      mockedAxios.get
        .mockResolvedValueOnce(mockSearchResponse)
        .mockResolvedValueOnce(mockPokemonDetails[0])
        .mockResolvedValueOnce(mockPokemonDetails[1]);

      const result = await service.searchPokemon("pika");

      expect(result).toHaveLength(2);
      expect(result[0]).toEqual({
        id: 25,
        name: "pikachu",
        types: ["electric"],
        abilities: ["static"],
        height: 0.4,
        weight: 6.0,
        baseExperience: 112,
        imageUrl: "https://example.com/pikachu.png",
      });
      expect(result[1]).toEqual({
        id: 26,
        name: "raichu",
        types: ["electric"],
        abilities: ["static"],
        height: 0.8,
        weight: 30.0,
        baseExperience: 218,
        imageUrl: "https://example.com/raichu.png",
      });
    });

    it("should handle errors when searching pokemon", async () => {
      mockedAxios.get.mockRejectedValueOnce(new Error("API Error"));
      await expect(service.searchPokemon("pikachu")).rejects.toThrow(
        "API Error"
      );
    });
  });

  describe("getPokemonsByType", () => {
    it("should return pokemons by type", async () => {
      const mockTypeResponse = {
        data: {
          pokemon: [
            {
              pokemon: {
                name: "charmander",
                url: "https://pokeapi.co/api/v2/pokemon/4",
              },
            },
            {
              pokemon: {
                name: "charizard",
                url: "https://pokeapi.co/api/v2/pokemon/6",
              },
            },
          ],
        },
      };

      const mockPokemonDetails = [
        {
          data: {
            id: 4,
            name: "charmander",
            types: [{ type: { name: "fire" } }],
            abilities: [{ ability: { name: "blaze" } }],
            height: 6,
            weight: 85,
            base_experience: 62,
            sprites: { front_default: "https://example.com/charmander.png" },
          },
        },
        {
          data: {
            id: 6,
            name: "charizard",
            types: [{ type: { name: "fire" } }],
            abilities: [{ ability: { name: "blaze" } }],
            height: 17,
            weight: 905,
            base_experience: 240,
            sprites: { front_default: "https://example.com/charizard.png" },
          },
        },
      ];

      mockedAxios.get
        .mockResolvedValueOnce(mockTypeResponse)
        .mockResolvedValueOnce(mockPokemonDetails[0])
        .mockResolvedValueOnce(mockPokemonDetails[1]);

      const result = await service.getPokemonsByType("fire");

      expect(result).toHaveLength(2);
      expect(result[0]).toEqual({
        id: 4,
        name: "charmander",
        types: ["fire"],
        abilities: ["blaze"],
        height: 0.6,
        weight: 8.5,
        baseExperience: 62,
        imageUrl: "https://example.com/charmander.png",
      });
      expect(result[1]).toEqual({
        id: 6,
        name: "charizard",
        types: ["fire"],
        abilities: ["blaze"],
        height: 1.7,
        weight: 90.5,
        baseExperience: 240,
        imageUrl: "https://example.com/charizard.png",
      });
    });

    it("should handle errors when fetching pokemons by type", async () => {
      mockedAxios.get.mockRejectedValueOnce(new Error("API Error"));
      await expect(service.getPokemonsByType("fire")).rejects.toThrow(
        "API Error"
      );
    });
  });

  describe("getPokemonsByAbility", () => {
    it("should return pokemons by ability", async () => {
      const mockAbilityResponse = {
        data: {
          pokemon: [
            {
              pokemon: {
                name: "bulbasaur",
                url: "https://pokeapi.co/api/v2/pokemon/1",
              },
            },
            {
              pokemon: {
                name: "ivysaur",
                url: "https://pokeapi.co/api/v2/pokemon/2",
              },
            },
          ],
        },
      };

      const mockPokemonDetails = [
        {
          data: {
            id: 1,
            name: "bulbasaur",
            types: [{ type: { name: "grass" } }],
            abilities: [{ ability: { name: "overgrow" } }],
            height: 7,
            weight: 69,
            base_experience: 64,
            sprites: { front_default: "https://example.com/bulbasaur.png" },
          },
        },
        {
          data: {
            id: 2,
            name: "ivysaur",
            types: [{ type: { name: "grass" } }],
            abilities: [{ ability: { name: "overgrow" } }],
            height: 10,
            weight: 130,
            base_experience: 142,
            sprites: { front_default: "https://example.com/ivysaur.png" },
          },
        },
      ];

      mockedAxios.get
        .mockResolvedValueOnce(mockAbilityResponse)
        .mockResolvedValueOnce(mockPokemonDetails[0])
        .mockResolvedValueOnce(mockPokemonDetails[1]);

      const result = await service.getPokemonsByAbility("overgrow");

      expect(result).toHaveLength(2);
      expect(result[0]).toEqual({
        id: 1,
        name: "bulbasaur",
        types: ["grass"],
        abilities: ["overgrow"],
        height: 0.7,
        weight: 6.9,
        baseExperience: 64,
        imageUrl: "https://example.com/bulbasaur.png",
      });
      expect(result[1]).toEqual({
        id: 2,
        name: "ivysaur",
        types: ["grass"],
        abilities: ["overgrow"],
        height: 1.0,
        weight: 13.0,
        baseExperience: 142,
        imageUrl: "https://example.com/ivysaur.png",
      });
    });

    it("should handle errors when fetching pokemons by ability", async () => {
      mockedAxios.get.mockRejectedValueOnce(new Error("API Error"));
      await expect(service.getPokemonsByAbility("overgrow")).rejects.toThrow(
        "API Error"
      );
    });
  });
});
