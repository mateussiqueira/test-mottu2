import 'package:get/get.dart';

import '../../features/pokemon/domain/entities/i_pokemon_entity.dart';
import 'app_status.dart';

class BasePokemonState {
  final _status = AppStatus.initial.obs;
  final _pokemons = <IPokemonEntity>[].obs;
  final _filteredPokemons = <IPokemonEntity>[].obs;
  final _searchQuery = ''.obs;
  final _error = Rxn<String>();

  AppStatus get status => _status.value;
  List<IPokemonEntity> get pokemons => _pokemons;
  List<IPokemonEntity> get filteredPokemons => _filteredPokemons;
  String get searchQuery => _searchQuery.value;
  String? get error => _error.value;

  void setStatus(AppStatus newStatus) {
    _status.value = newStatus;
  }

  void setError(String? errorMessage) {
    _error.value = errorMessage;
  }

  void updatePokemons(List<IPokemonEntity> newPokemons) {
    _pokemons.value = newPokemons;
  }

  void updateSearchQuery(String query) {
    if (query == searchQuery) return;
    _searchQuery.value = query;
  }

  void updateFilteredPokemons(List<IPokemonEntity> filteredPokemons) {
    _filteredPokemons.value = filteredPokemons;
  }
}
