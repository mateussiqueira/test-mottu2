import 'package:get/get.dart';

import '../../../../core/domain/entities/pokemon.dart';
import '../../../../core/domain/repositories/pokemon_repository.dart';

class PokemonListController extends GetxController {
  final PokemonRepository _repository;
  final pokemons = <Pokemon>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;
  final hasMore = true.obs;
  final searchQuery = ''.obs;
  final filterType = ''.obs;
  final filterAbility = ''.obs;
  final _limit = 20;
  int _offset = 0;

  PokemonListController(this._repository);

  @override
  void onInit() {
    super.onInit();
    loadPokemons();
  }

  Future<void> loadPokemons({bool refresh = false}) async {
    try {
      if (refresh) {
        _offset = 0;
        hasMore.value = true;
        filterType.value = '';
        filterAbility.value = '';
        searchQuery.value = '';
      }

      if (!hasMore.value) return;

      isLoading.value = true;
      error.value = '';

      final result = await _repository.getPokemons(
        limit: _limit,
        offset: _offset,
      );

      if (refresh) {
        pokemons.value = result;
      } else {
        pokemons.addAll(result);
      }

      _offset += _limit;
      hasMore.value = result.length >= _limit;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void loadMore() {
    if (!isLoading.value && hasMore.value) {
      loadPokemons();
    }
  }

  Future<void> searchPokemon(String query) async {
    try {
      if (query.isEmpty) {
        searchQuery.value = '';
        loadPokemons(refresh: true);
        return;
      }

      searchQuery.value = query;
      isLoading.value = true;
      error.value = '';

      final pokemon = await _repository.getPokemonByName(query.toLowerCase());
      pokemons.value = [pokemon];
      hasMore.value = false;
    } catch (e) {
      error.value = e.toString();
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
    loadPokemons(refresh: true);
  }
}
