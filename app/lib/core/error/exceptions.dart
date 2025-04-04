class ServerException implements Exception {
  final String message;

  ServerException([this.message = 'Server error']);

  @override
  String toString() => 'ServerException: $message';
}

class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'Cache error']);

  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = 'Network error']);

  @override
  String toString() => 'NetworkException: $message';
}

class ValidationException implements Exception {
  final String message;

  ValidationException(this.message);

  @override
  String toString() => 'ValidationException: $message';
}

class UnexpectedException implements Exception {
  final String message;

  UnexpectedException([this.message = 'Unexpected error']);

  @override
  String toString() => 'UnexpectedException: $message';
}
