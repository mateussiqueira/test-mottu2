import 'package:get_it/get_it.dart';

import '../../features/pokemon/presentation/routes/pokemon_router.dart';
import '../bindings/initial_binding.dart';
import '../logging/i_logger.dart';
import '../performance/i_performance_monitor.dart';
import '../presentation/localization/getx_localization_manager.dart';
import '../presentation/localization/i_localization_manager.dart';
import '../presentation/routes/app_router.dart';
import '../presentation/routes/i_router.dart';
import '../presentation/theme/getx_theme_manager.dart';
import '../presentation/theme/i_theme_manager.dart';

class PresentationModule {
  static void setup(GetIt getIt) {
    // Theme
    getIt.registerLazySingleton<IThemeManager>(
      () => GetXThemeManager(),
    );

    // Localization
    getIt.registerLazySingleton<ILocalizationManager>(
      () => GetXLocalizationManager(
        translations: {
          'en': {
            'app_name': 'PokeAPI',
            'search': 'Search',
            'loading': 'Loading...',
            'error': 'Error',
            'try_again': 'Try Again',
            'no_results': 'No results found',
            'pokemon_types': 'Types',
            'pokemon_abilities': 'Abilities',
            'related_pokemons': 'Related Pokemons',
            'same_type_pokemons': 'Same Type Pokemons',
            'same_ability_pokemons': 'Same Ability Pokemons',
          },
          'pt': {
            'app_name': 'PokeAPI',
            'search': 'Buscar',
            'loading': 'Carregando...',
            'error': 'Erro',
            'try_again': 'Tentar Novamente',
            'no_results': 'Nenhum resultado encontrado',
            'pokemon_types': 'Tipos',
            'pokemon_abilities': 'Habilidades',
            'related_pokemons': 'Pokémons Relacionados',
            'same_type_pokemons': 'Pokémons do Mesmo Tipo',
            'same_ability_pokemons': 'Pokémons com a Mesma Habilidade',
          },
        },
        defaultLocale: 'en',
        supportedLocales: ['en', 'pt'],
      ),
    );

    // Router
    getIt.registerLazySingleton<PokemonRouter>(() => PokemonRouter());
    getIt.registerLazySingleton<IRouter>(
      () => AppRouter(getIt<PokemonRouter>()),
    );

    // Initial Binding
    getIt.registerLazySingleton<InitialBinding>(
      () => InitialBinding(
        logger: getIt<ILogger>(),
        performanceMonitor: getIt<IPerformanceMonitor>(),
      ),
    );
  }
}
