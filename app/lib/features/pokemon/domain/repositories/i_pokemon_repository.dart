import '../../../../core/domain/errors/result.dart';
import '../entities/i_pokemon_entity.dart';

/// Interface for Pokemon repository operations
abstract class IPokemonRepository {
  /// Fetches a list of Pokemon with pagination support
  ///
  /// [limit] - Maximum number of Pokemon to return
  /// [offset] - Number of Pokemon to skip
  ///
  /// Returns a [Result] containing either:
  /// - A list of [IPokemonEntity] on success
  /// - An error message on failure
  Future<Result<List<IPokemonEntity>>> getPokemonList({
    required int limit,
    required int offset,
  });

  /// Fetches detailed information about a specific Pokemon
  ///
  /// [id] - The ID of the Pokemon to fetch
  ///
  /// Returns a [Result] containing either:
  /// - An [IPokemonEntity] on success
  /// - An error message on failure
  Future<Result<IPokemonEntity>> getPokemonById(int id);

  /// Searches for Pokemon by name
  ///
  /// [query] - The search query string
  ///
  /// Returns a [Result] containing either:
  /// - A list of matching [IPokemonEntity] on success
  /// - An error message on failure
  Future<Result<List<IPokemonEntity>>> searchPokemons(String query);

  /// Fetches all Pokemon of a specific type
  ///
  /// [type] - The type to filter Pokemon by (e.g., "fire", "water")
  ///
  /// Returns a [Result] containing either:
  /// - A list of [IPokemonEntity] of the specified type on success
  /// - An error message on failure
  Future<Result<List<IPokemonEntity>>> getPokemonByType(String type);

  /// Fetches all Pokemon with a specific ability
  ///
  /// [ability] - The ability to filter Pokemon by (e.g., "blaze", "overgrow")
  ///
  /// Returns a [Result] containing either:
  /// - A list of [IPokemonEntity] with the specified ability on success
  /// - An error message on failure
  Future<Result<List<IPokemonEntity>>> getPokemonByAbility(String ability);

  /// Fetches all Pokemon with a specific move
  ///
  /// [move] - The move to filter Pokemon by (e.g., "thunderbolt", "waterfall")
  ///
  /// Returns a [Result] containing either:
  /// - A list of [IPokemonEntity] with the specified move on success
  /// - An error message on failure
  Future<Result<List<IPokemonEntity>>> getPokemonByMove(String move);

  /// Fetches all Pokemon with a specific evolution
  ///
  /// [evolution] - The evolution to filter Pokemon by (e.g., "mega", "alolan")
  ///
  /// Returns a [Result] containing either:
  /// - A list of [IPokemonEntity] with the specified evolution on success
  /// - An error message on failure
  Future<Result<List<IPokemonEntity>>> getPokemonByEvolution(String evolution);

  /// Fetches all Pokemon with a specific stat
  ///
  /// [stat] - The stat to filter Pokemon by (e.g., "attack", "defense")
  /// [value] - The value of the stat to filter by
  ///
  /// Returns a [Result] containing either:
  /// - A list of [IPokemonEntity] with the specified stat on success
  /// - An error message on failure
  Future<Result<List<IPokemonEntity>>> getPokemonByStat(String stat, int value);

  /// Fetches all Pokemon with a specific description
  ///
  /// [description] - The description to filter Pokemon by
  ///
  /// Returns a [Result] containing either:
  /// - A list of [IPokemonEntity] with the specified description on success
  /// - An error message on failure
  Future<Result<List<IPokemonEntity>>> getPokemonByDescription(
      String description);
}
