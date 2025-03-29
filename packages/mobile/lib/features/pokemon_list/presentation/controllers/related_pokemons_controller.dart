import 'package:get/get.dart';

import '../../../../core/presentation/adapters/getx_adapter.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';

class RelatedPokemonsController extends GetxController {
  final PokemonRepository _repository;
  final _adapter = GetXAdapter();
  final RxList<PokemonEntityImpl> relatedPokemons = <PokemonEntityImpl>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  RelatedPokemonsController(this._repository);

  Future<void> loadRelatedPokemons(PokemonEntityImpl pokemon) async {
    try {
      isLoading.value = true;
      error.value = '';

      final result = await _repository.getPokemonList(offset: 0, limit: 20);
      if (result.isSuccess && result.data != null) {
        final filteredPokemons = result.data!
            .where((p) =>
                p.types.any((type) => pokemon.types.contains(type)) ||
                p.abilities
                    .any((ability) => pokemon.abilities.contains(ability)))
            .where((p) => p.id != pokemon.id)
            .toList();
        relatedPokemons.value = filteredPokemons;
      } else {
        error.value = result.error?.toString() ?? 'Unknown error';
      }
    } catch (e) {
      error.value = 'Error loading related pokemons: $e';
      _adapter.showSnackbar(
        title: 'Error',
        message: 'Failed to load related pokemons. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToDetail(PokemonEntityImpl pokemon) {
    _adapter.toNamed(
      '/pokemon-detail',
      arguments: pokemon,
    );
  }
}
