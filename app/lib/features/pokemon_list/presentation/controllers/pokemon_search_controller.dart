import 'package:get/get.dart';

import '../../../../core/constants/route_names.dart';
import '../../../../core/domain/errors/error_handler.dart';
import '../../../../core/domain/errors/failure.dart';
import '../../../../core/domain/errors/logger.dart';
import '../../../../core/domain/errors/performance_monitor.dart';
import '../../../../core/domain/errors/result.dart';
import '../../domain/entities/i_pokemon_entity.dart';
import '../../domain/repositories/i_pokemon_repository.dart';
import '../services/pokemon_search_isolate.dart';
import 'i_pokemon_search_controller.dart';

class PokemonSearchController extends GetxController
    implements IPokemonSearchController {
  final IPokemonRepository _repository;
  final ILogger _logger;
  final IPerformanceMonitor _performanceMonitor;
  final IErrorHandler _errorHandler;
  final RxList<IPokemonEntity> _searchResults = <IPokemonEntity>[].obs;
  String _lastQuery = '';
  bool _isSearching = false;

  PokemonSearchController({
    required IPokemonRepository repository,
    required ILogger logger,
    required IPerformanceMonitor performanceMonitor,
    required IErrorHandler errorHandler,
  })  : _repository = repository,
        _logger = logger,
        _performanceMonitor = performanceMonitor,
        _errorHandler = errorHandler;

  @override
  RxList<IPokemonEntity> get searchResults => _searchResults;

  @override
  Future<void> search(String query) async {
    if (query.isEmpty) {
      clearSearch();
      return;
    }

    if (query == _lastQuery || _isSearching) return;

    _isSearching = true;
    _lastQuery = query;

    try {
      _logger.info('Searching Pokemon', data: {'query': query});
      _performanceMonitor.startOperation('search_pokemon');

      final results =
          await PokemonSearchIsolate.searchPokemons(query, _repository);

      if (query == _lastQuery) {
        _searchResults.value = results;
        _logger.info(
          'Successfully searched Pokemon',
          data: {'query': query, 'count': _searchResults.length},
        );
      }
    } catch (e, stackTrace) {
      if (query == _lastQuery) {
        final failure = _errorHandler.handleError(e);
        _logger.error(
          'Error searching Pokemon',
          error: failure,
          stackTrace: stackTrace,
        );
        _searchResults.clear();
      }
    } finally {
      if (query == _lastQuery) {
        _performanceMonitor.endOperation('search_pokemon');
        _isSearching = false;
      }
    }
  }

  @override
  void clearSearch() {
    _searchResults.clear();
    _lastQuery = '';
  }

  @override
  void navigateToDetail(IPokemonEntity pokemon) {
    Get.toNamed(
      RouteNames.pokemonDetail,
      arguments: pokemon,
    );
  }

  @override
  void onClose() {
    _searchResults.close();
    super.onClose();
  }
}
