import 'package:get_it/get_it.dart';

import '../presentation/localization/getx_localization_manager.dart';
import '../presentation/localization/i_localization_manager.dart';

class LocalizationModule {
  static void setup(GetIt getIt) {
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
  }
}
