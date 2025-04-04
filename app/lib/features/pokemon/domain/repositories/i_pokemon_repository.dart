import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';

/// Interface for Pokemon repository
abstract class IPokemonRepository {
  /// Get a list of Pokemon
  Future<Result<List<PokemonEntity>>> getPokemonList({
    int? limit,
    int? offset,
  });

  /// Get a Pokemon by ID
  Future<Result<PokemonEntity>> getPokemonById(int id);

  /// Search Pokemon by name
  Future<Result<List<PokemonEntity>>> searchPokemon(String query);

  /// Get Pokemon by type
  Future<Result<List<PokemonEntity>>> getPokemonsByType(String type);

  /// Get Pokemon by ability
  Future<Result<List<PokemonEntity>>> getPokemonsByAbility(String ability);

  /// Get Pokemon by move
  Future<Result<List<PokemonEntity>>> getPokemonsByMove(String move);

  /// Get Pokemon by evolution
  Future<Result<List<PokemonEntity>>> getPokemonsByEvolution(String evolution);

  /// Get Pokemon by stat
  Future<Result<List<PokemonEntity>>> getPokemonsByStat(String stat, int value);

  /// Get Pokemon by description
  Future<Result<List<PokemonEntity>>> getPokemonsByDescription(
      String description);
}
