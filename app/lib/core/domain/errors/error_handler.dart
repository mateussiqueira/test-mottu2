import 'failure.dart';

abstract class IErrorHandler {
  Failure handleError(dynamic error);
  String getErrorMessage(dynamic error);
}

class ErrorHandler implements IErrorHandler {
  @override
  Failure handleError(dynamic error) {
    if (error is Failure) {
      return error;
    }

    if (error is Exception) {
      return ServerFailure(
        message: error.toString(),
        error: error,
      );
    }

    return UnknownFailure(
      message: 'An unexpected error occurred',
      error: error,
    );
  }

  @override
  String getErrorMessage(dynamic error) {
    if (error is Failure) {
      return error.message;
    }

    if (error is Exception) {
      return error.toString();
    }

    return 'An unexpected error occurred';
  }
}
