import 'package:get/get.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_detail/data/datasources/pokemon_detail_remote_datasource.dart';
import 'package:mobile/features/pokemon_detail/data/repositories/pokemon_detail_repository_impl.dart';
import 'package:mobile/features/pokemon_detail/domain/repositories/pokemon_detail_repository.dart';
import 'package:mobile/features/pokemon_detail/domain/usecases/get_pokemon_by_id.dart';
import 'package:mobile/features/pokemon_detail/domain/usecases/get_pokemons_by_ability.dart';
import 'package:mobile/features/pokemon_detail/domain/usecases/get_pokemons_by_type.dart';
import 'package:mobile/features/pokemon_detail/presentation/controllers/pokemon_detail_controller.dart';

class PokemonDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Datasources
    Get.lazyPut<PokemonDetailRemoteDataSource>(
      () => PokemonDetailRemoteDataSourceImpl(),
    );

    // Repositories
    Get.lazyPut<PokemonDetailRepository>(
      () => PokemonDetailRepositoryImpl(
        remoteDataSource: Get.find(),
      ),
    );

    // Use Cases
    Get.lazyPut(
      () => GetPokemonById(
        repository: Get.find(),
      ),
    );

    Get.lazyPut(
      () => GetPokemonsByType(
        repository: Get.find(),
      ),
    );

    Get.lazyPut(
      () => GetPokemonsByAbility(
        repository: Get.find(),
      ),
    );

    // Controllers
    Get.lazyPut(
      () {
        final controller = PokemonDetailController(
          getPokemonById: Get.find(),
          getPokemonsByType: Get.find(),
          getPokemonsByAbility: Get.find(),
        );

        // Se houver um Pokémon nos argumentos, atualiza o controller
        final arguments = Get.arguments;
        if (arguments is PokemonEntity) {
          controller.updatePokemon(arguments);
        }

        return controller;
      },
    );
  }
}
