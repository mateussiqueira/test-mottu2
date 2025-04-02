import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/logging/i_logger.dart';
import '../../pokemon_detail/data/datasources/pokemon_detail_remote_datasource.dart';
import '../../pokemon_detail/data/repositories/pokemon_detail_repository_impl.dart';
import '../../pokemon_detail/domain/repositories/i_pokemon_detail_repository.dart';
import '../data/clients/pokemon_api_client.dart';
import '../data/datasources/i_pokemon_remote_datasource.dart';
import '../data/datasources/pokemon_remote_datasource_impl.dart';
import '../data/repositories/pokemon_repository_impl.dart';
import '../domain/repositories/i_pokemon_repository.dart';
import '../domain/usecases/get_pokemon_detail.dart';
import '../domain/usecases/get_pokemon_list.dart';
import '../domain/usecases/get_pokemons_by_ability.dart';
import '../domain/usecases/get_pokemons_by_type.dart';
import '../domain/usecases/i_get_pokemon_detail.dart';
import '../domain/usecases/i_get_pokemon_list.dart';
import '../domain/usecases/i_get_pokemons_by_ability.dart';
import '../domain/usecases/i_get_pokemons_by_type.dart';
import '../domain/usecases/i_search_pokemon.dart';
import '../domain/usecases/search_pokemon.dart';

/// Module for Pokemon feature dependency injection
class PokemonModule {
  /// Sets up all dependencies for the Pokemon feature
  static void setup(GetIt getIt) {
    // API Client
    getIt.registerLazySingleton<PokemonApiClient>(
      () => PokemonApiClient(getIt<Dio>()),
    );

    // Data Sources
    getIt.registerLazySingleton<IPokemonRemoteDataSource>(
      () => PokemonRemoteDataSourceImpl(apiClient: getIt<PokemonApiClient>()),
    );

    getIt.registerLazySingleton<PokemonDetailRemoteDataSource>(
      () => PokemonDetailRemoteDataSourceImpl(dio: getIt<Dio>()),
    );

    // Repositories
    getIt.registerLazySingleton<IPokemonRepository>(
      () => PokemonRepositoryImpl(getIt<IPokemonRemoteDataSource>()),
    );

    getIt.registerLazySingleton<IPokemonDetailRepository>(
      () => PokemonDetailRepositoryImpl(
        remoteDataSource: getIt<PokemonDetailRemoteDataSource>(),
        logger: getIt<ILogger>(),
      ),
    );

    // Use Cases
    getIt.registerLazySingleton<IGetPokemonList>(
      () => GetPokemonList(getIt()),
    );

    getIt.registerLazySingleton<IGetPokemonDetail>(
      () => GetPokemonDetail(getIt()),
    );

    getIt.registerLazySingleton<IGetPokemonsByType>(
      () => GetPokemonsByType(getIt()),
    );

    getIt.registerLazySingleton<IGetPokemonsByAbility>(
      () => GetPokemonsByAbility(getIt()),
    );

    getIt.registerLazySingleton<ISearchPokemon>(
      () => SearchPokemon(getIt()),
    );
  }
}
