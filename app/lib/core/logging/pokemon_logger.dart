import 'package:flutter/foundation.dart';

import 'i_logger.dart';

class PokemonLogger implements ILogger {
  @override
  void debug(String message, {Map<String, dynamic>? data}) {
    print('DEBUG: $message');
    if (data != null) {
      print('Data: $data');
    }
  }

  @override
  void info(String message, {Map<String, dynamic>? data}) {
    print('INFO: $message');
    if (data != null) {
      print('Data: $data');
    }
  }

  @override
  void warning(String message, {Map<String, dynamic>? data}) {
    print('WARNING: $message');
    if (data != null) {
      print('Data: $data');
    }
  }

  @override
  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    print('ERROR: $message');
    if (error != null) {
      print('Error: $error');
    }
    if (stackTrace != null) {
      print('Stack trace: $stackTrace');
    }
    if (data != null) {
      print('Data: $data');
    }
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
