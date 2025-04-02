import 'package:get/get.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:mobile/features/pokemon/domain/usecases/get_pokemon_list_use_case.dart';
import 'package:mobile/features/pokemon/domain/usecases/search_pokemon_use_case.dart';

class PokemonListController extends GetxController {
  final PokemonRepository _repository;
  final GetPokemonListUseCase _getPokemonListUseCase;
  final SearchPokemonUseCase _searchPokemonUseCase;

  PokemonListController(this._repository)
      : _getPokemonListUseCase = GetPokemonListUseCase(_repository),
        _searchPokemonUseCase = SearchPokemonUseCase(_repository);

  // Estado
  final _pokemons = <PokemonEntityImpl>[].obs;
  final _isLoading = false.obs;
  final _error = Rxn<String>();
  final _hasMore = true.obs;
  final _currentPage = 0.obs;
  final _searchQuery = ''.obs;

  // Getters
  List<PokemonEntity> get pokemons => _pokemons;
  bool get isLoading => _isLoading.value;
  String? get error => _error.value;
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
    if (_isLoading.value) return;

    _isLoading.value = true;
    _error.value = null;

    try {
      final result = await _repository.getPokemonList(
        limit: 20,
        offset: _currentPage.value * 20,
      );

      if (result.isSuccess && result.data != null) {
        if (result.data!.isEmpty) {
          _hasMore.value = false;
          return;
        }
        _pokemons.addAll(result.data!);
        _hasMore.value = result.data!.length == 20;
        _currentPage.value++;
      } else if (result.error != null) {
        _error.value = result.error!.toString();
      } else {
        _error.value = 'Erro ao carregar pokémons';
      }
    } catch (e) {
      _error.value = 'Erro ao carregar pokémons';
    }

    _isLoading.value = false;
  }

  /// Busca Pokemons por nome
  Future<void> searchPokemons(String query) async {
    if (query.isEmpty) {
      await resetSearch();
      return;
    }

    _isLoading.value = true;
    _error.value = null;
    _searchQuery.value = query;

    try {
      final result = await _repository.searchPokemon(query);

      if (result.isSuccess && result.data != null) {
        _pokemons.clear();
        _pokemons.addAll(result.data!);
        _hasMore.value = false;
      } else if (result.error != null) {
        _error.value = result.error!.toString();
      } else {
        _error.value = 'Erro ao buscar pokémons';
      }
    } catch (e) {
      _error.value = 'Erro ao buscar pokémons';
    }

    _isLoading.value = false;
  }

  /// Reseta a busca
  Future<void> resetSearch() async {
    _searchQuery.value = '';
    _hasMore.value = true;
    _currentPage.value = 0;
    _pokemons.clear();
    await loadPokemons();
  }

  /// Atualiza a lista de Pokemons
  @override
  Future<void> refresh() async {
    _pokemons.clear();
    _hasMore.value = true;
    _currentPage.value = 0;
    await loadPokemons();
  }
}
