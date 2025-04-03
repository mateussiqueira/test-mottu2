import 'package:get/get.dart';

import '../../../../core/constants/route_names.dart';
import '../../../../core/domain/errors/i_logger.dart';
import '../../../../core/domain/errors/i_performance_monitor.dart';
import '../../../../core/domain/errors/result.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';
import '../../../pokemon/domain/usecases/i_get_pokemon_list.dart';
import '../../../pokemon/domain/usecases/i_search_pokemon.dart';
import 'i_pokemon_list_controller.dart';
import 'i_pokemon_search_controller.dart';
import 'pokemon_list_state.dart';

/// Controller for managing the Pokemon list page
class PokemonListController extends GetxController
    implements IPokemonListController, IPokemonSearchController {
  final IGetPokemonList getPokemonList;
  final ISearchPokemon searchPokemon;
  final IPokemonRepository repository;
  final ILogger _logger;
  final IPerformanceMonitor _performanceMonitor;
  @override
  final PokemonListState state = PokemonListState();

  PokemonListController({
    required this.getPokemonList,
    required this.searchPokemon,
    required this.repository,
    required ILogger logger,
    required IPerformanceMonitor performanceMonitor,
  })  : _logger = logger,
        _performanceMonitor = performanceMonitor;

  @override
  void onInit() {
    super.onInit();
    fetchPokemonList();
  }

  @override
  RxList<PokemonEntity> get searchResults => state.pokemons;

  @override
  RxString get lastQuery => state.searchQuery;

  @override
  RxBool get isLoading => state.isLoading;

  @override
  String? get error => state.error.value;

  @override
  bool get hasError => state.error.value != null;

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      await fetchPokemonList();
      return;
    }

    try {
      state.isLoading.value = true;
      final result =
          await _performanceMonitor.measure<Result<List<PokemonEntity>>>(
        'searchPokemons',
        () => searchPokemon(query),
      );
      if (result.isSuccess && result.data != null) {
        state.pokemons.clear();
        state.pokemons.addAll(result.data!);
        state.hasMore.value = false;
        _logger.info('Pokemons searched successfully');
      } else {
        state.error.value = result.error?.message ?? 'Failed to search Pokemon';
        _logger.error(
          'Error searching Pokemon',
          result.error,
          result.error?.stackTrace,
        );
      }
    } catch (e, stackTrace) {
      state.error.value = 'Error searching Pokemon';
      _logger.error(
        'Error searching Pokemon',
        e,
        stackTrace,
      );
    } finally {
      state.isLoading.value = false;
    }
  }

  @override
  RxList<PokemonEntity> get pokemons => state.pokemons;

  @override
  bool get isLoadingMore => state.isLoadingMore.value;

  @override
  int get currentPage => state.offset.value ~/ PokemonListState.limit;

  @override
  bool get hasMore => state.hasMore.value;

  @override
  String get searchQuery => state.searchQuery.value;

  @override
  String get filterType => state.filterType.value;

  @override
  String get filterAbility => state.filterAbility.value;

  @override
  void clearError() {
    state.error.value = '';
  }

  @override
  void setError(String? message) {
    if (message != null) {
      _logger.error(message);
      state.error.value = message;
    }
  }

  @override
  void setLoading(bool loading) {
    state.isLoading.value = loading;
  }

  @override
  Future<T> trackOperation<T>(
    String operation,
    Future<T> Function() action,
  ) async {
    try {
      _logger.info('Starting operation: $operation');
      final result = _performanceMonitor.measure(
        operation,
        action,
      );
      _logger.info('Operation completed: $operation');
      return result;
    } catch (e, stackTrace) {
      _logger.error('Error in operation: $operation', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> fetchPokemonList() async {
    if (state.isLoading.value) return;

    try {
      state.isLoading.value = true;
      state.offset.value = 0;
      state.hasMore.value = true;
      state.pokemons.clear();

      final result =
          await _performanceMonitor.measure<Result<List<PokemonEntity>>>(
        'fetchPokemons',
        () => getPokemonList(
          limit: null, // Use default from API for first request
          offset: null, // Use base URL without parameters
        ),
      );

      if (result.isSuccess && result.data != null) {
        state.pokemons.addAll(result.data!);
        state.offset.value = PokemonListState.limit;
        state.hasMore.value = result.data!.length >= PokemonListState.limit;
        _logger.info('Pokemons fetched successfully');
      } else {
        state.error.value =
            result.error?.message ?? 'Failed to load Pokemon list';
        _logger.error(
          'Error fetching Pokemon list',
          result.error,
          result.error?.stackTrace,
        );
      }
    } catch (e, stackTrace) {
      state.error.value = 'Failed to load Pokemon list';
      _logger.error(
        'Error fetching Pokemon list',
        e,
        stackTrace,
      );
    } finally {
      state.isLoading.value = false;
    }
  }

  @override
  Future<void> loadMore() async {
    if (!state.hasMore.value || state.isLoadingMore.value) return;

    try {
      state.isLoadingMore.value = true;

      final result =
          await _performanceMonitor.measure<Result<List<PokemonEntity>>>(
        'loadMorePokemons',
        () => getPokemonList(
          limit: PokemonListState.limit,
          offset: state.offset.value,
        ),
      );

      if (result.isSuccess && result.data != null) {
        state.pokemons.addAll(result.data!);
        state.offset.value += PokemonListState.limit;
        state.hasMore.value = result.data!.length >= PokemonListState.limit;
        _logger.info('More Pokemons loaded successfully');
      } else {
        state.error.value =
            result.error?.message ?? 'Failed to load more Pokemon';
        _logger.error(
          'Error loading more Pokemon',
          result.error,
          result.error?.stackTrace,
        );
      }
    } catch (e, stackTrace) {
      state.error.value = 'Failed to load more Pokemon';
      _logger.error(
        'Error loading more Pokemon',
        e,
        stackTrace,
      );
    } finally {
      state.isLoadingMore.value = false;
    }
  }

  @override
  Future<void> search(String query) async {
    state.searchQuery.value = query;
    await _performSearch(query);
  }

  @override
  void clearSearch() {
    state.searchQuery.value = '';
    fetchPokemonList();
  }

  @override
  void navigateToDetail(PokemonEntity pokemon) {
    Get.toNamed(
      RouteNames.pokemonDetail,
      arguments: {
        'pokemon': pokemon,
        'fromSearch': true,
      },
    );
  }

  @override
  Future<void> filterByType(String type) async {
    state.filterType.value = type;
    if (type.isEmpty) {
      await fetchPokemonList();
      return;
    }

    try {
      state.isLoading.value = true;
      final result =
          await _performanceMonitor.measure<Result<List<PokemonEntity>>>(
        'filterPokemonsByType',
        () => repository.getPokemonsByType(type),
      );
      if (result.isSuccess && result.data != null) {
        state.pokemons.clear();
        state.pokemons.addAll(result.data!);
        state.hasMore.value = false;
        _logger.info('Pokemons filtered by type successfully');
      } else {
        state.error.value =
            result.error?.message ?? 'Failed to filter Pokemon by type';
        _logger.error(
          'Error filtering Pokemon by type',
          result.error,
          result.error?.stackTrace,
        );
      }
    } catch (e, stackTrace) {
      state.error.value = 'Failed to filter Pokemon by type';
      _logger.error(
        'Error filtering Pokemon by type',
        e,
        stackTrace,
      );
    } finally {
      state.isLoading.value = false;
    }
  }

  @override
  Future<void> filterByAbility(String ability) async {
    state.filterAbility.value = ability;
    if (ability.isEmpty) {
      await fetchPokemonList();
      return;
    }

    try {
      state.isLoading.value = true;
      final result =
          await _performanceMonitor.measure<Result<List<PokemonEntity>>>(
        'filterPokemonsByAbility',
        () => repository.getPokemonsByAbility(ability),
      );
      if (result.isSuccess && result.data != null) {
        state.pokemons.clear();
        state.pokemons.addAll(result.data!);
        state.hasMore.value = false;
        _logger.info('Pokemons filtered by ability successfully');
      } else {
        state.error.value =
            result.error?.message ?? 'Failed to filter Pokemon by ability';
        _logger.error(
          'Error filtering Pokemon by ability',
          result.error,
          result.error?.stackTrace,
        );
      }
    } catch (e, stackTrace) {
      state.error.value = 'Failed to filter Pokemon by ability';
      _logger.error(
        'Error filtering Pokemon by ability',
        e,
        stackTrace,
      );
    } finally {
      state.isLoading.value = false;
    }
  }

  @override
  void clearFilters() {
    state.filterType.value = '';
    state.filterAbility.value = '';
    fetchPokemonList();
  }
}
