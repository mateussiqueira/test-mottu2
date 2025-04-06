import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/di/service_locator.dart';
import '../data/datasources/i_pokemon_remote_datasource.dart';
import '../data/datasources/pokemon_remote_data_source_impl.dart';
import '../data/repositories/pokemon_repository_impl.dart';
import '../domain/repositories/i_pokemon_repository.dart';
import '../domain/usecases/get_pokemon_by_ability.dart' as ability;
import '../domain/usecases/get_pokemon_by_description.dart' as description;
import '../domain/usecases/get_pokemon_by_evolution.dart' as evolution;
import '../domain/usecases/get_pokemon_by_id.dart' as id;
import '../domain/usecases/get_pokemon_by_move.dart' as move;
import '../domain/usecases/get_pokemon_by_stat.dart' as stat;
import '../domain/usecases/get_pokemon_by_type.dart' as type;
import '../domain/usecases/get_pokemon_list.dart' as list;
import '../domain/usecases/search_pokemon.dart' as search;
import '../presentation/bloc/pokemon_bloc.dart';

/// Module for Pokemon feature dependencies
class PokemonModule extends GetxService {
  @override
  void onInit() {
    super.onInit();

    // External
    Get.lazyPut<http.Client>(
      () => http.Client(),
    );

    // Data Sources
    Get.lazyPut<PokemonRemoteDataSourceImpl>(
      () => PokemonRemoteDataSourceImpl(
        client: Get.find<http.Client>(),
      ),
    );

    // Repositories
    Get.lazyPut<IPokemonRepository>(
      () => PokemonRepositoryImpl(
        remoteDataSource: Get.find<PokemonRemoteDataSourceImpl>(),
      ),
    );

    // Use Cases
    Get.lazyPut<list.GetPokemonList>(
      () => list.GetPokemonList(Get.find<IPokemonRepository>()),
    );
    Get.lazyPut<id.GetPokemonById>(
      () => id.GetPokemonById(Get.find<IPokemonRepository>()),
    );
    Get.lazyPut<search.SearchPokemon>(
      () => search.SearchPokemon(Get.find<IPokemonRepository>()),
    );
    Get.lazyPut<type.GetPokemonsByType>(
      () => type.GetPokemonsByType(Get.find<IPokemonRepository>()),
    );
    Get.lazyPut<ability.GetPokemonsByAbility>(
      () => ability.GetPokemonsByAbility(Get.find<IPokemonRepository>()),
    );
    Get.lazyPut<move.GetPokemonsByMove>(
      () => move.GetPokemonsByMove(Get.find<IPokemonRepository>()),
    );
    Get.lazyPut<evolution.GetPokemonsByEvolution>(
      () => evolution.GetPokemonsByEvolution(Get.find<IPokemonRepository>()),
    );
    Get.lazyPut<stat.GetPokemonsByStat>(
      () => stat.GetPokemonsByStat(Get.find<IPokemonRepository>()),
    );
    Get.lazyPut<description.GetPokemonsByDescription>(
      () =>
          description.GetPokemonsByDescription(Get.find<IPokemonRepository>()),
    );

    // Bloc
    Get.lazyPut<PokemonBloc>(
      () => PokemonBloc(Get.find<IPokemonRepository>()),
    );
  }
  
  /// Setup method for registering dependencies with the service locator
  void setup() {
    final remoteDataSource = locator<IPokemonRemoteDataSource>();
    final repository = PokemonRepositoryImpl(remoteDataSource);
    
    locator.registerLazySingleton<IPokemonRepository>(() => repository);
    
    // Register use cases
    locator.registerFactory<list.GetPokemonList>(
        () => list.GetPokemonList(locator()));
    locator.registerFactory<id.GetPokemonById>(
        () => id.GetPokemonById(locator()));
    locator.registerFactory<search.SearchPokemon>(
        () => search.SearchPokemon(locator()));
    locator.registerFactory<type.GetPokemonsByType>(
        () => type.GetPokemonsByType(locator()));
    locator.registerFactory<ability.GetPokemonsByAbility>(
        () => ability.GetPokemonsByAbility(locator()));
    locator.registerFactory<move.GetPokemonsByMove>(
        () => move.GetPokemonsByMove(locator()));
    locator.registerFactory<evolution.GetPokemonsByEvolution>(
        () => evolution.GetPokemonsByEvolution(locator()));
    locator.registerFactory<stat.GetPokemonsByStat>(
        () => stat.GetPokemonsByStat(locator()));
    locator.registerFactory<description.GetPokemonsByDescription>(
        () => description.GetPokemonsByDescription(locator()));
        
    // Register bloc
    locator.registerFactory<PokemonBloc>(
        () => PokemonBloc(locator()));
  }
}
