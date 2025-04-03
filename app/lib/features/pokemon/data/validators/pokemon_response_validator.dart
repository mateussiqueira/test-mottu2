/// Validates Pokemon API responses
class PokemonResponseValidator {
  /// Validates if the response from the list endpoint is valid
  static bool isValidListResponse(Map<String, dynamic> response) {
    return response['results'] != null && response['results'] is List;
  }

  /// Validates if the response from the type endpoint is valid
  static bool isValidTypeResponse(Map<String, dynamic> response) {
    return response['pokemon'] != null && response['pokemon'] is List;
  }

  /// Validates if the response from the ability endpoint is valid
  static bool isValidAbilityResponse(Map<String, dynamic> response) {
    return response['pokemon'] != null && response['pokemon'] is List;
  }

  /// Validates if a Pokemon data object has a valid URL
  static bool hasValidUrl(Map<String, dynamic> pokemon) {
    return pokemon['url'] != null && pokemon['url'] is String;
  }

  /// Validates if a Pokemon data object from type/ability response has a valid URL
  static bool hasValidTypeUrl(Map<String, dynamic> pokemon) {
    return pokemon['pokemon'] != null &&
        pokemon['pokemon']['url'] != null &&
        pokemon['pokemon']['url'] is String;
  }

  static bool hasValidStats(Map<String, dynamic> pokemon) {
    return pokemon['stats'] != null &&
        pokemon['stats'] is List &&
        (pokemon['stats'] as List).isNotEmpty;
  }

  static bool hasValidTypes(Map<String, dynamic> pokemon) {
    return pokemon['types'] != null &&
        pokemon['types'] is List &&
        (pokemon['types'] as List).isNotEmpty;
  }

  static bool hasValidAbilities(Map<String, dynamic> pokemon) {
    return pokemon['abilities'] != null &&
        pokemon['abilities'] is List &&
        (pokemon['abilities'] as List).isNotEmpty;
  }

  static bool hasValidMoves(Map<String, dynamic> pokemon) {
    return pokemon['moves'] != null &&
        pokemon['moves'] is List &&
        (pokemon['moves'] as List).isNotEmpty;
  }

  static bool hasValidEvolutions(Map<String, dynamic> pokemon) {
    return pokemon['evolutions'] != null &&
        pokemon['evolutions'] is List &&
        (pokemon['evolutions'] as List).isNotEmpty;
  }

  static bool hasValidDescription(Map<String, dynamic> pokemon) {
    return pokemon['description'] != null &&
        pokemon['description'] is String &&
        (pokemon['description'] as String).isNotEmpty;
  }
}
