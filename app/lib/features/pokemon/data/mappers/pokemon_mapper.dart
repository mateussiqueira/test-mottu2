import '../../domain/entities/pokemon_entity.dart';
import '../models/pokemon_model.dart';
import '../validators/pokemon_response_validator.dart';

/// Handles Pokemon data transformations
class PokemonMapper {
  /// Maps a list of Pokemon data to Pokemon entities
  static Future<List<PokemonEntity>> mapToEntities(
    List<dynamic> results,
    Future<Map<String, dynamic>> Function(String url) fetchDetails,
  ) async {
    return Future.wait(
      results.map((pokemon) async {
        if (!PokemonResponseValidator.hasValidUrl(pokemon)) {
          throw Exception('Invalid pokemon data: missing url');
        }
        final response = await fetchDetails(pokemon['url']);
        return PokemonModel.fromJson(response) as PokemonEntity;
      }),
    );
  }

  /// Maps a list of Pokemon data from type/ability responses to Pokemon entities
  static Future<List<PokemonEntity>> mapTypeResultsToEntities(
    List<dynamic> results,
    Future<Map<String, dynamic>> Function(String url) fetchDetails,
  ) async {
    return Future.wait(
      results.map((pokemon) async {
        if (!PokemonResponseValidator.hasValidTypeUrl(pokemon)) {
          throw Exception('Invalid pokemon data: missing url');
        }
        final response = await fetchDetails(pokemon['pokemon']['url']);
        return PokemonModel.fromJson(response) as PokemonEntity;
      }),
    );
  }

  /// Filters Pokemon by name based on the search query
  static List<dynamic> filterByName(
    List<dynamic> results,
    String query,
  ) {
    return results.where((pokemon) {
      final name = pokemon['name']?.toString().toLowerCase();
      return name?.contains(query.toLowerCase()) ?? false;
    }).toList();
  }

  /// Converts JSON data to a Pokemon entity
  static PokemonEntity fromJson(Map<String, dynamic> json) {
    final stats = <String, int>{};
    for (final stat in json['stats'] as List) {
      final name = stat['stat']['name'] as String;
      final value = stat['base_stat'] as int;
      stats[name] = value;
    }

    return PokemonEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      height: json['height'] as int,
      weight: json['weight'] as int,
      baseExperience: json['base_experience'] as int? ?? 0,
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      abilities: (json['abilities'] as List)
          .map((ability) => ability['ability']['name'] as String)
          .toList(),
      stats: stats,
      imageUrl: json['sprites']['other']['official-artwork']['front_default']
              as String? ??
          '',
      moves: (json['moves'] as List)
          .map((move) => move['move']['name'] as String)
          .toList(),
      evolutions: [], // This will be filled when needed from evolution-chain endpoint
      description: '',
    );
  }
}
