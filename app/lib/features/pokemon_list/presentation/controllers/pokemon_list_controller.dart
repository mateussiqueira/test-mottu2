import 'package:get/get.dart';

import '../../../../core/constants/route_names.dart';
import '../../../../core/logging/i_logger.dart';
import '../../../../core/performance/i_performance_monitor.dart';
import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';
import '../../../../features/pokemon/domain/repositories/i_pokemon_repository.dart';
import '../../../../features/pokemon/domain/usecases/i_get_pokemon_list.dart';
import '../../../../features/pokemon/domain/usecases/i_search_pokemon.dart';
import 'i_pokemon_list_controller.dart';
import 'pokemon_list_state.dart';

/// Controller for managing the Pokemon list page
class PokemonListController extends GetxController
    implements IPokemonListController {
  final IGetPokemonList getPokemonList;
  final ISearchPokemon searchPokemon;
  final IPokemonRepository repository;
  final ILogger logger;
  final IPerformanceMonitor performanceMonitor;
  @override
  final PokemonListState state = PokemonListState();
  Worker? _searchWorker;

  PokemonListController({
    required this.getPokemonList,
    required this.searchPokemon,
    required this.repository,
    required this.logger,
    required this.performanceMonitor,
  });

  @override
  void onInit() {
    super.onInit();
    _setupSearchWorker();
    fetchPokemonList();
  }

  @override
  void onClose() {
    _searchWorker?.dispose();
    super.onClose();
  }

  void _setupSearchWorker() {
    _searchWorker = debounce(
      state.searchQuery,
      (String query) => _performSearch(query),
      time: const Duration(milliseconds: 500),
    );
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      await fetchPokemonList();
      return;
    }

    try {
      state.isLoading.value = true;
      final result = await searchPokemon(query);
      if (result.isSuccess && result.data != null) {
        state.pokemons.clear();
        state.pokemons.addAll(result.data!);
        state.hasMore.value = false;
      }
    } catch (e, stackTrace) {
      logger.error('Error searching Pokemon', error: e, stackTrace: stackTrace);
    } finally {
      state.isLoading.value = false;
    }
  }

  @override
  RxList<PokemonEntity> get pokemons => state.pokemons;

  @override
  bool get isLoadingMore => state.isLoadingMore.value;

  @override
  bool get isLoading => state.isLoading.value;

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
  bool get hasError => error != null;

  @override
  String? get error => null;

  @override
  void clearError() {}

  @override
  void setError(String? message) {
    if (message != null) {
      logger.error(message);
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
      logger.info('Starting operation: $operation');
      final result = await action();
      logger.info('Operation completed: $operation');
      return result;
    } catch (e, stackTrace) {
      logger.error('Error in operation: $operation',
          error: e, stackTrace: stackTrace);
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

      final result = await getPokemonList(
        limit: PokemonListState.limit,
        offset: state.offset.value,
      );

      if (result.isSuccess && result.data != null && result.data!.isNotEmpty) {
        state.pokemons.clear();
        state.pokemons.addAll(result.data!);
        state.offset.value += PokemonListState.limit;
        state.hasMore.value = result.data!.length >= PokemonListState.limit;
      } else {
        state.hasMore.value = false;
      }
    } catch (e, stackTrace) {
      logger.error('Error fetching Pokemon list',
          error: e, stackTrace: stackTrace);
    } finally {
      state.isLoading.value = false;
    }
  }

  @override
  Future<void> loadMore() async {
    if (!state.hasMore.value || state.isLoadingMore.value) return;

    try {
      state.isLoadingMore.value = true;

      final result = await getPokemonList(
        limit: PokemonListState.limit,
        offset: state.offset.value,
      );

      if (result.isSuccess && result.data != null && result.data!.isNotEmpty) {
        state.pokemons.addAll(result.data!);
        state.offset.value += PokemonListState.limit;
        state.hasMore.value = result.data!.length >= PokemonListState.limit;
      } else {
        state.hasMore.value = false;
      }
    } catch (e, stackTrace) {
      logger.error('Error loading more Pokemon',
          error: e, stackTrace: stackTrace);
    } finally {
      state.isLoadingMore.value = false;
    }
  }

  @override
  void search(String query) {
    state.searchQuery.value = query;
    if (query.isEmpty) {
      state.searchResults.clear();
      return;
    }

    state.isLoading.value = true;
    final filteredPokemons = state.pokemons.where((pokemon) {
      final name = pokemon.name.toLowerCase();
      final searchQuery = query.toLowerCase();
      return name.contains(searchQuery);
    }).toList();
    state.searchResults.assignAll(filteredPokemons);
    state.isLoading.value = false;
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
      final result = await repository.getPokemonsByType(type);
      if (result.isSuccess && result.data != null) {
        state.pokemons.clear();
        state.pokemons.addAll(result.data!);
        state.hasMore.value = false;
      }
    } catch (e, stackTrace) {
      logger.error('Error filtering Pokemon by type',
          error: e, stackTrace: stackTrace);
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
      final result = await repository.getPokemonsByAbility(ability);
      if (result.isSuccess && result.data != null) {
        state.pokemons.clear();
        state.pokemons.addAll(result.data!);
        state.hasMore.value = false;
      }
    } catch (e, stackTrace) {
      logger.error('Error filtering Pokemon by ability',
          error: e, stackTrace: stackTrace);
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

  @override
  void clearSearch() {
    state.searchQuery.value = '';
    state.searchResults.clear();
  }

  @override
  void navigateToDetail(PokemonEntity pokemon) {
    Get.toNamed(
      '${RouteNames.pokemonDetail}/${pokemon.id}',
      arguments: {
        'pokemon': pokemon,
        'fromSearch': state.searchQuery.isNotEmpty,
      },
    );
  }
}
