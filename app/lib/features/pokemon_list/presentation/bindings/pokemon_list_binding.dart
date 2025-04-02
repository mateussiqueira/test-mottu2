import 'package:get/get.dart';

import '../../../../core/config/di.dart';
import '../../../../core/logging/i_logger.dart';
import '../../../../core/performance/i_performance_monitor.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';
import '../controllers/i_pokemon_list_controller.dart';
import '../controllers/i_pokemon_search_controller.dart';
import '../controllers/pokemon_list_controller.dart';
import '../controllers/pokemon_search_controller.dart';
import 'base_pokemon_list_binding.dart';

class PokemonListBinding extends BasePokemonListBinding {
  PokemonListBinding()
      : super(
          logger: getIt<ILogger>(),
          performanceMonitor: getIt<IPerformanceMonitor>(),
          repository: getIt<IPokemonRepository>(),
        );

  @override
  void registerListController() {
    Get.lazyPut<IPokemonListController>(
      () => PokemonListController(
        getPokemonList: Get.find(),
        searchPokemon: Get.find(),
        repository: repository,
        logger: logger,
        performanceMonitor: performanceMonitor,
      ),
    );
  }

  @override
  void registerSearchController() {
    Get.lazyPut<IPokemonSearchController>(
      () => PokemonSearchController(
        repository: repository,
        logger: logger,
        performanceMonitor: performanceMonitor,
      ),
    );
  }
}
