import 'package:get/get.dart';

import '../../../../features/pokemon/domain/entities/i_pokemon_entity.dart';

/// State class for PokemonListController
class PokemonListState {
  final RxList<IPokemonEntity> pokemons = <IPokemonEntity>[].obs;
  final RxBool isLoadingMore = false.obs;
  final RxInt currentPage = 0.obs;
  final RxBool hasMore = true.obs;
  final RxString searchQuery = ''.obs;
  final RxString filterType = ''.obs;
  final RxString filterAbility = ''.obs;

  static const int limit = 20;

  void reset() {
    pokemons.clear();
    currentPage.value = 0;
    hasMore.value = true;
    searchQuery.value = '';
    filterType.value = '';
    filterAbility.value = '';
  }

  void updatePokemons(List<IPokemonEntity> newPokemons) {
    pokemons.value = newPokemons;
    hasMore.value = newPokemons.length >= limit;
  }

  void addPokemons(List<IPokemonEntity> newPokemons) {
    pokemons.addAll(newPokemons);
    hasMore.value = newPokemons.length >= limit;
  }

  void updateFilters({String? type, String? ability}) {
    if (type != null) filterType.value = type;
    if (ability != null) filterAbility.value = ability;
    hasMore.value = false; // Disable infinite scroll during filtering
  }

  void clearFilters() {
    filterType.value = '';
    filterAbility.value = '';
    hasMore.value = true;
  }

  void updateSearch(String query) {
    searchQuery.value = query;
    hasMore.value = false; // Disable infinite scroll during search
  }

  void clearSearch() {
    searchQuery.value = '';
    hasMore.value = true;
  }
}
