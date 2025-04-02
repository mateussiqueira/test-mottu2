import 'package:get_it/get_it.dart';

import '../data/datasources/i_pokemon_remote_datasource.dart';
import '../data/datasources/pokemon_remote_datasource_impl.dart';
import '../data/repositories/pokemon_repository_impl.dart';
import '../domain/repositories/i_pokemon_repository.dart';
import '../domain/usecases/get_pokemon_detail.dart';
import '../domain/usecases/get_pokemon_list.dart';
import '../domain/usecases/get_pokemons_by_ability.dart';
import '../domain/usecases/get_pokemons_by_type.dart';
import '../domain/usecases/search_pokemon.dart';

class PokemonModule {
  static void setup(GetIt getIt) {
    // Data Sources
    getIt.registerLazySingleton<IPokemonRemoteDataSource>(
      () => PokemonRemoteDataSourceImpl(dio: getIt()),
    );

    // Repositories
    getIt.registerLazySingleton<IPokemonRepository>(
      () => PokemonRepositoryImpl(
        remoteDataSource: getIt(),
        logger: getIt(),
      ),
    );

    // Use Cases
    getIt.registerLazySingleton(() => GetPokemonList(getIt()));
    getIt.registerLazySingleton(() => GetPokemonDetail(getIt()));
    getIt.registerLazySingleton(() => GetPokemonsByType(getIt()));
    getIt.registerLazySingleton(() => GetPokemonsByAbility(getIt()));
    getIt.registerLazySingleton(() => SearchPokemon(getIt()));
  }
}
