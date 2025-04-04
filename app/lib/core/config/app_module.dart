import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/pokemon_entity.dart';
import '../../features/pokemon/presentation/bloc/pokemon_bloc.dart';

abstract class IPokemonRemoteDataSource {
  Future<List<PokemonEntity>> fetchPokemonList(
      {required int offset, required int limit});
  Future<PokemonEntity> fetchPokemonDetail(int id);
  Future<List<PokemonEntity>> searchPokemon(String query);
}

abstract class IPokemonRepository {
  Future<List<PokemonEntity>> getPokemonList(
      {required int offset, required int limit});
  Future<PokemonEntity> getPokemonDetail(int id);
  Future<List<PokemonEntity>> searchPokemon(String query);
}

class PokemonRemoteDataSource implements IPokemonRemoteDataSource {
  final Dio dio;

  PokemonRemoteDataSource({required this.dio});

  @override
  Future<List<PokemonEntity>> fetchPokemonList(
      {required int offset, required int limit}) async {
    final response = await dio
        .get('https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=$limit');
    return (response.data['results'] as List)
        .map((json) => PokemonEntity.fromJson(json))
        .toList();
  }

  @override
  Future<PokemonEntity> fetchPokemonDetail(int id) async {
    final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$id');
    return PokemonEntity.fromJson(response.data);
  }

  @override
  Future<List<PokemonEntity>> searchPokemon(String query) async {
    final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$query');
    return [PokemonEntity.fromJson(response.data)];
  }
}

class PokemonRepositoryImpl implements IPokemonRepository {
  final IPokemonRemoteDataSource remoteDataSource;

  PokemonRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<PokemonEntity>> getPokemonList(
      {required int offset, required int limit}) async {
    return await remoteDataSource.fetchPokemonList(
        offset: offset, limit: limit);
  }

  @override
  Future<PokemonEntity> getPokemonDetail(int id) async {
    return await remoteDataSource.fetchPokemonDetail(id);
  }

  @override
  Future<List<PokemonEntity>> searchPokemon(String query) async {
    return await remoteDataSource.searchPokemon(query);
  }
}

final getIt = GetIt.instance;

void setupDependencies() {
  // External
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Data sources
  getIt.registerLazySingleton<IPokemonRemoteDataSource>(
      () => PokemonRemoteDataSource(dio: getIt()));

  // Repositories
  getIt.registerLazySingleton<IPokemonRepository>(
      () => PokemonRepositoryImpl(remoteDataSource: getIt()));

  // Blocs
  getIt.registerFactory<PokemonBloc>(() => PokemonBloc(getIt()));
}
