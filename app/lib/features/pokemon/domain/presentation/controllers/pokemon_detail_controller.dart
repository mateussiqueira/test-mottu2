import 'package:get/get.dart';
import 'package:pokemon_list/features/pokemon/domain/entities/pokemon_entity_impl.dart';
import 'package:pokemon_list/features/pokemon/domain/errors/failures.dart';
import 'package:pokemon_list/features/pokemon/domain/repositories/i_pokemon_repository.dart';

class PokemonDetailController extends GetxController {
  final IPokemonRepository repository;

  final _pokemon = Rxn<PokemonEntityImpl>();
  final _isLoading = false.obs;
  final _error = Rxn<PokemonFailure>();
  final _relatedPokemons = <PokemonEntityImpl>[].obs;

  PokemonDetailController({
    required this.repository,
  });

  PokemonEntityImpl? get pokemon => _pokemon.value;
  bool get isLoading => _isLoading.value;
  PokemonFailure? get error => _error.value;
  List<PokemonEntityImpl> get relatedPokemons => _relatedPokemons;

  @override
  void onInit() {
    super.onInit();
    final pokemonId = Get.arguments as int;
    loadPokemon(pokemonId);
  }

  Future<void> loadPokemon(int id) async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final result = await repository.getPokemonById(id: id);

      result.fold(
        (failure) => _error.value = failure,
        (pokemon) {
          _pokemon.value = pokemon;
          loadRelatedPokemons(pokemon);
        },
      );
    } catch (e) {
      _error.value = PokemonApiFailure(e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> loadRelatedPokemons(PokemonEntityImpl pokemon) async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final result =
          await repository.getPokemonsByType(type: pokemon.types.first);

      result.fold(
        (failure) => _error.value = failure,
        (pokemons) {
          _relatedPokemons.assignAll(
            pokemons.where((p) => p.id != pokemon.id).take(6),
          );
        },
      );
    } catch (e) {
      _error.value = PokemonApiFailure(e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  void clearError() {
    _error.value = null;
  }
}
