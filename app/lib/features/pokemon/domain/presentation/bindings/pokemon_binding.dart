import 'package:get/get.dart';

import '../../data/repositories/pokemon_repository_impl.dart';
import '../../domain/repositories/i_pokemon_repository.dart';
import '../../domain/usecases/get_pokemon_detail.dart';
import '../../domain/usecases/get_pokemon_list.dart';
import '../../domain/usecases/get_pokemons_by_ability.dart';
import '../../domain/usecases/get_pokemons_by_type.dart';
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
    Get.lazyPut<GetPokemonList>(
      () => GetPokemonList(Get.find()),
    );
    Get.lazyPut<GetPokemonDetail>(
      () => GetPokemonDetail(Get.find()),
    );
    Get.lazyPut<SearchPokemon>(
      () => SearchPokemon(Get.find()),
    );
    Get.lazyPut<GetPokemonsByType>(
      () => GetPokemonsByType(Get.find()),
    );
    Get.lazyPut<GetPokemonsByAbility>(
      () => GetPokemonsByAbility(Get.find()),
    );

    // Controllers
    Get.lazyPut<PokemonListController>(
      () => PokemonListController(
        Get.find<GetPokemonList>(),
        Get.find<SearchPokemon>(),
        Get.find<GetPokemonsByType>(),
        Get.find<GetPokemonsByAbility>(),
      ),
    );
    Get.lazyPut<PokemonDetailController>(
      () => PokemonDetailController(
        Get.find<GetPokemonDetail>(),
      ),
    );
  }
}
