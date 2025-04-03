import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';

/// Interface for Pokemon repository operations
abstract class IPokemonRepository {
  /// Fetches a list of Pokemon with pagination support
  ///
  /// [limit] - Maximum number of Pokemon to return
  /// [offset] - Number of Pokemon to skip
  ///
  /// Returns a [Result] containing either:
  /// - A list of [PokemonEntity] on success
  /// - An error message on failure
  Future<Result<List<PokemonEntity>>> getPokemonList({int? limit, int? offset});

  /// Fetches detailed information about a specific Pokemon
  ///
  /// [id] - The ID of the Pokemon to fetch
  ///
  /// Returns a [Result] containing either:
  /// - A [PokemonEntity] on success
  /// - An error message on failure
  Future<Result<PokemonEntity>> getPokemonById(int id);

  /// Searches for Pokemon by name
  ///
  /// [query] - The search query string
  ///
  /// Returns a [Result] containing either:
  /// - A list of matching [PokemonEntity] on success
  /// - An error message on failure
  Future<Result<List<PokemonEntity>>> searchPokemon(String query);

  /// Fetches all Pokemon of a specific type
  ///
  /// [type] - The type to filter Pokemon by (e.g., "fire", "water")
  ///
  /// Returns a [Result] containing either:
  /// - A list of [PokemonEntity] of the specified type on success
  /// - An error message on failure
  Future<Result<List<PokemonEntity>>> getPokemonsByType(String type);

  /// Fetches all Pokemon with a specific ability
  ///
  /// [ability] - The ability to filter Pokemon by (e.g., "blaze", "overgrow")
  ///
  /// Returns a [Result] containing either:
  /// - A list of [PokemonEntity] with the specified ability on success
  /// - An error message on failure
  Future<Result<List<PokemonEntity>>> getPokemonsByAbility(String ability);

  /// Fetches all Pokemon with a specific move
  ///
  /// [move] - The move to filter Pokemon by (e.g., "thunderbolt", "waterfall")
  ///
  /// Returns a [Result] containing either:
  /// - A list of [PokemonEntity] with the specified move on success
  /// - An error message on failure
  Future<Result<List<PokemonEntity>>> getPokemonsByMove(String move);

  /// Fetches all Pokemon with a specific evolution
  ///
  /// [evolution] - The evolution to filter Pokemon by (e.g., "mega", "alolan")
  ///
  /// Returns a [Result] containing either:
  /// - A list of [PokemonEntity] with the specified evolution on success
  /// - An error message on failure
  Future<Result<List<PokemonEntity>>> getPokemonsByEvolution(String evolution);

  /// Fetches all Pokemon with a specific stat
  ///
  /// [stat] - The stat to filter Pokemon by (e.g., "attack", "defense")
  /// [value] - The value of the stat to filter by
  ///
  /// Returns a [Result] containing either:
  /// - A list of [PokemonEntity] with the specified stat on success
  /// - An error message on failure
  Future<Result<List<PokemonEntity>>> getPokemonsByStat(String stat, int value);

  /// Fetches all Pokemon with a specific description
  ///
  /// [description] - The description to filter Pokemon by
  ///
  /// Returns a [Result] containing either:
  /// - A list of [PokemonEntity] with the specified description on success
  /// - An error message on failure
  Future<Result<List<PokemonEntity>>> getPokemonsByDescription(
      String description);

  /// Fetches details of a specific Pokemon
  ///
  /// [id] - The ID of the Pokemon to fetch
  /// Returns a [Result] containing either the Pokemon details or an error
  Future<Result<PokemonEntity>> getPokemonDetail(int id);
}
