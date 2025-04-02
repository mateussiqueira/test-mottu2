import 'package:get_it/get_it.dart';

import '../../features/pokemon/config/pokemon_module.dart';
import 'cache_module.dart';
import 'infrastructure_module.dart';
import 'localization_module.dart';
import 'presentation_module.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Infrastructure
  await InfrastructureModule.setup(getIt);

  // Cache
  await CacheModule.setup(getIt);

  // Presentation
  PresentationModule.setup(getIt);

  // Localization
  LocalizationModule.setup(getIt);

  // Features
  PokemonModule.setup(getIt);
}
