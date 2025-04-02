import 'package:get_it/get_it.dart';

import '../cache/i_pokemon_cache_manager.dart';
import 'i_pokemon_cache_handler.dart';
import 'i_pokemon_search_handler.dart';
import 'i_pokemon_state_manager.dart';
import 'pokemon_cache_handler.dart';
import 'pokemon_search_handler.dart';
import 'pokemon_state_manager.dart';

class PokemonStateModule {
  static void register() {
    final getIt = GetIt.instance;

    getIt.registerLazySingleton<IPokemonCacheHandler>(
      () => PokemonCacheHandler(getIt<IPokemonCacheManager>()),
    );

    getIt.registerLazySingleton<IPokemonSearchHandler>(
      () => PokemonSearchHandler(),
    );

    getIt.registerLazySingleton<IPokemonStateManager>(
      () => PokemonStateManager(
        getIt<IPokemonCacheHandler>(),
        getIt<IPokemonSearchHandler>(),
      ),
    );
  }
}
