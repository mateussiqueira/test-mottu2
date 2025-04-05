import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failure.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';

abstract class PokemonDetailRemoteDataSource {
  Future<Either<Failure, List<PokemonEntity>>> getPokemonsByType(String type);
  Future<Either<Failure, List<PokemonEntity>>> getPokemonsByAbility(
      String ability);
}

class PokemonDetailRemoteDataSourceImpl
    implements PokemonDetailRemoteDataSource {
  final Dio dio;

  PokemonDetailRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<Either<Failure, List<PokemonEntity>>> getPokemonsByType(
      String type) async {
    try {
      final response = await dio.get('/type/$type');
      final data = response.data as Map<String, dynamic>;
      final pokemons = data['pokemon'] as List;
      return Right(pokemons
          .map((p) =>
              PokemonEntity.fromJson(p['pokemon'] as Map<String, dynamic>))
          .toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PokemonEntity>>> getPokemonsByAbility(
      String ability) async {
    try {
      final response = await dio.get('/ability/$ability');
      final data = response.data as Map<String, dynamic>;
      final pokemons = data['pokemon'] as List;
      return Right(pokemons
          .map((p) =>
              PokemonEntity.fromJson(p['pokemon'] as Map<String, dynamic>))
          .toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
