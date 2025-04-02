import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cache/i_cache_manager.dart';

class CacheModule {
  static Future<void> setup(GetIt getIt) async {
    // SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    getIt.registerLazySingleton(() => prefs);

    // Cache
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
