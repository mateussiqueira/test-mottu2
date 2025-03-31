import 'errors/pokemon_error.dart';

class Result<T> {
  final T? data;
  final PokemonError? error;

  Result._(this.data, this.error);

  factory Result.success(T data) {
    return Result._(data, null);
  }

  factory Result.failure(PokemonError error) {
    return Result._(null, error);
  }

  bool get isSuccess => error == null;
  bool get isFailure => error != null;

  R fold<R>(
    R Function(PokemonError) onFailure,
    R Function(T) onSuccess,
  ) {
    if (isSuccess && data != null) {
      return onSuccess(data as T);
    } else if (error != null) {
      return onFailure(error as PokemonError);
    } else {
      throw StateError('Invalid Result state');
    }
  }
}
