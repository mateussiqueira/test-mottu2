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
    final pokemonId = Get.arguments as int;
    loadPokemon(pokemonId);
  }

  Future<void> loadPokemon(int id) async {
    try {
      final result = await _repository.getPokemonById(id);
      result.fold(
        (pokemon) {
          this.pokemon.value = pokemon;
          _loadRelatedPokemons(pokemon);
        },
        (error) => Get.snackbar(
          'Error',
          'Failed to load pokemon details',
          snackPosition: SnackPosition.BOTTOM,
        ),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load pokemon details',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _loadRelatedPokemons(PokemonEntity pokemon) async {
    try {
      // Load pokemons with same type
      for (final type in pokemon.types) {
        final result = await _repository.getPokemonsByType(type);
        result.fold(
          (pokemons) {
            sameTypePokemons.value =
                pokemons.where((p) => p.id != pokemon.id).take(5).toList();
          },
          (error) => print('Failed to load pokemons with type $type'),
        );
      }

      // Load pokemons with same ability
      for (final ability in pokemon.abilities) {
        final result = await _repository.getPokemonsByAbility(ability);
        result.fold(
          (pokemons) {
            sameAbilityPokemons.value =
                pokemons.where((p) => p.id != pokemon.id).take(5).toList();
          },
          (error) => print('Failed to load pokemons with ability $ability'),
        );
      }
    } catch (e) {
      print('Failed to load related pokemons: $e');
    }
  }
}
