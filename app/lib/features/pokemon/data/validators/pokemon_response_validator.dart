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
    return pokemon['url'] != null;
  }

  /// Validates if a Pokemon data object from type/ability response has a valid URL
  static bool hasValidTypeUrl(Map<String, dynamic> pokemon) {
    return pokemon['pokemon']?['url'] != null;
  }
}
