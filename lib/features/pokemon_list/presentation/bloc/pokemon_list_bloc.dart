import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/pokemon.dart';
import '../../../../core/domain/repositories/pokemon_repository.dart';

// Events
abstract class PokemonListEvent extends Equatable {
  const PokemonListEvent();

  @override
  List<Object?> get props => [];
}

class LoadPokemons extends PokemonListEvent {
  final int offset;
  final int limit;

  const LoadPokemons({this.offset = 0, this.limit = 20});

  @override
  List<Object?> get props => [offset, limit];
}

class SearchPokemon extends PokemonListEvent {
  final String query;

  const SearchPokemon(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadPokemonsByType extends PokemonListEvent {
  final String type;

  const LoadPokemonsByType(this.type);

  @override
  List<Object?> get props => [type];
}

class LoadPokemonsByAbility extends PokemonListEvent {
  final String ability;

  const LoadPokemonsByAbility(this.ability);

  @override
  List<Object?> get props => [ability];
}

// States
abstract class PokemonListState extends Equatable {
  const PokemonListState();

  @override
  List<Object?> get props => [];
}

class PokemonListInitial extends PokemonListState {}

class PokemonListLoading extends PokemonListState {
  final List<Pokemon> pokemons;
  final bool hasMore;
  final String? filterType;
  final String? filterAbility;
  final String? searchQuery;

  const PokemonListLoading({
    this.pokemons = const [],
    this.hasMore = true,
    this.filterType,
    this.filterAbility,
    this.searchQuery,
  });

  @override
  List<Object?> get props =>
      [pokemons, hasMore, filterType, filterAbility, searchQuery];
}

class PokemonListLoaded extends PokemonListState {
  final List<Pokemon> pokemons;
  final bool hasMore;
  final String? filterType;
  final String? filterAbility;
  final String? searchQuery;

  const PokemonListLoaded({
    required this.pokemons,
    this.hasMore = true,
    this.filterType,
    this.filterAbility,
    this.searchQuery,
  });

  @override
  List<Object?> get props =>
      [pokemons, hasMore, filterType, filterAbility, searchQuery];
}

class PokemonListError extends PokemonListState {
  final String message;

  const PokemonListError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  final PokemonRepository repository;
  int _currentOffset = 0;
  static const int _limit = 20;
  Timer? _debounceTimer;

  PokemonListBloc({required this.repository}) : super(PokemonListInitial()) {
    on<LoadPokemons>(_onLoadPokemons);
    on<SearchPokemon>(_onSearchPokemon);
    on<LoadPokemonsByType>(_onLoadPokemonsByType);
    on<LoadPokemonsByAbility>(_onLoadPokemonsByAbility);
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }

  Future<void> _onLoadPokemons(
    LoadPokemons event,
    Emitter<PokemonListState> emit,
  ) async {
    try {
      if (state is PokemonListLoading) return;

      final currentState = state;
      final currentPokemons = currentState is PokemonListLoaded
          ? currentState.pokemons
          : currentState is PokemonListLoading
              ? currentState.pokemons
              : <Pokemon>[];

      emit(PokemonListLoading(
        pokemons: currentPokemons,
        hasMore:
            currentState is PokemonListLoaded ? currentState.hasMore : true,
        filterType:
            currentState is PokemonListLoaded ? currentState.filterType : null,
        filterAbility: currentState is PokemonListLoaded
            ? currentState.filterAbility
            : null,
        searchQuery:
            currentState is PokemonListLoaded ? currentState.searchQuery : null,
      ));

      final pokemons = await repository.getPokemons(
        offset: event.offset,
        limit: event.limit,
      );

      _currentOffset = event.offset + event.limit;

      final updatedPokemons =
          event.offset == 0 ? pokemons : [...currentPokemons, ...pokemons];

      emit(PokemonListLoaded(
        pokemons: updatedPokemons,
        hasMore: pokemons.length == event.limit,
        filterType:
            currentState is PokemonListLoaded ? currentState.filterType : null,
        filterAbility: currentState is PokemonListLoaded
            ? currentState.filterAbility
            : null,
        searchQuery:
            currentState is PokemonListLoaded ? currentState.searchQuery : null,
      ));
    } catch (e) {
      emit(PokemonListError(e.toString()));
    }
  }

  Future<void> _onSearchPokemon(
    SearchPokemon event,
    Emitter<PokemonListState> emit,
  ) async {
    // Cancela o timer anterior se existir
    _debounceTimer?.cancel();

    // Se a query estiver vazia, volta para a lista normal
    if (event.query.isEmpty) {
      add(const LoadPokemons());
      return;
    }

    // Cria um novo timer para debounce
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      try {
        if (state is PokemonListLoading) return;

        emit(const PokemonListLoading());

        final pokemons = await repository.searchPokemons(event.query);
        emit(PokemonListLoaded(
          pokemons: pokemons,
          hasMore: false,
          searchQuery: event.query,
        ));
      } catch (e) {
        emit(PokemonListError(e.toString()));
      }
    });
  }

  Future<void> _onLoadPokemonsByType(
    LoadPokemonsByType event,
    Emitter<PokemonListState> emit,
  ) async {
    try {
      if (state is PokemonListLoading) return;

      emit(const PokemonListLoading());

      final pokemons = await repository.getPokemonsByType(event.type);
      emit(PokemonListLoaded(
        pokemons: pokemons,
        hasMore: false,
        filterType: event.type,
      ));
    } catch (e) {
      emit(PokemonListError(e.toString()));
    }
  }

  Future<void> _onLoadPokemonsByAbility(
    LoadPokemonsByAbility event,
    Emitter<PokemonListState> emit,
  ) async {
    try {
      if (state is PokemonListLoading) return;

      emit(const PokemonListLoading());

      final pokemons = await repository.getPokemonsByAbility(event.ability);
      emit(PokemonListLoaded(
        pokemons: pokemons,
        hasMore: false,
        filterAbility: event.ability,
      ));
    } catch (e) {
      emit(PokemonListError(e.toString()));
    }
  }
}
