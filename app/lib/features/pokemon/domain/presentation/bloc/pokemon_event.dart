import 'package:equatable/equatable.dart';

/// Base class for Pokemon events
abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object?> get props => [];
}

/// Event to get Pokemon list
class GetPokemonListEvent extends PokemonEvent {
  final int? limit;
  final int? offset;

  const GetPokemonListEvent({this.limit, this.offset});

  @override
  List<Object?> get props => [limit, offset];
}

/// Event to get Pokemon by ID
class GetPokemonByIdEvent extends PokemonEvent {
  final int id;

  const GetPokemonByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

/// Event to search Pokemon
class SearchPokemonEvent extends PokemonEvent {
  final String query;

  const SearchPokemonEvent(this.query);

  @override
  List<Object?> get props => [query];
}

/// Event to get Pokemon by type
class GetPokemonsByTypeEvent extends PokemonEvent {
  final String type;

  const GetPokemonsByTypeEvent(this.type);

  @override
  List<Object?> get props => [type];
}

/// Event to get Pokemon by ability
class GetPokemonsByAbilityEvent extends PokemonEvent {
  final String ability;

  const GetPokemonsByAbilityEvent(this.ability);

  @override
  List<Object?> get props => [ability];
}

/// Event to get Pokemon by move
class GetPokemonsByMoveEvent extends PokemonEvent {
  final String move;

  const GetPokemonsByMoveEvent(this.move);

  @override
  List<Object?> get props => [move];
}

/// Event to get Pokemon by evolution
class GetPokemonsByEvolutionEvent extends PokemonEvent {
  final String evolution;

  const GetPokemonsByEvolutionEvent(this.evolution);

  @override
  List<Object?> get props => [evolution];
}

/// Event to get Pokemon by stat
class GetPokemonsByStatEvent extends PokemonEvent {
  final String stat;
  final int value;

  const GetPokemonsByStatEvent(this.stat, this.value);

  @override
  List<Object?> get props => [stat, value];
}

/// Event to get Pokemon by description
class GetPokemonsByDescriptionEvent extends PokemonEvent {
  final String description;

  const GetPokemonsByDescriptionEvent(this.description);

  @override
  List<Object?> get props => [description];
}

class GetPokemonDetail extends PokemonEvent {
  final int id;

  const GetPokemonDetail(this.id);

  @override
  List<Object?> get props => [id];
}
