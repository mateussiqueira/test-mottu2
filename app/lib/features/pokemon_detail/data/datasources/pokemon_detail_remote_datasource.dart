import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_detail/domain/repositories/pokemon_detail_repository.dart';

abstract class PokemonDetailRemoteDataSource {
  Future<PokemonEntity> getPokemonById(int id);
  Future<List<PokemonEntity>> getPokemonsByType(String type);
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability);
}

class PokemonDetailRemoteDataSourceImpl
    implements PokemonDetailRemoteDataSource {
  @override
  Future<PokemonEntity> getPokemonById(int id) async {
    // TODO: Implementar chamada à API
    throw UnimplementedError();
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByType(String type) async {
    // TODO: Implementar chamada à API
    throw UnimplementedError();
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability) async {
    // TODO: Implementar chamada à API
    throw UnimplementedError();
  }
}
