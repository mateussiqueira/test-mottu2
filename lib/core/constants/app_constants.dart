class AppConstants {
  // App Info
  static const String appName = 'Pokédex';
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  // Cache Settings
  static const Duration cacheDuration = Duration(hours: 24);

  // Grid Settings
  static const int gridCrossAxisCount = 2;
  static const double gridChildAspectRatio = 0.75;
  static const double gridSpacing = 16.0;

  // Card Settings
  static const double cardElevation = 4.0;
  static const double cardBorderRadius = 12.0;
  static const double cardPadding = 8.0;

  // Image Settings
  static const double imageHeight = 120.0;
  static const double imageWidth = 120.0;

  // Spacing
  static const double spacingSmall = 4.0;
  static const double spacingMedium = 8.0;
  static const double spacingLarge = 16.0;
  static const double spacingXLarge = 24.0;

  // Icon Sizes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;

  // Pokemon Type Colors
  static const Map<String, int> typeColors = {
    'normal': 0xFFA8A878,
    'fire': 0xFFF08030,
    'water': 0xFF6890F0,
    'electric': 0xFFF8D030,
    'grass': 0xFF78C850,
    'ice': 0xFF98D8D8,
    'fighting': 0xFFC03028,
    'poison': 0xFFA040A0,
    'ground': 0xFFE0C068,
    'flying': 0xFFA890F0,
    'psychic': 0xFFF85888,
    'bug': 0xFFA8B820,
    'rock': 0xFFB8A038,
    'ghost': 0xFF705898,
    'dragon': 0xFF7038F8,
    'dark': 0xFF705848,
    'steel': 0xFFB8B8D0,
    'fairy': 0xFFEE99AC,
  };

  // Pokemon Stats
  static const int maxStatValue = 255;
  static const double statsBarHeight = 8.0;
  static const double statsBarRadius = 4.0;
  static const double statsBarWidth = 150.0;

  // Pokemon Limits
  static const int maxPokemonsPerPage = 20;
  static const int maxSearchResults = 10;
  static const int maxMovesDisplayed = 4;
  static const int maxAbilitiesDisplayed = 3;

  // Animation Settings
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration splashScreenDuration = Duration(seconds: 2);
  static const Duration splashScreenDelay = Duration(seconds: 1);
  static const double splashScreenLogoSize = 200.0;

  // Theme Settings
  static const double appBarElevation = 0.0;
  static const double chipBorderRadius = 8.0;
  static const double chipPadding = 4.0;
  static const double chipFontSize = 12.0;

  // Text Styles
  static const double titleLargeSize = 24.0;
  static const double titleMediumSize = 18.0;
  static const double bodyLargeSize = 16.0;
  static const double bodyMediumSize = 14.0;
  static const int titleLargeWeight = 700; // FontWeight.bold
  static const int titleMediumWeight = 600; // FontWeight.w600

  // Routes
  static const String splashRoute = '/';
  static const String pokemonListRoute = '/pokemon-list';
  static const String pokemonDetailRoute = '/pokemon-detail';

  // Error Messages
  static const String errorLoadingPokemons = 'Failed to load Pokémon';
  static const String errorLoadingPokemon = 'Failed to load Pokémon details';
  static const String errorSearchingPokemon = 'Failed to search Pokémon';
  static const String errorNoPokemonFound = 'No Pokémon found';
  static const String errorNoInternet = 'No internet connection';
  static const String errorCache = 'Failed to load cached data';
  static const String errorUnknown = 'An unknown error occurred';

  // Asset Paths
  static const String pokemonLogoPath = 'assets/images/pokemon_logo.png';
  static const String pokemonPlaceholderPath =
      'assets/images/pokemon_placeholder.png';

  // UI Strings
  static const String searchHint = 'Search Pokémon...';
  static const String searchEmpty = 'Enter a Pokémon name to search';
  static const String searchNoResults = 'No Pokémon found';
  static const String statsLabel = 'Stats';
  static const String abilitiesLabel = 'Abilities';
  static const String movesLabel = 'Moves';
  static const String heightLabel = 'Height';
  static const String weightLabel = 'Weight';
  static const String metersUnit = 'm';
  static const String kilogramsUnit = 'kg';
}
