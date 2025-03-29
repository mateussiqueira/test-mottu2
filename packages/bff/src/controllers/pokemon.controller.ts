import { Request, Response } from 'express';
import { PokemonService } from '../services/pokemon.service';

export class PokemonController {
  private pokemonService: PokemonService;

  constructor() {
    this.pokemonService = new PokemonService();
  }

  async getPokemonList(req: Request, res: Response) {
    try {
      const limit = parseInt(req.query.limit as string) || 20;
      const offset = parseInt(req.query.offset as string) || 0;

      const pokemons = await this.pokemonService.getPokemonList(limit, offset);
      res.json(pokemons);
    } catch (error) {
      console.error('Error in getPokemonList:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  async getPokemonById(req: Request, res: Response) {
    try {
      const id = parseInt(req.params.id);
      const pokemon = await this.pokemonService.getPokemonById(id);
      res.json(pokemon);
    } catch (error) {
      console.error('Error in getPokemonById:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  async searchPokemon(req: Request, res: Response) {
    try {
      const query = req.query.q as string;
      if (!query) {
        return res.status(400).json({ error: 'Query parameter is required' });
      }

      const pokemons = await this.pokemonService.searchPokemon(query);
      res.json(pokemons);
    } catch (error) {
      console.error('Error in searchPokemon:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  async getPokemonsByType(req: Request, res: Response) {
    try {
      const type = req.params.type;
      const pokemons = await this.pokemonService.getPokemonsByType(type);
      res.json(pokemons);
    } catch (error) {
      console.error('Error in getPokemonsByType:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  async getPokemonsByAbility(req: Request, res: Response) {
    try {
      const ability = req.params.ability;
      const pokemons = await this.pokemonService.getPokemonsByAbility(ability);
      res.json(pokemons);
    } catch (error) {
      console.error('Error in getPokemonsByAbility:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }
}
