import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/pokemon/data/datasources/pokemon_local_datasource.dart';
import '../../features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import '../../features/pokemon/data/repositories/pokemon_repository_impl.dart';
import '../../features/pokemon/domain/repositories/pokemon_repository.dart';
import '../../features/pokemon/domain/usecases/get_pokemon_list_use_case.dart';
import '../../features/pokemon/domain/usecases/search_pokemon_use_case.dart';
import '../../features/pokemon/presentation/controllers/pokemon_list_controller.dart';
import '../../features/pokemon_detail/data/datasources/pokemon_detail_remote_datasource.dart';
import '../../features/pokemon_detail/data/repositories/pokemon_detail_repository_impl.dart';
import '../../features/pokemon_detail/domain/repositories/pokemon_detail_repository.dart';
import '../../features/pokemon_detail/domain/usecases/get_pokemon_by_id.dart';
import '../../features/pokemon_detail/domain/usecases/get_pokemons_by_ability.dart';
import '../../features/pokemon_detail/domain/usecases/get_pokemons_by_type.dart';
import '../../features/pokemon_detail/presentation/controllers/pokemon_detail_controller.dart';
import '../services/cache_service.dart';
import '../services/connectivity_service.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Services
  getIt.registerLazySingleton(() => ConnectivityService());
  getIt.registerLazySingleton(() => CacheService(preferences: getIt()));
  getIt.registerLazySingleton(() => http.Client());

  // Data sources
  getIt.registerLazySingleton<PokemonRemoteDataSource>(
    () => PokemonRemoteDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<PokemonLocalDataSource>(
    () => PokemonLocalDataSource(getIt()),
  );

  getIt.registerLazySingleton<PokemonDetailRemoteDataSource>(
    () => PokemonDetailRemoteDataSourceImpl(),
  );

  // Repositories
  getIt.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(getIt<PokemonRemoteDataSource>()),
  );

  getIt.registerLazySingleton<PokemonDetailRepository>(
    () => PokemonDetailRepositoryImpl(
      remoteDataSource: getIt<PokemonDetailRemoteDataSource>(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(
      () => GetPokemonListUseCase(getIt<PokemonRepository>()));
  getIt.registerLazySingleton(
      () => SearchPokemonUseCase(getIt<PokemonRepository>()));

  getIt.registerLazySingleton(
    () => GetPokemonById(repository: getIt<PokemonDetailRepository>()),
  );

  getIt.registerLazySingleton(
    () => GetPokemonsByType(repository: getIt<PokemonDetailRepository>()),
  );

  getIt.registerLazySingleton(
    () => GetPokemonsByAbility(repository: getIt<PokemonDetailRepository>()),
  );

  // Controllers
  getIt.registerFactory(
    () => PokemonListController(getIt<PokemonRepository>()),
  );

  getIt.registerFactory(
    () => PokemonDetailController(
      getPokemonById: getIt<GetPokemonById>(),
      getPokemonsByType: getIt<GetPokemonsByType>(),
      getPokemonsByAbility: getIt<GetPokemonsByAbility>(),
    ),
  );
}
