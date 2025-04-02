import 'package:get/get.dart';

import '../../../../core/logging/i_logger.dart';
import '../../../../core/performance/i_performance_monitor.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';
import '../../../pokemon/domain/usecases/get_pokemon_list.dart';
import '../../../pokemon/domain/usecases/i_get_pokemon_list.dart';
import '../../../pokemon/domain/usecases/i_search_pokemon.dart';
import '../../../pokemon/domain/usecases/search_pokemon.dart';
import 'i_pokemon_list_binding.dart';

abstract class BasePokemonListBinding extends Bindings
    implements IPokemonListBinding {
  @override
  final ILogger logger;
  @override
  final IPerformanceMonitor performanceMonitor;
  @override
  final IPokemonRepository repository;

  BasePokemonListBinding({
    required this.logger,
    required this.performanceMonitor,
    required this.repository,
  });

  @override
  void dependencies() {
    registerUseCases();
    registerControllers();
  }

  void registerUseCases() {
    Get.lazyPut<IGetPokemonList>(
      () => GetPokemonList(repository),
    );

    Get.lazyPut<ISearchPokemon>(
      () => SearchPokemon(repository),
    );
  }

  void registerControllers() {
    registerListController();
    registerSearchController();
  }

  void registerListController();
  void registerSearchController();
}
