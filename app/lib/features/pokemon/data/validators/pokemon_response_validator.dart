import 'package:pokemon_list/features/pokemon/data/models/pokemon_response.dart';

import '../../../../core/error/failure.dart';

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

  void validateResponse(Map<String, dynamic> response) {
    if (response.isEmpty) {
      throw const ValidationFailure(message: 'Empty response');
    }

    if (!response.containsKey('results')) {
      throw const ValidationFailure(message: 'Missing results field');
    }

    final results = response['results'];
    if (results is! List) {
      throw const ValidationFailure(message: 'Results field is not a list');
    }

    if (!response.containsKey('count')) {
      throw const ValidationFailure(message: 'Missing count field');
    }

    final count = response['count'];
    if (count is! int) {
      throw const ValidationFailure(message: 'Count field is not an integer');
    }
  }

  void validatePokemonResponse(Map<String, dynamic> response) {
    if (response.isEmpty) {
      throw const ValidationFailure(message: 'Empty response');
    }

    final requiredFields = [
      'id',
      'name',
      'height',
      'weight',
      'base_experience',
      'is_default',
      'order',
      'abilities',
      'forms',
      'game_indices',
      'held_items',
      'location_area_encounters',
      'moves',
      'species',
      'sprites',
      'stats',
      'types',
    ];

    for (final field in requiredFields) {
      if (!response.containsKey(field)) {
        throw ValidationFailure(message: 'Missing required field: $field');
      }
    }

    _validateId(response['id']);
    _validateName(response['name']);
    _validateHeight(response['height']);
    _validateWeight(response['weight']);
    _validateBaseExperience(response['base_experience']);
    _validateIsDefault(response['is_default']);
    _validateOrder(response['order']);
    _validateAbilities(response['abilities']);
    _validateForms(response['forms']);
    _validateGameIndices(response['game_indices']);
    _validateHeldItems(response['held_items']);
    _validateLocationAreaEncounters(response['location_area_encounters']);
    _validateMoves(response['moves']);
    _validateSpecies(response['species']);
    _validateSprites(response['sprites']);
    _validateStats(response['stats']);
    _validateTypes(response['types']);
  }

  void _validateId(dynamic id) {
    if (id is! int) {
      throw const ValidationFailure(message: 'ID must be an integer');
    }
  }

  void _validateName(dynamic name) {
    if (name is! String) {
      throw const ValidationFailure(message: 'Name must be a string');
    }
  }

  void _validateHeight(dynamic height) {
    if (height is! int) {
      throw const ValidationFailure(message: 'Height must be an integer');
    }
  }

  void _validateWeight(dynamic weight) {
    if (weight is! int) {
      throw const ValidationFailure(message: 'Weight must be an integer');
    }
  }

  void _validateBaseExperience(dynamic baseExperience) {
    if (baseExperience is! int) {
      throw const ValidationFailure(
          message: 'Base experience must be an integer');
    }
  }

  void _validateIsDefault(dynamic isDefault) {
    if (isDefault is! bool) {
      throw const ValidationFailure(message: 'Is default must be a boolean');
    }
  }

  void _validateOrder(dynamic order) {
    if (order is! int) {
      throw const ValidationFailure(message: 'Order must be an integer');
    }
  }

  void _validateAbilities(dynamic abilities) {
    if (abilities is! List) {
      throw const ValidationFailure(message: 'Abilities must be a list');
    }
  }

  void _validateForms(dynamic forms) {
    if (forms is! List) {
      throw const ValidationFailure(message: 'Forms must be a list');
    }
  }

  void _validateGameIndices(dynamic gameIndices) {
    if (gameIndices is! List) {
      throw const ValidationFailure(message: 'Game indices must be a list');
    }
  }

  void _validateHeldItems(dynamic heldItems) {
    if (heldItems is! List) {
      throw const ValidationFailure(message: 'Held items must be a list');
    }
  }

  void _validateLocationAreaEncounters(dynamic locationAreaEncounters) {
    if (locationAreaEncounters is! String) {
      throw const ValidationFailure(
          message: 'Location area encounters must be a string');
    }
  }

  void _validateMoves(dynamic moves) {
    if (moves is! List) {
      throw const ValidationFailure(message: 'Moves must be a list');
    }
  }

  void _validateSpecies(dynamic species) {
    if (species is! Map) {
      throw const ValidationFailure(message: 'Species must be an object');
    }
  }

  void _validateSprites(dynamic sprites) {
    if (sprites is! Map) {
      throw const ValidationFailure(message: 'Sprites must be an object');
    }
  }

  void _validateStats(dynamic stats) {
    if (stats is! List) {
      throw const ValidationFailure(message: 'Stats must be a list');
    }
  }

  void _validateTypes(dynamic types) {
    if (types is! List) {
      throw const ValidationFailure(message: 'Types must be a list');
    }
  }

  static void validate(PokemonResponse response) {
    if (response.results.isEmpty) {
      throw PokemonListEmptyFailure();
    }

    for (final pokemon in response.results) {
      if (pokemon.id <= 0) {
        throw InvalidPokemonIdFailure(pokemon.id);
      }

      if (pokemon.name.isEmpty) {
        throw InvalidPokemonNameFailure(pokemon.name);
      }

      if (pokemon.types.isEmpty) {
        throw InvalidPokemonTypesFailure(pokemon.types);
      }

      if (pokemon.abilities.isEmpty) {
        throw InvalidPokemonAbilitiesFailure(pokemon.abilities);
      }

      if (pokemon.height <= 0) {
        throw InvalidPokemonHeightFailure(pokemon.height);
      }

      if (pokemon.weight <= 0) {
        throw InvalidPokemonWeightFailure(pokemon.weight);
      }

      if (pokemon.stats.isEmpty) {
        throw InvalidPokemonStatsFailure(pokemon.stats);
      }

      if (pokemon.sprites.isEmpty) {
        throw InvalidPokemonSpritesFailure(pokemon.sprites);
      }

      if (pokemon.baseExperience <= 0) {
        throw InvalidPokemonBaseExperienceFailure(pokemon.baseExperience);
      }

      if (pokemon.moves.isEmpty) {
        throw InvalidPokemonMovesFailure(pokemon.moves);
      }

      if (pokemon.description.isEmpty) {
        throw InvalidPokemonDescriptionFailure(pokemon.description);
      }
    }
  }
}
