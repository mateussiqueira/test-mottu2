import 'package:get/get.dart';

import '../../../../core/config/di.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../../domain/usecases/get_pokemon_by_id.dart';
import '../../domain/usecases/get_pokemons_by_ability.dart';
import '../../domain/usecases/get_pokemons_by_type.dart';
import '../controllers/pokemon_detail_controller.dart';

class PokemonDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Use Cases
    Get.lazyPut(
      () => GetPokemonById(
        repository: getIt(),
      ),
    );

    Get.lazyPut(
      () => GetPokemonsByType(
        repository: getIt(),
      ),
    );

    Get.lazyPut(
      () => GetPokemonsByAbility(
        repository: getIt(),
      ),
    );

    // Controller
    Get.lazyPut(
      () {
        final controller = PokemonDetailController(
          getPokemonById: Get.find(),
          getPokemonsByType: Get.find(),
          getPokemonsByAbility: Get.find(),
        );

        final arguments = Get.arguments;
        if (arguments is Map<String, dynamic> &&
            arguments['pokemon'] is PokemonEntity) {
          controller.updatePokemon(arguments['pokemon'] as PokemonEntity);
        }

        return controller;
      },
    );
  }
}
