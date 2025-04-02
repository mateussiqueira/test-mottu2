import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'i_cache_module.dart';

abstract class BaseCacheModule implements ICacheModule {
  @override
  Future<void> setup(GetIt getIt) async {
    await _setupSharedPreferences(getIt);
    await _setupCache(getIt);
  }

  Future<void> _setupSharedPreferences(GetIt getIt) async {
    final prefs = await SharedPreferences.getInstance();
    getIt.registerLazySingleton(() => prefs);
  }

  Future<void> _setupCache(GetIt getIt);
}
