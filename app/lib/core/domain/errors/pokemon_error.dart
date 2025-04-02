/// Classe base para erros do domínio Pokemon
abstract class PokemonError {
  const PokemonError();
}

/// Erro de rede
class NetworkError extends PokemonError {
  NetworkError() : super();
}

/// Erro de cache
class CacheError extends PokemonError {
  CacheError() : super();
}

/// Erro de validação
class ValidationError extends PokemonError {
  final String message;
  ValidationError(this.message) : super();
}

/// Erro desconhecido
class UnknownError extends PokemonError {
  UnknownError() : super();
}

/// Erro quando o Pokemon não é encontrado
class PokemonNotFoundError extends PokemonError {
  PokemonNotFoundError() : super();
}

/// Erro de rede ao buscar Pokemon
class PokemonNetworkError extends PokemonError {
  PokemonNetworkError() : super();
}

/// Erro inesperado ao buscar Pokemon
class PokemonUnexpectedError extends PokemonError {
  const PokemonUnexpectedError();
}

/// Erro de validação do Pokemon
class PokemonValidationError extends PokemonError {
  final String message;
  PokemonValidationError(this.message) : super();
}
