import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../data/datasources/pokemon_remote_data_source_impl.dart';
import '../../data/repositories/pokemon_repository_impl.dart';
import '../../domain/presentation/bloc/pokemon_bloc.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../../domain/usecases/get_pokemon_by_ability.dart';
import '../../domain/usecases/get_pokemon_by_description.dart';
import '../../domain/usecases/get_pokemon_by_evolution.dart';
import '../../domain/usecases/get_pokemon_by_id.dart';
import '../../domain/usecases/get_pokemon_by_move.dart';
import '../../domain/usecases/get_pokemon_by_stat.dart';
import '../../domain/usecases/get_pokemon_by_type.dart';
import '../../domain/usecases/get_pokemon_list.dart';
import '../../domain/usecases/search_pokemon.dart';

/// Module for Pokemon feature dependencies
class PokemonModule extends GetxService {
  @override
  void onInit() {
    super.onInit();

    // Data Sources
    Get.lazyPut<PokemonRemoteDataSourceImpl>(
      () => PokemonRemoteDataSourceImpl(
        dio: Get.find<Dio>(),
        baseUrl: 'https://pokeapi.co/api/v2',
      ),
    );

    // Repositories
    Get.lazyPut<PokemonRepository>(
      () => PokemonRepositoryImpl(
        Get.find<PokemonRemoteDataSourceImpl>(),
      ),
    );

    // Use Cases
    Get.lazyPut<GetPokemonList>(
      () => GetPokemonList(Get.find<PokemonRepository>()),
    );
    Get.lazyPut<GetPokemonById>(
      () => GetPokemonById(Get.find<PokemonRepository>()),
    );
    Get.lazyPut<SearchPokemon>(
      () => SearchPokemon(Get.find<PokemonRepository>()),
    );
    Get.lazyPut<GetPokemonsByType>(
      () => GetPokemonsByType(Get.find<PokemonRepository>()),
    );
    Get.lazyPut<GetPokemonsByAbility>(
      () => GetPokemonsByAbility(Get.find<PokemonRepository>()),
    );
    Get.lazyPut<GetPokemonsByMove>(
      () => GetPokemonsByMove(Get.find<PokemonRepository>()),
    );
    Get.lazyPut<GetPokemonsByEvolution>(
      () => GetPokemonsByEvolution(Get.find<PokemonRepository>()),
    );
    Get.lazyPut<GetPokemonsByStat>(
      () => GetPokemonsByStat(Get.find<PokemonRepository>()),
    );
    Get.lazyPut<GetPokemonsByDescription>(
      () => GetPokemonsByDescription(Get.find<PokemonRepository>()),
    );

    // Bloc
    Get.lazyPut<PokemonBloc>(
      () => PokemonBloc(
        getPokemonList: Get.find<GetPokemonList>(),
        getPokemonById: Get.find<GetPokemonById>(),
        searchPokemon: Get.find<SearchPokemon>(),
        getPokemonByType: Get.find<GetPokemonsByType>(),
        getPokemonByAbility: Get.find<GetPokemonsByAbility>(),
        getPokemonByMove: Get.find<GetPokemonsByMove>(),
        getPokemonByEvolution: Get.find<GetPokemonsByEvolution>(),
        getPokemonByStat: Get.find<GetPokemonsByStat>(),
        getPokemonByDescription: Get.find<GetPokemonsByDescription>(),
      ),
    );
  }
}
