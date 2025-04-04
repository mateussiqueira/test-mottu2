import 'package:dartz/dartz.dart';

import '../error/failure.dart';

/// Type alias for Either<Failure, T>
typedef Result<T> = Either<Failure, T>;

/// Extension methods for Result
extension ResultExtension<T> on Result<T> {
  /// Get the value if it exists, otherwise throw an exception
  T getOrThrow() {
    return fold(
      (failure) => throw failure,
      (value) => value,
    );
  }

  /// Get the value if it exists, otherwise return null
  T? getOrNull() {
    return fold(
      (failure) => null,
      (value) => value,
    );
  }

  /// Get the value if it exists, otherwise return the default value
  T getOrElse(T defaultValue) {
    return fold(
      (failure) => defaultValue,
      (value) => value,
    );
  }

  /// Execute a function if the result is a success
  void ifSuccess(void Function(T) action) {
    fold(
      (failure) => null,
      (value) => action(value),
    );
  }

  /// Execute a function if the result is a failure
  void ifFailure(void Function(Failure) action) {
    fold(
      (failure) => action(failure),
      (value) => null,
    );
  }
}
