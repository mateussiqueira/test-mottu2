import 'package:dartz/dartz.dart';

import '../entities/i_pokemon_entity.dart';
import '../errors/failures.dart';

/// Repository interface for Pokemon operations
abstract class PokemonRepository {
  /// Get a list of Pokemon with pagination
  Future<Either<Failure, List<IPokemonEntity>>> getPokemonList({
    required int offset,
    required int limit,
  });

  /// Get Pokemon by type
  Future<Either<Failure, List<IPokemonEntity>>> getPokemonsByType(String type);

  /// Get Pokemon by ability
  Future<Either<Failure, List<IPokemonEntity>>> getPokemonsByAbility(
    String ability,
  );

  /// Search Pokemon by name
  Future<Either<Failure, List<IPokemonEntity>>> searchPokemon(String query);

  /// Get Pokemon detail by ID
  Future<Either<Failure, IPokemonEntity>> getPokemonDetail(int id);
}
