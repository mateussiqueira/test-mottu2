import 'package:get_it/get_it.dart';

import '../../data/repositories/pokemon_repository.dart';
import '../../presentation/blocs/pokemon_bloc.dart';
import '../network/dio_client.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Network
  locator.registerLazySingleton(() => DioClient());

  // Repositories
  locator.registerLazySingleton(() => PokemonRepository(locator<DioClient>()));

  // BLoCs
  locator.registerFactory(() => PokemonBloc(locator<PokemonRepository>()));
}
