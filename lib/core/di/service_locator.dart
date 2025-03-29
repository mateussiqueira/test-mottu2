import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/pokemon_list/data/datasources/pokemon_remote_data_source.dart';
import '../../features/pokemon_list/data/repositories/pokemon_repository_impl.dart';
import '../../features/pokemon_list/domain/repositories/pokemon_repository.dart';
import '../../features/pokemon_list/presentation/bloc/pokemon_list_bloc.dart';
import '../services/cache_service.dart';
import '../services/connectivity_service.dart';
import '../services/image_cache_service.dart';

Future<void> setupServiceLocator() async {
  // External dependencies
  final prefs = await SharedPreferences.getInstance();
  final client = http.Client();

  // Data sources
  final pokemonDataSource = PokemonRemoteDataSourceImpl(client: client);

  // Repositories
  final pokemonRepository = PokemonRepositoryImpl(pokemonDataSource);

  // Blocs
  final pokemonListBloc = PokemonListBloc(repository: pokemonRepository);

  // Register dependencies
  Get.put<PokemonRepository>(pokemonRepository);
  Get.put<PokemonListBloc>(pokemonListBloc);

  // Serviços
  Get.put<CacheService>(CacheService(prefs));
  Get.put<ConnectivityService>(ConnectivityService());
  Get.put<ImageCacheService>(ImageCacheService());
  Get.put<http.Client>(client);
}
