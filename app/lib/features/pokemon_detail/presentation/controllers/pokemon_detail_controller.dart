import 'package:get/get.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_detail/domain/usecases/get_pokemon_by_id.dart';
import 'package:mobile/features/pokemon_detail/domain/usecases/get_pokemons_by_ability.dart';
import 'package:mobile/features/pokemon_detail/domain/usecases/get_pokemons_by_type.dart';

class PokemonDetailController extends GetxController {
  final GetPokemonById getPokemonById;
  final GetPokemonsByType getPokemonsByType;
  final GetPokemonsByAbility getPokemonsByAbility;

  final pokemon = Rxn<PokemonEntity>();
  final sameTypePokemons = <PokemonEntity>[].obs;
  final sameAbilityPokemons = <PokemonEntity>[].obs;
  final isLoading = false.obs;

  PokemonDetailController({
    required this.getPokemonById,
    required this.getPokemonsByType,
    required this.getPokemonsByAbility,
  });

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is Map<String, dynamic> &&
        arguments['pokemon'] is PokemonEntity) {
      updatePokemon(arguments['pokemon'] as PokemonEntity);
    }
  }

  void updatePokemon(PokemonEntity newPokemon) {
    pokemon.value = newPokemon;
    loadRelatedPokemons();
  }

  Future<void> loadPokemon(int id) async {
    try {
      isLoading.value = true;
      final result = await getPokemonById(id);
      pokemon.value = result;
      await loadRelatedPokemons();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load Pokemon details',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadRelatedPokemons() async {
    if (pokemon.value == null) return;

    try {
      final type = pokemon.value!.types.first;
      final ability = pokemon.value!.abilities.first;

      final typePokemons = await getPokemonsByType(type);
      final abilityPokemons = await getPokemonsByAbility(ability);

      sameTypePokemons.value =
          typePokemons.where((p) => p.id != pokemon.value!.id).take(5).toList();

      sameAbilityPokemons.value = abilityPokemons
          .where((p) => p.id != pokemon.value!.id)
          .take(5)
          .toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load related Pokemons',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<List<PokemonEntity>> fetchPokemonsByType(String type) async {
    return await getPokemonsByType(type);
  }

  Future<List<PokemonEntity>> fetchPokemonsByAbility(String ability) async {
    return await getPokemonsByAbility(ability);
  }

  @override
  void onClose() {
    sameTypePokemons.clear();
    sameAbilityPokemons.clear();
    super.onClose();
  }
}
