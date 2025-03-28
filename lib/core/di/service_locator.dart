import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
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
  getIt.registerSingleton<http.Client>(http.Client());

  // Repositories
  getIt.registerSingleton<PokemonRepository>(
    PokeApiAdapter(
      client: getIt<http.Client>(),
      prefs: getIt<SharedPreferences>(),
    ),
  );

  // Blocs
  getIt.registerFactory<PokemonListBloc>(
    () => PokemonListBloc(repository: getIt<PokemonRepository>()),
  );
}
