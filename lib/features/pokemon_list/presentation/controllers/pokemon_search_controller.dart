import 'package:get/get.dart';
import 'package:pokeapi/features/pokemon_list/domain/entities/pokemon.dart';
import 'package:pokeapi/features/pokemon_list/domain/repositories/pokemon_repository.dart';

class PokemonSearchController extends GetxController {
  final PokemonRepository _repository;
  final RxList<PokemonEntity> pokemons = <PokemonEntity>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final RxString error = ''.obs;

  PokemonSearchController(this._repository);

  @override
  void onInit() {
    super.onInit();
    ever(searchQuery, (_) => _searchPokemons());
  }

  Future<void> _searchPokemons() async {
    if (searchQuery.value.isEmpty) {
      pokemons.clear();
      return;
    }

    try {
      isLoading.value = true;
      error.value = '';
      final results = await _repository.searchPokemons(searchQuery.value);
      pokemons.value = results;
    } catch (e) {
      error.value = 'Error searching pokemons: $e';
      pokemons.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
