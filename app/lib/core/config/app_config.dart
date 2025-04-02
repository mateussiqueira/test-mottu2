class AppConfig {
  static const bool useBFF = bool.fromEnvironment(
    'USE_BFF',
    defaultValue: true,
  );

  static const String bffBaseUrl = String.fromEnvironment(
    'BFF_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );

  static const String pokeApiBaseUrl = String.fromEnvironment(
    'POKE_API_BASE_URL',
    defaultValue: 'https://pokeapi.co/api/v2',
  );

  static String get baseUrl => useBFF ? bffBaseUrl : pokeApiBaseUrl;
}
