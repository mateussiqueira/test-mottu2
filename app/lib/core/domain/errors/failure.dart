class Failure {
  final String message;
  final String? code;
  final dynamic error;
  final StackTrace? stackTrace;

  Failure({
    required this.message,
    this.code,
    this.error,
    this.stackTrace,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          code == other.code &&
          error == other.error &&
          stackTrace == other.stackTrace;

  @override
  int get hashCode =>
      message.hashCode ^ code.hashCode ^ error.hashCode ^ stackTrace.hashCode;

  @override
  String toString() {
    return 'Failure(message: $message, code: $code, error: $error, stackTrace: $stackTrace)';
  }
}

class ServerFailure extends Failure {
  ServerFailure({
    required String message,
    String? code,
    dynamic error,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          code: code,
          error: error,
          stackTrace: stackTrace,
        );
}

class CacheFailure extends Failure {
  CacheFailure({
    required String message,
    String? code,
    dynamic error,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          code: code,
          error: error,
          stackTrace: stackTrace,
        );
}

class NetworkFailure extends Failure {
  NetworkFailure({
    required String message,
    String? code,
    dynamic error,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          code: code,
          error: error,
          stackTrace: stackTrace,
        );
}

class ValidationFailure extends Failure {
  ValidationFailure({
    required String message,
    String? code,
    dynamic error,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          code: code,
          error: error,
          stackTrace: stackTrace,
        );
}

class UnknownFailure extends Failure {
  UnknownFailure({
    required String message,
    String? code,
    dynamic error,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          code: code,
          error: error,
          stackTrace: stackTrace,
        );
}
