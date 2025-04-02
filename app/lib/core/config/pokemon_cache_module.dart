import 'package:get_it/get_it.dart';

import '../cache/i_cache_manager.dart';
import '../cache/shared_preferences_cache_manager.dart';
import 'base_cache_module.dart';

class PokemonCacheModule extends BaseCacheModule {
  @override
  Future<void> _setupCache(GetIt getIt) async {
    getIt.registerLazySingleton<ICacheManager>(
      () => SharedPreferencesCacheManager(
        prefs: getIt(),
        prefix: 'pokemon_cache',
        fromJson: (json) => json as Map<String, dynamic>,
        toJson: (value) => value as Map<String, dynamic>,
      ),
    );
  }
}
