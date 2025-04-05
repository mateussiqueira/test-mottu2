import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_list/features/pokemon/data/datasources/pokemon_remote_datasource_impl.dart';
import 'package:pokemon_list/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon_list/features/pokemon/domain/presentation/controllers/pokemon_detail_controller.dart';
import 'package:pokemon_list/features/pokemon/domain/presentation/controllers/pokemon_list_controller.dart';
import 'package:pokemon_list/features/pokemon/domain/repositories/i_pokemon_repository.dart';

/// Binding class for Pokemon feature dependencies
class PokemonBinding extends Bindings {
  @override
  void dependencies() {
    final httpClient = http.Client();
    const baseUrl = 'https://pokeapi.co/api/v2';

    final dataSource = PokemonRemoteDataSourceImpl(
      client: httpClient,
      baseUrl: baseUrl,
    );

    final repository = PokemonRepositoryImpl(
      remoteDataSource: dataSource,
    );

    Get.lazyPut<IPokemonRepository>(
      () => repository,
    );

    Get.lazyPut<PokemonListController>(
      () => PokemonListController(
        repository: Get.find<IPokemonRepository>(),
      ),
    );

    Get.lazyPut<PokemonDetailController>(
      () => PokemonDetailController(
        repository: Get.find<IPokemonRepository>(),
      ),
    );
  }
}
