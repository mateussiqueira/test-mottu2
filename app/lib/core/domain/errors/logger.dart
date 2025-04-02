abstract class ILogger {
  void debug(String message, {Map<String, dynamic>? data});
  void info(String message, {Map<String, dynamic>? data});
  void warning(String message, {Map<String, dynamic>? data});
  void error(String message, {Object? error, StackTrace? stackTrace});
  void verbose(String message, {Map<String, dynamic>? data});
}
