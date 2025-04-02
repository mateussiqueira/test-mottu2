import 'package:get_it/get_it.dart';

import '../../features/pokemon/presentation/routes/pokemon_router.dart';
import '../bindings/initial_binding.dart';
import '../logging/i_logger.dart';
import '../performance/i_performance_monitor.dart';
import '../presentation/routes/app_router.dart';
import '../presentation/routes/i_router.dart';
import '../presentation/theme/getx_theme_manager.dart';
import '../presentation/theme/i_theme_manager.dart';

class PresentationModule {
  static void setup(GetIt getIt) {
    // Theme
    getIt.registerLazySingleton<IThemeManager>(
      () => GetXThemeManager(),
    );

    // Router
    getIt.registerLazySingleton<PokemonRouter>(() => PokemonRouter());
    getIt.registerLazySingleton<IRouter>(
      () => AppRouter(getIt<PokemonRouter>()),
    );

    // Initial Binding
    getIt.registerLazySingleton<InitialBinding>(
      () => InitialBinding(
        logger: getIt<ILogger>(),
        performanceMonitor: getIt<IPerformanceMonitor>(),
      ),
    );
  }
}
