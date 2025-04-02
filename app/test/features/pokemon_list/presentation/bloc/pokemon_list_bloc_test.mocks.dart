
import 'dart:async' as _i4;

import 'package:mobile/core/domain/result.dart' as _i2;
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart'
    as _i5;
import 'package:mobile/features/pokemon_list/domain/repositories/pokemon_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;


class _FakeResult_0<T> extends _i1.SmartFake implements _i2.Result<T> {
  _FakeResult_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class MockPokemonRepository extends _i1.Mock implements _i3.PokemonRepository {
  MockPokemonRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result<List<_i5.PokemonEntityImpl>>> getPokemonList({
    required int? limit,
    required int? offset,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#getPokemonList, [], {
              #limit: limit,
              #offset: offset,
            }),
            returnValue:
                _i4.Future<_i2.Result<List<_i5.PokemonEntityImpl>>>.value(
                  _FakeResult_0<List<_i5.PokemonEntityImpl>>(
                    this,
                    Invocation.method(#getPokemonList, [], {
                      #limit: limit,
                      #offset: offset,
                    }),
                  ),
                ),
          )
          as _i4.Future<_i2.Result<List<_i5.PokemonEntityImpl>>>);

  @override
  _i4.Future<_i2.Result<_i5.PokemonEntityImpl>> getPokemonDetail(int? id) =>
      (super.noSuchMethod(
            Invocation.method(#getPokemonDetail, [id]),
            returnValue: _i4.Future<_i2.Result<_i5.PokemonEntityImpl>>.value(
              _FakeResult_0<_i5.PokemonEntityImpl>(
                this,
                Invocation.method(#getPokemonDetail, [id]),
              ),
            ),
          )
          as _i4.Future<_i2.Result<_i5.PokemonEntityImpl>>);

  @override
  _i4.Future<_i2.Result<List<_i5.PokemonEntityImpl>>> searchPokemon(
    String? query,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#searchPokemon, [query]),
            returnValue:
                _i4.Future<_i2.Result<List<_i5.PokemonEntityImpl>>>.value(
                  _FakeResult_0<List<_i5.PokemonEntityImpl>>(
                    this,
                    Invocation.method(#searchPokemon, [query]),
                  ),
                ),
          )
          as _i4.Future<_i2.Result<List<_i5.PokemonEntityImpl>>>);
}
