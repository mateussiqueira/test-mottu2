import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'app_router.dart';
import 'core/services/connectivity_service.dart';
import 'features/pokemon_list/data/datasources/pokemon_remote_data_source.dart';
import 'features/pokemon_list/data/repositories/pokemon_repository_impl.dart';
import 'features/pokemon_list/domain/repositories/pokemon_repository.dart';
import 'features/pokemon_list/presentation/bloc/pokemon_list_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final client = http.Client();

  // Register services
  Get.put(ConnectivityService());
  Get.put(client);

  // Register data source
  final pokemonDataSource = PokemonRemoteDataSourceImpl(client: client);
  Get.put<PokemonRemoteDataSource>(pokemonDataSource);

  // Register repository
  final pokemonRepository = PokemonRepositoryImpl(pokemonDataSource);
  Get.put<PokemonRepository>(pokemonRepository);

  // Register bloc
  final pokemonListBloc = PokemonListBloc(repository: pokemonRepository);
  Get.put<PokemonListBloc>(pokemonListBloc);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pokédex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      initialRoute: '/pokemon-list',
      getPages: AppRouter.routes,
    );
  }
}
