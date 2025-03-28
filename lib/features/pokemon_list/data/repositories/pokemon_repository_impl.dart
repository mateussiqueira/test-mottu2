import '../../../../core/domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_remote_data_source.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  PokemonRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Pokemon>> getPokemons({int offset = 0, int limit = 20}) async {
    try {
      return await remoteDataSource.getPokemons(offset: offset, limit: limit);
    } catch (e) {
      throw Exception('Failed to fetch pokemons: $e');
    }
  }

  @override
  Future<Pokemon> getPokemonById(int id) async {
    try {
      return await remoteDataSource.getPokemonById(id);
    } catch (e) {
      throw Exception('Failed to fetch pokemon: $e');
    }
  }

  @override
  Future<List<Pokemon>> searchPokemons(String query) async {
    try {
      return await remoteDataSource.searchPokemons(query);
    } catch (e) {
      throw Exception('Failed to search pokemons: $e');
    }
  }
}
