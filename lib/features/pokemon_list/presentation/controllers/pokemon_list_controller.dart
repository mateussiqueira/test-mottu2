import 'package:get/get.dart';
import 'package:pokeapi/features/pokemon_list/domain/entities/pokemon.dart'; // Ensure this is the correct path for the Pokemon class
import 'package:pokeapi/features/pokemon_list/domain/repositories/pokemon_repository.dart';

class PokemonListController extends GetxController {
  final PokemonRepository _repository;
  final RxList<PokemonEntity> pokemons = <PokemonEntity>[].obs;
  final RxBool isLoading = false.obs;
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
    } finally {
      isLoading.value = false;
    }
  }

  void reset() {
    pokemons.clear();
    currentPage.value = 0;
    hasMore.value = true;
    error.value = '';
  }

  Future<void> searchPokemon(String query) async {
    try {
      if (query.isEmpty) {
        searchQuery.value = '';
        reset();
        loadPokemons();
        return;
      }

      searchQuery.value = query;
      isLoading.value = true;
      error.value = '';

      final result = await _repository.searchPokemons(query.toLowerCase());
      pokemons.value = result;
      hasMore.value = false;
    } catch (e) {
      error.value = 'Erro ao buscar Pokémon. Tente novamente.';
      pokemons.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadPokemonsByType(String type) async {
    try {
      filterType.value = type;
      filterAbility.value = '';
      searchQuery.value = '';
      isLoading.value = true;
      error.value = '';

      final result = await _repository.getPokemonsByType(type);
      pokemons.value = result;
      hasMore.value = false;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadPokemonsByAbility(String ability) async {
    try {
      filterType.value = '';
      filterAbility.value = ability;
      searchQuery.value = '';
      isLoading.value = true;
      error.value = '';

      final result = await _repository.getPokemonsByAbility(ability);
      pokemons.value = result;
      hasMore.value = false;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void clearFilters() {
    loadPokemons();
  }
}
