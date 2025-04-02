import 'package:get_it/get_it.dart';

import '../cache/pokemon_cache_module.dart';
import 'base_dependency_module.dart';

class CacheModule extends BaseDependencyModule {
  final PokemonCacheModule _pokemonCacheModule;

  CacheModule(this._pokemonCacheModule, GetIt getIt) : super(getIt);

  @override
  Future<void> setup(GetIt getIt) async {
    await _pokemonCacheModule.setup();
  }
}
