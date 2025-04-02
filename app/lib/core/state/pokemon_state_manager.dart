import 'package:get/get.dart';

import '../../features/pokemon/domain/entities/i_pokemon_entity.dart';
import 'app_status.dart';
import 'base_pokemon_state.dart';
import 'i_pokemon_cache_handler.dart';
import 'i_pokemon_search_handler.dart';
import 'i_pokemon_state_manager.dart';

class PokemonStateManager extends GetxController
    implements IPokemonStateManager {
  final IPokemonCacheHandler _cacheHandler;
  final IPokemonSearchHandler _searchHandler;
  final BasePokemonState _state;

  PokemonStateManager(this._cacheHandler, this._searchHandler)
      : _state = BasePokemonState();

  @override
  AppStatus get status => _state.status;

  @override
  List<IPokemonEntity> get pokemons => _state.pokemons;

  @override
  List<IPokemonEntity> get filteredPokemons => _state.filteredPokemons;

  @override
  String get searchQuery => _state.searchQuery;

  @override
  String? get error => _state.error;

  @override
  void updatePokemons(List<IPokemonEntity> newPokemons) {
    _state.updatePokemons(newPokemons);
    _updateFilteredPokemons();
    _cacheHandler.cachePokemons(newPokemons);
  }

  @override
  void updateSearchQuery(String query) {
    _state.updateSearchQuery(query);
    _updateFilteredPokemons();
  }

  void _updateFilteredPokemons() {
    final filteredPokemons = _searchHandler.filterPokemons(
      _state.pokemons,
      _state.searchQuery,
    );
    _state.updateFilteredPokemons(filteredPokemons);
  }

  @override
  void setError(String? errorMessage) {
    _state.setError(errorMessage);
  }

  @override
  void setStatus(AppStatus newStatus) {
    _state.setStatus(newStatus);
  }

  @override
  Future<void> initialize() async {
    await _loadCachedPokemons();
  }

  Future<void> _loadCachedPokemons() async {
    final cachedPokemons = await _cacheHandler.loadCachedPokemons();
    if (cachedPokemons != null) {
      updatePokemons(cachedPokemons);
    }
  }

  @override
  void onInit() {
    super.onInit();
    initialize();
  }
}
