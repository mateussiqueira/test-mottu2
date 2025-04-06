import 'package:get_it/get_it.dart';

import '../../data/repositories/pokemon_repository.dart';
import '../../presentation/blocs/pokemon_bloc.dart';
import '../network/dio_client.dart';
import '../presentation/routes/app_router.dart';
import '../../features/pokemon/presentation/routes/pokemon_router.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Network
  locator.registerLazySingleton(() => DioClient());

  // Repositories
  locator.registerLazySingleton(() => PokemonRepository(locator<DioClient>()));

  // BLoCs
  locator.registerFactory(() => PokemonBloc(locator<PokemonRepository>()));
  
  // Routers
  locator.registerLazySingleton(() => PokemonRouter());
  locator.registerLazySingleton(() => AppRouter(locator<PokemonRouter>()));
}
