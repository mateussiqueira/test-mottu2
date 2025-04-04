import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';
import '../../usecases/get_pokemon_by_ability.dart';
import '../../usecases/get_pokemon_by_description.dart';
import '../../usecases/get_pokemon_by_evolution.dart';
import '../../usecases/get_pokemon_by_id.dart';
import '../../usecases/get_pokemon_by_move.dart';
import '../../usecases/get_pokemon_by_stat.dart';
import '../../usecases/get_pokemon_by_type.dart';
import '../../usecases/get_pokemon_list.dart';
import '../../usecases/search_pokemon.dart';
import 'pokemon_event.dart';
import 'pokemon_state.dart';

/// Bloc that manages Pokemon state
class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final GetPokemonList _getPokemonList;
  final GetPokemonById _getPokemonById;
  final SearchPokemon _searchPokemon;
  final GetPokemonsByType _getPokemonByType;
  final GetPokemonsByAbility _getPokemonByAbility;
  final GetPokemonsByMove _getPokemonByMove;
  final GetPokemonsByEvolution _getPokemonByEvolution;
  final GetPokemonsByStat _getPokemonByStat;
  final GetPokemonsByDescription _getPokemonByDescription;

  PokemonBloc({
    required GetPokemonList getPokemonList,
    required GetPokemonById getPokemonById,
    required SearchPokemon searchPokemon,
    required GetPokemonsByType getPokemonByType,
    required GetPokemonsByAbility getPokemonByAbility,
    required GetPokemonsByMove getPokemonByMove,
    required GetPokemonsByEvolution getPokemonByEvolution,
    required GetPokemonsByStat getPokemonByStat,
    required GetPokemonsByDescription getPokemonByDescription,
  })  : _getPokemonList = getPokemonList,
        _getPokemonById = getPokemonById,
        _searchPokemon = searchPokemon,
        _getPokemonByType = getPokemonByType,
        _getPokemonByAbility = getPokemonByAbility,
        _getPokemonByMove = getPokemonByMove,
        _getPokemonByEvolution = getPokemonByEvolution,
        _getPokemonByStat = getPokemonByStat,
        _getPokemonByDescription = getPokemonByDescription,
        super(PokemonInitial()) {
    on<GetPokemonListEvent>(_onGetPokemonList);
    on<GetPokemonByIdEvent>(_onGetPokemonById);
    on<SearchPokemonEvent>(_onSearchPokemon);
    on<GetPokemonsByTypeEvent>(_onGetPokemonsByType);
    on<GetPokemonsByAbilityEvent>(_onGetPokemonsByAbility);
    on<GetPokemonsByMoveEvent>(_onGetPokemonsByMove);
    on<GetPokemonsByEvolutionEvent>(_onGetPokemonsByEvolution);
    on<GetPokemonsByStatEvent>(_onGetPokemonsByStat);
    on<GetPokemonsByDescriptionEvent>(_onGetPokemonsByDescription);
  }

  Future<void> _onGetPokemonList(
    GetPokemonListEvent event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoading());
    final result = await _getPokemonList.call(
      limit: event.limit,
      offset: event.offset,
    );
    result.fold(
      (failure) => emit(PokemonError(message: _mapFailureToMessage(failure))),
      (pokemons) => emit(PokemonListLoaded(pokemons: pokemons)),
    );
  }

  Future<void> _onGetPokemonById(
    GetPokemonByIdEvent event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoading());
    final result = await _getPokemonById.call(event.id);
    result.fold(
      (failure) => emit(PokemonError(message: _mapFailureToMessage(failure))),
      (pokemon) => emit(PokemonDetailLoaded(pokemon)),
    );
  }

  Future<void> _onSearchPokemon(
    SearchPokemonEvent event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoading());
    final result = await _searchPokemon.call(event.query);
    result.fold(
      (failure) => emit(PokemonError(message: _mapFailureToMessage(failure))),
      (pokemons) => emit(PokemonListLoaded(pokemons: pokemons)),
    );
  }

  Future<void> _onGetPokemonsByType(
    GetPokemonsByTypeEvent event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoading());
    final result = await _getPokemonByType.call(event.type);
    result.fold(
      (failure) => emit(PokemonError(message: _mapFailureToMessage(failure))),
      (pokemons) => emit(PokemonListLoaded(pokemons: pokemons)),
    );
  }

  Future<void> _onGetPokemonsByAbility(
    GetPokemonsByAbilityEvent event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoading());
    final result = await _getPokemonByAbility.call(event.ability);
    result.fold(
      (failure) => emit(PokemonError(message: _mapFailureToMessage(failure))),
      (pokemons) => emit(PokemonListLoaded(pokemons: pokemons)),
    );
  }

  Future<void> _onGetPokemonsByMove(
    GetPokemonsByMoveEvent event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoading());
    final result = await _getPokemonByMove.call(event.move);
    result.fold(
      (failure) => emit(PokemonError(message: _mapFailureToMessage(failure))),
      (pokemons) => emit(PokemonListLoaded(pokemons: pokemons)),
    );
  }

  Future<void> _onGetPokemonsByEvolution(
    GetPokemonsByEvolutionEvent event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoading());
    final result = await _getPokemonByEvolution.call(event.evolution);
    result.fold(
      (failure) => emit(PokemonError(message: _mapFailureToMessage(failure))),
      (pokemons) => emit(PokemonListLoaded(pokemons: pokemons)),
    );
  }

  Future<void> _onGetPokemonsByStat(
    GetPokemonsByStatEvent event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoading());
    final result = await _getPokemonByStat.call('${event.stat}:${event.value}');
    result.fold(
      (failure) => emit(PokemonError(message: _mapFailureToMessage(failure))),
      (pokemons) => emit(PokemonListLoaded(pokemons: pokemons)),
    );
  }

  Future<void> _onGetPokemonsByDescription(
    GetPokemonsByDescriptionEvent event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoading());
    final result = await _getPokemonByDescription.call(event.description);
    result.fold(
      (failure) => emit(PokemonError(message: _mapFailureToMessage(failure))),
      (pokemons) => emit(PokemonListLoaded(pokemons: pokemons)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ValidationFailure) {
      return failure.message ?? 'Validation error';
    }
    if (failure is ServerFailure) {
      return failure.message ?? 'Server error';
    }
    if (failure is CacheFailure) {
      return failure.message ?? 'Cache error';
    }
    if (failure is NetworkFailure) {
      return failure.message ?? 'Network error';
    }
    if (failure is AuthenticationFailure) {
      return failure.message ?? 'Authentication error';
    }
    if (failure is AuthorizationFailure) {
      return failure.message ?? 'Authorization error';
    }
    return failure.message ?? 'Unknown error';
  }
}
