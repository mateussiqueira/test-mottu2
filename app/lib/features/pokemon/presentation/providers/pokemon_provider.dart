import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/pokemon_remote_datasource_impl.dart';
import '../../data/repositories/pokemon_repository_impl.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/usecases/get_pokemon_by_id_usecase.dart';
import '../../domain/usecases/get_pokemon_list_usecase.dart';
import '../../domain/usecases/get_pokemons_by_ability_usecase.dart';
import '../../domain/usecases/get_pokemons_by_type_usecase.dart';
import '../../domain/usecases/search_pokemon_usecase.dart';

final pokemonListProvider = FutureProvider.autoDispose
    .family<List<PokemonEntity>, ({int? limit, int? offset})>(
        (ref, params) async {
  try {
    final usecase = ref.watch(getPokemonListUseCaseProvider);
    final result = await usecase(limit: params.limit, offset: params.offset);
    if (result.isFailure) {
      throw result.error ?? 'Failed to fetch Pokemon list';
    }
    return result.data ?? [];
  } catch (e) {
    throw 'Failed to fetch Pokemon list: ${e.toString()}';
  }
});

final pokemonByIdProvider =
    FutureProvider.autoDispose.family<PokemonEntity, int>((ref, id) async {
  try {
    final usecase = ref.watch(getPokemonByIdUseCaseProvider);
    final result = await usecase(id);
    if (result.isFailure) {
      throw result.error ?? 'Failed to fetch Pokemon';
    }
    return result.data!;
  } catch (e) {
    throw 'Failed to fetch Pokemon: ${e.toString()}';
  }
});

final pokemonsByTypeProvider = FutureProvider.autoDispose
    .family<List<PokemonEntity>, String>((ref, type) async {
  try {
    final usecase = ref.watch(getPokemonsByTypeUseCaseProvider);
    final result = await usecase(type);
    if (result.isFailure) {
      throw result.error ?? 'Failed to fetch Pokemon by type';
    }
    return result.data ?? [];
  } catch (e) {
    throw 'Failed to fetch Pokemon by type: ${e.toString()}';
  }
});

final pokemonsByAbilityProvider = FutureProvider.autoDispose
    .family<List<PokemonEntity>, String>((ref, ability) async {
  try {
    final usecase = ref.watch(getPokemonsByAbilityUseCaseProvider);
    final result = await usecase(ability);
    if (result.isFailure) {
      throw result.error ?? 'Failed to fetch Pokemon by ability';
    }
    return result.data ?? [];
  } catch (e) {
    throw 'Failed to fetch Pokemon by ability: ${e.toString()}';
  }
});

final searchPokemonProvider = FutureProvider.autoDispose
    .family<List<PokemonEntity>, String>((ref, query) async {
  try {
    final usecase = ref.watch(searchPokemonUseCaseProvider);
    final result = await usecase(query);
    if (result.isFailure) {
      throw result.error ?? 'Failed to search Pokemon';
    }
    return result.data ?? [];
  } catch (e) {
    throw 'Failed to search Pokemon: ${e.toString()}';
  }
});

final getPokemonListUseCaseProvider = Provider<GetPokemonListUseCase>((ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return GetPokemonListUseCase(repository);
});

final getPokemonByIdUseCaseProvider = Provider<GetPokemonByIdUseCase>((ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return GetPokemonByIdUseCase(repository);
});

final getPokemonsByTypeUseCaseProvider =
    Provider<GetPokemonsByTypeUseCase>((ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return GetPokemonsByTypeUseCase(repository);
});

final getPokemonsByAbilityUseCaseProvider =
    Provider<GetPokemonsByAbilityUseCase>((ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return GetPokemonsByAbilityUseCase(repository);
});

final searchPokemonUseCaseProvider = Provider<SearchPokemonUseCase>((ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return SearchPokemonUseCase(repository);
});

final pokemonRepositoryProvider = Provider<PokemonRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(pokemonRemoteDataSourceProvider);
  return PokemonRepositoryImpl(remoteDataSource);
});

final pokemonRemoteDataSourceProvider =
    Provider<PokemonRemoteDataSourceImpl>((ref) {
  final client = ref.watch(httpClientProvider);
  return PokemonRemoteDataSourceImpl(client);
});

final httpClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  return client;
});
