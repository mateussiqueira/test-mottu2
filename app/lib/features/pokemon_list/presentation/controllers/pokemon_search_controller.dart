import 'package:get/get.dart';

import '../../../../core/presentation/adapters/getx_adapter.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../../../pokemon/domain/repositories/pokemon_repository.dart';

class PokemonSearchController extends GetxController {
  final PokemonRepository _repository;
  final _adapter = GetXAdapter();
  final RxList<PokemonEntityImpl> searchResults = <PokemonEntityImpl>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxString searchQuery = ''.obs;

  PokemonSearchController(this._repository);

  Future<void> searchPokemon(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      isLoading.value = true;
      error.value = '';
      searchQuery.value = query;

      final result = await _repository.searchPokemon(query);
      if (result.isSuccess && result.data != null) {
        searchResults.value = result.data!;
      } else {
        error.value = result.error?.toString() ?? 'Unknown error';
      }
    } catch (e) {
      error.value = 'Error searching pokemons: $e';
      _adapter.showSnackbar(
        title: 'Error',
        message: 'Failed to search pokemons. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  void clearSearch() {
    searchQuery.value = '';
    searchResults.clear();
    error.value = '';
  }

  void navigateToDetail(PokemonEntityImpl pokemon) {
    _adapter.toNamed(
      '/pokemon-detail',
      arguments: pokemon,
    );
  }
}
