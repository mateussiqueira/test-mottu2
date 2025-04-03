import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/pokemon_repository.dart';
import '../../domain/entities/pokemon_entity.dart';

// Events
abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object> get props => [];
}

class LoadPokemons extends PokemonEvent {
  final bool refresh;

  const LoadPokemons({this.refresh = false});

  @override
  List<Object> get props => [refresh];
}

class SearchPokemons extends PokemonEvent {
  final String query;

  const SearchPokemons(this.query);

  @override
  List<Object> get props => [query];
}

class LoadPokemonsByType extends PokemonEvent {
  final String type;

  const LoadPokemonsByType(this.type);

  @override
  List<Object> get props => [type];
}

// States
abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final List<PokemonEntity> pokemons;
  final bool hasMore;
  final bool isSearching;

  const PokemonLoaded({
    required this.pokemons,
    this.hasMore = true,
    this.isSearching = false,
  });

  @override
  List<Object> get props => [pokemons, hasMore, isSearching];
}

class PokemonError extends PokemonState {
  final String message;

  const PokemonError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository repository;
  int _currentPage = 0;
  static const int _pageSize = 20;

  PokemonBloc(this.repository) : super(PokemonInitial()) {
    on<LoadPokemons>(_onLoadPokemons);
    on<SearchPokemons>(_onSearchPokemons);
    on<LoadPokemonsByType>(_onLoadPokemonsByType);
  }

  Future<void> _onLoadPokemons(
      LoadPokemons event, Emitter<PokemonState> emit) async {
    try {
      if (event.refresh) {
        _currentPage = 0;
        emit(PokemonLoading());
      }

      final currentState = state;
      if (currentState is PokemonLoaded && !event.refresh) {
        _currentPage++;
      }

      final pokemons = await repository.fetchPokemons(
        page: _currentPage,
        limit: _pageSize,
      );

      if (event.refresh) {
        emit(PokemonLoaded(
          pokemons: pokemons,
          hasMore: pokemons.length == _pageSize,
        ));
      } else if (currentState is PokemonLoaded) {
        emit(PokemonLoaded(
          pokemons: [...currentState.pokemons, ...pokemons],
          hasMore: pokemons.length == _pageSize,
        ));
      } else {
        emit(PokemonLoaded(
          pokemons: pokemons,
          hasMore: pokemons.length == _pageSize,
        ));
      }
    } catch (e) {
      emit(PokemonError(e.toString()));
    }
  }

  Future<void> _onSearchPokemons(
      SearchPokemons event, Emitter<PokemonState> emit) async {
    try {
      emit(PokemonLoading());
      final pokemons = await repository.searchPokemons(event.query);
      emit(PokemonLoaded(
        pokemons: pokemons,
        hasMore: false,
        isSearching: true,
      ));
    } catch (e) {
      emit(PokemonError(e.toString()));
    }
  }

  Future<void> _onLoadPokemonsByType(
      LoadPokemonsByType event, Emitter<PokemonState> emit) async {
    try {
      emit(PokemonLoading());
      final pokemons = await repository.getPokemonsByType(event.type);
      emit(PokemonLoaded(
        pokemons: pokemons,
        hasMore: false,
      ));
    } catch (e) {
      emit(PokemonError(e.toString()));
    }
  }
}
