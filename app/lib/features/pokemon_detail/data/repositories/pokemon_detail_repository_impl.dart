import 'package:dartz/dartz.dart';

import '../../../../core/logging/i_logger.dart';
import '../../../pokemon/domain/entities/pokemon_entity_impl.dart';
import '../../../pokemon/domain/errors/failures.dart';
import '../../domain/repositories/i_pokemon_detail_repository.dart';
import '../datasources/pokemon_detail_remote_datasource.dart';

class PokemonDetailRepositoryImpl implements IPokemonDetailRepository {
  final PokemonDetailRemoteDataSource remoteDataSource;
  final ILogger logger;

  PokemonDetailRepositoryImpl({
    required this.remoteDataSource,
    required this.logger,
  });

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonsByType({
    required String type,
  }) async {
    try {
      final pokemons = await remoteDataSource.getPokemonsByType(type);
      return Right(pokemons);
    } catch (e, s) {
      logger.error('Error getting pokemons by type', error: e, stackTrace: s);
      return Left(PokemonApiFailure(e.toString()));
    }
  }

  @override
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonsByAbility({
    required String ability,
  }) async {
    try {
      final pokemons = await remoteDataSource.getPokemonsByAbility(ability);
      return Right(pokemons);
    } catch (e, s) {
      logger.error('Error getting pokemons by ability',
          error: e, stackTrace: s);
      return Left(PokemonApiFailure(e.toString()));
    }
  }
}
