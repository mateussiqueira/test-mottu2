abstract class IOperationTracker {
  void start(String operationName);
  void end(String operationName);
  void recordTime(String operationName, Duration duration);
  Future<T> track<T>(
    String operationName,
    Future<T> Function() operation,
  );
}
