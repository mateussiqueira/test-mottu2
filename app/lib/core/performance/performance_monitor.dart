import 'package:get/get.dart';

import 'i_performance_monitor.dart';

class PerformanceMonitor extends GetxService implements IPerformanceMonitor {
  final Map<String, DateTime> _startTimes = {};
  final Map<String, Duration> _durations = {};

  @override
  void startOperation(String operationName) {
    _startTimes[operationName] = DateTime.now();
  }

  @override
  void endOperation(String operationName) {
    final startTime = _startTimes[operationName];
    if (startTime != null) {
      final duration = DateTime.now().difference(startTime);
      _durations[operationName] = duration;
      _startTimes.remove(operationName);
    }
  }

  @override
  Future<void> trackOperation(
    String operationName,
    Future<void> Function() operation,
  ) async {
    startOperation(operationName);
    try {
      await operation();
    } finally {
      endOperation(operationName);
    }
  }

  @override
  Future<T> trackOperationWithResult<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    startOperation(operationName);
    try {
      return await operation();
    } finally {
      endOperation(operationName);
    }
  }

  @override
  void reset() {
    _startTimes.clear();
    _durations.clear();
  }

  @override
  Map<String, Duration> getOperationDurations() {
    return Map.unmodifiable(_durations);
  }
}

class PerformanceTracker {
  final PerformanceMonitor _monitor;
  final String _operation;
  final Stopwatch _stopwatch;

  PerformanceTracker(this._monitor, this._operation)
      : _stopwatch = Stopwatch()..start();

  void stop() {
    _stopwatch.stop();
    _monitor.recordOperationTime(_operation, _stopwatch.elapsed);
  }
}
