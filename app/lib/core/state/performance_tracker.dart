import '../performance/i_performance_monitor.dart';
import 'i_performance_tracker.dart';

class PerformanceTracker implements IPerformanceTracker {
  final IPerformanceMonitor _monitor;
  final String _operation;
  final DateTime _startTime;

  PerformanceTracker(this._monitor, this._operation)
      : _startTime = DateTime.now();

  @override
  void stop() {
    final duration = DateTime.now().difference(_startTime);
    _monitor.recordOperationTime(_operation, duration);
  }
}
