import 'package:get/get.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon/domain/repositories/pokemon_repository.dart';

class PokemonDetailController extends GetxController {
  final PokemonRepository _repository;
  final pokemon = Rxn<PokemonEntity>();
  final sameTypePokemons = <PokemonEntity>[].obs;
  final sameAbilityPokemons = <PokemonEntity>[].obs;

  PokemonDetailController(this._repository);

  @override
  void onInit() {
    super.onInit();
    final initialPokemon = Get.arguments as PokemonEntity?;
    if (initialPokemon != null) {
      pokemon.value = initialPokemon;
      _loadRelatedPokemons(initialPokemon);
    }
  }

  Future<void> loadPokemon(int id) async {
    try {
      final result = await _repository.getPokemonDetail(id);
      result.fold(
        (failure) => Get.snackbar(
          'Error',
          'Failed to load pokemon',
          snackPosition: SnackPosition.BOTTOM,
        ),
        (pokemonData) {
          pokemon.value = pokemonData;
          _loadRelatedPokemons(pokemonData);
        },
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load pokemon',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _loadRelatedPokemons(PokemonEntity pokemon) async {
    try {
      // Load pokemons with same type
      final typeResult =
          await _repository.getPokemonsByType(pokemon.types.first);
      typeResult.fold(
        (failure) => print('Failed to load pokemons with same type: $failure'),
        (pokemons) {
          sameTypePokemons.value =
              pokemons.where((p) => p.id != pokemon.id).take(5).toList();
        },
      );

      // Load pokemons with same ability
      final abilityResult =
          await _repository.getPokemonsByAbility(pokemon.abilities.first);
      abilityResult.fold(
        (failure) =>
            print('Failed to load pokemons with same ability: $failure'),
        (pokemons) {
          sameAbilityPokemons.value =
              pokemons.where((p) => p.id != pokemon.id).take(5).toList();
        },
      );
    } catch (e) {
      print('Failed to load related pokemons: $e');
    }
  }
}
