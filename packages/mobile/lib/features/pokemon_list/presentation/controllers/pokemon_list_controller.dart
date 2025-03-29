import 'package:get/get.dart';

import '../../../../core/presentation/adapters/getx_adapter.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';

class PokemonListController extends GetxController {
  final PokemonRepository _repository;
  final _adapter = GetXAdapter();
  final RxList<PokemonEntityImpl> pokemons = <PokemonEntityImpl>[].obs;
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
      final result = await _repository.getPokemonList(
        offset: currentPage.value * _limit,
        limit: _limit,
      );

      if (result.isSuccess && result.data != null) {
        if (result.data!.isEmpty) {
          hasMore.value = false;
          return;
        }

        pokemons.addAll(result.data!);
        hasMore.value = result.data!.length == _limit;
        currentPage.value++;
      } else {
        error.value = result.error?.toString() ?? 'Unknown error';
      }
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
      final result = await _repository.getPokemonList(
        offset: currentPage.value * _limit,
        limit: _limit,
      );

      if (result.isSuccess && result.data != null) {
        if (result.data!.isEmpty) {
          hasMore.value = false;
          return;
        }

        pokemons.addAll(result.data!);
        hasMore.value = result.data!.length == _limit;
        currentPage.value++;
      } else {
        error.value = result.error?.toString() ?? 'Unknown error';
      }
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
      final result = await _repository.searchPokemon(query);
      if (result.isSuccess && result.data != null) {
        pokemons.value = result.data!;
      } else {
        error.value = result.error?.toString() ?? 'Unknown error';
      }
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

      final result = await _repository.getPokemonList(offset: 0, limit: 20);
      if (result.isSuccess && result.data != null) {
        final filteredPokemons = result.data!
            .where((pokemon) => pokemon.types.contains(type))
            .toList();
        pokemons.value = filteredPokemons;
      } else {
        error.value = result.error?.toString() ?? 'Unknown error';
      }
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

      final result = await _repository.getPokemonList(offset: 0, limit: 20);
      if (result.isSuccess && result.data != null) {
        final filteredPokemons = result.data!
            .where((pokemon) => pokemon.abilities.contains(ability))
            .toList();
        pokemons.value = filteredPokemons;
      } else {
        error.value = result.error?.toString() ?? 'Unknown error';
      }
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

  void navigateToDetail(PokemonEntityImpl pokemon) {
    _adapter.toNamed(
      '/pokemon-detail',
      arguments: pokemon,
    );
  }
}
