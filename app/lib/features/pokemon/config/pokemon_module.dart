import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../data/datasources/i_pokemon_remote_datasource.dart';
import '../data/datasources/pokemon_remote_data_source.dart';
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
    // Data Sources
    getIt.registerLazySingleton<IPokemonRemoteDataSource>(
      () => PokemonRemoteDataSource(client: getIt<http.Client>()),
    );

    // Repositories
    getIt.registerLazySingleton<IPokemonRepository>(
      () => PokemonRepositoryImpl(getIt<IPokemonRemoteDataSource>()),
    );

    // Use Cases
    getIt.registerLazySingleton<IGetPokemonList>(
      () => GetPokemonList(getIt<IPokemonRepository>()),
    );

    getIt.registerLazySingleton<IGetPokemonDetail>(
      () => GetPokemonDetail(getIt<IPokemonRepository>()),
    );

    getIt.registerLazySingleton<IGetPokemonsByType>(
      () => GetPokemonsByType(getIt<IPokemonRepository>()),
    );

    getIt.registerLazySingleton<IGetPokemonsByAbility>(
      () => GetPokemonsByAbility(getIt<IPokemonRepository>()),
    );

    getIt.registerLazySingleton<ISearchPokemon>(
      () => SearchPokemon(getIt<IPokemonRepository>()),
    );
  }
}
