import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'Pokédex';
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  // Cache Settings
  static const Duration cacheDuration = Duration(hours: 1);

  // Grid Settings
  static const int gridCrossAxisCount = 2;
  static const double gridChildAspectRatio = 0.75;
  static const double gridSpacing = 16.0;

  // Card Settings
  static const double cardElevation = 4.0;
  static const double cardBorderRadius = 8.0;
  static const EdgeInsets cardPadding = EdgeInsets.all(8.0);

  // Image Settings
  static const double imageHeight = 120.0;
  static const double imageWidth = 120.0;

  // Spacing
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingExtraLarge = 32.0;

  // Icon Sizes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;

  // Pokemon Type Colors
  static const Map<String, Color> typeColors = {
    'normal': Color(0xFFA8A878),
    'fire': Color(0xFFF08030),
    'water': Color(0xFF6890F0),
    'electric': Color(0xFFF8D030),
    'grass': Color(0xFF78C850),
    'ice': Color(0xFF98D8D8),
    'fighting': Color(0xFFC03028),
    'poison': Color(0xFFA040A0),
    'ground': Color(0xFFE0C068),
    'flying': Color(0xFFA890F0),
    'psychic': Color(0xFFF85888),
    'bug': Color(0xFFA8B820),
    'rock': Color(0xFFB8A038),
    'ghost': Color(0xFF705898),
    'dragon': Color(0xFF7038F8),
    'dark': Color(0xFF705848),
    'steel': Color(0xFFB8B8D0),
    'fairy': Color(0xFFEE99AC),
  };

  // Pokemon Stats
  static const int maxStatValue = 255;
  static const double statsBarHeight = 8.0;

  // Pokemon Limits
  static const int pokemonPerPage = 20;
  static const int maxPokemonCount = 1118;

  // Animation Settings
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration splashScreenDuration = Duration(seconds: 2);

  // Theme Settings
  static const double appBarElevation = 0.0;
  static const double chipBorderRadius = 16.0;
  static const EdgeInsets chipPadding = EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 6.0,
  );
  static const double chipFontSize = 14.0;

  // Text Styles
  static const double titleLargeSize = 24.0;
  static const double titleMediumSize = 20.0;
  static const double titleSmallSize = 16.0;
  static const double bodyLargeSize = 16.0;
  static const double bodyMediumSize = 14.0;
  static const double bodySmallSize = 12.0;
  static const FontWeight titleWeight = FontWeight.bold;
  static const FontWeight bodyWeight = FontWeight.normal;

  // Routes
  static const String homeRoute = '/';
  static const String detailRoute = '/pokemon-detail';

  // Error Messages
  static const String errorLoadingPokemons = 'Failed to load pokemons';
  static const String errorLoadingPokemon = 'Failed to load pokemon';
  static const String errorSearchingPokemons = 'Failed to search pokemons';
  static const String errorNoInternet = 'No internet connection';

  // Asset Paths
  static const String pokemonLogoPath = 'assets/images/pokemon_logo.png';
  static const String placeholderImagePath = 'assets/images/placeholder.png';

  // UI Strings
  static const String searchHint = 'Search pokemon...';
  static const String statsLabel = 'Stats';
  static const String abilitiesLabel = 'Abilities';
  static const String movesLabel = 'Moves';
  static const String heightLabel = 'Height';
  static const String weightLabel = 'Weight';
  static const String metersUnit = 'm';
  static const String kilogramsUnit = 'kg';
}
