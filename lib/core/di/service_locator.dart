
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/cache_service.dart';
import '../services/http_client.dart';
import '../services/image_cache_service.dart';
import '../data/repositories/pokemon_repository_impl.dart';
import '../domain/repositories/pokemon_repository.dart';
import '../../features/pokemon_list/domain/usecases/get_pokemons_use_case.dart';
import '../../features/pokemon_list/domain/usecases/search_pokemons_use_case.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Services
  final sharedPrefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  
  serviceLocator.registerLazySingleton<CacheService>(
    () => CacheService(serviceLocator<SharedPreferences>()),
  );
  
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());
  
  serviceLocator.registerLazySingleton<HttpClient>(
    () => HttpClient(serviceLocator<http.Client>()),
  );
  
  serviceLocator.registerLazySingleton<ImageCacheService>(
    () => ImageCacheService(),
  );

  // Repositories
  serviceLocator.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(
      httpClient: serviceLocator<HttpClient>(),
      cacheService: serviceLocator<CacheService>(),
    ),
  );

  // Use cases
  serviceLocator.registerLazySingleton<GetPokemonsUseCase>(
    () => GetPokemonsUseCase(serviceLocator<PokemonRepository>()),
  );
  
  serviceLocator.registerLazySingleton<SearchPokemonsUseCase>(
    () => SearchPokemonsUseCase(serviceLocator<PokemonRepository>()),
  );
}
