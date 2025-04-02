class PokeApiUrls {
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  static String getPokemons({int offset = 0, int limit = 20}) =>
      '$baseUrl/pokemon?offset=$offset&limit=$limit';

  static String getPokemonById(int id) => '$baseUrl/pokemon/$id';

  static String getPokemonByName(String name) => '$baseUrl/pokemon/$name';

  static String getAllPokemons() => '$baseUrl/pokemon?limit=1118';

  static String getPokemonsByType(String type) => '$baseUrl/type/$type';

  static String getPokemonsByAbility(String ability) =>
      '$baseUrl/ability/$ability';
}
