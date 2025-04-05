/// Base class for all failures in the application
class Failure {
  /// Error message
  final String message;

  /// Creates a new failure with the given [message]
  const Failure({required this.message});

  @override
  String toString() => message;
}

/// Failure that occurs when there is a server error
class ServerFailure extends Failure {
  /// Creates a new server failure with the given [message]
  const ServerFailure({required String message}) : super(message: message);
}

/// Failure that occurs when there is a cache error
class CacheFailure extends Failure {
  /// Creates a new cache failure with the given [message]
  const CacheFailure({required String message}) : super(message: message);
}

/// Failure that occurs when there is a network error
class NetworkFailure extends Failure {
  /// Creates a new network failure with the given [message]
  const NetworkFailure({required String message}) : super(message: message);
}

/// Failure that occurs when there is a validation error
class ValidationFailure extends Failure {
  /// Creates a new validation failure with the given [message]
  const ValidationFailure({required String message}) : super(message: message);
}

/// Failure that occurs when there is an unknown error
class UnknownFailure extends Failure {
  /// Creates a new unknown failure with the given [message]
  const UnknownFailure({required String message}) : super(message: message);
}
