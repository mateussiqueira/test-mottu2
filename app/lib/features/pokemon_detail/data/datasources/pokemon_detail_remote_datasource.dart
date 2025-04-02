import 'package:dio/dio.dart';

import '../../../pokemon/domain/entities/pokemon_entity.dart';

abstract class PokemonDetailRemoteDataSource {
  Future<List<PokemonEntity>> getPokemonsByType(String type);
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability);
}

class PokemonDetailRemoteDataSourceImpl
    implements PokemonDetailRemoteDataSource {
  final Dio dio;

  PokemonDetailRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<List<PokemonEntity>> getPokemonsByType(String type) async {
    final response = await dio.get('/type/$type');
    final data = response.data as Map<String, dynamic>;
    final pokemons = data['pokemon'] as List;
    return pokemons
        .map(
            (p) => PokemonEntity.fromJson(p['pokemon'] as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability) async {
    final response = await dio.get('/ability/$ability');
    final data = response.data as Map<String, dynamic>;
    final pokemons = data['pokemon'] as List;
    return pokemons
        .map(
            (p) => PokemonEntity.fromJson(p['pokemon'] as Map<String, dynamic>))
        .toList();
  }
}
