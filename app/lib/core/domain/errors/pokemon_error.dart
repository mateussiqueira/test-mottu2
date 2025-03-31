/// Classe base para erros do domínio Pokemon
class PokemonError {
  final String code;
  final String? message;

  const PokemonError({
    required this.code,
    this.message,
  });

  @override
  String toString() => message ?? code;
}

/// Erro de rede
class NetworkError extends PokemonError {
  NetworkError()
      : super(code: 'network_error', message: 'Network error occurred');
}

/// Erro de cache
class CacheError extends PokemonError {
  CacheError() : super(code: 'cache_error', message: 'Cache error occurred');
}

/// Erro de validação
class ValidationError extends PokemonError {
  ValidationError(String message)
      : super(code: 'validation_error', message: message);
}

/// Erro desconhecido
class UnknownError extends PokemonError {
  UnknownError()
      : super(code: 'unknown_error', message: 'An unknown error occurred');
}

/// Erro quando o Pokemon não é encontrado
class PokemonNotFoundError extends PokemonError {
  PokemonNotFoundError()
      : super(code: 'pokemon_not_found', message: 'Pokemon not found');
}

/// Erro de rede ao buscar Pokemon
class PokemonNetworkError extends PokemonError {
  PokemonNetworkError()
      : super(code: 'network_error', message: 'Network error occurred');
}

/// Erro inesperado ao buscar Pokemon
class PokemonUnexpectedError extends PokemonError {
  PokemonUnexpectedError()
      : super(
            code: 'unexpected_error', message: 'An unexpected error occurred');
}

/// Erro de validação do Pokemon
class PokemonValidationError extends PokemonError {
  PokemonValidationError(String message)
      : super(code: 'validation_error', message: message);
}
