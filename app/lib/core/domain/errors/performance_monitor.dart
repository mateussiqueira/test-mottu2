import 'dart:async';

import '../../performance/i_performance_monitor.dart' as performance;
import 'i_performance_monitor.dart';

/// Implementation of IPerformanceMonitor
class PerformanceMonitor
    implements IPerformanceMonitor, performance.IPerformanceMonitor {
  final Map<String, DateTime> _startTimes = {};
  final Map<String, Duration> _operationDurations = {};

  @override
  void start(String operation) {
    startOperation(operation);
  }

  @override
  void end(String operation) {
    endOperation(operation);
  }

  @override
  void startOperation(String operationName) {
    _startTimes[operationName] = DateTime.now();
  }

  @override
  void endOperation(String operationName) {
    final startTime = _startTimes.remove(operationName);
    if (startTime != null) {
      final duration = DateTime.now().difference(startTime);
      recordOperationTime(operationName, duration);
    }
  }

  @override
  void recordOperationTime(String operationName, Duration duration) {
    _operationDurations[operationName] = duration;
    print('Operation $operationName took ${duration.inMilliseconds}ms');
  }

  @override
  Future<T> measure<T>(String operation, Future<T> Function() action) async {
    return trackOperationWithResult(operation, action);
  }

  @override
  Future<T> trackOperationWithResult<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    startOperation(operationName);
    try {
      final result = await operation();
      return result;
    } finally {
      endOperation(operationName);
    }
  }

  @override
  void reset() {
    _startTimes.clear();
    _operationDurations.clear();
  }

  @override
  Map<String, Duration> getOperationDurations() {
    return Map.unmodifiable(_operationDurations);
  }
}
