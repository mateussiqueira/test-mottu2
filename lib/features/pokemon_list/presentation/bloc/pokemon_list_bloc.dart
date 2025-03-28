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

class PokemonListLoading extends PokemonListState {}

class PokemonListLoaded extends PokemonListState {
  final List<Pokemon> pokemons;
  final bool hasMore;
  final String? filterType;
  final String? filterAbility;

  const PokemonListLoaded({
    required this.pokemons,
    this.hasMore = true,
    this.filterType,
    this.filterAbility,
  });

  @override
  List<Object?> get props => [pokemons, hasMore, filterType, filterAbility];
}

class PokemonListError extends PokemonListState {
  final String message;

  const PokemonListError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  final PokemonRepository repository;
  int _currentOffset = 0;
  static const int _limit = 20;

  PokemonListBloc({required this.repository}) : super(PokemonListInitial()) {
    on<LoadPokemons>(_onLoadPokemons);
    on<SearchPokemon>(_onSearchPokemon);
    on<LoadPokemonsByType>(_onLoadPokemonsByType);
    on<LoadPokemonsByAbility>(_onLoadPokemonsByAbility);
  }

  Future<void> _onLoadPokemons(
    LoadPokemons event,
    Emitter<PokemonListState> emit,
  ) async {
    try {
      if (state is PokemonListLoading) return;

      emit(PokemonListLoading());

      final pokemons = await repository.getPokemons(
        offset: event.offset,
        limit: event.limit,
      );

      _currentOffset = event.offset + event.limit;

      emit(PokemonListLoaded(
        pokemons: pokemons,
        hasMore: pokemons.length == event.limit,
      ));
    } catch (e) {
      emit(PokemonListError(e.toString()));
    }
  }

  Future<void> _onSearchPokemon(
    SearchPokemon event,
    Emitter<PokemonListState> emit,
  ) async {
    try {
      if (state is PokemonListLoading) return;

      emit(PokemonListLoading());

      final pokemon =
          await repository.getPokemonByName(event.query.toLowerCase());
      emit(PokemonListLoaded(pokemons: [pokemon], hasMore: false));
    } catch (e) {
      emit(PokemonListError(e.toString()));
    }
  }

  Future<void> _onLoadPokemonsByType(
    LoadPokemonsByType event,
    Emitter<PokemonListState> emit,
  ) async {
    try {
      if (state is PokemonListLoading) return;

      emit(PokemonListLoading());

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

      emit(PokemonListLoading());

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
