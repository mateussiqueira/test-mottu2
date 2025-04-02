import 'package:get/get.dart';

import '../logging/pokemon_logger.dart';
import '../performance/performance_monitor.dart';

abstract class BaseStateController extends GetxController {
  final PokemonLogger logger;
  final PerformanceMonitor performanceMonitor;

  final _isLoading = false.obs;
  final _error = RxnString();

  BaseStateController({
    required this.logger,
    required this.performanceMonitor,
  });

  bool get isLoading => _isLoading.value;
  String? get error => _error.value;

  void setLoading(bool value) {
    _isLoading.value = value;
  }

  void setError(String? message) {
    _error.value = message;
  }

  void clearError() {
    _error.value = null;
  }

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
      setLoading(false);
    }
  }
}
