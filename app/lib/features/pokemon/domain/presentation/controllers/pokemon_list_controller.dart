import 'package:get/get.dart';
import 'package:pokemon_list/features/pokemon/domain/entities/pokemon_entity_impl.dart';
import 'package:pokemon_list/features/pokemon/domain/errors/failures.dart';
import 'package:pokemon_list/features/pokemon/domain/repositories/i_pokemon_repository.dart';

/// Controller for Pokemon list page
class PokemonListController extends GetxController {
  final IPokemonRepository repository;

  final _pokemons = <PokemonEntityImpl>[].obs;
  final _isLoading = false.obs;
  final _error = Rxn<PokemonFailure>();
  final _offset = 0.obs;
  final _limit = 20.obs;
  final _hasMore = true.obs;

  PokemonListController({
    required this.repository,
  });

  List<PokemonEntityImpl> get pokemons => _pokemons;
  bool get isLoading => _isLoading.value;
  PokemonFailure? get error => _error.value;
  bool get hasMore => _hasMore.value;

  @override
  void onInit() {
    super.onInit();
    loadPokemons();
  }

  /// Loads the initial list of Pokemon
  Future<void> loadPokemons() async {
    if (_isLoading.value || !_hasMore.value) return;

    _isLoading.value = true;
    _error.value = null;

    try {
      final result = await repository.getPokemonList(
        offset: _offset.value,
        limit: _limit.value,
      );

      result.fold(
        (failure) => _error.value = failure,
        (pokemons) {
          if (pokemons.isEmpty) {
            _hasMore.value = false;
          } else {
            _pokemons.addAll(pokemons);
            _offset.value += _limit.value;
          }
        },
      );
    } catch (e) {
      _error.value = PokemonApiFailure(e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  /// Searches for Pokemon by name
  Future<void> searchPokemon(String query) async {
    if (query.isEmpty) {
      _pokemons.clear();
      _offset.value = 0;
      _hasMore.value = true;
      await loadPokemons();
      return;
    }

    _isLoading.value = true;
    _error.value = null;

    try {
      final result = await repository.searchPokemon(query: query);

      result.fold(
        (failure) => _error.value = failure,
        (pokemons) {
          _pokemons.assignAll(pokemons);
          _hasMore.value = false;
        },
      );
    } catch (e) {
      _error.value = PokemonApiFailure(e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  /// Filters Pokemon by type
  Future<void> getPokemonsByType(String type) async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final result = await repository.getPokemonsByType(type: type);

      result.fold(
        (failure) => _error.value = failure,
        (pokemons) {
          _pokemons.assignAll(pokemons);
          _hasMore.value = false;
        },
      );
    } catch (e) {
      _error.value = PokemonApiFailure(e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  /// Filters Pokemon by ability
  Future<void> getPokemonsByAbility(String ability) async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final result = await repository.getPokemonsByAbility(ability: ability);

      result.fold(
        (failure) => _error.value = failure,
        (pokemons) {
          _pokemons.assignAll(pokemons);
          _hasMore.value = false;
        },
      );
    } catch (e) {
      _error.value = PokemonApiFailure(e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  void clearError() {
    _error.value = null;
  }

  void navigateToDetail(PokemonEntityImpl pokemon) {
    Get.toNamed(
      '/pokemon/detail',
      arguments: pokemon,
    );
  }
}
