import '../../../core/domain/errors/pokemon_error.dart';
import '../../../core/domain/result.dart';
import '../../../core/presentation/l10n/app_localizations.dart';

/// Classe para validação de dados de Pokemon
class PokemonValidator {
  /// Valida o ID do Pokemon
  static Result<int> validateId(int id) {
    if (id <= 0) {
      return Result.failure(
        PokemonValidationError(AppLocalizations.invalidId),
      );
    }
    return Result.success(id);
  }

  /// Valida o nome do Pokemon
  static Result<String> validateName(String name) {
    if (name.isEmpty) {
      return Result.failure(
        PokemonValidationError(AppLocalizations.invalidName),
      );
    }
    return Result.success(name);
  }

  /// Valida o tipo do Pokemon
  static Result<String> validateType(String type) {
    if (type.isEmpty) {
      return Result.failure(
        PokemonValidationError(AppLocalizations.invalidType),
      );
    }
    return Result.success(type);
  }

  /// Valida a habilidade do Pokemon
  static Result<String> validateAbility(String ability) {
    if (ability.isEmpty) {
      return Result.failure(
        PokemonValidationError(AppLocalizations.invalidAbility),
      );
    }
    return Result.success(ability);
  }

  /// Valida a lista de tipos do Pokemon
  static Result<List<String>> validateTypes(List<String> types) {
    if (types.isEmpty) {
      return Result.failure(
        PokemonValidationError(AppLocalizations.invalidType),
      );
    }

    for (final type in types) {
      final result = validateType(type);
      if (!result.isSuccess) {
        return Result.failure(result.error!);
      }
    }

    return Result.success(types);
  }

  /// Valida a lista de habilidades do Pokemon
  static Result<List<String>> validateAbilities(List<String> abilities) {
    if (abilities.isEmpty) {
      return Result.failure(
        PokemonValidationError(AppLocalizations.invalidAbility),
      );
    }

    for (final ability in abilities) {
      final result = validateAbility(ability);
      if (!result.isSuccess) {
        return Result.failure(result.error!);
      }
    }

    return Result.success(abilities);
  }

  /// Valida a altura do Pokemon
  static Result<double> validateHeight(double height) {
    if (height <= 0) {
      return Result.failure(
        PokemonValidationError('Invalid height'),
      );
    }
    return Result.success(height);
  }

  /// Valida o peso do Pokemon
  static Result<double> validateWeight(double weight) {
    if (weight <= 0) {
      return Result.failure(
        PokemonValidationError('Invalid weight'),
      );
    }
    return Result.success(weight);
  }

  /// Valida a experiência base do Pokemon
  static Result<int> validateBaseExperience(int baseExperience) {
    if (baseExperience < 0) {
      return Result.failure(
        PokemonValidationError('Invalid base experience'),
      );
    }
    return Result.success(baseExperience);
  }
}
