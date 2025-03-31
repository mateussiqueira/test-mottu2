import 'package:get/get.dart';

import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';

class PokemonDetailController extends GetxController {
  final PokemonRepository repository;
  final _pokemon = Rxn<PokemonEntity>();
  final _isLoading = false.obs;
  final _error = ''.obs;

  PokemonDetailController(this.repository);

  PokemonEntity? get pokemon => _pokemon.value;
  bool get isLoading => _isLoading.value;
  String get error => _error.value;

  Future<void> loadPokemonDetail(int id) async {
    _isLoading.value = true;
    _error.value = '';

    try {
      final result = await repository.getPokemonDetail(id);
      if (result.isSuccess && result.data != null) {
        _pokemon.value = result.data!;
      } else {
        _error.value =
            result.error?.toString() ?? 'An unexpected error occurred';
      }
    } catch (e) {
      _error.value = 'An unexpected error occurred';
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Future<void> refresh() async {
    if (_pokemon.value != null) {
      await loadPokemonDetail(_pokemon.value!.id);
    }
  }
}
