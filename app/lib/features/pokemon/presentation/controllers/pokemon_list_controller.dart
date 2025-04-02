import 'package:get/get.dart';

import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';

/// Controlador GetX para a lista de Pokemons
class PokemonListController extends GetxController {
  final PokemonRepository repository;

  PokemonListController(this.repository);

  // Estado
  final _pokemons = <PokemonEntityImpl>[].obs;
  final _isLoading = false.obs;
  final _error = ''.obs;
  final _hasMore = true.obs;
  final _currentPage = 0.obs;
  final _searchQuery = ''.obs;

  // Getters
  List<PokemonEntityImpl> get pokemons => _pokemons;
  bool get isLoading => _isLoading.value;
  String get error => _error.value;
  bool get hasMore => _hasMore.value;
  int get currentPage => _currentPage.value;
  String get searchQuery => _searchQuery.value;

  @override
  void onInit() {
    super.onInit();
    loadPokemons();
  }

  /// Carrega a lista de Pokemons
  Future<void> loadPokemons() async {
    _isLoading.value = true;
    _error.value = '';

    try {
      final result = await repository.getPokemonList(
        limit: 20,
        offset: _currentPage.value * 20,
      );
      result.fold(
        (failure) => _error.value = 'Failed to load pokemons',
        (pokemons) {
          _pokemons.value = pokemons;
          _hasMore.value = pokemons.length == 20;
          _currentPage.value++;
        },
      );
    } catch (e) {
      _error.value = 'An unexpected error occurred';
    } finally {
      _isLoading.value = false;
    }
  }

  /// Busca Pokemons por nome
  Future<void> searchPokemon(String query) async {
    if (query.isEmpty) {
      loadPokemons();
      return;
    }

    _isLoading.value = true;
    _error.value = '';

    try {
      final result = await repository.searchPokemon(query);
      result.fold(
        (failure) => _error.value = 'Failed to search pokemons',
        (pokemons) {
          _pokemons.value = pokemons;
          _hasMore.value = false;
        },
      );
    } catch (e) {
      _error.value = 'An unexpected error occurred';
    } finally {
      _isLoading.value = false;
    }
  }

  /// Reseta a busca
  void resetSearch() {
    _searchQuery.value = '';
    _hasMore.value = true;
    _currentPage.value = 0;
    _pokemons.clear();
    loadPokemons();
  }

  /// Recarrega a lista de Pokemons
  @override
  Future<void> refresh() async {
    _pokemons.clear();
    _hasMore.value = true;
    _currentPage.value = 0;
    await loadPokemons();
  }
}
