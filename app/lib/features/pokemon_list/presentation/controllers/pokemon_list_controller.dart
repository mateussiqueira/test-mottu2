import 'package:get/get.dart';

import '../../../../core/logging/i_logger.dart';
import '../../../../core/performance/i_performance_monitor.dart';
import '../../../../core/state/base_state_controller.dart';
import '../../../../features/pokemon/domain/entities/i_pokemon_entity.dart';
import '../../../../features/pokemon/domain/repositories/i_pokemon_repository.dart';
import '../../../../features/pokemon/domain/usecases/i_get_pokemon_list.dart';
import '../../../../features/pokemon/domain/usecases/i_search_pokemon.dart';
import 'i_pokemon_list_controller.dart';
import 'pokemon_list_state.dart';

/// Controller for managing the Pokemon list page
class PokemonListController extends BaseStateController
    implements IPokemonListController {
  final IGetPokemonList getPokemonList;
  final ISearchPokemon searchPokemon;
  final IPokemonRepository repository;
  final PokemonListState state;

  PokemonListController({
    required this.getPokemonList,
    required this.searchPokemon,
    required this.repository,
    required ILogger logger,
    required IPerformanceMonitor performanceMonitor,
  })  : state = PokemonListState(),
        super(logger: logger, performanceMonitor: performanceMonitor);

  @override
  RxList<IPokemonEntity> get pokemons => state.pokemons;

  @override
  bool get isLoadingMore => state.isLoadingMore.value;

  @override
  int get currentPage => state.currentPage.value;

  @override
  bool get hasMore => state.hasMore.value;

  @override
  String get searchQuery => state.searchQuery.value;

  @override
  String get filterType => state.filterType.value;

  @override
  String get filterAbility => state.filterAbility.value;

  @override
  void onInit() {
    super.onInit();
    fetchPokemonList();
  }

  @override
  Future<void> fetchPokemonList() async {
    setLoading(true);
    try {
      logger.info('Fetching Pokemon list');
      final result = await getPokemonList(
        limit: PokemonListState.limit,
        offset: 0,
      );
      if (result.isSuccess) {
        state.updatePokemons(result.data ?? []);
        logger.info(
          'Successfully fetched Pokemon list',
          data: {'count': result.data?.length ?? 0},
        );
      } else {
        setError(result.error ?? 'Failed to fetch Pokemon list');
      }
    } catch (e, stackTrace) {
      logger.error('Error fetching Pokemon list',
          error: e, stackTrace: stackTrace);
      setError('Failed to fetch Pokemon list');
    } finally {
      setLoading(false);
    }
  }

  @override
  Future<void> loadMorePokemons() async {
    if (state.isLoadingMore.value || !state.hasMore.value) return;

    state.isLoadingMore.value = true;
    try {
      final nextPage = state.currentPage.value + 1;
      final result = await getPokemonList(
        limit: PokemonListState.limit,
        offset: nextPage * PokemonListState.limit,
      );
      if (result.isSuccess) {
        final newPokemons = result.data ?? [];
        if (newPokemons.isNotEmpty) {
          state.addPokemons(newPokemons);
          state.currentPage.value = nextPage;
          logger.info(
            'Successfully loaded more Pokemon',
            data: {'page': nextPage, 'count': newPokemons.length},
          );
        } else {
          state.hasMore.value = false;
        }
      } else {
        setError(result.error ?? 'Failed to load more Pokemon');
      }
    } catch (e, stackTrace) {
      logger.error('Error loading more Pokemon',
          error: e, stackTrace: stackTrace);
      setError('Failed to load more Pokemon');
    } finally {
      state.isLoadingMore.value = false;
    }
  }

  @override
  Future<void> search(String query) async {
    if (query.isEmpty) {
      clearSearch();
      return;
    }

    setLoading(true);
    try {
      state.updateSearch(query);
      logger.info('Searching Pokemon', data: {'query': query});
      final result = await searchPokemon(query);
      if (result.isSuccess) {
        state.updatePokemons(result.data ?? []);
        logger.info(
          'Successfully searched Pokemon',
          data: {'query': query, 'count': result.data?.length ?? 0},
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
  Future<void> loadPokemonsByType(String type) async {
    if (type.isEmpty) {
      clearFilters();
      return;
    }

    setLoading(true);
    try {
      state.updateFilters(type: type);
      final result = await repository.getPokemonsByType(type);
      if (result.isSuccess) {
        state.updatePokemons(result.data ?? []);
        logger.info(
          'Successfully loaded Pokemon by type',
          data: {'type': type, 'count': result.data?.length ?? 0},
        );
      } else {
        setError(result.error ?? 'Failed to load Pokemon by type');
      }
    } catch (e, stackTrace) {
      logger.error('Error loading Pokemon by type',
          error: e, stackTrace: stackTrace);
      setError('Failed to load Pokemon by type');
    } finally {
      setLoading(false);
    }
  }

  @override
  Future<void> loadPokemonsByAbility(String ability) async {
    if (ability.isEmpty) {
      clearFilters();
      return;
    }

    setLoading(true);
    try {
      state.updateFilters(ability: ability);
      final result = await repository.getPokemonsByAbility(ability);
      if (result.isSuccess) {
        state.updatePokemons(result.data ?? []);
        logger.info(
          'Successfully loaded Pokemon by ability',
          data: {'ability': ability, 'count': result.data?.length ?? 0},
        );
      } else {
        setError(result.error ?? 'Failed to load Pokemon by ability');
      }
    } catch (e, stackTrace) {
      logger.error('Error loading Pokemon by ability',
          error: e, stackTrace: stackTrace);
      setError('Failed to load Pokemon by ability');
    } finally {
      setLoading(false);
    }
  }

  @override
  void clearFilters() {
    state.clearFilters();
    fetchPokemonList();
  }

  @override
  void clearSearch() {
    state.clearSearch();
    fetchPokemonList();
  }

  @override
  void navigateToDetail(IPokemonEntity pokemon) {
    Get.toNamed(
      '/pokemon-detail',
      arguments: {
        'pokemon': pokemon,
        'fromSearch': state.searchQuery.isNotEmpty,
      },
    );
  }
}
