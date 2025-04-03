import 'package:get/get.dart';

import '../../../../core/config/di.dart';
import '../../../../core/domain/errors/error_handler.dart';
import '../../../../core/domain/errors/i_logger.dart';
import '../../../../core/domain/errors/logger.dart';
import '../../../../core/domain/errors/performance_monitor.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';
import '../../../pokemon/domain/usecases/get_pokemon_list.dart';
import '../../../pokemon/domain/usecases/i_get_pokemon_list.dart';
import '../../../pokemon/domain/usecases/i_search_pokemon.dart';
import '../../../pokemon/domain/usecases/search_pokemon.dart';
import '../controllers/i_pokemon_search_controller.dart';
import '../controllers/pokemon_list_controller.dart';
import '../controllers/pokemon_search_controller.dart';

class PokemonListBinding extends Bindings {
  @override
  void dependencies() {
    final repository = getIt<IPokemonRepository>();
    final logger = Logger();
    final performanceMonitor = PerformanceMonitor();

    final getPokemonList = GetPokemonList(repository);
    final searchPokemon = SearchPokemon(repository);

    Get.put<PokemonListController>(
      PokemonListController(
        getPokemonList: getPokemonList,
        searchPokemon: searchPokemon,
        repository: repository,
        logger: logger,
        performanceMonitor: performanceMonitor,
      ),
    );

    Get.lazyPut<IGetPokemonList>(
      () => getPokemonList,
    );

    Get.lazyPut<ISearchPokemon>(
      () => searchPokemon,
    );

    registerSearchController(logger);
  }

  void registerSearchController(ILogger logger) {
    Get.lazyPut<IPokemonSearchController>(
      () => PokemonSearchController(
        errorHandler: ErrorHandler(),
        performanceMonitor: PerformanceMonitor(),
        logger: logger,
      ),
    );
  }
}
