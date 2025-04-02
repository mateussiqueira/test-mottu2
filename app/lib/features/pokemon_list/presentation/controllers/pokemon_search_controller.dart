import 'package:get/get.dart';

import '../../../../core/constants/route_names.dart';
import '../../../../core/logging/i_logger.dart';
import '../../../../core/performance/i_performance_monitor.dart';
import '../../../../core/state/base_state_controller.dart';
import '../../../../features/pokemon/domain/entities/i_pokemon_entity.dart';
import '../../../../features/pokemon/domain/repositories/i_pokemon_repository.dart';
import 'i_pokemon_search_controller.dart';

class PokemonSearchController extends BaseStateController
    implements IPokemonSearchController {
  final IPokemonRepository repository;
  final _searchResults = <IPokemonEntity>[].obs;

  PokemonSearchController({
    required this.repository,
    required ILogger logger,
    required IPerformanceMonitor performanceMonitor,
  }) : super(logger: logger, performanceMonitor: performanceMonitor);

  @override
  RxList<IPokemonEntity> get searchResults => _searchResults;

  @override
  Future<void> search(String query) async {
    if (query.isEmpty) {
      clearSearch();
      return;
    }

    setLoading(true);
    try {
      logger.info('Searching Pokemon', data: {'query': query});
      final result = await repository.searchPokemon(query);
      if (result.isSuccess) {
        _searchResults.value = result.data ?? [];
        logger.info(
          'Successfully searched Pokemon',
          data: {'query': query, 'count': _searchResults.length},
        );
      } else {
        setError(result.error ?? 'Failed to search Pokemon');
      }
    } catch (e, stackTrace) {
      logger.error('Error searching Pokemon', error: e, stackTrace: stackTrace);
      setError('Failed to search Pokemon');
    } finally {
      setLoading(false);
    }
  }

  @override
  void clearSearch() {
    _searchResults.clear();
    setError(null);
  }

  @override
  void navigateToDetail(IPokemonEntity pokemon) {
    Get.toNamed(
      RouteNames.pokemonDetail,
      arguments: {
        'pokemon': pokemon,
        'fromSearch': true,
      },
    );
  }
}
