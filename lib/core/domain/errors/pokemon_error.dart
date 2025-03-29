import 'package:pokeapi/core/presentation/l10n/app_localizations.dart';

/// Classe base para erros do domínio Pokemon
sealed class PokemonError {
  final String message;
  final String? code;
  final dynamic originalError;

  PokemonError({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() =>
      'PokemonError: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Erro de rede
class NetworkError extends PokemonError {
  NetworkError({
    super.message = AppLocalizations.networkError,
    super.code,
    super.originalError,
  });
}

/// Erro de cache
class CacheError extends PokemonError {
  CacheError({
    super.message = AppLocalizations.cacheError,
    super.code,
    super.originalError,
  });
}

/// Erro de validação
class ValidationError extends PokemonError {
  ValidationError({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// Erro desconhecido
class UnknownError extends PokemonError {
  UnknownError({
    super.message = AppLocalizations.unknownError,
    super.code,
    super.originalError,
  });
}

/// Resultado de operações que podem falhar
class Result<T> {
  final T? data;
  final PokemonError? error;

  Result.success(this.data) : error = null;
  Result.failure(this.error) : data = null;

  bool get isSuccess => error == null;
  bool get isFailure => error != null;

  T getOrThrow() {
    if (isSuccess) return data!;
    throw error!;
  }

  T? getOrNull() => data;

  T getOrDefault(T defaultValue) => data ?? defaultValue;

  Result<R> map<R>(R Function(T) mapper) {
    if (isSuccess) {
      return Result.success(mapper(data as T));
    }
    return Result.failure(error);
  }

  Result<R> flatMap<R>(Result<R> Function(T) mapper) {
    if (isSuccess) {
      return mapper(data as T);
    }
    return Result.failure(error);
  }

  @override
  String toString() {
    if (isSuccess) {
      return 'Result.success($data)';
    }
    return 'Result.failure($error)';
  }
}
