import '../../domain/entities/i_pokemon_entity.dart';

abstract class IPokemonLocalDataSource {
  Future<List<IPokemonEntity>> getPokemonList();
  Future<void> savePokemonList(List<IPokemonEntity> pokemons);
  Future<IPokemonEntity?> getPokemonDetail(int id);
  Future<void> savePokemonDetail(IPokemonEntity pokemon);
}
