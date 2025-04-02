import 'package:get/get.dart';

import '../../features/pokemon/domain/entities/pokemon_entity.dart';
import '../cache/pokemon_cache_manager.dart';

enum AppStatus { initial, loading, loaded, error }

class PokemonStateManager extends GetxController {
  final PokemonCacheManager _cacheManager;

  final _status = AppStatus.initial.obs;
  final _pokemons = <PokemonEntityImpl>[].obs;
  final _filteredPokemons = <PokemonEntityImpl>[].obs;
  final _searchQuery = ''.obs;
  final _error = Rxn<String>();

  PokemonStateManager(this._cacheManager);

  AppStatus get status => _status.value;
  List<PokemonEntityImpl> get pokemons => _pokemons;
  List<PokemonEntityImpl> get filteredPokemons => _filteredPokemons;
  String get searchQuery => _searchQuery.value;
  String? get error => _error.value;

  void updatePokemons(List<PokemonEntityImpl> newPokemons) {
    _pokemons.value = newPokemons;
    _updateFilteredPokemons();
    _cachePokemons(newPokemons);
  }

  void updateSearchQuery(String query) {
    if (query == searchQuery) return;
    _searchQuery.value = query;
    _updateFilteredPokemons();
  }

  void _updateFilteredPokemons() {
    if (searchQuery.isEmpty) {
      _filteredPokemons.value = _pokemons;
      return;
    }

    _filteredPokemons.value = _pokemons
        .where((pokemon) => _matchesSearch(pokemon, searchQuery))
        .toList();
  }

  bool _matchesSearch(PokemonEntityImpl pokemon, String query) {
    final lowercaseQuery = query.toLowerCase();
    return pokemon.name.toLowerCase().contains(lowercaseQuery) ||
        pokemon.types
            .any((type) => type.toLowerCase().contains(lowercaseQuery));
  }

  void _cachePokemons(List<PokemonEntityImpl> pokemons) {
    _cacheManager.set(
      'pokemon_list',
      pokemons,
      duration: const Duration(hours: 1),
    );
  }

  void setError(String? errorMessage) {
    _error.value = errorMessage;
  }

  void setStatus(AppStatus newStatus) {
    _status.value = newStatus;
  }

  @override
  void onInit() {
    super.onInit();
    _loadCachedPokemons();
  }

  void _loadCachedPokemons() {
    final cachedPokemons =
        _cacheManager.get<List<PokemonEntityImpl>>('pokemon_list');
    if (cachedPokemons != null) {
      updatePokemons(cachedPokemons);
    }
  }
}
