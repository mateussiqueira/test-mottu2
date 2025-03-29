import 'errors/pokemon_error.dart';

class Result<T> {
  final T? data;
  final PokemonError? error;
  final bool isSuccess;

  Result._({
    this.data,
    this.error,
    required this.isSuccess,
  });

  factory Result.success(T data) {
    return Result._(
      data: data,
      isSuccess: true,
    );
  }

  factory Result.failure(PokemonError error) {
    return Result._(
      error: error,
      isSuccess: false,
    );
  }

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
