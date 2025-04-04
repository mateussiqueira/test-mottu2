/// Base class for all failures in the application
abstract class Failure {
  final String? message;
  final String? code;

  Failure({this.message, this.code});
}

/// Server failure
class ServerFailure extends Failure {
  ServerFailure({String? message, String? code})
      : super(message: message, code: code);
}

/// Cache failure
class CacheFailure extends Failure {
  CacheFailure({String? message, String? code})
      : super(message: message, code: code);
}

/// Network failure
class NetworkFailure extends Failure {
  NetworkFailure({String? message, String? code})
      : super(message: message, code: code);
}

/// Validation failure
class ValidationFailure extends Failure {
  ValidationFailure({String? message, String? code})
      : super(message: message, code: code);
}

/// Authentication failure
class AuthenticationFailure extends Failure {
  AuthenticationFailure({String? message, String? code})
      : super(message: message, code: code);
}

/// Authorization failure
class AuthorizationFailure extends Failure {
  AuthorizationFailure({String? message, String? code})
      : super(message: message, code: code);
}

/// Unknown failure
class UnknownFailure extends Failure {
  UnknownFailure({String? message, String? code})
      : super(message: message, code: code);
}
