import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/cache_service.dart';
import 'core/services/connectivity_service.dart';
import 'features/pokemon/data/datasources/pokemon_local_datasource.dart';
import 'features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'features/pokemon/domain/repositories/pokemon_repository.dart';
import 'features/pokemon/domain/usecases/get_pokemon_list_use_case.dart';
import 'features/pokemon/domain/usecases/search_pokemon_use_case.dart';
import 'features/pokemon/presentation/controllers/pokemon_list_controller.dart';
import 'features/pokemon_detail/presentation/controllers/pokemon_detail_controller.dart';
import 'features/splash/presentation/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final client = http.Client();

  // Register services
  Get.put(ConnectivityService());
  Get.put(CacheService(prefs));
  Get.put(client);

  // Register data sources
  final pokemonRemoteDataSource = PokemonRemoteDataSourceImpl(client: client);
  Get.put<PokemonRemoteDataSource>(pokemonRemoteDataSource);

  final pokemonLocalDataSource = PokemonLocalDataSource(prefs);
  Get.put<PokemonLocalDataSource>(pokemonLocalDataSource);

  // Register repository
  final pokemonRepository = PokemonRepositoryImpl(
    remoteDataSource: pokemonRemoteDataSource,
    localDataSource: pokemonLocalDataSource,
    prefs: prefs,
  );
  Get.put<PokemonRepository>(pokemonRepository);

  // Register use cases
  Get.put(GetPokemonListUseCase(pokemonRepository));
  Get.put(SearchPokemonUseCase(pokemonRepository));

  // Register controllers
  Get.put(PokemonListController(pokemonRepository));
  Get.put(PokemonDetailController(pokemonRepository));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pokemon App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
