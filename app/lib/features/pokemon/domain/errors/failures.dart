import 'package:equatable/equatable.dart';

/// Base class for all failures in the Pokemon domain
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure when server communication fails
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

/// Failure when cache operations fail
class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

/// Failure when network is not available
class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

/// Failure when Pokemon is not found
class PokemonNotFoundFailure extends Failure {
  const PokemonNotFoundFailure(String message) : super(message);
}

/// Failure when Pokemon data is invalid
class InvalidPokemonDataFailure extends Failure {
  const InvalidPokemonDataFailure(String message) : super(message);
}

abstract class PokemonFailure extends Equatable {
  const PokemonFailure();

  @override
  List<Object?> get props => [];
}

class PokemonListEmptyFailure extends PokemonFailure {}

class InvalidPokemonIdFailure extends PokemonFailure {
  final int id;

  const InvalidPokemonIdFailure(this.id);

  @override
  List<Object?> get props => [id];
}

class InvalidPokemonNameFailure extends PokemonFailure {
  final String name;

  const InvalidPokemonNameFailure(this.name);

  @override
  List<Object?> get props => [name];
}

class InvalidPokemonTypesFailure extends PokemonFailure {
  final List<String> types;

  const InvalidPokemonTypesFailure(this.types);

  @override
  List<Object?> get props => [types];
}

class InvalidPokemonAbilitiesFailure extends PokemonFailure {
  final List<String> abilities;

  const InvalidPokemonAbilitiesFailure(this.abilities);

  @override
  List<Object?> get props => [abilities];
}

class InvalidPokemonHeightFailure extends PokemonFailure {
  final int height;

  const InvalidPokemonHeightFailure(this.height);

  @override
  List<Object?> get props => [height];
}

class InvalidPokemonWeightFailure extends PokemonFailure {
  final int weight;

  const InvalidPokemonWeightFailure(this.weight);

  @override
  List<Object?> get props => [weight];
}

class InvalidPokemonStatsFailure extends PokemonFailure {
  final Map<String, int> stats;

  const InvalidPokemonStatsFailure(this.stats);

  @override
  List<Object?> get props => [stats];
}

class InvalidPokemonSpritesFailure extends PokemonFailure {
  final Map<String, String> sprites;

  const InvalidPokemonSpritesFailure(this.sprites);

  @override
  List<Object?> get props => [sprites];
}

class InvalidPokemonBaseExperienceFailure extends PokemonFailure {
  final int baseExperience;

  const InvalidPokemonBaseExperienceFailure(this.baseExperience);

  @override
  List<Object?> get props => [baseExperience];
}

class InvalidPokemonMovesFailure extends PokemonFailure {
  final List<String> moves;

  const InvalidPokemonMovesFailure(this.moves);

  @override
  List<Object?> get props => [moves];
}

class InvalidPokemonDescriptionFailure extends PokemonFailure {
  final String description;

  const InvalidPokemonDescriptionFailure(this.description);

  @override
  List<Object?> get props => [description];
}

class PokemonApiFailure extends PokemonFailure {
  final String message;

  const PokemonApiFailure(this.message);

  @override
  List<Object?> get props => [message];
}
