import '../errors/pokemon_error.dart';
import '../result.dart';

class PokemonValidator {
  /// Valida o ID do Pokemon
  static Result<int> validateId(int id) {
    if (id <= 0) {
      return Result.failure(PokemonValidationError('Invalid ID'));
    }
    return Result.success(id);
  }

  /// Valida o nome do Pokemon
  static Result<String> validateName(String name) {
    if (name.isEmpty) {
      return Result.failure(PokemonValidationError('Invalid name'));
    }
    return Result.success(name);
  }

  /// Valida o tipo do Pokemon
  static Result<String> validateType(String type) {
    if (type.isEmpty) {
      return Result.failure(PokemonValidationError('Invalid type'));
    }
    return Result.success(type);
  }

  /// Valida a habilidade do Pokemon
  static Result<String> validateAbility(String ability) {
    if (ability.isEmpty) {
      return Result.failure(PokemonValidationError('Invalid ability'));
    }
    return Result.success(ability);
  }

  /// Valida a lista de tipos do Pokemon
  static Result<List<String>> validateTypes(List<String> types) {
    if (types.isEmpty) {
      return Result.failure(PokemonValidationError('Invalid types'));
    }
    for (final type in types) {
      if (type.isEmpty) {
        return Result.failure(PokemonValidationError('Invalid type'));
      }
    }
    return Result.success(types);
  }

  /// Valida a lista de habilidades do Pokemon
  static Result<List<String>> validateAbilities(List<String> abilities) {
    if (abilities.isEmpty) {
      return Result.failure(PokemonValidationError('Invalid abilities'));
    }
    for (final ability in abilities) {
      if (ability.isEmpty) {
        return Result.failure(PokemonValidationError('Invalid ability'));
      }
    }
    return Result.success(abilities);
  }

  /// Valida a altura do Pokemon
  static Result<double> validateHeight(double height) {
    if (height <= 0) {
      return Result.failure(PokemonValidationError('Invalid height'));
    }
    return Result.success(height);
  }

  /// Valida o peso do Pokemon
  static Result<double> validateWeight(double weight) {
    if (weight <= 0) {
      return Result.failure(PokemonValidationError('Invalid weight'));
    }
    return Result.success(weight);
  }

  /// Valida a experiência base do Pokemon
  static Result<int> validateBaseExperience(int baseExperience) {
    if (baseExperience < 0) {
      return Result.failure(PokemonValidationError('Invalid base experience'));
    }
    return Result.success(baseExperience);
  }
}
