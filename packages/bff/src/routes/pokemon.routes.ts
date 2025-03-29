import { Router } from 'express';
import { PokemonController } from '../controllers/pokemon.controller';

const router = Router();
const pokemonController = new PokemonController();

// Get list of pokemons with pagination
router.get('/pokemon', (req, res) => pokemonController.getPokemonList(req, res));

// Get pokemon by id
router.get('/pokemon/:id', (req, res) => pokemonController.getPokemonById(req, res));

// Search pokemons by name
router.get('/pokemon/search', (req, res) => pokemonController.searchPokemon(req, res));

// Get pokemons by type
router.get('/pokemon/type/:type', (req, res) => pokemonController.getPokemonsByType(req, res));

// Get pokemons by ability
router.get('/pokemon/ability/:ability', (req, res) =>
  pokemonController.getPokemonsByAbility(req, res),
);

export default router;
