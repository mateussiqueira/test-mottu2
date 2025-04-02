import '../../../../core/domain/result.dart' as core;
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
  Future<core.Result<List<IPokemonEntity>>> getPokemonList({
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
  Future<core.Result<IPokemonEntity>> getPokemonDetail(int id);

  /// Searches for Pokemon by name
  ///
  /// [query] - The search query string
  ///
  /// Returns a [Result] containing either:
  /// - A list of matching [IPokemonEntity] on success
  /// - An error message on failure
  Future<core.Result<List<IPokemonEntity>>> searchPokemon(String query);

  /// Fetches all Pokemon of a specific type
  ///
  /// [type] - The type to filter Pokemon by (e.g., "fire", "water")
  ///
  /// Returns a [Result] containing either:
  /// - A list of [IPokemonEntity] of the specified type on success
  /// - An error message on failure
  Future<core.Result<List<IPokemonEntity>>> getPokemonsByType(String type);

  /// Fetches all Pokemon with a specific ability
  ///
  /// [ability] - The ability to filter Pokemon by (e.g., "blaze", "overgrow")
  ///
  /// Returns a [Result] containing either:
  /// - A list of [IPokemonEntity] with the specified ability on success
  /// - An error message on failure
  Future<core.Result<List<IPokemonEntity>>> getPokemonsByAbility(
      String ability);
}
