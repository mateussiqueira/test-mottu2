import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../data/datasources/i_pokemon_remote_datasource.dart';
import '../data/datasources/pokemon_remote_data_source_impl.dart';
import '../data/repositories/pokemon_repository_impl.dart';
import '../domain/repositories/i_pokemon_repository.dart';
import '../domain/usecases/get_pokemon_detail.dart';
import '../domain/usecases/get_pokemon_list.dart';
import '../domain/usecases/get_pokemons_by_ability.dart';
import '../domain/usecases/get_pokemons_by_type.dart';
import '../domain/usecases/search_pokemon.dart';

/// Module for Pokemon feature dependency injection
class PokemonModule {
  /// Sets up all dependencies for the Pokemon feature
  static void init() {
    final getIt = GetIt.instance;

    // External
    getIt.registerLazySingleton<http.Client>(
      () => http.Client(),
    );

    // Data Sources
    getIt.registerLazySingleton<IPokemonRemoteDataSource>(
      () => PokemonRemoteDataSourceImpl(
        client: getIt<http.Client>(),
      ),
    );

    // Repositories
    getIt.registerLazySingleton<IPokemonRepository>(
      () => PokemonRepositoryImpl(
        getIt<PokemonRemoteDataSourceImpl>(),
      ),
    );

    // Use Cases
    getIt.registerLazySingleton<GetPokemonList>(
      () => GetPokemonList(getIt<IPokemonRepository>()),
    );

    getIt.registerLazySingleton<GetPokemonDetail>(
      () => GetPokemonDetail(getIt<IPokemonRepository>()),
    );

    getIt.registerLazySingleton<GetPokemonsByType>(
      () => GetPokemonsByType(getIt<IPokemonRepository>()),
    );

    getIt.registerLazySingleton<GetPokemonsByAbility>(
      () => GetPokemonsByAbility(getIt<IPokemonRepository>()),
    );

    getIt.registerLazySingleton<SearchPokemon>(
      () => SearchPokemon(getIt<IPokemonRepository>()),
    );
  }
}
