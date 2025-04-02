import 'package:flutter/foundation.dart';

import 'i_logger.dart';

class PokemonLogger implements ILogger {
  @override
  void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('DEBUG: $message');
      if (error != null) print('Error: $error');
      if (stackTrace != null) print('StackTrace: $stackTrace');
    }
  }

  @override
  void info(String message, [dynamic error, StackTrace? stackTrace]) {
    print('INFO: $message');
    if (error != null) print('Error: $error');
    if (stackTrace != null) print('StackTrace: $stackTrace');
  }

  @override
  void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    print('WARNING: $message');
    if (error != null) print('Error: $error');
    if (stackTrace != null) print('StackTrace: $stackTrace');
  }

  @override
  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    print('ERROR: $message');
    if (error != null) print('Error: $error');
    if (stackTrace != null) print('StackTrace: $stackTrace');
  }

  @override
  void verbose(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('VERBOSE: $message');
      if (error != null) print('Error: $error');
      if (stackTrace != null) print('StackTrace: $stackTrace');
    }
  }
}
