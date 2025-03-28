import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/pokemon_list/presentation/bloc/pokemon_list_bloc.dart';
import '../data/adapters/poke_api_adapter.dart';
import '../domain/repositories/pokemon_repository.dart';
import '../services/connectivity_service.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Services
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  getIt.registerSingleton<ConnectivityService>(ConnectivityService());

  // Repositories
  getIt.registerSingleton<PokemonRepository>(
    PokeApiAdapter(),
  );

  // Blocs
  getIt.registerFactory<PokemonListBloc>(
    () => PokemonListBloc(repository: getIt<PokemonRepository>()),
  );
}
