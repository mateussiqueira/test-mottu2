import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../../../pokemon/domain/repositories/pokemon_repository.dart';

// Events
abstract class RelatedPokemonsEvent extends Equatable {
  const RelatedPokemonsEvent();

  @override
  List<Object?> get props => [];
}

class LoadPokemonsByType extends RelatedPokemonsEvent {
  final String type;

  const LoadPokemonsByType(this.type);

  @override
  List<Object?> get props => [type];
}

class LoadPokemonsByAbility extends RelatedPokemonsEvent {
  final String ability;

  const LoadPokemonsByAbility(this.ability);

  @override
  List<Object?> get props => [ability];
}

// States
abstract class RelatedPokemonsState extends Equatable {
  const RelatedPokemonsState();

  @override
  List<Object?> get props => [];
}

class RelatedPokemonsInitial extends RelatedPokemonsState {}

class RelatedPokemonsLoading extends RelatedPokemonsState {}

class RelatedPokemonsLoaded extends RelatedPokemonsState {
  final List<PokemonEntityImpl> pokemons;
  final String? filterType;
  final String? filterAbility;

  const RelatedPokemonsLoaded({
    required this.pokemons,
    this.filterType,
    this.filterAbility,
  });

  @override
  List<Object?> get props => [pokemons, filterType, filterAbility];
}

class RelatedPokemonsError extends RelatedPokemonsState {
  final String message;

  const RelatedPokemonsError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class RelatedPokemonsBloc
    extends Bloc<RelatedPokemonsEvent, RelatedPokemonsState> {
  final PokemonRepository repository;

  RelatedPokemonsBloc({required this.repository})
      : super(RelatedPokemonsInitial()) {
    on<LoadPokemonsByType>(_onLoadPokemonsByType);
    on<LoadPokemonsByAbility>(_onLoadPokemonsByAbility);
  }

  Future<void> _onLoadPokemonsByType(
    LoadPokemonsByType event,
    Emitter<RelatedPokemonsState> emit,
  ) async {
    try {
      if (state is RelatedPokemonsLoading) return;

      emit(RelatedPokemonsLoading());

      final result = await repository.getPokemonsByType(event.type);
      result.fold(
        (failure) => emit(RelatedPokemonsError(failure.message)),
        (pokemons) => emit(RelatedPokemonsLoaded(
          pokemons: pokemons,
          filterType: event.type,
        )),
      );
    } catch (e) {
      emit(RelatedPokemonsError(e.toString()));
    }
  }

  Future<void> _onLoadPokemonsByAbility(
    LoadPokemonsByAbility event,
    Emitter<RelatedPokemonsState> emit,
  ) async {
    try {
      if (state is RelatedPokemonsLoading) return;

      emit(RelatedPokemonsLoading());

      final result = await repository.getPokemonsByAbility(event.ability);
      result.fold(
        (failure) => emit(RelatedPokemonsError(failure.message)),
        (pokemons) => emit(RelatedPokemonsLoaded(
          pokemons: pokemons,
          filterAbility: event.ability,
        )),
      );
    } catch (e) {
      emit(RelatedPokemonsError(e.toString()));
    }
  }
}
