import 'package:get/get.dart';

import 'base_operation_tracker.dart';
import 'i_performance_monitor.dart';

abstract class BasePerformanceMonitor extends GetxService
    implements IPerformanceMonitor {
  final BaseOperationTracker _tracker;

  BasePerformanceMonitor(this._tracker);

  @override
  void startOperation(String operationName) {
    _tracker.start(operationName);
  }

  @override
  void endOperation(String operationName) {
    _tracker.end(operationName);
  }

  @override
  void recordOperationTime(String operationName, Duration duration) {
    _tracker.recordTime(operationName, duration);
  }

  @override
  Future<T> trackOperationWithResult<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    return _tracker.track(operationName, operation);
  }

  @override
  void reset() {
    _tracker.reset();
  }

  @override
  Map<String, Duration> getOperationDurations() {
    return _tracker.getDurations();
  }
}
