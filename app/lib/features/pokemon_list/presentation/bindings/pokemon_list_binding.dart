import 'package:get/get.dart';

import '../../../../core/config/di.dart';
import '../../../../core/logging/i_logger.dart';
import '../../../../core/performance/i_performance_monitor.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';
import '../../../pokemon/domain/usecases/get_pokemon_list.dart';
import '../../../pokemon/domain/usecases/i_get_pokemon_list.dart';
import '../../../pokemon/domain/usecases/i_search_pokemon.dart';
import '../../../pokemon/domain/usecases/search_pokemon.dart';
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
  void dependencies() {
    Get.lazyPut<IGetPokemonList>(
      () => GetPokemonList(repository),
    );

    Get.lazyPut<ISearchPokemon>(
      () => SearchPokemon(repository),
    );

    registerListController();
    registerSearchController();
  }

  @override
  void registerListController() {
    Get.lazyPut<IPokemonListController>(
      () => PokemonListController(
        getPokemonList: Get.find<IGetPokemonList>(),
        searchPokemon: Get.find<ISearchPokemon>(),
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
