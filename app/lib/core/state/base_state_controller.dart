import 'package:get/get.dart';

import '../logging/i_logger.dart';
import '../performance/i_performance_monitor.dart';
import 'i_base_state_controller.dart';
import 'performance_tracker.dart';

abstract class BaseStateController extends GetxController
    implements IBaseStateController {
  final ILogger logger;
  final IPerformanceMonitor performanceMonitor;

  final _isLoading = false.obs;
  final _error = RxnString();

  BaseStateController({
    required this.logger,
    required this.performanceMonitor,
  });

  @override
  bool get isLoading => _isLoading.value;

  @override
  String? get error => _error.value;

  @override
  void setLoading(bool value) {
    _isLoading.value = value;
  }

  @override
  void setError(String? message) {
    _error.value = message;
  }

  @override
  void clearError() {
    _error.value = null;
  }

  @override
  Future<T> trackOperation<T>(
    String operation,
    Future<T> Function() action,
  ) async {
    final tracker = PerformanceTracker(performanceMonitor, operation);
    try {
      setLoading(true);
      clearError();
      return await action();
    } catch (e, stackTrace) {
      logger.error(
        'Error in $operation',
        error: e,
        stackTrace: stackTrace,
      );
      setError(e.toString());
      rethrow;
    } finally {
      tracker.stop();
      setLoading(false);
    }
  }
}
