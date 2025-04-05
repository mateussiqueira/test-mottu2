import 'package:flutter/material.dart';

class AppConstants {
  static const String apiBaseUrl = 'https://pokeapi.co/api/v2';
  static const int defaultLimit = 20;
  static const int maxPokemonId = 898; // Limite de Pokémon na API

  // Endpoints
  static String getPokemonsEndpoint(int offset, int limit) {
    return '$apiBaseUrl/pokemon?offset=$offset&limit=$limit';
  }

  static String getPokemonByIdEndpoint(int id) {
    return '$apiBaseUrl/pokemon/$id';
  }

  static String getPokemonByNameEndpoint(String name) {
    return '$apiBaseUrl/pokemon/${name.toLowerCase()}';
  }

  static String getPokemonsByTypeEndpoint(String type) {
    return '$apiBaseUrl/type/${type.toLowerCase()}';
  }

  static String getPokemonsByAbilityEndpoint(String ability) {
    return '$apiBaseUrl/ability/${ability.toLowerCase()}';
  }

  // Cache keys
  static String pokemonListCacheKey(int offset, int limit) {
    return 'pokemon_list_${offset}_$limit';
  }

  static String pokemonDetailCacheKey(String identifier) {
    return 'pokemon_detail_$identifier';
  }

  static String pokemonsByTypeCacheKey(String type) {
    return 'pokemons_by_type_$type';
  }

  static String pokemonsByAbilityCacheKey(String ability) {
    return 'pokemons_by_ability_$ability';
  }

  // Imagem
  static String getPokemonImageUrl(int id) {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }
}