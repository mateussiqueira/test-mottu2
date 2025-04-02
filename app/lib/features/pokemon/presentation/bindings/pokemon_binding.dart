import 'package:get/get.dart';

import '../../data/repositories/pokemon_repository_impl.dart';
import '../../domain/repositories/i_pokemon_repository.dart';
import '../../domain/usecases/get_pokemon_detail.dart';
import '../../domain/usecases/get_pokemon_list.dart';
import '../../domain/usecases/get_pokemons_by_ability.dart';
import '../../domain/usecases/get_pokemons_by_type.dart';
import '../../domain/usecases/i_get_pokemon_detail.dart';
import '../../domain/usecases/i_get_pokemon_list.dart';
import '../../domain/usecases/i_get_pokemons_by_ability.dart';
import '../../domain/usecases/i_get_pokemons_by_type.dart';
import '../../domain/usecases/i_search_pokemon.dart';
import '../../domain/usecases/search_pokemon.dart';
import '../controllers/pokemon_detail_controller.dart';
import '../controllers/pokemon_list_controller.dart';

/// Binding class for Pokemon feature dependencies
class PokemonBinding extends Bindings {
  @override
  void dependencies() {
    // Repositories
    Get.lazyPut<IPokemonRepository>(
      () => PokemonRepositoryImpl(Get.find()),
    );

    // Use Cases
    Get.lazyPut<IGetPokemonList>(
      () => GetPokemonList(Get.find()),
    );
    Get.lazyPut<IGetPokemonDetail>(
      () => GetPokemonDetail(Get.find()),
    );
    Get.lazyPut<ISearchPokemon>(
      () => SearchPokemon(Get.find()),
    );
    Get.lazyPut<IGetPokemonsByType>(
      () => GetPokemonsByType(Get.find()),
    );
    Get.lazyPut<IGetPokemonsByAbility>(
      () => GetPokemonsByAbility(Get.find()),
    );

    // Controllers
    Get.lazyPut<PokemonListController>(
      () => PokemonListController(
        Get.find<IGetPokemonList>(),
        Get.find<ISearchPokemon>(),
        Get.find<IGetPokemonsByType>(),
        Get.find<IGetPokemonsByAbility>(),
      ),
    );
    Get.lazyPut<PokemonDetailController>(
      () => PokemonDetailController(
        Get.find<IGetPokemonDetail>(),
      ),
    );
  }
}
