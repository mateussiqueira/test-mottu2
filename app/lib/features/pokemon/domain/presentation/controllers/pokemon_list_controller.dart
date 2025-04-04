import 'package:get/get.dart';

import '../../entities/pokemon_entity.dart';
import '../../usecases/i_get_pokemon_list.dart';
import '../../usecases/i_get_pokemons_by_ability.dart';
import '../../usecases/i_get_pokemons_by_type.dart';
import '../../usecases/i_search_pokemon.dart';

/// Controller for Pokemon list page
class PokemonListController extends GetxController {
  final IGetPokemonList _getPokemonList;
  final ISearchPokemon _searchPokemon;
  final IGetPokemonsByType _getPokemonsByType;
  final IGetPokemonsByAbility _getPokemonsByAbility;

  PokemonListController(
    this._getPokemonList,
    this._searchPokemon,
    this._getPokemonsByType,
    this._getPokemonsByAbility,
  );

  final RxList<PokemonEntity> _pokemons = <PokemonEntity>[].obs;
  final RxList<PokemonEntity> _filteredPokemons = <PokemonEntity>[].obs;
  final RxString _searchQuery = ''.obs;
  final RxBool _isLoading = false.obs;
  final RxBool _hasMore = true.obs;
  final RxInt _currentPage = 0.obs;
  final RxString _error = ''.obs;

  List<PokemonEntity> get pokemons => _pokemons;
  List<PokemonEntity> get filteredPokemons => _filteredPokemons;
  String get searchQuery => _searchQuery.value;
  bool get isLoading => _isLoading.value;
  bool get hasMore => _hasMore.value;
  int get currentPage => _currentPage.value;
  String? get error => _error.value.isEmpty ? null : _error.value;

  @override
  void onInit() {
    super.onInit();
    loadPokemons();
  }

  /// Loads the initial list of Pokemon
  Future<void> loadPokemons() async {
    _isLoading.value = true;
    _error.value = '';
    try {
      final result = await _getPokemonList(limit: 151, offset: 0);
      if (result.isSuccess && result.data != null) {
        _pokemons.value = result.data!;
      } else {
        _error.value = result.error?.message ?? 'Unknown error';
      }
    } catch (e) {
      _error.value = 'Failed to load Pokemon: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  /// Searches for Pokemon by name
  Future<void> searchPokemon(String query) async {
    if (query.isEmpty) {
      loadPokemons();
      return;
    }

    _isLoading.value = true;
    _error.value = '';
    try {
      final result = await _searchPokemon(query);
      if (result.isSuccess && result.data != null) {
        _pokemons.value = result.data!;
      } else {
        _error.value = result.error?.message ?? 'Unknown error';
      }
    } catch (e) {
      _error.value = 'Failed to search Pokemon: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  /// Filters Pokemon by type
  Future<void> filterByType(String type) async {
    _isLoading.value = true;
    _error.value = '';
    try {
      final result = await _getPokemonsByType(type);
      if (result.isSuccess && result.data != null) {
        _pokemons.value = result.data!;
      } else {
        _error.value = result.error?.message ?? 'Unknown error';
      }
    } catch (e) {
      _error.value = 'Failed to filter Pokemon by type: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  /// Filters Pokemon by ability
  Future<void> filterByAbility(String ability) async {
    _isLoading.value = true;
    _error.value = '';
    try {
      final result = await _getPokemonsByAbility(ability);
      if (result.isSuccess && result.data != null) {
        _pokemons.value = result.data!;
      } else {
        _error.value = result.error?.message ?? 'Unknown error';
      }
    } catch (e) {
      _error.value = 'Failed to filter Pokemon by ability: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  void clearFilters() {
    _filteredPokemons.value = _pokemons;
    _hasMore.value = true;
  }

  void clearSearch() {
    _searchQuery.value = '';
    _filteredPokemons.value = _pokemons;
    _hasMore.value = true;
  }

  void navigateToDetail(PokemonEntity pokemon) {
    Get.toNamed(
      '/pokemon/detail',
      arguments: pokemon,
    );
  }
}
