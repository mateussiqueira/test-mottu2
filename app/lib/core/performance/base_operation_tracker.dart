import 'i_operation_tracker.dart';

abstract class BaseOperationTracker implements IOperationTracker {
  final Map<String, DateTime> _startTimes = {};
  final Map<String, Duration> _durations = {};

  @override
  void start(String operationName) {
    _startTimes[operationName] = DateTime.now();
  }

  @override
  void end(String operationName) {
    final startTime = _startTimes[operationName];
    if (startTime != null) {
      final duration = DateTime.now().difference(startTime);
      recordTime(operationName, duration);
      _startTimes.remove(operationName);
    }
  }

  @override
  void recordTime(String operationName, Duration duration) {
    _durations[operationName] = duration;
  }

  @override
  Future<T> track<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    start(operationName);
    try {
      return await operation();
    } finally {
      end(operationName);
    }
  }

  void reset() {
    _startTimes.clear();
    _durations.clear();
  }

  Map<String, Duration> getDurations() {
    return Map.unmodifiable(_durations);
  }
}
