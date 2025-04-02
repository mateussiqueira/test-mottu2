import '../logging/i_logger.dart';
import '../performance/i_performance_monitor.dart';
import 'base_binding.dart';

class InitialBinding extends BaseBinding {
  final ILogger _logger;
  final IPerformanceMonitor _performanceMonitor;

  InitialBinding({
    required ILogger logger,
    required IPerformanceMonitor performanceMonitor,
  })  : _logger = logger,
        _performanceMonitor = performanceMonitor;

  @override
  void dependencies() {
    put<ILogger>(
      _logger,
      permanent: true,
    );

    put<IPerformanceMonitor>(
      _performanceMonitor,
      permanent: true,
    );
  }
}
