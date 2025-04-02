/// Utility class for Pokemon API URLs
class PokemonApiUrls {
  static const String baseUrl = 'https://pokeapi.co/api/v2';
  static const int defaultLimit = 151;

  /// Gets the URL for fetching a list of Pokemon
  static String getPokemonListUrl({int offset = 0, int limit = defaultLimit}) =>
      '$baseUrl/pokemon?offset=$offset&limit=$limit';

  /// Gets the URL for fetching Pokemon details
  static String getPokemonDetailUrl(String name) => '$baseUrl/pokemon/$name';

  /// Gets the URL for fetching Pokemon by type
  static String getPokemonByTypeUrl(String type) => '$baseUrl/type/$type';

  /// Gets the URL for fetching Pokemon by ability
  static String getPokemonByAbilityUrl(String ability) =>
      '$baseUrl/ability/$ability';
}
