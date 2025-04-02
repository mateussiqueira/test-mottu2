import '../../domain/entities/i_pokemon_entity.dart';
import '../../domain/entities/pokemon_entity_impl.dart';
import '../models/pokemon_model.dart';
import '../validators/pokemon_response_validator.dart';

/// Handles Pokemon data transformations
class PokemonMapper {
  /// Maps a list of Pokemon data to Pokemon entities
  static Future<List<IPokemonEntity>> mapToEntities(
    List<dynamic> results,
    Future<Map<String, dynamic>> Function(String url) fetchDetails,
  ) async {
    return Future.wait(
      results.map((pokemon) async {
        if (!PokemonResponseValidator.hasValidUrl(pokemon)) {
          throw Exception('Invalid pokemon data: missing url');
        }
        final response = await fetchDetails(pokemon['url']);
        return PokemonModel.fromJson(response);
      }),
    );
  }

  /// Maps a list of Pokemon data from type/ability responses to Pokemon entities
  static Future<List<IPokemonEntity>> mapTypeResultsToEntities(
    List<dynamic> results,
    Future<Map<String, dynamic>> Function(String url) fetchDetails,
  ) async {
    return Future.wait(
      results.map((pokemon) async {
        if (!PokemonResponseValidator.hasValidTypeUrl(pokemon)) {
          throw Exception('Invalid pokemon data: missing url');
        }
        final response = await fetchDetails(pokemon['pokemon']['url']);
        return PokemonModel.fromJson(response);
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
  static IPokemonEntity fromJson(Map<String, dynamic> json) {
    final stats = <String, int>{};
    for (final stat in json['stats'] as List) {
      final name = stat['stat']['name'] as String;
      final value = stat['base_stat'] as int;
      stats[name] = value;
    }

    return PokemonEntityImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      height: json['height'] as int,
      weight: json['weight'] as int,
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      abilities: (json['abilities'] as List)
          .map((ability) => ability['ability']['name'] as String)
          .toList(),
      stats: stats,
      sprites: {
        'front_default': json['sprites']['front_default'] as String?,
        'back_default': json['sprites']['back_default'] as String?,
        'front_shiny': json['sprites']['front_shiny'] as String?,
        'back_shiny': json['sprites']['back_shiny'] as String?,
      },
    );
  }
}
