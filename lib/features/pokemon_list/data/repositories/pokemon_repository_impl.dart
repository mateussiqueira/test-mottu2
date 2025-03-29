import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_remote_data_source.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource _dataSource;

  PokemonRepositoryImpl(this._dataSource);

  @override
  Future<List<PokemonEntity>> getPokemons(
      {int offset = 0, int limit = 20}) async {
    final pokemons =
        await _dataSource.getPokemons(offset: offset, limit: limit);
    return pokemons.map((e) => e.toEntity()).toList();
  }

  @override
  Future<PokemonEntity> getPokemonById(int id) async {
    final pokemon = await _dataSource.getPokemonById(id);
    return pokemon.toEntity();
  }

  @override
  Future<PokemonEntity> getPokemonByName(String name) async {
    final pokemon = await _dataSource.getPokemonByName(name);
    return pokemon.toEntity();
  }

  @override
  Future<List<PokemonEntity>> searchPokemons(String query) async {
    final pokemons = await _dataSource.searchPokemons(query);
    return pokemons.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByType(String type) async {
    final pokemons = await _dataSource.getPokemonsByType(type);
    return pokemons.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability) async {
    final pokemons = await _dataSource.getPokemonsByAbility(ability);
    return pokemons.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> clearCache() async {
    await _dataSource.clearCache();
  }

  @override
  String toString() {
    return 'PokemonRepositoryImpl()';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokemonRepositoryImpl && other._dataSource == _dataSource;
  }

  @override
  int get hashCode => _dataSource.hashCode;
}
