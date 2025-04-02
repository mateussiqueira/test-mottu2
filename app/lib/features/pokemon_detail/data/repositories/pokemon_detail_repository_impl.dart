import '../../../../core/domain/result.dart';
import '../../../../core/logging/i_logger.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
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
  Future<Result<List<PokemonEntity>>> getPokemonsByType(String type) async {
    try {
      final pokemons = await remoteDataSource.getPokemonsByType(type);
      return Result.success(pokemons);
    } catch (e, s) {
      logger.error('Error getting pokemons by type', error: e, stackTrace: s);
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<List<PokemonEntity>>> getPokemonsByAbility(
      String ability) async {
    try {
      final pokemons = await remoteDataSource.getPokemonsByAbility(ability);
      return Result.success(pokemons);
    } catch (e, s) {
      logger.error('Error getting pokemons by ability',
          error: e, stackTrace: s);
      return Result.failure(e.toString());
    }
  }
}
