/// Interface for performance monitoring
abstract class IPerformanceMonitor {
  void start(String operation);
  void end(String operation);
  Future<T> measure<T>(String operation, Future<T> Function() action);
}
