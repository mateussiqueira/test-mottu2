import 'package:get_it/get_it.dart';

import '../logging/i_logger.dart';
import '../logging/pokemon_logger.dart';
import '../network/dio_config.dart';
import '../performance/i_performance_monitor.dart';
import '../performance/performance_monitor.dart';
import '../resources/i_resource_manager.dart';
import '../resources/shared_preferences_resource_manager.dart';

class InfrastructureModule {
  static Future<void> setup(GetIt getIt) async {
    // Core Services
    getIt.registerLazySingleton<ILogger>(() => PokemonLogger());
    getIt
        .registerLazySingleton<IPerformanceMonitor>(() => PerformanceMonitor());
    getIt.registerLazySingleton(() => DioConfig.create());

    // Resources
    getIt.registerLazySingleton<IResourceManager>(
      () => SharedPreferencesResourceManager(
        prefs: getIt(),
        prefix: 'pokemon_resources',
      ),
    );
  }
}
