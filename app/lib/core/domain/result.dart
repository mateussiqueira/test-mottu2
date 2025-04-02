import 'package:mobile/core/domain/errors/pokemon_error.dart';

class Result<T> {
  final T? data;
  final PokemonError? error;

  const Result._({
    this.data,
    this.error,
  });

  factory Result.success(T data) => Result._(data: data);

  factory Result.failure(PokemonError error) => Result._(error: error);

  bool get isSuccess => data != null && error == null;
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
