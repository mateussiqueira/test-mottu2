import 'package:equatable/equatable.dart';

import '../../entities/pokemon_entity.dart';

/// Base class for Pokemon states
abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class PokemonInitial extends PokemonState {}

/// Loading state
class PokemonLoading extends PokemonState {}

/// Error state
class PokemonError extends PokemonState {
  final String message;

  const PokemonError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// State when Pokemon list is loaded
class PokemonListLoaded extends PokemonState {
  final List<PokemonEntity> pokemons;

  const PokemonListLoaded({required this.pokemons});

  @override
  List<Object?> get props => [pokemons];
}

/// State when Pokemon detail is loaded
class PokemonDetailLoaded extends PokemonState {
  final PokemonEntity pokemon;

  const PokemonDetailLoaded(this.pokemon);

  @override
  List<Object?> get props => [pokemon];
}
