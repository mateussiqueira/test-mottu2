import 'package:get/get.dart';

import '../../../../core/presentation/adapters/getx_adapter.dart';
import '../../../../core/state/base_state_controller.dart';
import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';
import '../../../../features/pokemon/domain/repositories/pokemon_repository.dart';
import '../../domain/usecases/get_pokemon_list.dart';
import '../../domain/usecases/search_pokemon.dart';
import 'i_pokemon_list_controller.dart';

class PokemonListController extends BaseStateController
    implements IPokemonListController {
  final GetPokemonList getPokemonList;
  final SearchPokemon searchPokemon;
  final PokemonRepository repository;
  final _adapter = GetXAdapter();

  final _pokemons = <PokemonEntity>[].obs;
  final _isLoadingMore = false.obs;
  final _currentPage = 0.obs;
  final _hasMore = true.obs;
  final _searchQuery = ''.obs;
  final _filterType = ''.obs;
  final _filterAbility = ''.obs;

  static const int _limit = 20;

  PokemonListController({
    required this.getPokemonList,
    required this.searchPokemon,
    required this.repository,
  });

  @override
  RxList<PokemonEntity> get pokemons => _pokemons;

  @override
  RxBool get isLoading => isLoading;

  @override
  RxBool get isLoadingMore => _isLoadingMore;

  @override
  RxString get error => error;

  @override
  RxInt get currentPage => _currentPage;

  @override
  RxBool get hasMore => _hasMore;

  @override
  RxString get searchQuery => _searchQuery;

  @override
  RxString get filterType => _filterType;

  @override
  RxString get filterAbility => _filterAbility;

  @override
  void onInit() {
    super.onInit();
    fetchPokemonList();
  }

  @override
  Future<void> fetchPokemonList() async {
    await trackOperation('list_load', () async {
      setLoading(true);
      clearError();

      logger.info('Fetching Pokemon list');
      final result = await getPokemonList();
      _pokemons.value = result;
      logger.info(
        'Successfully fetched Pokemon list',
        data: {'count': result.length},
      );
    });
  }

  @override
  Future<void> loadMorePokemons() async {
    if (!_hasMore.value || _isLoadingMore.value) return;

    try {
      _isLoadingMore.value = true;
      final result = await repository.getPokemonList(
        offset: _currentPage.value * _limit,
        limit: _limit,
      );

      if (result.isSuccess && result.data != null) {
        if (result.data!.isEmpty) {
          _hasMore.value = false;
          return;
        }

        _pokemons.addAll(result.data!);
        _hasMore.value = result.data!.length == _limit;
        _currentPage.value++;
      } else {
        setError(result.error?.toString() ?? 'Unknown error');
      }
    } catch (e) {
      setError('Error loading more pokemons: $e');
    } finally {
      _isLoadingMore.value = false;
    }
  }

  @override
  Future<void> search(String query) async {
    await trackOperation('search', () async {
      _searchQuery.value = query;
      if (query.isEmpty) {
        _pokemons.clear();
        _currentPage.value = 0;
        _hasMore.value = true;
        await fetchPokemonList();
        return;
      }

      logger.info('Searching Pokemon', data: {'query': query});
      final result = await searchPokemon(query);
      _pokemons.value = result;
      logger.info(
        'Successfully searched Pokemon',
        data: {'query': query, 'count': result.length},
      );
    });
  }

  @override
  Future<void> loadPokemonsByType(String type) async {
    await trackOperation('type_filter', () async {
      setLoading(true);
      clearError();
      _filterType.value = type;
      _filterAbility.value = '';

      final result = await repository.getPokemonList(offset: 0, limit: 20);
      if (result.isSuccess && result.data != null) {
        final filteredPokemons = result.data!
            .where((pokemon) => pokemon.types.contains(type))
            .toList();
        _pokemons.value = filteredPokemons;
      } else {
        setError(result.error?.toString() ?? 'Unknown error');
      }
    });
  }

  @override
  Future<void> loadPokemonsByAbility(String ability) async {
    await trackOperation('ability_filter', () async {
      setLoading(true);
      clearError();
      _filterType.value = '';
      _filterAbility.value = ability;

      final result = await repository.getPokemonList(offset: 0, limit: 20);
      if (result.isSuccess && result.data != null) {
        final filteredPokemons = result.data!
            .where((pokemon) => pokemon.abilities.contains(ability))
            .toList();
        _pokemons.value = filteredPokemons;
      } else {
        setError(result.error?.toString() ?? 'Unknown error');
      }
    });
  }

  @override
  void clearFilters() {
    _filterType.value = '';
    _filterAbility.value = '';
    _pokemons.clear();
    _currentPage.value = 0;
    _hasMore.value = true;
    fetchPokemonList();
  }

  @override
  void navigateToDetail(PokemonEntity pokemon) {
    _adapter.toNamed(
      '/pokemon-detail',
      arguments: pokemon,
    );
  }
}
