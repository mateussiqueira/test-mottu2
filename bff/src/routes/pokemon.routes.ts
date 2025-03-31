import { Router } from 'express';
import { PokemonController } from '../controllers/pokemon.controller';
import { PokemonService } from '../services/pokemon.service';

const router = Router();
const pokemonService = new PokemonService();
const pokemonController = new PokemonController(pokemonService);

// Search pokemons by name
router.get('/pokemon/search', (req, res) => pokemonController.searchPokemon(req, res));

// Get pokemons by type
router.get('/pokemon/type/:type', (req, res) => pokemonController.getPokemonsByType(req, res));

// Get pokemons by ability
router.get('/pokemon/ability/:ability', (req, res) =>
  pokemonController.getPokemonsByAbility(req, res),
);

// Get pokemon by id
router.get('/pokemon/:id', (req, res) => pokemonController.getPokemonById(req, res));

// Get list of pokemons with pagination
router.get('/pokemon', (req, res) => pokemonController.getPokemonList(req, res));

export default router;
