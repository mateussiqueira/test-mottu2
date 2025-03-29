import 'package:get/get.dart';
import 'package:pokeapi/core/presentation/adapters/getx_adapter.dart';
import 'package:pokeapi/features/pokemon_list/domain/entities/pokemon.dart'; // Ensure this is the correct path for the Pokemon class
import 'package:pokeapi/features/pokemon_list/domain/repositories/pokemon_repository.dart';

class PokemonListController extends GetxController {
  final PokemonRepository _repository;
  final _adapter = GetXAdapter();
  final RxList<PokemonEntity> pokemons = <PokemonEntity>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString error = ''.obs;
  final RxInt currentPage = 0.obs;
  final RxBool hasMore = true.obs;
  final searchQuery = ''.obs;
  final filterType = ''.obs;
  final filterAbility = ''.obs;
  final _limit = 20;

  PokemonListController(this._repository);

  @override
  void onInit() {
    super.onInit();
    loadPokemons();
  }

  Future<void> loadPokemons() async {
    if (!hasMore.value || isLoading.value) return;

    try {
      isLoading.value = true;
      error.value = '';
      final newPokemons = await _repository.getPokemons(
        offset: currentPage.value * _limit,
        limit: _limit,
      );

      if (newPokemons.isEmpty) {
        hasMore.value = false;
        return;
      }

      pokemons.addAll(newPokemons);
      hasMore.value = newPokemons.length == _limit;
      currentPage.value++;
    } catch (e) {
      error.value = 'Error loading pokemons: $e';
      _adapter.showSnackbar(
        title: 'Error',
        message: 'Failed to load pokemons. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMorePokemons() async {
    if (!hasMore.value || isLoadingMore.value) return;

    try {
      isLoadingMore.value = true;
      final newPokemons = await _repository.getPokemons(
        offset: currentPage.value * _limit,
        limit: _limit,
      );

      if (newPokemons.isEmpty) {
        hasMore.value = false;
        return;
      }

      pokemons.addAll(newPokemons);
      hasMore.value = newPokemons.length == _limit;
      currentPage.value++;
    } catch (e) {
      error.value = 'Error loading more pokemons: $e';
    } finally {
      isLoadingMore.value = false;
    }
  }

  void reset() {
    pokemons.clear();
    currentPage.value = 0;
    hasMore.value = true;
    error.value = '';
  }

  Future<void> searchPokemon(String query) async {
    if (query.isEmpty) {
      pokemons.clear();
      currentPage.value = 0;
      hasMore.value = true;
      loadPokemons();
      return;
    }

    try {
      isLoading.value = true;
      error.value = '';
      final results = await _repository.searchPokemons(query);
      pokemons.value = results;
    } catch (e) {
      error.value = 'Error searching pokemons: $e';
      _adapter.showSnackbar(
        title: 'Error',
        message: 'Failed to search pokemons. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadPokemonsByType(String type) async {
    try {
      isLoading.value = true;
      error.value = '';
      filterType.value = type;
      filterAbility.value = '';

      final result = await _repository.getPokemonsByType(type);
      pokemons.value = result;
    } catch (e) {
      error.value = 'Error loading pokemons by type: $e';
      _adapter.showSnackbar(
        title: 'Error',
        message: 'Failed to load pokemons by type. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadPokemonsByAbility(String ability) async {
    try {
      isLoading.value = true;
      error.value = '';
      filterType.value = '';
      filterAbility.value = ability;

      final result = await _repository.getPokemonsByAbility(ability);
      pokemons.value = result;
    } catch (e) {
      error.value = 'Error loading pokemons by ability: $e';
      _adapter.showSnackbar(
        title: 'Error',
        message: 'Failed to load pokemons by ability. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  void clearFilters() {
    filterType.value = '';
    filterAbility.value = '';
    pokemons.clear();
    currentPage.value = 0;
    hasMore.value = true;
    loadPokemons();
  }

  void navigateToDetail(PokemonEntity pokemon) {
    _adapter.toNamed(
      '/pokemon-detail',
      arguments: pokemon,
    );
  }
}
