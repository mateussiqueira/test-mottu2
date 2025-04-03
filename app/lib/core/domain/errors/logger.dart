import 'package:logging/logging.dart' as logging;

import '../../logging/i_logger.dart' as logging_interface;
import 'i_logger.dart';

/// Base logger implementation
class _BaseLogger {
  final logging.Logger _logger;

  _BaseLogger() : _logger = logging.Logger('PokemonApp') {
    _init();
  }

  void _init() {
    logging.Logger.root.level = logging.Level.ALL;
    logging.Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
      if (record.error != null) {
        print('Error: ${record.error}');
      }
    });
  }

  void debug(String message, {Map<String, dynamic>? data}) {
    _logger.fine(message);
    if (data != null) {
      _logger.fine('Data: $data');
    }
  }

  void info(String message, {Map<String, dynamic>? data}) {
    _logger.info(message);
    if (data != null) {
      _logger.info('Data: $data');
    }
  }

  void warning(String message, {Map<String, dynamic>? data}) {
    _logger.warning(message);
    if (data != null) {
      _logger.warning('Data: $data');
    }
  }

  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    _logger.severe(message);
    if (data != null) {
      _logger.severe('Data: $data');
    }
    if (error != null) {
      print('Error details: $error');
    }
    if (stackTrace != null) {
      print('Stack trace: $stackTrace');
    }
  }
}

/// Implementation of ILogger from core/domain/errors/i_logger.dart
class Logger implements ILogger {
  final _BaseLogger _baseLogger;

  Logger() : _baseLogger = _BaseLogger();

  @override
  void debug(String message) {
    _baseLogger.debug(message);
  }

  @override
  void info(String message) {
    _baseLogger.info(message);
  }

  @override
  void warning(String message) {
    _baseLogger.warning(message);
  }

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    _baseLogger.error(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }
}

/// Implementation of ILogger from core/logging/i_logger.dart
class LoggingLogger implements logging_interface.ILogger {
  final _BaseLogger _baseLogger;

  LoggingLogger() : _baseLogger = _BaseLogger();

  @override
  void debug(String message, {Map<String, dynamic>? data}) {
    _baseLogger.debug(message, data: data);
  }

  @override
  void info(String message, {Map<String, dynamic>? data}) {
    _baseLogger.info(message, data: data);
  }

  @override
  void warning(String message, {Map<String, dynamic>? data}) {
    _baseLogger.warning(message, data: data);
  }

  @override
  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    _baseLogger.error(
      message,
      error: error,
      stackTrace: stackTrace,
      data: data,
    );
  }
}
