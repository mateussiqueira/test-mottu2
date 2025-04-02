import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_detail/data/datasources/pokemon_detail_remote_datasource.dart';
import 'package:mobile/features/pokemon_detail/domain/repositories/pokemon_detail_repository.dart';

class PokemonDetailRepositoryImpl implements PokemonDetailRepository {
  final PokemonDetailRemoteDataSource remoteDataSource;

  PokemonDetailRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<PokemonEntity> getPokemonById(int id) async {
    return await remoteDataSource.getPokemonById(id);
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByType(String type) async {
    return await remoteDataSource.getPokemonsByType(type);
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability) async {
    return await remoteDataSource.getPokemonsByAbility(ability);
  }
}
