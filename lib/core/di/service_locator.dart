import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/pokemon_list/data/adapters/poke_api_adapter.dart';
import '../../features/pokemon_list/data/repositories/pokemon_repository_impl.dart';
import '../../features/pokemon_list/presentation/bloc/pokemon_list_bloc.dart';
import '../domain/repositories/pokemon_repository.dart';
import '../services/cache_service.dart';
import '../services/connectivity_service.dart';
import '../services/image_cache_service.dart';

class ServiceLocator {
  static final GetIt getIt = GetIt.instance;

  static Future<void> init() async {
    // Serviços
    final prefs = await SharedPreferences.getInstance();
    getIt.registerSingleton<CacheService>(CacheService(prefs));
    getIt.registerSingleton<ConnectivityService>(ConnectivityService());
    getIt.registerSingleton<ImageCacheService>(ImageCacheService());
    getIt.registerSingleton<http.Client>(http.Client());

    // Adapters
    getIt.registerSingleton<PokeApiAdapter>(
      PokeApiAdapter(
        client: getIt<http.Client>(),
        prefs: prefs,
      ),
    );

    // Repositories
    getIt.registerSingleton<PokemonRepository>(
      PokemonRepositoryImpl(getIt<PokeApiAdapter>()),
    );

    // Blocs
    getIt.registerFactory<PokemonListBloc>(
      () => PokemonListBloc(repository: getIt<PokemonRepository>()),
    );
  }
}
