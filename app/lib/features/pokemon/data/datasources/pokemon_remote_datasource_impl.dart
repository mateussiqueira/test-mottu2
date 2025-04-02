import '../../domain/entities/i_pokemon_entity.dart';
import '../clients/pokemon_api_client.dart';
import 'i_pokemon_remote_datasource.dart';

/// Implementation of the Pokemon remote data source
class PokemonRemoteDataSourceImpl implements IPokemonRemoteDataSource {
  final PokemonApiClient _apiClient;

  PokemonRemoteDataSourceImpl({required PokemonApiClient apiClient})
      : _apiClient = apiClient;

  @override
  Future<List<IPokemonEntity>> getPokemons({int? limit, int? offset}) async {
    final result = await _apiClient.getPokemonList(
      limit: limit ?? 20,
      offset: offset ?? 0,
    );
    if (result.isFailure) {
      throw Exception(result.error);
    }
    return result.data!;
  }

  @override
  Future<IPokemonEntity> getPokemonDetail(int id) async {
    final result = await _apiClient.getPokemonDetail(id);
    if (result.isFailure) {
      throw Exception(result.error);
    }
    return result.data!;
  }

  @override
  Future<List<IPokemonEntity>> searchPokemons(String query) async {
    final result = await _apiClient.searchPokemon(query);
    if (result.isFailure) {
      throw Exception(result.error);
    }
    return result.data!;
  }

  @override
  Future<List<IPokemonEntity>> getPokemonsByType(String type) async {
    final result = await _apiClient.getPokemonsByType(type);
    if (result.isFailure) {
      throw Exception(result.error);
    }
    return result.data!;
  }

  @override
  Future<List<IPokemonEntity>> getPokemonsByAbility(String ability) async {
    final result = await _apiClient.getPokemonsByAbility(ability);
    if (result.isFailure) {
      throw Exception(result.error);
    }
    return result.data!;
  }
}
