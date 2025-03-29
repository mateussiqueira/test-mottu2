import 'package:mobile/core/presentation/l10n/app_localizations.dart';

/// Classe base para erros do domínio Pokemon
sealed class PokemonError {
  final String message;

  PokemonError(this.message);

  @override
  String toString() => message;
}

/// Erro de rede
class NetworkError extends PokemonError {
  NetworkError() : super(AppLocalizations.networkError);
}

/// Erro de cache
class CacheError extends PokemonError {
  CacheError() : super(AppLocalizations.cacheError);
}

/// Erro de validação
class ValidationError extends PokemonError {
  ValidationError(super.message);
}

/// Erro desconhecido
class UnknownError extends PokemonError {
  UnknownError() : super(AppLocalizations.unknownError);
}

class PokemonNotFoundError extends PokemonError {
  PokemonNotFoundError() : super('Pokemon not found');
}

class PokemonNetworkError extends PokemonError {
  PokemonNetworkError() : super('Network error occurred');
}

class PokemonValidationError extends PokemonError {
  PokemonValidationError(super.message);
}

class PokemonUnexpectedError extends PokemonError {
  PokemonUnexpectedError() : super('An unexpected error occurred');
}
