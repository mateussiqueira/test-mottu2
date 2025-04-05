import 'package:dartz/dartz.dart';
import 'package:pokemon_list/features/pokemon/domain/entities/pokemon_entity_impl.dart';
import 'package:pokemon_list/features/pokemon/domain/errors/failures.dart';

/// Interface for Pokemon repository
abstract class IPokemonRepository {
  /// Get a list of Pokemon with pagination
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonList({
    required int offset,
    required int limit,
  });

  /// Get a Pokemon by ID
  Future<Either<PokemonFailure, PokemonEntityImpl>> getPokemonById({
    required int id,
  });

  /// Search Pokemon by query
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> searchPokemon({
    required String query,
  });

  /// Get Pokemon by type
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonsByType({
    required String type,
  });

  /// Get Pokemon by ability
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonsByAbility({
    required String ability,
  });

  /// Get Pokemon by move
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonsByMove({
    required String move,
  });

  /// Get Pokemon by evolution
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>>
      getPokemonsByEvolution({
    required String evolution,
  });

  /// Get Pokemon by stat
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>> getPokemonsByStat({
    required String stat,
    required int value,
  });

  /// Get Pokemon by description
  Future<Either<PokemonFailure, List<PokemonEntityImpl>>>
      getPokemonsByDescription({
    required String description,
  });

  /// Get Pokemon by name
  Future<Either<PokemonFailure, PokemonEntityImpl>> getPokemonByName({
    required String name,
  });
}
