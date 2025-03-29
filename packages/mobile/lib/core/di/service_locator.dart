import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/pokemon/data/datasources/pokemon_local_datasource.dart';
import '../../features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import '../../features/pokemon/data/repositories/pokemon_repository_impl.dart';
import '../../features/pokemon/domain/repositories/pokemon_repository.dart';
import '../../features/pokemon_list/domain/repositories/pokemon_repository.dart'
    as pokemon_list;
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
  final pokemonLocalDataSource = PokemonLocalDataSource(prefs);

  // Repositories
  final pokemonRepository = PokemonRepositoryImpl(
    remoteDataSource: pokemonDataSource,
    localDataSource: pokemonLocalDataSource,
    prefs: prefs,
  );

  // Blocs
  final pokemonListBloc = PokemonListBloc(
      repository: pokemonRepository as pokemon_list.PokemonRepository);

  // Register dependencies
  Get.put<PokemonRepository>(pokemonRepository);
  Get.put<PokemonListBloc>(pokemonListBloc);

  // Serviços
  Get.put<CacheService>(CacheService(prefs));
  Get.put<ConnectivityService>(ConnectivityService());
  Get.put<ImageCacheService>(ImageCacheService());
  Get.put<http.Client>(client);
}
