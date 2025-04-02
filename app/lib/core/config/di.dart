import 'package:get_it/get_it.dart';

import '../../features/pokemon/config/pokemon_module.dart';
import '../cache/pokemon_cache_module.dart';
import 'base_dependency_module.dart';
import 'cache_module.dart';
import 'infrastructure_module.dart';
import 'localization_module.dart';
import 'presentation_module.dart';

final getIt = GetIt.instance;

class DependencyInjection extends BaseDependencyModule {
  DependencyInjection(super.getIt);

  @override
  Future<void> setup(GetIt getIt) async {
    // Infrastructure
    await InfrastructureModule.setup(getIt);

    // Cache
    final pokemonCacheModule = PokemonCacheModule();
    final cacheModule = CacheModule(pokemonCacheModule, getIt);
    getIt.registerSingleton<CacheModule>(cacheModule);
    await cacheModule.setup(getIt);

    // Presentation
    PresentationModule.setup(getIt);

    // Localization
    LocalizationModule.setup(getIt);

    // Features
    PokemonModule.setup(getIt);
  }
}

Future<void> setupDependencies() async {
  final di = DependencyInjection(getIt);
  await di.setup(getIt);
}
