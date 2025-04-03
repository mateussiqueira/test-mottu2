import 'package:logging/logging.dart' as logging;

import 'failure.dart';
import 'i_logger.dart';
import 'logger.dart';

class ErrorHandler {
  static final logging.Logger _logger = logging.Logger('ErrorHandler');
  static final ILogger _loggerInstance = Logger();

  static Failure handleError(Object error, StackTrace? stackTrace) {
    print('Error occurred: $error');
    if (stackTrace != null) {
      print('Stack trace: $stackTrace');
    }

    if (error is Failure) {
      return error;
    }

    return Failure(
      message: error.toString(),
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void logError(String message,
      {Object? error, StackTrace? stackTrace}) {
    print('Error: $message');
    if (error != null) {
      print('Error details: $error');
    }
    if (stackTrace != null) {
      print('Stack trace: $stackTrace');
    }
    _loggerInstance.error(message, error, stackTrace);
  }

  static void logWarning(String message,
      {Object? error, StackTrace? stackTrace}) {
    print('Warning: $message');
    if (error != null) {
      print('Warning details: $error');
    }
    if (stackTrace != null) {
      print('Stack trace: $stackTrace');
    }
    _loggerInstance.warning(message);
  }

  static void logInfo(String message, {Object? error, StackTrace? stackTrace}) {
    print('Info: $message');
    if (error != null) {
      print('Info details: $error');
    }
    if (stackTrace != null) {
      print('Stack trace: $stackTrace');
    }
    _loggerInstance.info(message);
  }

  static void logDebug(String message,
      {Object? error, StackTrace? stackTrace}) {
    print('Debug: $message');
    if (error != null) {
      print('Debug details: $error');
    }
    if (stackTrace != null) {
      print('Stack trace: $stackTrace');
    }
    _loggerInstance.debug(message);
  }
}
