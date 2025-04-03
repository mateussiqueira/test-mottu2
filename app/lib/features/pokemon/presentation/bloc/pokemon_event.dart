part of 'pokemon_bloc.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object?> get props => [];
}

class GetPokemonList extends PokemonEvent {
  final int? limit;
  final int? offset;

  const GetPokemonList({this.limit, this.offset});

  @override
  List<Object?> get props => [limit, offset];
}

class SearchPokemon extends PokemonEvent {
  final String query;

  const SearchPokemon(this.query);

  @override
  List<Object> get props => [query];
}

class GetPokemonsByType extends PokemonEvent {
  final String type;

  const GetPokemonsByType(this.type);

  @override
  List<Object> get props => [type];
}

class GetPokemonsByAbility extends PokemonEvent {
  final String ability;

  const GetPokemonsByAbility(this.ability);

  @override
  List<Object> get props => [ability];
}

class GetPokemonsByMove extends PokemonEvent {
  final String move;

  const GetPokemonsByMove(this.move);

  @override
  List<Object> get props => [move];
}

class GetPokemonsByEvolution extends PokemonEvent {
  final String evolution;

  const GetPokemonsByEvolution(this.evolution);

  @override
  List<Object> get props => [evolution];
}

class GetPokemonsByStat extends PokemonEvent {
  final String stat;
  final int value;

  const GetPokemonsByStat(this.stat, this.value);

  @override
  List<Object> get props => [stat, value];
}

class GetPokemonsByDescription extends PokemonEvent {
  final String description;

  const GetPokemonsByDescription(this.description);

  @override
  List<Object> get props => [description];
}

class GetPokemonDetail extends PokemonEvent {
  final int id;

  const GetPokemonDetail(this.id);

  @override
  List<Object> get props => [id];
}
