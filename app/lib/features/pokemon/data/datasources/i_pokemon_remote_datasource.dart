import '../../domain/entities/pokemon_entity_impl.dart';

/// Interface for remote data source
abstract class IPokemonRemoteDataSource {
  /// Get a list of Pokemon with pagination
  Future<List<PokemonEntityImpl>> getPokemonList({
    required int offset,
    required int limit,
  });

  /// Get a Pokemon by ID
  Future<PokemonEntityImpl> getPokemonById(int id);

  /// Search Pokemon by query
  Future<List<PokemonEntityImpl>> searchPokemon(String query);
  
  /// Search Pokemon by query (alias for searchPokemon)
  Future<List<PokemonEntityImpl>> searchPokemons(String query);

  /// Get Pokemon by type
  Future<List<PokemonEntityImpl>> getPokemonsByType(String type);

  /// Get Pokemon by ability
  Future<List<PokemonEntityImpl>> getPokemonsByAbility(String ability);

  /// Get Pokemon by move
  Future<List<PokemonEntityImpl>> getPokemonsByMove(String move);

  /// Get Pokemon by evolution
  Future<List<PokemonEntityImpl>> getPokemonsByEvolution(String evolution);

  /// Get Pokemon by stat
  Future<List<PokemonEntityImpl>> getPokemonsByStat(String stat, int value);

  /// Get Pokemon by description
  Future<List<PokemonEntityImpl>> getPokemonsByDescription(String description);

  /// Get Pokemon by name
  Future<PokemonEntityImpl> getPokemonByName(String name);
}
