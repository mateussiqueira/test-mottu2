abstract class IPerformanceMonitor {
  void startOperation(String operationName);
  void endOperation(String operationName);
  void recordOperationTime(String operationName, Duration duration);
  Future<T> trackOperationWithResult<T>(
    String operationName,
    Future<T> Function() operation,
  );
  void reset();
  Map<String, Duration> getOperationDurations();
}
