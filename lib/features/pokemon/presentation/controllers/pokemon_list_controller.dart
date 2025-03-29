import 'package:get/get.dart';
import 'package:pokeapi/core/domain/entities/pokemon_entity.dart';
import 'package:pokeapi/core/domain/errors/pokemon_error.dart';
import 'package:pokeapi/features/pokemon/domain/usecases/get_pokemon_list_usecase.dart';
import 'package:pokeapi/features/pokemon/domain/usecases/search_pokemon_usecase.dart';

/// Controlador GetX para a lista de Pokemons
class PokemonListController extends GetxController {
  final GetPokemonListUseCase _getPokemonListUseCase;
  final SearchPokemonUseCase _searchPokemonUseCase;

  PokemonListController({
    required GetPokemonListUseCase getPokemonListUseCase,
    required SearchPokemonUseCase searchPokemonUseCase,
  })  : _getPokemonListUseCase = getPokemonListUseCase,
        _searchPokemonUseCase = searchPokemonUseCase;

  // Estado
  final _pokemons = <PokemonEntity>[].obs;
  final _isLoading = false.obs;
  final _error = Rxn<PokemonError>();
  final _hasMore = true.obs;
  final _currentPage = 0.obs;
  final _searchQuery = ''.obs;

  // Getters
  List<PokemonEntity> get pokemons => _pokemons;
  bool get isLoading => _isLoading.value;
  PokemonError? get error => _error.value;
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
    if (_isLoading.value || !_hasMore.value) return;

    try {
      _isLoading.value = true;
      _error.value = null;

      final result = await _getPokemonListUseCase(
        offset: _currentPage.value * 20,
        limit: 20,
      );

      if (result.isSuccess) {
        final newPokemons = result.data;
        if (newPokemons == null || newPokemons.isEmpty) {
          _hasMore.value = false;
        } else {
          _pokemons.addAll(newPokemons);
          _currentPage.value++;
        }
      } else {
        _error.value = result.error;
      }
    } catch (e) {
      _error.value = UnknownError(
        message: 'An unexpected error occurred',
        code: 'UNKNOWN_ERROR',
        originalError: e,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  /// Busca Pokemons por nome
  Future<void> searchPokemons(String query) async {
    if (_isLoading.value) return;

    try {
      _isLoading.value = true;
      _error.value = null;
      _searchQuery.value = query;

      final result = await _searchPokemonUseCase(query);

      if (result.isSuccess) {
        final pokemons = result.data;
        if (pokemons != null) {
          _pokemons.clear();
          _pokemons.addAll(pokemons);
        }
        _hasMore.value = false;
        _currentPage.value = 0;
      } else {
        _error.value = result.error;
      }
    } catch (e) {
      _error.value = UnknownError(
        message: 'An unexpected error occurred',
        code: 'UNKNOWN_ERROR',
        originalError: e,
      );
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
