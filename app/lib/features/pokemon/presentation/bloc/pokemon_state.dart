part of 'pokemon_bloc.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object?> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final List<PokemonEntity> pokemons;

  const PokemonLoaded(this.pokemons);

  @override
  List<Object> get props => [pokemons];
}

class PokemonDetailLoaded extends PokemonState {
  final PokemonEntity pokemon;

  const PokemonDetailLoaded(this.pokemon);

  @override
  List<Object> get props => [pokemon];
}

class PokemonError extends PokemonState {
  final String message;

  const PokemonError(this.message);

  @override
  List<Object> get props => [message];
}
