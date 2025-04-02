
import 'dart:async' as _i5;

import 'package:flutter_bloc/flutter_bloc.dart' as _i7;
import 'package:mobile/core/domain/result.dart' as _i2;
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart'
    as _i6;
import 'package:mobile/features/pokemon_list/domain/repositories/pokemon_repository.dart'
    as _i3;
import 'package:mobile/features/pokemon_list/presentation/bloc/pokemon_list_bloc.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;


class _FakeResult_0<T> extends _i1.SmartFake implements _i2.Result<T> {
  _FakeResult_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakePokemonRepository_1 extends _i1.SmartFake
    implements _i3.PokemonRepository {
  _FakePokemonRepository_1(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakePokemonListState_2 extends _i1.SmartFake
    implements _i4.PokemonListState {
  _FakePokemonListState_2(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class MockPokemonRepository extends _i1.Mock implements _i3.PokemonRepository {
  MockPokemonRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Result<List<_i6.PokemonEntityImpl>>> getPokemonList({
    required int? limit,
    required int? offset,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#getPokemonList, [], {
              #limit: limit,
              #offset: offset,
            }),
            returnValue:
                _i5.Future<_i2.Result<List<_i6.PokemonEntityImpl>>>.value(
                  _FakeResult_0<List<_i6.PokemonEntityImpl>>(
                    this,
                    Invocation.method(#getPokemonList, [], {
                      #limit: limit,
                      #offset: offset,
                    }),
                  ),
                ),
          )
          as _i5.Future<_i2.Result<List<_i6.PokemonEntityImpl>>>);

  @override
  _i5.Future<_i2.Result<_i6.PokemonEntityImpl>> getPokemonDetail(int? id) =>
      (super.noSuchMethod(
            Invocation.method(#getPokemonDetail, [id]),
            returnValue: _i5.Future<_i2.Result<_i6.PokemonEntityImpl>>.value(
              _FakeResult_0<_i6.PokemonEntityImpl>(
                this,
                Invocation.method(#getPokemonDetail, [id]),
              ),
            ),
          )
          as _i5.Future<_i2.Result<_i6.PokemonEntityImpl>>);

  @override
  _i5.Future<_i2.Result<List<_i6.PokemonEntityImpl>>> searchPokemon(
    String? query,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#searchPokemon, [query]),
            returnValue:
                _i5.Future<_i2.Result<List<_i6.PokemonEntityImpl>>>.value(
                  _FakeResult_0<List<_i6.PokemonEntityImpl>>(
                    this,
                    Invocation.method(#searchPokemon, [query]),
                  ),
                ),
          )
          as _i5.Future<_i2.Result<List<_i6.PokemonEntityImpl>>>);
}

class MockPokemonListBloc extends _i1.Mock implements _i4.PokemonListBloc {
  MockPokemonListBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.PokemonRepository get repository =>
      (super.noSuchMethod(
            Invocation.getter(#repository),
            returnValue: _FakePokemonRepository_1(
              this,
              Invocation.getter(#repository),
            ),
          )
          as _i3.PokemonRepository);

  @override
  _i4.PokemonListState get state =>
      (super.noSuchMethod(
            Invocation.getter(#state),
            returnValue: _FakePokemonListState_2(
              this,
              Invocation.getter(#state),
            ),
          )
          as _i4.PokemonListState);

  @override
  _i5.Stream<_i4.PokemonListState> get stream =>
      (super.noSuchMethod(
            Invocation.getter(#stream),
            returnValue: _i5.Stream<_i4.PokemonListState>.empty(),
          )
          as _i5.Stream<_i4.PokemonListState>);

  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);

  @override
  _i5.Future<void> close() =>
      (super.noSuchMethod(
            Invocation.method(#close, []),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);

  @override
  void add(_i4.PokemonListEvent? event) => super.noSuchMethod(
    Invocation.method(#add, [event]),
    returnValueForMissingStub: null,
  );

  @override
  void onEvent(_i4.PokemonListEvent? event) => super.noSuchMethod(
    Invocation.method(#onEvent, [event]),
    returnValueForMissingStub: null,
  );

  @override
  void emit(_i4.PokemonListState? state) => super.noSuchMethod(
    Invocation.method(#emit, [state]),
    returnValueForMissingStub: null,
  );

  @override
  void on<E extends _i4.PokemonListEvent>(
    _i7.EventHandler<E, _i4.PokemonListState>? handler, {
    _i7.EventTransformer<E>? transformer,
  }) => super.noSuchMethod(
    Invocation.method(#on, [handler], {#transformer: transformer}),
    returnValueForMissingStub: null,
  );

  @override
  void onTransition(
    _i7.Transition<_i4.PokemonListEvent, _i4.PokemonListState>? transition,
  ) => super.noSuchMethod(
    Invocation.method(#onTransition, [transition]),
    returnValueForMissingStub: null,
  );

  @override
  void onChange(_i7.Change<_i4.PokemonListState>? change) => super.noSuchMethod(
    Invocation.method(#onChange, [change]),
    returnValueForMissingStub: null,
  );

  @override
  void addError(Object? error, [StackTrace? stackTrace]) => super.noSuchMethod(
    Invocation.method(#addError, [error, stackTrace]),
    returnValueForMissingStub: null,
  );

  @override
  void onError(Object? error, StackTrace? stackTrace) => super.noSuchMethod(
    Invocation.method(#onError, [error, stackTrace]),
    returnValueForMissingStub: null,
  );
}
