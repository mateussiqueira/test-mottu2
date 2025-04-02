import 'i_performance_monitor.dart';
import 'i_performance_tracker.dart';

class PerformanceTracker implements IPerformanceTracker {
  final IPerformanceMonitor _monitor;
  final String _operation;
  final Stopwatch _stopwatch;

  PerformanceTracker(this._monitor, this._operation)
      : _stopwatch = Stopwatch()..start();

  @override
  void stop() {
    _stopwatch.stop();
    _monitor.recordOperationTime(_operation, _stopwatch.elapsed);
  }
}
