import 'package:get/get.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';

/// State class for PokemonListController
class PokemonListState {
  static const int limit = AppConstants.pokemonPerPage;

  final pokemons = RxList<PokemonEntity>([]);
  final searchResults = RxList<PokemonEntity>([]);
  final isLoading = RxBool(false);
  final isLoadingMore = RxBool(false);
  final hasMore = RxBool(true);
  final error = RxnString();
  final searchQuery = RxString('');
  final offset = RxInt(0);
  final filterAbility = RxString('');
  final filterType = RxString('');

  void reset() {
    pokemons.clear();
    searchResults.clear();
    isLoading.value = false;
    isLoadingMore.value = false;
    hasMore.value = true;
    error.value = null;
    searchQuery.value = '';
    offset.value = 0;
    filterType.value = '';
    filterAbility.value = '';
  }

  void updatePokemons(List<PokemonEntity> newPokemons) {
    pokemons.value = newPokemons;
    hasMore.value = newPokemons.length >= limit;
  }

  void addPokemons(List<PokemonEntity> newPokemons) {
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
