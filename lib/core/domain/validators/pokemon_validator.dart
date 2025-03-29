import 'package:pokeapi/core/domain/errors/pokemon_error.dart';
import 'package:pokeapi/core/presentation/l10n/app_localizations.dart';

/// Classe para validação de dados de Pokemon
class PokemonValidator {
  /// Valida o ID do Pokemon
  static Result<int> validateId(int id) {
    if (id <= 0) {
      return Result.failure(
        ValidationError(
          message: AppLocalizations.invalidId,
          code: 'INVALID_ID',
        ),
      );
    }
    return Result.success(id);
  }

  /// Valida o nome do Pokemon
  static Result<String> validateName(String name) {
    if (name.isEmpty) {
      return Result.failure(
        ValidationError(
          message: AppLocalizations.invalidName,
          code: 'INVALID_NAME',
        ),
      );
    }
    return Result.success(name);
  }

  /// Valida o tipo do Pokemon
  static Result<String> validateType(String type) {
    if (type.isEmpty) {
      return Result.failure(
        ValidationError(
          message: AppLocalizations.invalidType,
          code: 'INVALID_TYPE',
        ),
      );
    }
    return Result.success(type);
  }

  /// Valida a habilidade do Pokemon
  static Result<String> validateAbility(String ability) {
    if (ability.isEmpty) {
      return Result.failure(
        ValidationError(
          message: AppLocalizations.invalidAbility,
          code: 'INVALID_ABILITY',
        ),
      );
    }
    return Result.success(ability);
  }

  /// Valida a lista de tipos do Pokemon
  static Result<List<String>> validateTypes(List<String> types) {
    if (types.isEmpty) {
      return Result.failure(
        ValidationError(
          message: AppLocalizations.invalidType,
          code: 'INVALID_TYPES',
        ),
      );
    }

    for (final type in types) {
      final result = validateType(type);
      if (result.isFailure) {
        return Result.failure(result.error);
      }
    }

    return Result.success(types);
  }

  /// Valida a lista de habilidades do Pokemon
  static Result<List<String>> validateAbilities(List<String> abilities) {
    if (abilities.isEmpty) {
      return Result.failure(
        ValidationError(
          message: AppLocalizations.invalidAbility,
          code: 'INVALID_ABILITIES',
        ),
      );
    }

    for (final ability in abilities) {
      final result = validateAbility(ability);
      if (result.isFailure) {
        return Result.failure(result.error);
      }
    }

    return Result.success(abilities);
  }

  /// Valida a altura do Pokemon
  static Result<double> validateHeight(double height) {
    if (height <= 0) {
      return Result.failure(
        ValidationError(
          message: 'Invalid height',
          code: 'INVALID_HEIGHT',
        ),
      );
    }
    return Result.success(height);
  }

  /// Valida o peso do Pokemon
  static Result<double> validateWeight(double weight) {
    if (weight <= 0) {
      return Result.failure(
        ValidationError(
          message: 'Invalid weight',
          code: 'INVALID_WEIGHT',
        ),
      );
    }
    return Result.success(weight);
  }

  /// Valida a experiência base do Pokemon
  static Result<int> validateBaseExperience(int baseExperience) {
    if (baseExperience < 0) {
      return Result.failure(
        ValidationError(
          message: 'Invalid base experience',
          code: 'INVALID_BASE_EXPERIENCE',
        ),
      );
    }
    return Result.success(baseExperience);
  }
}
