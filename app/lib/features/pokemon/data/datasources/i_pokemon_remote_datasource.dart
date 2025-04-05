import '../../domain/entities/pokemon_entity.dart';

/// Interface for remote data source
abstract class IPokemonRemoteDataSource {
  /// Get a list of Pokemon with pagination
  Future<List<PokemonEntity>> getPokemonList({
    int? offset,
    int? limit,
  });

  /// Get a Pokemon by ID
  Future<PokemonEntity> getPokemonById(int id);

  /// Search Pokemon by query
  Future<List<PokemonEntity>> searchPokemon(String query);

  /// Get Pokemon by type
  Future<List<PokemonEntity>> getPokemonsByType(String type);

  /// Get Pokemon by ability
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability);

  /// Get Pokemon by move
  Future<List<PokemonEntity>> getPokemonsByMove(String move);

  /// Get Pokemon by evolution
  Future<List<PokemonEntity>> getPokemonsByEvolution(String evolution);

  /// Get Pokemon by stat
  Future<List<PokemonEntity>> getPokemonsByStat(String stat, int value);

  /// Get Pokemon by description
  Future<List<PokemonEntity>> getPokemonsByDescription(String description);

  /// Get Pokemon by name
  Future<PokemonEntity> getPokemonByName(String name);
}
