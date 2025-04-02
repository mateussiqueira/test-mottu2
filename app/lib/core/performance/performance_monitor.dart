import 'base_performance_monitor.dart';
import 'operation_tracker.dart';

class PerformanceMonitor extends BasePerformanceMonitor {
  PerformanceMonitor() : super(OperationTracker());
}
