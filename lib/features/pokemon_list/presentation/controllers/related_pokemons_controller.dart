import 'package:get/get.dart';

import '../../../../core/domain/entities/pokemon.dart';
import '../../../../core/domain/repositories/pokemon_repository.dart';

class RelatedPokemonsController extends GetxController {
  final PokemonRepository _repository;
  final pokemons = <Pokemon>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;
  final filterType = ''.obs;
  final filterAbility = ''.obs;

  RelatedPokemonsController(this._repository);

  Future<void> loadPokemonsByType(String type) async {
    try {
      isLoading.value = true;
      error.value = '';
      filterType.value = type;
      filterAbility.value = '';

      final result = await _repository.getPokemonsByType(type);
      pokemons.value = result;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadPokemonsByAbility(String ability) async {
    try {
      isLoading.value = true;
      error.value = '';
      filterType.value = '';
      filterAbility.value = ability;

      final result = await _repository.getPokemonsByAbility(ability);
      pokemons.value = result;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
