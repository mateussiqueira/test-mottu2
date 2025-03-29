import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';

// Events
abstract class PokemonListEvent {}

class LoadPokemons extends PokemonListEvent {}

class SearchPokemons extends PokemonListEvent {
  final String query;

  SearchPokemons(this.query);

  @override
  String toString() => 'SearchPokemons(query: $query)';
}

class LoadPokemonsByType extends PokemonListEvent {
  final String type;

  LoadPokemonsByType(this.type);

  @override
  String toString() => 'LoadPokemonsByType(type: $type)';
}

class LoadPokemonsByAbility extends PokemonListEvent {
  final String ability;

  LoadPokemonsByAbility(this.ability);

  @override
  String toString() => 'LoadPokemonsByAbility(ability: $ability)';
}

// States
abstract class PokemonListState {}

class PokemonListInitial extends PokemonListState {
  @override
  String toString() => 'PokemonListInitial';
}

class PokemonListLoading extends PokemonListState {
  @override
  String toString() => 'PokemonListLoading';
}

class PokemonListLoaded extends PokemonListState {
  final List<PokemonEntityImpl> pokemons;

  PokemonListLoaded(this.pokemons);

  @override
  String toString() => 'PokemonListLoaded(pokemons: $pokemons)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokemonListLoaded && other.pokemons == pokemons;
  }

  @override
  int get hashCode => pokemons.hashCode;
}

class PokemonListError extends PokemonListState {
  final String message;

  PokemonListError(this.message);

  @override
  String toString() => 'PokemonListError(message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokemonListError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

// Bloc
class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  final PokemonRepository repository;
  Timer? _debounce;

  PokemonListBloc({required this.repository}) : super(PokemonListInitial()) {
    on<LoadPokemons>(_onLoadPokemons);
    on<SearchPokemons>(_onSearchPokemons);
    on<LoadPokemonsByType>(_onLoadPokemonsByType);
    on<LoadPokemonsByAbility>(_onLoadPokemonsByAbility);
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  Future<void> _onLoadPokemons(
    LoadPokemons event,
    Emitter<PokemonListState> emit,
  ) async {
    emit(PokemonListLoading());
    try {
      final result = await repository.getPokemonList(offset: 0, limit: 20);
      if (result.isSuccess) {
        emit(PokemonListLoaded(result.data!));
      } else {
        emit(PokemonListError(result.error!.toString()));
      }
    } catch (e) {
      emit(PokemonListError(e.toString()));
    }
  }

  Future<void> _onSearchPokemons(
    SearchPokemons event,
    Emitter<PokemonListState> emit,
  ) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(PokemonListLoading());
      try {
        final result = await repository.searchPokemon(event.query);
        if (result.isSuccess) {
          emit(PokemonListLoaded(result.data!));
        } else {
          emit(PokemonListError(result.error!.toString()));
        }
      } catch (e) {
        emit(PokemonListError(e.toString()));
      }
    });
  }

  Future<void> _onLoadPokemonsByType(
    LoadPokemonsByType event,
    Emitter<PokemonListState> emit,
  ) async {
    emit(PokemonListLoading());
    try {
      final result = await repository.getPokemonList(offset: 0, limit: 20);
      if (result.isSuccess) {
        final filteredPokemons = result.data!
            .where((pokemon) => pokemon.types.contains(event.type))
            .toList();
        emit(PokemonListLoaded(filteredPokemons));
      } else {
        emit(PokemonListError(result.error!.toString()));
      }
    } catch (e) {
      emit(PokemonListError(e.toString()));
    }
  }

  Future<void> _onLoadPokemonsByAbility(
    LoadPokemonsByAbility event,
    Emitter<PokemonListState> emit,
  ) async {
    emit(PokemonListLoading());
    try {
      final result = await repository.getPokemonList(offset: 0, limit: 20);
      if (result.isSuccess) {
        final filteredPokemons = result.data!
            .where((pokemon) => pokemon.abilities.contains(event.ability))
            .toList();
        emit(PokemonListLoaded(filteredPokemons));
      } else {
        emit(PokemonListError(result.error!.toString()));
      }
    } catch (e) {
      emit(PokemonListError(e.toString()));
    }
  }

  @override
  String toString() => 'PokemonListBloc(repository: $repository)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokemonListBloc && other.repository == repository;
  }

  @override
  int get hashCode => repository.hashCode;
}
