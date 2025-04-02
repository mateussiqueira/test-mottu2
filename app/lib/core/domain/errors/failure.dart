abstract class Failure {
  final String message;
  final String? code;
  final dynamic error;

  Failure({
    required this.message,
    this.code,
    this.error,
  });
}

class ServerFailure extends Failure {
  ServerFailure({
    required String message,
    String? code,
    dynamic error,
  }) : super(
          message: message,
          code: code,
          error: error,
        );
}

class CacheFailure extends Failure {
  CacheFailure({
    required String message,
    String? code,
    dynamic error,
  }) : super(
          message: message,
          code: code,
          error: error,
        );
}

class NetworkFailure extends Failure {
  NetworkFailure({
    required String message,
    String? code,
    dynamic error,
  }) : super(
          message: message,
          code: code,
          error: error,
        );
}

class ValidationFailure extends Failure {
  ValidationFailure({
    required String message,
    String? code,
    dynamic error,
  }) : super(
          message: message,
          code: code,
          error: error,
        );
}

class UnknownFailure extends Failure {
  UnknownFailure({
    required String message,
    String? code,
    dynamic error,
  }) : super(
          message: message,
          code: code,
          error: error,
        );
}
