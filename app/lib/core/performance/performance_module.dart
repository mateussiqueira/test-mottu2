import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'i_performance_monitor.dart';
import 'performance_monitor.dart';

class PerformanceModule {
  static void setup(GetIt getIt) {
    getIt.registerLazySingleton<IPerformanceMonitor>(
      () => PerformanceMonitor(),
    );
  }
}
