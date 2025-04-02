abstract class PokemonError {
  const PokemonError();
}

class NetworkError extends PokemonError {
  NetworkError() : super();
}

class CacheError extends PokemonError {
  CacheError() : super();
}

class ValidationError extends PokemonError {
  final String message;
  ValidationError(this.message) : super();
}

class UnknownError extends PokemonError {
  UnknownError() : super();
}

class PokemonNotFoundError extends PokemonError {
  PokemonNotFoundError() : super();
}

class PokemonNetworkError extends PokemonError {
  PokemonNetworkError() : super();
}

class PokemonUnexpectedError extends PokemonError {
  const PokemonUnexpectedError();
}

class PokemonValidationError extends PokemonError {
  final String message;
  PokemonValidationError(this.message) : super();
}
