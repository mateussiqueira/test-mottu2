import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/i_pokemon_repository.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final IPokemonRepository _repository;

  PokemonBloc(this._repository) : super(PokemonInitial()) {
    on<GetPokemonList>(_onGetPokemonList);
    on<SearchPokemon>(_onSearchPokemon);
    on<GetPokemonsByType>(_onGetPokemonsByType);
    on<GetPokemonsByAbility>(_onGetPokemonsByAbility);
    on<GetPokemonsByMove>(_onGetPokemonsByMove);
    on<GetPokemonsByEvolution>(_onGetPokemonsByEvolution);
    on<GetPokemonsByStat>(_onGetPokemonsByStat);
    on<GetPokemonsByDescription>(_onGetPokemonsByDescription);
    on<GetPokemonDetail>(_onGetPokemonDetail);
  }

  Future<void> _onGetPokemonList(
    GetPokemonList event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoading());
    final result = await _repository.getPokemonList(
      limit: event.limit,
      offset: event.offset,
    );
    result.isSuccess
        ? emit(PokemonLoaded(result.data!))
        : emit(PokemonError(result.error.toString()));
  }

  Future<void> _onSearchPokemon(
    SearchPokemon event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoading());
    final result = await _repository.searchPokemon(event.query);
    result.isSuccess
        ? emit(PokemonLoaded(result.data!))
        : emit(PokemonError(result.error.toString()));
  }

  Future<void> _onGetPokemonsByType(
    GetPokemonsByType event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoading());
    final result = await _repository.getPokemonsByType(event.type);
    result.isSuccess
        ? emit(PokemonLoaded(result.data!))
        : emit(PokemonError(result.error.toString()));
  }

  Future<void> _onGetPokemonsByAbility(
    GetPokemonsByAbility event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoading());
    final result = await _repository.getPokemonsByAbility(event.ability);
    result.isSuccess
        ? emit(PokemonLoaded(result.data!))
        : emit(PokemonError(result.error.toString()));
  }

  Future<void> _onGetPokemonsByMove(
    GetPokemonsByMove event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoading());
    final result = await _repository.getPokemonsByMove(event.move);
    result.isSuccess
        ? emit(PokemonLoaded(result.data!))
        : emit(PokemonError(result.error.toString()));
  }

  Future<void> _onGetPokemonsByEvolution(
    GetPokemonsByEvolution event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoading());
    final result = await _repository.getPokemonsByEvolution(event.evolution);
    result.isSuccess
        ? emit(PokemonLoaded(result.data!))
        : emit(PokemonError(result.error.toString()));
  }

  Future<void> _onGetPokemonsByStat(
    GetPokemonsByStat event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoading());
    final result = await _repository.getPokemonsByStat(event.stat, event.value);
    result.isSuccess
        ? emit(PokemonLoaded(result.data!))
        : emit(PokemonError(result.error.toString()));
  }

  Future<void> _onGetPokemonsByDescription(
    GetPokemonsByDescription event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoading());
    final result =
        await _repository.getPokemonsByDescription(event.description);
    result.isSuccess
        ? emit(PokemonLoaded(result.data!))
        : emit(PokemonError(result.error.toString()));
  }

  Future<void> _onGetPokemonDetail(
    GetPokemonDetail event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoading());
    final result = await _repository.getPokemonDetail(event.id);
    result.isSuccess
        ? emit(PokemonDetailLoaded(result.data!))
        : emit(PokemonError(result.error.toString()));
  }
}
