import '../../../../core/domain/errors/result.dart';
import '../../../../core/logging/pokemon_logger.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/i_pokemon_repository.dart';
import '../datasources/i_pokemon_remote_datasource.dart';

class PokemonRepositoryImpl implements IPokemonRepository {
  final IPokemonRemoteDataSource remoteDataSource;
  final PokemonLogger logger;

  PokemonRepositoryImpl({
    required this.remoteDataSource,
    required this.logger,
  });

  @override
  Future<Result<List<PokemonEntity>>> getPokemonList({
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      logger.info('Getting Pokemon list',
          data: {'offset': offset, 'limit': limit});
      final result =
          await remoteDataSource.getPokemonList(offset: offset, limit: limit);
      logger.info('Successfully got Pokemon list',
          data: {'count': result.length});
      return Result.success(result);
    } catch (e, stackTrace) {
      logger.error(
        'Error getting Pokemon list',
        error: e,
        stackTrace: stackTrace,
        data: {'offset': offset, 'limit': limit},
      );
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<PokemonEntity>> getPokemonDetail(int id) async {
    try {
      logger.info('Getting Pokemon detail', data: {'id': id});
      final result = await remoteDataSource.getPokemonDetail(id);
      logger.info('Successfully got Pokemon detail', data: {'id': id});
      return Result.success(result);
    } catch (e, stackTrace) {
      logger.error(
        'Error getting Pokemon detail',
        error: e,
        stackTrace: stackTrace,
        data: {'id': id},
      );
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> searchPokemon(String query) async {
    try {
      logger.info('Searching Pokemon', data: {'query': query});
      final result = await remoteDataSource.searchPokemon(query);
      logger.info('Successfully searched Pokemon',
          data: {'query': query, 'count': result.length});
      return Result.success(result);
    } catch (e, stackTrace) {
      logger.error(
        'Error searching Pokemon',
        error: e,
        stackTrace: stackTrace,
        data: {'query': query},
      );
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByType(String type) async {
    try {
      logger.info('Getting Pokemon by type', data: {'type': type});
      final result = await remoteDataSource.getPokemonsByType(type);
      logger.info('Successfully got Pokemon by type',
          data: {'type': type, 'count': result.length});
      return Result.success(result);
    } catch (e, stackTrace) {
      logger.error(
        'Error getting Pokemon by type',
        error: e,
        stackTrace: stackTrace,
        data: {'type': type},
      );
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByAbility(
      String ability) async {
    try {
      logger.info('Getting Pokemon by ability', data: {'ability': ability});
      final result = await remoteDataSource.getPokemonsByAbility(ability);
      logger.info('Successfully got Pokemon by ability',
          data: {'ability': ability, 'count': result.length});
      return Result.success(result);
    } catch (e, stackTrace) {
      logger.error(
        'Error getting Pokemon by ability',
        error: e,
        stackTrace: stackTrace,
        data: {'ability': ability},
      );
      return Result.failure(e.toString());
    }
  }

  @override
  String toString() {
    return 'PokemonRepositoryImpl()';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokemonRepositoryImpl &&
        other.remoteDataSource == remoteDataSource;
  }

  @override
  int get hashCode => remoteDataSource.hashCode;
}
